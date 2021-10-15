const std = @import("std");
const builtin = std.builtin;
const terminal = @import("terminal.zig");
const serial = @import("serial.zig");

const MultiBoot = packed struct {
    magic: i32,
    flags: i32,
    checksum: i32,
};

const ALIGN = 1 << 0;
const MEMINFO = 1 << 1;
const MAGIC = 0x1BADB002;
const FLAGS = ALIGN | MEMINFO;

// must be placed at the beginning of the binary
export const multiboot align(4) linksection(".multiboot.data") = MultiBoot{
    .magic = MAGIC,
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

export var stack_bytes: [16 * 1024]u8 align(16) linksection(".bootstrap_stack") = undefined;
const stack_bytes_slice = stack_bytes[0..];

extern const _kernel_start: usize;
extern const _kernel_end: usize;

export var boot_page_directory: [1024]u32 align(4096) linksection(".bss") = undefined;
export var boot_page_table1: [1024]u32 align(4096) linksection(".bss") = undefined;

const kernel_mem_loc: usize = 0xC0000000;

export fn _start() linksection(".multiboot.text") callconv(.Naked) noreturn {
    @call(.{ .stack = stack_bytes_slice }, init_paging, .{});
}

export fn init_paging() linksection(".multiboot.text") noreturn {
    var kernel_start: usize = @ptrToInt(&_kernel_start);
    var kernel_end: usize = @ptrToInt(&_kernel_end);

    const physical_pd: [*]u32 = @intToPtr([*]u32, @ptrToInt(&boot_page_directory) - kernel_mem_loc);
    const physical_pt: [*]u32 = @intToPtr([*]u32, @ptrToInt(&boot_page_table1) - kernel_mem_loc);

    var page_loc: usize = 0;
    var pt_index: usize = 0;
    while (page_loc < kernel_end - kernel_mem_loc) : ({
        page_loc += 4096;
        pt_index += 1;
    }) {
        if (page_loc < kernel_start) {
            continue;
        }
        // Here we map EVERYTHING as present and writable, including .text and .rodata
        // TODO: fix this
        boot_page_table1[pt_index] = page_loc | 0x003;
    }

    // Map VGA video memory to 0xC03FF000 as "present, writable".
    physical_pt[1023] = 0x000B8000 | 0x03;

    // Create both the upper memory mapping from 0xC0000000 to 0xC03FFFFF
    // and an identity mapping, as our instruction pointer is still pointing
    // into our lower mapping when we switch on paging
    physical_pd[0] = @ptrToInt(&physical_pt) | 0x03;
    physical_pd[768] = @ptrToInt(&physical_pt) | 0x03; // corresponds to 0xC0000000 to 0xC03FFFFF

    // set cr3 to the address of the page directory
    asm volatile ("movl %[source], %%cr3"
        :
        : [source] "r" (physical_pd)
    );

    // flip the paging and write-protect bits
    asm volatile (
        \\movl %%cr0, %%ecx
        \\movl $0x80010000, %%ecx
        \\movl %%ecx, %%cr0
        ::: "ecx");

    cleanup_paging();
}

fn cleanup_paging() noreturn {
    // paging is now setup!
    boot_page_directory[0] = 0; // unmap the identity mapping
    // Reload crc3 to force a TLB flush so the changes to take effect.
    asm volatile (
        \\movl %%cr3, %%ecx
        \\movl %%ecx, %%cr3
        ::: "ecx");

    kmain();
    while (true) {}
}

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    terminal.write("KERNEL PANIC: ");
    terminal.write(msg);
    while (true) {}
}

fn print(buf: []u8, comptime fmt: []const u8, args: anytype) void {
    var x: []u8 = std.fmt.bufPrint(&stack_bytes, fmt, args) catch |_| {
        panic("print() buffer ran out of memory", null);
    };
    terminal.writeLn(fmt);
}

fn kmain() void {
    terminal.initialize();
    terminal.writeLn("Kernel started");

    serial.initialize() catch |err| switch (err) {
        error.MissingPort => @panic("No serial port"),
        error.FaultyPort => @panic("Serial port is faulty"),
    };

    serial.write('a');
    serial.write('b');
    serial.write('c');

    terminal.writeLn("Serial port written");

    while (true) {}
}

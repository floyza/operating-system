const std = @import("std");
const builtin = std.builtin;
const terminal = @import("terminal.zig");
const serial = @import("serial.zig");
// const itoa = @cImport({
//     @cInclude("mytoa.h");
// });
const itoa = @import("mytoa.zig");

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
export const multiboot align(4) linksection(".multiboot") = MultiBoot{
    .magic = MAGIC,
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

export var stack_bytes: [16 * 1024]u8 align(16) linksection(".bss") = undefined;
const stack_bytes_slice = stack_bytes[0..];

export fn _start() callconv(.Naked) noreturn {
    @call(.{ .stack = stack_bytes_slice }, kmain, .{});

    while (true) {}
}

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    terminal.write("KERNEL PANIC: ");
    terminal.write(msg);
    while (true) {}
}

// var print_buf: [100]u8 = undefined;
fn print(comptime fmt: []const u8, args: anytype) void {
    // var x: []u8 = std.fmt.bufPrint(&stack_bytes, fmt, args) catch |_| {
    //     panic("print() buffer ran out of memory", null);
    // };
    terminal.writeLn(fmt);
}

fn kmain() void {
    terminal.initialize();
    terminal.writeLn("Kernel started");

    // var serial_port = serial.get_serial() catch |err| {
    //     @panic("Failed to get serial port address");
    // };
    // print("Serial port location: {x}", .{@ptrToInt(serial_port)});
    //
    //locations:
    //stack: 0x108000
    //print_buf: 0x10c000
    //print_buf2: 0x10c064
    //
    //locations2:
    //stack:0x107000 top:0x10b000
    //print_buf:0x10b144

    // print("0x{x}", .{stack_bytes_slice.len + @ptrToInt(&stack_bytes_slice)});
    // print("{}", .{@ptrToInt(&stack_bytes) == @ptrToInt(&stack_bytes_slice)});
    // print("{}", .{@frameAddress()});

    // print("{}", .{1});

    var s: [1]u8 = undefined;
    // var res = itoa.uintToStr(4, &s);
    // var res = itoa.uintToStr(@frameAddress(), &s);
    // terminal.writeLn(res[0..]);

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

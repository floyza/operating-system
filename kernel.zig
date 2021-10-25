const std = @import("std");
const builtin = std.builtin;
const terminal = @import("terminal.zig");
const serial = @import("serial.zig");
const gdt = @import("gdt.zig");
const idt = @import("idt.zig");

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    serial.put('~');
    // terminal.write("KERNEL PANIC: ");
    // terminal.write(msg);
    while (true) {}
}

fn print(buf: []u8, comptime fmt: []const u8, args: anytype) void {
    var x: []u8 = std.fmt.bufPrint(&stack_bytes, fmt, args) catch |_| {
        panic("print() buffer ran out of memory", null);
    };
    terminal.writeLn(fmt);
}

export fn kmain() void {
    gdt.initialize();
    idt.initialize();

    // terminal.initialize();
    // terminal.writeLn("Kernel started");

    serial.initialize() catch |err| switch (err) {
        error.MissingPort => @panic("No serial port"),
        error.FaultyPort => @panic("Serial port is faulty"),
    };

    serial.put('H');
    serial.put('i');
    serial.put('\r');
    serial.put('\n');
    serial.put('w');
    serial.put('r');
    serial.put('d');
    serial.put('!');

    // terminal.writeLn("Serial port written");

    while (true) {}
}

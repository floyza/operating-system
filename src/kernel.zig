const std = @import("std");
const builtin = std.builtin;
const terminal = @import("terminal.zig");
const serial = @import("serial.zig");
const gdt = @import("gdt.zig");
const idt = @import("idt.zig");
const log = @import("log.zig");

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    serial.write("KERNEL PANIC: ");
    serial.write(msg);
    terminal.write("KERNEL PANIC: ");
    terminal.write(msg);
    while (true) {}
}

export fn kmain() noreturn {
    gdt.initialize();
    idt.initialize();

    terminal.initialize();

    serial.initialize() catch |err| switch (err) {
        error.MissingPort => @panic("No serial port"),
        error.FaultyPort => @panic("Serial port is faulty"),
    };

    log.printk_ln("Hello, {s}", .{"world!"});
    log.printk_ln("Hello, second world!", .{});

    while (true) {}
}

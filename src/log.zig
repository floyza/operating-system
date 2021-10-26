const std = @import("std");
const terminal = @import("terminal.zig");
const serial = @import("serial.zig");

pub fn printk(comptime fmt: []const u8, args: anytype) void {
    var buf: [100]u8 = undefined;
    const str: []u8 = std.fmt.bufPrint(&buf, fmt, args) catch |_| {
        @panic("print() buffer ran out of memory");
    };
    terminal.write(str);
    serial.write(str);
}

pub fn printk_ln(comptime fmt: []const u8, args: anytype) void {
    var buf: [100]u8 = undefined;
    const str: []u8 = std.fmt.bufPrint(&buf, fmt, args) catch |_| {
        @panic("print() buffer ran out of memory");
    };
    terminal.write_ln(str);
    serial.write_ln(str);
}

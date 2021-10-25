const serial = @import("serial.zig");

pub const handler = fn () callconv(.Interrupt) void;

fn generic_handle(name: []const u8) noreturn {
    serial.write("Interrupt with id: ");
    serial.write_ln(name);
    @panic("Interrupt");
}

pub fn handle0() callconv(.Interrupt) void {
    generic_handle("0");
}

pub fn handle1() callconv(.Interrupt) void {
    generic_handle("1");
}

pub fn handle2() callconv(.Interrupt) void {
    generic_handle("2");
}

pub fn handle3() callconv(.Interrupt) void {
    generic_handle("3");
}

pub fn handle4() callconv(.Interrupt) void {
    generic_handle("4");
}

pub fn handle5() callconv(.Interrupt) void {
    generic_handle("5");
}

pub fn handle6() callconv(.Interrupt) void {
    generic_handle("6");
}

pub fn handle7() callconv(.Interrupt) void {
    generic_handle("7");
}

pub fn handle8() callconv(.Interrupt) void {
    generic_handle("8");
}

pub fn handle9() callconv(.Interrupt) void {
    generic_handle("9");
}

pub fn handle10() callconv(.Interrupt) void {
    generic_handle("10");
}

pub fn handle11() callconv(.Interrupt) void {
    generic_handle("11");
}

pub fn handle12() callconv(.Interrupt) void {
    generic_handle("12");
}

pub fn handle13() callconv(.Interrupt) void {
    generic_handle("13");
}

pub fn handle14() callconv(.Interrupt) void {
    generic_handle("14");
}

pub fn handle15() callconv(.Interrupt) void {
    generic_handle("15");
}

pub fn handle16() callconv(.Interrupt) void {
    generic_handle("16");
}

pub fn handle17() callconv(.Interrupt) void {
    generic_handle("17");
}

pub fn handle18() callconv(.Interrupt) void {
    generic_handle("18");
}

pub fn handle19() callconv(.Interrupt) void {
    generic_handle("19");
}

pub fn handle20() callconv(.Interrupt) void {
    generic_handle("20");
}

pub fn handle21() callconv(.Interrupt) void {
    generic_handle("21");
}

const Builder = @import("std").build.Builder;
const std = @import("std");

pub fn build(b: *Builder) void {
    // const target = b.standardTargetOptions(.{});
    const target = std.zig.CrossTarget{
        .cpu_arch = .i386,
        .os_tag = .freestanding,
        .abi = .none,
    };

    const mode = b.standardReleaseOptions();

    const kernel = b.addExecutable("os", "kernel.zig");
    kernel.setTarget(target);
    kernel.setBuildMode(mode);
    kernel.setLinkerScriptPath("linker.ld");
    kernel.setOutputDir("kernel");
    kernel.install();

    const common_params = [_][]const u8{ "qemu-system-i386", "-kernel", kernel.getOutputPath() };
    const debug_params = [_][]const u8{ "-s", "-S" };

    var qemu_params = std.ArrayList([]const u8).init(b.allocator);
    var qemu_debug_params = std.ArrayList([]const u8).init(b.allocator);
    for (common_params) |str| {
        qemu_params.append(str) catch unreachable;
        qemu_debug_params.append(str) catch unreachable;
    }
    for (debug_params) |str| {
        qemu_debug_params.append(str) catch unreachable;
    }

    const qemu = b.step("qemu", "Run the OS in qemu");
    const qemu_debug = b.step("qemu-debug", "Run the OS in qemu, waiting for a debugger to attach");

    const run_qemu = b.addSystemCommand(qemu_params.items);
    const run_qemu_debug = b.addSystemCommand(qemu_debug_params.items);

    run_qemu.step.dependOn(b.getInstallStep());
    run_qemu_debug.step.dependOn(b.getInstallStep());
    // run_qemu.step.dependOn(&kernel.step);
    // run_qemu_debug.step.dependOn(&kernel.step);

    qemu.dependOn(&run_qemu.step);
    qemu_debug.dependOn(&run_qemu_debug.step);
}

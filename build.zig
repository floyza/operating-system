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

    const kernel = b.addExecutable("os", "src/kernel.zig");
    kernel.addAssemblyFile("src/boot.s");
    kernel.setTarget(target);
    kernel.setBuildMode(mode);
    kernel.setLinkerScriptPath("src/linker.ld");
    kernel.setOutputDir("out");
    kernel.install();

    var tests = b.addTest("src/test.zig");

    const test_step = b.step("test", "Run all tests");
    test_step.dependOn(&tests.step);

    const common_params = [_][]const u8{ "qemu-system-i386", "-kernel", kernel.getOutputPath(), "-serial", "file:serial.txt" };
    const verbose_params = [_][]const u8{ "-d", "int,cpu_reset" };
    const debug_params = [_][]const u8{ "-s", "-S" };

    var qemu_params = std.ArrayList([]const u8).init(b.allocator);
    var qemu_verbose_params = std.ArrayList([]const u8).init(b.allocator);
    var qemu_debug_params = std.ArrayList([]const u8).init(b.allocator);
    for (common_params) |str| {
        qemu_params.append(str) catch unreachable;
        qemu_verbose_params.append(str) catch unreachable;
        qemu_debug_params.append(str) catch unreachable;
    }
    for (verbose_params) |str| {
        qemu_verbose_params.append(str) catch unreachable;
    }
    for (debug_params) |str| {
        qemu_debug_params.append(str) catch unreachable;
    }

    const qemu = b.step("qemu", "Run the OS in qemu");
    const qemu_verbose = b.step("qemu-verbose", "Run the OS in qemu, set to output more log messages");
    const qemu_debug = b.step("qemu-debug", "Run the OS in qemu, waiting for a debugger to attach");

    const run_qemu = b.addSystemCommand(qemu_params.items);
    const run_qemu_verbose = b.addSystemCommand(qemu_verbose_params.items);
    const run_qemu_debug = b.addSystemCommand(qemu_debug_params.items);

    run_qemu.step.dependOn(b.getInstallStep());
    run_qemu_verbose.step.dependOn(b.getInstallStep());
    run_qemu_debug.step.dependOn(b.getInstallStep());

    qemu.dependOn(&run_qemu.step);
    qemu_verbose.dependOn(&run_qemu_verbose.step);
    qemu_debug.dependOn(&run_qemu_debug.step);
}

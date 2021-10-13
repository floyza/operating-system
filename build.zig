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

    const exe = b.addExecutable("os", "hellos.zig");
    exe.addAssemblyFile("_start.s");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.setLinkerScriptPath("linker.ld");
    exe.install();
}

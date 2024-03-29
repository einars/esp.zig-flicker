const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zig",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    if (std.os.getenv("INCLUDE_DIRS")) |include_dirs| {
        var it = std.mem.tokenize(u8, include_dirs, ";");
        while (it.next()) |dir| {
            lib.addIncludePath(.{ .path = dir });
        }
    }

    b.installArtifact(lib);
}

const std = @import("std");
const Application = @import("core/application.zig").Application;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var app = Application.init(allocator) catch {
        std.process.exit(1);
    };
    defer app.deinit();

    try app.run();
}

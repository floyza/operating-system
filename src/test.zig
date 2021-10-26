const gdt = @import("gdt.zig");
const expect = @import("std").testing.expect;
const std = @import("std");

test "GDTSegmentDisc getters and setters" {
    var tbl: gdt.GDTSegmentDesc = .{};
    const l = (1 << 20) - 1;
    tbl.set_limit(l);
    try expect(tbl.get_limit() == l);
    const b = (1 << 32) - 1;
    tbl.set_base(b);
    try expect(tbl.get_base() == b);
}

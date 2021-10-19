const assert = @import("std").debug.assert;

const GDTSegmentDesc = packed struct {
    l0: u16,
    b0: u16,
    b1: u8,
    access: u8,
    l1: u4,
    flags: u4,
    b2: u8,
};

comptime {
    assert(@bitSizeOf(GDTSegmentDesc) == 64);
}

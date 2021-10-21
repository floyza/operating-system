const assert = @import("std").debug.assert;

pub var GDT align(8) = [_]GDTSegmentDesc{
    .{ .present = 1 },
    make_segment(0, 0xffffffff, EXECUTABLE),
    make_segment(0, 0xffffffff, DATA),
    .{ .present = 1 }, // tss segment
};

const EXPAND_DOWN: u32 = 1 << 0;
const EXECUTABLE: u32 = 1 << 1;
const DATA: u32 = 1 << 2;
const SYSTEM: u32 = 1 << 3;

pub const GDTSegmentDesc = packed struct {
    limit_low: u16 = 0,
    base_low: u24 = 0,
    accessed: u1 = 0,
    read_write: u1 = 0,
    conforming_expand_down: u1 = 0, // if code determines if conforming, if data enable growth downwards
    executable: u1 = 0, // 0=data, 1=code
    descriptor_type: u1 = 0, // 0=system, 1=code/data
    privilege_level: u2 = 0, // ring level
    present: u1 = 0, // set for any valid segment
    limit_high: u4 = 0,
    avaliable: u1 = 0,
    long: u1 = 0, // 64-bit code segment, size should be clear when set
    size: u1 = 0, // 0=16 bit, 1=32 bit
    page_granularity: u1 = 0, // if set, limit determines number of 4k pages instead of bytes
    base_high: u8 = 0,

    pub fn set_limit(self: *GDTSegmentDesc, limit: u20) void {
        self.limit_low = @truncate(u16, limit);
        self.limit_high = @truncate(u4, limit >> 16);
    }

    pub fn get_limit(self: GDTSegmentDesc) u20 {
        var limit: u20 = self.limit_high;
        limit <<= 16;
        limit |= self.limit_low;
        return limit;
    }

    pub fn set_base(self: *GDTSegmentDesc, base: u32) void {
        self.base_low = @truncate(u24, base);
        self.base_high = @truncate(u8, base >> 24);
    }

    pub fn get_base(self: GDTSegmentDesc) u32 {
        var base: u32 = self.base_high;
        base <<= 24;
        base |= self.base_low;
        return base;
    }
};

pub fn make_segment(base: u32, limit: u32, flags: u32) GDTSegmentDesc {
    var seg: GDTSegmentDesc = .{ .size = 1, .read_write = 1, .privilege_level = 0, .present = 1 };
    seg.set_base(base);
    if (limit <= 0xfffff) {
        seg.set_limit(@truncate(u20, limit));
    } else {
        seg.page_granularity = 1;
        seg.set_limit(@truncate(u20, limit >> 12));
    }
    if (flags & EXECUTABLE != 0) {
        seg.executable = 1;
        seg.descriptor_type = 1;
    } else if (flags & DATA != 0) {
        seg.descriptor_type = 1;
        if (flags & EXPAND_DOWN != 0) {
            seg.conforming_expand_down = 1;
        }
    } else if (flags & SYSTEM == 0) {
        // must have either EXECUTABLE, DATA or SYSTEM set
        unreachable;
    }
    return seg;
}

comptime {
    assert(@bitSizeOf(GDTSegmentDesc) == 64);
}

pub fn initialize() void {
    load_gdt();
}

const GDTLoader = packed struct {
    limit: u16,
    base_addr: *GDTSegmentDesc,
};

fn load_gdt() void {
    var combined: GDTLoader = .{ .base_addr = &GDT[0], .limit = @sizeOf(@TypeOf(GDT)) - 1 };
    asm volatile ("lgdt (%[val])"
        :
        : [val] "{eax}" (&combined)
    );
    // Load segments
    asm volatile (
        \\ljmp $0x08,$.reload_CS
        \\.reload_CS:
        \\movw $0x10, %%ax
        \\movw %%ax, %%ds
        \\movw %%ax, %%es
        \\movw %%ax, %%fs
        \\movw %%ax, %%gs
        \\movw %%ax, %%ss
    );
}

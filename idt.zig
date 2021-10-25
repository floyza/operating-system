const assert = @import("std").debug.assert;
const handlers = @import("idt-handlers.zig");

var IDT: [256]IDTEntry align(8) = undefined;

const Interrupt = struct {
    mnemonic: []const u8 = "",
    description: []const u8 = "",
    itype: Type,
    const Type = enum {
        Interrupt,
        Fault,
        Trap,
        Abort,
    };
};

pub const TaskGate = packed struct {
    _unused0: u16 = 0,
    tss_segment_selector: u16 = 0, // we don't have a tss segment yet
    _unused1: u8 = 0,
    _flags: u5 = 0b00101, // shows that this is a Task Gate
    privilege_level: u2 = 0,
    present: u1 = 0,
    _unused2: u16 = 0,
};

pub const InterruptGate = packed struct {
    offset_low: u16 = 0,
    segment_selector: u16 = 0x8, // code segment
    _unused: u5 = 0,
    _flags0: u3 = 0b000,
    _flags1: u5 = 0b01110, // 0b00110 if size of gate is 16 bits
    privilege_level: u2 = 0,
    present: u1 = 0,
    offset_high: u16 = 0,
};

pub fn set_interrupt_gate(index: usize, handler: handlers.handler) void {
    const offset: u32 = @ptrToInt(handler);
    var gate = InterruptGate{ .present = 1 };
    gate.offset_low = @truncate(u16, offset);
    gate.offset_high = @truncate(u16, offset >> 16);
    IDT[index] = IDTEntry{ .interrupt_gate = gate };
}

pub const TrapGate = packed struct {
    offset_low: u16 = 0,
    segment_selector: u16 = 0x8, // code segment
    _unused: u5 = 0,
    _flags0: u3 = 0b000,
    _flags1: u5 = 0b01111, // 0b00111 if size of gate is 16 bits
    privilege_level: u2 = 0,
    present: u1 = 0,
    offset_high: u16 = 0,
};

pub fn set_trap_gate(index: usize, handler: handlers.handler) void {
    const offset: u32 = @ptrToInt(u32, handler);
    var gate = TrapGate{ .present = 1 };
    gate.offset_low = @truncate(u16, offset);
    gate.offset_high = @truncate(u16, offset >> 16);
    IDT[index] = IDTEntry{ .trap_gate = gate };
}

pub const IDTEntry = packed union {
    task_gate: TaskGate,
    interrupt_gate: InterruptGate,
    trap_gate: TrapGate,
};

comptime {
    assert(@bitSizeOf(TaskGate) == 64);
    assert(@bitSizeOf(InterruptGate) == 64);
    assert(@bitSizeOf(TrapGate) == 64);
    assert(@bitSizeOf(IDTEntry) == 64);
}

pub const interrupt_table = [_]Interrupt{
    .{ .mnemonic = "#DE", .description = "Divide Error", .itype = Interrupt.Type.Fault },
    .{ .mnemonic = "#DB", .description = "Debug Exception", .itype = Interrupt.Type.Fault }, // or trap
};

pub fn initialize() void {
    load_idt();
}

const IDTLoader = packed struct {
    limit: u16,
    base_addr: *IDTEntry,
};

fn load_idt() void {
    set_interrupt_gate(0, handlers.handle0);
    set_interrupt_gate(1, handlers.handle1);
    set_interrupt_gate(2, handlers.handle2);
    set_interrupt_gate(3, handlers.handle3);
    set_interrupt_gate(4, handlers.handle4);
    set_interrupt_gate(5, handlers.handle5);
    set_interrupt_gate(6, handlers.handle6);
    set_interrupt_gate(7, handlers.handle7);
    set_interrupt_gate(8, handlers.handle8);
    set_interrupt_gate(9, handlers.handle9);
    set_interrupt_gate(10, handlers.handle10);
    set_interrupt_gate(11, handlers.handle11);
    set_interrupt_gate(12, handlers.handle12);
    set_interrupt_gate(13, handlers.handle13);
    set_interrupt_gate(14, handlers.handle14);
    set_interrupt_gate(15, handlers.handle15);
    set_interrupt_gate(16, handlers.handle16);
    set_interrupt_gate(17, handlers.handle17);
    set_interrupt_gate(18, handlers.handle18);
    set_interrupt_gate(19, handlers.handle19);
    set_interrupt_gate(20, handlers.handle20);
    set_interrupt_gate(21, handlers.handle21);

    const combined: IDTLoader = .{ .base_addr = &IDT[0], .limit = @sizeOf(@TypeOf(IDT)) };
    asm volatile ("lidt (%[val])"
        :
        : [val] "{eax}" (&combined)
    );
    asm volatile ("sti");
}

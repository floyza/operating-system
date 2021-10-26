const assert = @import("std").debug.assert;
const handlers = @import("idt_handlers.zig");

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

pub const IDTEntry = packed struct {
    offset_low: u16,
    segment_selector: u16,
    zero: u8 = 0,
    flags: u5, // 0b00101 for task gate, 0b01110 for interrupt gate, 0b01111 for trap gate
    privilege_level: u2,
    present: u1,
    offset_high: u16,
};

pub fn set_interrupt_gate(index: usize, handler: handlers.handler) void {
    const offset: u32 = @ptrToInt(handler);
    IDT[index] = IDTEntry{ .offset_low = @truncate(u16, offset), .segment_selector = 0x8, .flags = 0b01110, .privilege_level = 0, .present = 1, .offset_high = @truncate(u16, offset >> 16) };
}

pub fn set_trap_gate(index: usize, handler: handlers.handler) void {
    const offset: u32 = @ptrToInt(u32, handler);
    IDT[index] = IDTEntry{ .offset_low = @truncate(u16, offset), .segment_selector = 0x8, .flags = 0b01111, .privilege_level = 0, .present = 1, .offset_high = @truncate(u16, offset >> 16) };
}

comptime {
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
    set_interrupt_gate(22, handlers.handle22);
    set_interrupt_gate(23, handlers.handle23);
    set_interrupt_gate(24, handlers.handle24);
    set_interrupt_gate(25, handlers.handle25);
    set_interrupt_gate(26, handlers.handle26);
    set_interrupt_gate(27, handlers.handle27);
    set_interrupt_gate(28, handlers.handle28);
    set_interrupt_gate(29, handlers.handle29);
    set_interrupt_gate(30, handlers.handle30);
    set_interrupt_gate(31, handlers.handle31);
    set_interrupt_gate(32, handlers.handle32);
    set_interrupt_gate(33, handlers.handle33);
    set_interrupt_gate(34, handlers.handle34);
    set_interrupt_gate(35, handlers.handle35);
    set_interrupt_gate(36, handlers.handle36);
    set_interrupt_gate(37, handlers.handle37);
    set_interrupt_gate(38, handlers.handle38);
    set_interrupt_gate(39, handlers.handle39);
    set_interrupt_gate(40, handlers.handle40);
    set_interrupt_gate(41, handlers.handle41);
    set_interrupt_gate(42, handlers.handle42);
    set_interrupt_gate(43, handlers.handle43);
    set_interrupt_gate(44, handlers.handle44);
    set_interrupt_gate(45, handlers.handle45);
    set_interrupt_gate(46, handlers.handle46);
    set_interrupt_gate(47, handlers.handle47);
    set_interrupt_gate(48, handlers.handle48);
    set_interrupt_gate(49, handlers.handle49);
    set_interrupt_gate(50, handlers.handle50);
    set_interrupt_gate(51, handlers.handle51);
    set_interrupt_gate(52, handlers.handle52);
    set_interrupt_gate(53, handlers.handle53);
    set_interrupt_gate(54, handlers.handle54);
    set_interrupt_gate(55, handlers.handle55);
    set_interrupt_gate(56, handlers.handle56);
    set_interrupt_gate(57, handlers.handle57);
    set_interrupt_gate(58, handlers.handle58);
    set_interrupt_gate(59, handlers.handle59);
    set_interrupt_gate(60, handlers.handle60);
    set_interrupt_gate(61, handlers.handle61);
    set_interrupt_gate(62, handlers.handle62);
    set_interrupt_gate(63, handlers.handle63);
    set_interrupt_gate(64, handlers.handle64);
    set_interrupt_gate(65, handlers.handle65);
    set_interrupt_gate(66, handlers.handle66);
    set_interrupt_gate(67, handlers.handle67);
    set_interrupt_gate(68, handlers.handle68);
    set_interrupt_gate(69, handlers.handle69);
    set_interrupt_gate(70, handlers.handle70);
    set_interrupt_gate(71, handlers.handle71);
    set_interrupt_gate(72, handlers.handle72);
    set_interrupt_gate(73, handlers.handle73);
    set_interrupt_gate(74, handlers.handle74);
    set_interrupt_gate(75, handlers.handle75);
    set_interrupt_gate(76, handlers.handle76);
    set_interrupt_gate(77, handlers.handle77);
    set_interrupt_gate(78, handlers.handle78);
    set_interrupt_gate(79, handlers.handle79);
    set_interrupt_gate(80, handlers.handle80);
    set_interrupt_gate(81, handlers.handle81);
    set_interrupt_gate(82, handlers.handle82);
    set_interrupt_gate(83, handlers.handle83);
    set_interrupt_gate(84, handlers.handle84);
    set_interrupt_gate(85, handlers.handle85);
    set_interrupt_gate(86, handlers.handle86);
    set_interrupt_gate(87, handlers.handle87);
    set_interrupt_gate(88, handlers.handle88);
    set_interrupt_gate(89, handlers.handle89);
    set_interrupt_gate(90, handlers.handle90);
    set_interrupt_gate(91, handlers.handle91);
    set_interrupt_gate(92, handlers.handle92);
    set_interrupt_gate(93, handlers.handle93);
    set_interrupt_gate(94, handlers.handle94);
    set_interrupt_gate(95, handlers.handle95);
    set_interrupt_gate(96, handlers.handle96);
    set_interrupt_gate(97, handlers.handle97);
    set_interrupt_gate(98, handlers.handle98);
    set_interrupt_gate(99, handlers.handle99);
    set_interrupt_gate(100, handlers.handle100);
    set_interrupt_gate(101, handlers.handle101);
    set_interrupt_gate(102, handlers.handle102);
    set_interrupt_gate(103, handlers.handle103);
    set_interrupt_gate(104, handlers.handle104);
    set_interrupt_gate(105, handlers.handle105);
    set_interrupt_gate(106, handlers.handle106);
    set_interrupt_gate(107, handlers.handle107);
    set_interrupt_gate(108, handlers.handle108);
    set_interrupt_gate(109, handlers.handle109);
    set_interrupt_gate(110, handlers.handle110);
    set_interrupt_gate(111, handlers.handle111);
    set_interrupt_gate(112, handlers.handle112);
    set_interrupt_gate(113, handlers.handle113);
    set_interrupt_gate(114, handlers.handle114);
    set_interrupt_gate(115, handlers.handle115);
    set_interrupt_gate(116, handlers.handle116);
    set_interrupt_gate(117, handlers.handle117);
    set_interrupt_gate(118, handlers.handle118);
    set_interrupt_gate(119, handlers.handle119);
    set_interrupt_gate(120, handlers.handle120);
    set_interrupt_gate(121, handlers.handle121);
    set_interrupt_gate(122, handlers.handle122);
    set_interrupt_gate(123, handlers.handle123);
    set_interrupt_gate(124, handlers.handle124);
    set_interrupt_gate(125, handlers.handle125);
    set_interrupt_gate(126, handlers.handle126);
    set_interrupt_gate(127, handlers.handle127);
    set_interrupt_gate(128, handlers.handle128);
    set_interrupt_gate(129, handlers.handle129);
    set_interrupt_gate(130, handlers.handle130);
    set_interrupt_gate(131, handlers.handle131);
    set_interrupt_gate(132, handlers.handle132);
    set_interrupt_gate(133, handlers.handle133);
    set_interrupt_gate(134, handlers.handle134);
    set_interrupt_gate(135, handlers.handle135);
    set_interrupt_gate(136, handlers.handle136);
    set_interrupt_gate(137, handlers.handle137);
    set_interrupt_gate(138, handlers.handle138);
    set_interrupt_gate(139, handlers.handle139);
    set_interrupt_gate(140, handlers.handle140);
    set_interrupt_gate(141, handlers.handle141);
    set_interrupt_gate(142, handlers.handle142);
    set_interrupt_gate(143, handlers.handle143);
    set_interrupt_gate(144, handlers.handle144);
    set_interrupt_gate(145, handlers.handle145);
    set_interrupt_gate(146, handlers.handle146);
    set_interrupt_gate(147, handlers.handle147);
    set_interrupt_gate(148, handlers.handle148);
    set_interrupt_gate(149, handlers.handle149);
    set_interrupt_gate(150, handlers.handle150);
    set_interrupt_gate(151, handlers.handle151);
    set_interrupt_gate(152, handlers.handle152);
    set_interrupt_gate(153, handlers.handle153);
    set_interrupt_gate(154, handlers.handle154);
    set_interrupt_gate(155, handlers.handle155);
    set_interrupt_gate(156, handlers.handle156);
    set_interrupt_gate(157, handlers.handle157);
    set_interrupt_gate(158, handlers.handle158);
    set_interrupt_gate(159, handlers.handle159);
    set_interrupt_gate(160, handlers.handle160);
    set_interrupt_gate(161, handlers.handle161);
    set_interrupt_gate(162, handlers.handle162);
    set_interrupt_gate(163, handlers.handle163);
    set_interrupt_gate(164, handlers.handle164);
    set_interrupt_gate(165, handlers.handle165);
    set_interrupt_gate(166, handlers.handle166);
    set_interrupt_gate(167, handlers.handle167);
    set_interrupt_gate(168, handlers.handle168);
    set_interrupt_gate(169, handlers.handle169);
    set_interrupt_gate(170, handlers.handle170);
    set_interrupt_gate(171, handlers.handle171);
    set_interrupt_gate(172, handlers.handle172);
    set_interrupt_gate(173, handlers.handle173);
    set_interrupt_gate(174, handlers.handle174);
    set_interrupt_gate(175, handlers.handle175);
    set_interrupt_gate(176, handlers.handle176);
    set_interrupt_gate(177, handlers.handle177);
    set_interrupt_gate(178, handlers.handle178);
    set_interrupt_gate(179, handlers.handle179);
    set_interrupt_gate(180, handlers.handle180);
    set_interrupt_gate(181, handlers.handle181);
    set_interrupt_gate(182, handlers.handle182);
    set_interrupt_gate(183, handlers.handle183);
    set_interrupt_gate(184, handlers.handle184);
    set_interrupt_gate(185, handlers.handle185);
    set_interrupt_gate(186, handlers.handle186);
    set_interrupt_gate(187, handlers.handle187);
    set_interrupt_gate(188, handlers.handle188);
    set_interrupt_gate(189, handlers.handle189);
    set_interrupt_gate(190, handlers.handle190);
    set_interrupt_gate(191, handlers.handle191);
    set_interrupt_gate(192, handlers.handle192);
    set_interrupt_gate(193, handlers.handle193);
    set_interrupt_gate(194, handlers.handle194);
    set_interrupt_gate(195, handlers.handle195);
    set_interrupt_gate(196, handlers.handle196);
    set_interrupt_gate(197, handlers.handle197);
    set_interrupt_gate(198, handlers.handle198);
    set_interrupt_gate(199, handlers.handle199);
    set_interrupt_gate(200, handlers.handle200);
    set_interrupt_gate(201, handlers.handle201);
    set_interrupt_gate(202, handlers.handle202);
    set_interrupt_gate(203, handlers.handle203);
    set_interrupt_gate(204, handlers.handle204);
    set_interrupt_gate(205, handlers.handle205);
    set_interrupt_gate(206, handlers.handle206);
    set_interrupt_gate(207, handlers.handle207);
    set_interrupt_gate(208, handlers.handle208);
    set_interrupt_gate(209, handlers.handle209);
    set_interrupt_gate(210, handlers.handle210);
    set_interrupt_gate(211, handlers.handle211);
    set_interrupt_gate(212, handlers.handle212);
    set_interrupt_gate(213, handlers.handle213);
    set_interrupt_gate(214, handlers.handle214);
    set_interrupt_gate(215, handlers.handle215);
    set_interrupt_gate(216, handlers.handle216);
    set_interrupt_gate(217, handlers.handle217);
    set_interrupt_gate(218, handlers.handle218);
    set_interrupt_gate(219, handlers.handle219);
    set_interrupt_gate(220, handlers.handle220);
    set_interrupt_gate(221, handlers.handle221);
    set_interrupt_gate(222, handlers.handle222);
    set_interrupt_gate(223, handlers.handle223);
    set_interrupt_gate(224, handlers.handle224);
    set_interrupt_gate(225, handlers.handle225);
    set_interrupt_gate(226, handlers.handle226);
    set_interrupt_gate(227, handlers.handle227);
    set_interrupt_gate(228, handlers.handle228);
    set_interrupt_gate(229, handlers.handle229);
    set_interrupt_gate(230, handlers.handle230);
    set_interrupt_gate(231, handlers.handle231);
    set_interrupt_gate(232, handlers.handle232);
    set_interrupt_gate(233, handlers.handle233);
    set_interrupt_gate(234, handlers.handle234);
    set_interrupt_gate(235, handlers.handle235);
    set_interrupt_gate(236, handlers.handle236);
    set_interrupt_gate(237, handlers.handle237);
    set_interrupt_gate(238, handlers.handle238);
    set_interrupt_gate(239, handlers.handle239);
    set_interrupt_gate(240, handlers.handle240);
    set_interrupt_gate(241, handlers.handle241);
    set_interrupt_gate(242, handlers.handle242);
    set_interrupt_gate(243, handlers.handle243);
    set_interrupt_gate(244, handlers.handle244);
    set_interrupt_gate(245, handlers.handle245);
    set_interrupt_gate(246, handlers.handle246);
    set_interrupt_gate(247, handlers.handle247);
    set_interrupt_gate(248, handlers.handle248);
    set_interrupt_gate(249, handlers.handle249);
    set_interrupt_gate(250, handlers.handle250);
    set_interrupt_gate(251, handlers.handle251);
    set_interrupt_gate(252, handlers.handle252);
    set_interrupt_gate(253, handlers.handle253);
    set_interrupt_gate(254, handlers.handle254);
    set_interrupt_gate(255, handlers.handle255);

    const combined: IDTLoader = .{ .base_addr = &IDT[0], .limit = @sizeOf(@TypeOf(IDT)) };
    asm volatile ("lidt (%[val])"
        :
        : [val] "{eax}" (&combined)
    );
    asm volatile ("sti");
}

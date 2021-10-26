const serial = @import("serial.zig");
const log = @import("log.zig");

pub const handler = fn () callconv(.Interrupt) void;

fn generic_handle(name: []const u8) noreturn {
    log.printk_ln("Interrupt with id: {s}", .{name});
    @panic("Interrupt");
}

pub fn handle0() callconv(.Interrupt) void {
    generic_handle("0");
}

pub fn handle1() callconv(.Interrupt) void {
    generic_handle("1");
}

pub fn handle2() callconv(.Interrupt) void {
    generic_handle("2");
}

pub fn handle3() callconv(.Interrupt) void {
    generic_handle("3");
}

pub fn handle4() callconv(.Interrupt) void {
    generic_handle("4");
}

pub fn handle5() callconv(.Interrupt) void {
    generic_handle("5");
}

pub fn handle6() callconv(.Interrupt) void {
    generic_handle("6");
}

pub fn handle7() callconv(.Interrupt) void {
    generic_handle("7");
}

pub fn handle8() callconv(.Interrupt) void {
    generic_handle("8");
}

pub fn handle9() callconv(.Interrupt) void {
    generic_handle("9");
}

pub fn handle10() callconv(.Interrupt) void {
    generic_handle("10");
}

pub fn handle11() callconv(.Interrupt) void {
    generic_handle("11");
}

pub fn handle12() callconv(.Interrupt) void {
    generic_handle("12");
}

pub fn handle13() callconv(.Interrupt) void {
    generic_handle("13");
}

pub fn handle14() callconv(.Interrupt) void {
    generic_handle("14");
}

pub fn handle15() callconv(.Interrupt) void {
    generic_handle("15");
}

pub fn handle16() callconv(.Interrupt) void {
    generic_handle("16");
}

pub fn handle17() callconv(.Interrupt) void {
    generic_handle("17");
}

pub fn handle18() callconv(.Interrupt) void {
    generic_handle("18");
}

pub fn handle19() callconv(.Interrupt) void {
    generic_handle("19");
}

pub fn handle20() callconv(.Interrupt) void {
    generic_handle("20");
}

pub fn handle21() callconv(.Interrupt) void {
    generic_handle("21");
}

pub fn handle22() callconv(.Interrupt) void {
    generic_handle("22");
}

pub fn handle23() callconv(.Interrupt) void {
    generic_handle("23");
}

pub fn handle24() callconv(.Interrupt) void {
    generic_handle("24");
}

pub fn handle25() callconv(.Interrupt) void {
    generic_handle("25");
}

pub fn handle26() callconv(.Interrupt) void {
    generic_handle("26");
}

pub fn handle27() callconv(.Interrupt) void {
    generic_handle("27");
}

pub fn handle28() callconv(.Interrupt) void {
    generic_handle("28");
}

pub fn handle29() callconv(.Interrupt) void {
    generic_handle("29");
}

pub fn handle30() callconv(.Interrupt) void {
    generic_handle("30");
}

pub fn handle31() callconv(.Interrupt) void {
    generic_handle("31");
}

pub fn handle32() callconv(.Interrupt) void {
    generic_handle("32");
}

pub fn handle33() callconv(.Interrupt) void {
    generic_handle("33");
}

pub fn handle34() callconv(.Interrupt) void {
    generic_handle("34");
}

pub fn handle35() callconv(.Interrupt) void {
    generic_handle("35");
}

pub fn handle36() callconv(.Interrupt) void {
    generic_handle("36");
}

pub fn handle37() callconv(.Interrupt) void {
    generic_handle("37");
}

pub fn handle38() callconv(.Interrupt) void {
    generic_handle("38");
}

pub fn handle39() callconv(.Interrupt) void {
    generic_handle("39");
}

pub fn handle40() callconv(.Interrupt) void {
    generic_handle("40");
}

pub fn handle41() callconv(.Interrupt) void {
    generic_handle("41");
}

pub fn handle42() callconv(.Interrupt) void {
    generic_handle("42");
}

pub fn handle43() callconv(.Interrupt) void {
    generic_handle("43");
}

pub fn handle44() callconv(.Interrupt) void {
    generic_handle("44");
}

pub fn handle45() callconv(.Interrupt) void {
    generic_handle("45");
}

pub fn handle46() callconv(.Interrupt) void {
    generic_handle("46");
}

pub fn handle47() callconv(.Interrupt) void {
    generic_handle("47");
}

pub fn handle48() callconv(.Interrupt) void {
    generic_handle("48");
}

pub fn handle49() callconv(.Interrupt) void {
    generic_handle("49");
}

pub fn handle50() callconv(.Interrupt) void {
    generic_handle("50");
}

pub fn handle51() callconv(.Interrupt) void {
    generic_handle("51");
}

pub fn handle52() callconv(.Interrupt) void {
    generic_handle("52");
}

pub fn handle53() callconv(.Interrupt) void {
    generic_handle("53");
}

pub fn handle54() callconv(.Interrupt) void {
    generic_handle("54");
}

pub fn handle55() callconv(.Interrupt) void {
    generic_handle("55");
}

pub fn handle56() callconv(.Interrupt) void {
    generic_handle("56");
}

pub fn handle57() callconv(.Interrupt) void {
    generic_handle("57");
}

pub fn handle58() callconv(.Interrupt) void {
    generic_handle("58");
}

pub fn handle59() callconv(.Interrupt) void {
    generic_handle("59");
}

pub fn handle60() callconv(.Interrupt) void {
    generic_handle("60");
}

pub fn handle61() callconv(.Interrupt) void {
    generic_handle("61");
}

pub fn handle62() callconv(.Interrupt) void {
    generic_handle("62");
}

pub fn handle63() callconv(.Interrupt) void {
    generic_handle("63");
}

pub fn handle64() callconv(.Interrupt) void {
    generic_handle("64");
}

pub fn handle65() callconv(.Interrupt) void {
    generic_handle("65");
}

pub fn handle66() callconv(.Interrupt) void {
    generic_handle("66");
}

pub fn handle67() callconv(.Interrupt) void {
    generic_handle("67");
}

pub fn handle68() callconv(.Interrupt) void {
    generic_handle("68");
}

pub fn handle69() callconv(.Interrupt) void {
    generic_handle("69");
}

pub fn handle70() callconv(.Interrupt) void {
    generic_handle("70");
}

pub fn handle71() callconv(.Interrupt) void {
    generic_handle("71");
}

pub fn handle72() callconv(.Interrupt) void {
    generic_handle("72");
}

pub fn handle73() callconv(.Interrupt) void {
    generic_handle("73");
}

pub fn handle74() callconv(.Interrupt) void {
    generic_handle("74");
}

pub fn handle75() callconv(.Interrupt) void {
    generic_handle("75");
}

pub fn handle76() callconv(.Interrupt) void {
    generic_handle("76");
}

pub fn handle77() callconv(.Interrupt) void {
    generic_handle("77");
}

pub fn handle78() callconv(.Interrupt) void {
    generic_handle("78");
}

pub fn handle79() callconv(.Interrupt) void {
    generic_handle("79");
}

pub fn handle80() callconv(.Interrupt) void {
    generic_handle("80");
}

pub fn handle81() callconv(.Interrupt) void {
    generic_handle("81");
}

pub fn handle82() callconv(.Interrupt) void {
    generic_handle("82");
}

pub fn handle83() callconv(.Interrupt) void {
    generic_handle("83");
}

pub fn handle84() callconv(.Interrupt) void {
    generic_handle("84");
}

pub fn handle85() callconv(.Interrupt) void {
    generic_handle("85");
}

pub fn handle86() callconv(.Interrupt) void {
    generic_handle("86");
}

pub fn handle87() callconv(.Interrupt) void {
    generic_handle("87");
}

pub fn handle88() callconv(.Interrupt) void {
    generic_handle("88");
}

pub fn handle89() callconv(.Interrupt) void {
    generic_handle("89");
}

pub fn handle90() callconv(.Interrupt) void {
    generic_handle("90");
}

pub fn handle91() callconv(.Interrupt) void {
    generic_handle("91");
}

pub fn handle92() callconv(.Interrupt) void {
    generic_handle("92");
}

pub fn handle93() callconv(.Interrupt) void {
    generic_handle("93");
}

pub fn handle94() callconv(.Interrupt) void {
    generic_handle("94");
}

pub fn handle95() callconv(.Interrupt) void {
    generic_handle("95");
}

pub fn handle96() callconv(.Interrupt) void {
    generic_handle("96");
}

pub fn handle97() callconv(.Interrupt) void {
    generic_handle("97");
}

pub fn handle98() callconv(.Interrupt) void {
    generic_handle("98");
}

pub fn handle99() callconv(.Interrupt) void {
    generic_handle("99");
}

pub fn handle100() callconv(.Interrupt) void {
    generic_handle("100");
}

pub fn handle101() callconv(.Interrupt) void {
    generic_handle("101");
}

pub fn handle102() callconv(.Interrupt) void {
    generic_handle("102");
}

pub fn handle103() callconv(.Interrupt) void {
    generic_handle("103");
}

pub fn handle104() callconv(.Interrupt) void {
    generic_handle("104");
}

pub fn handle105() callconv(.Interrupt) void {
    generic_handle("105");
}

pub fn handle106() callconv(.Interrupt) void {
    generic_handle("106");
}

pub fn handle107() callconv(.Interrupt) void {
    generic_handle("107");
}

pub fn handle108() callconv(.Interrupt) void {
    generic_handle("108");
}

pub fn handle109() callconv(.Interrupt) void {
    generic_handle("109");
}

pub fn handle110() callconv(.Interrupt) void {
    generic_handle("110");
}

pub fn handle111() callconv(.Interrupt) void {
    generic_handle("111");
}

pub fn handle112() callconv(.Interrupt) void {
    generic_handle("112");
}

pub fn handle113() callconv(.Interrupt) void {
    generic_handle("113");
}

pub fn handle114() callconv(.Interrupt) void {
    generic_handle("114");
}

pub fn handle115() callconv(.Interrupt) void {
    generic_handle("115");
}

pub fn handle116() callconv(.Interrupt) void {
    generic_handle("116");
}

pub fn handle117() callconv(.Interrupt) void {
    generic_handle("117");
}

pub fn handle118() callconv(.Interrupt) void {
    generic_handle("118");
}

pub fn handle119() callconv(.Interrupt) void {
    generic_handle("119");
}

pub fn handle120() callconv(.Interrupt) void {
    generic_handle("120");
}

pub fn handle121() callconv(.Interrupt) void {
    generic_handle("121");
}

pub fn handle122() callconv(.Interrupt) void {
    generic_handle("122");
}

pub fn handle123() callconv(.Interrupt) void {
    generic_handle("123");
}

pub fn handle124() callconv(.Interrupt) void {
    generic_handle("124");
}

pub fn handle125() callconv(.Interrupt) void {
    generic_handle("125");
}

pub fn handle126() callconv(.Interrupt) void {
    generic_handle("126");
}

pub fn handle127() callconv(.Interrupt) void {
    generic_handle("127");
}

pub fn handle128() callconv(.Interrupt) void {
    generic_handle("128");
}

pub fn handle129() callconv(.Interrupt) void {
    generic_handle("129");
}

pub fn handle130() callconv(.Interrupt) void {
    generic_handle("130");
}

pub fn handle131() callconv(.Interrupt) void {
    generic_handle("131");
}

pub fn handle132() callconv(.Interrupt) void {
    generic_handle("132");
}

pub fn handle133() callconv(.Interrupt) void {
    generic_handle("133");
}

pub fn handle134() callconv(.Interrupt) void {
    generic_handle("134");
}

pub fn handle135() callconv(.Interrupt) void {
    generic_handle("135");
}

pub fn handle136() callconv(.Interrupt) void {
    generic_handle("136");
}

pub fn handle137() callconv(.Interrupt) void {
    generic_handle("137");
}

pub fn handle138() callconv(.Interrupt) void {
    generic_handle("138");
}

pub fn handle139() callconv(.Interrupt) void {
    generic_handle("139");
}

pub fn handle140() callconv(.Interrupt) void {
    generic_handle("140");
}

pub fn handle141() callconv(.Interrupt) void {
    generic_handle("141");
}

pub fn handle142() callconv(.Interrupt) void {
    generic_handle("142");
}

pub fn handle143() callconv(.Interrupt) void {
    generic_handle("143");
}

pub fn handle144() callconv(.Interrupt) void {
    generic_handle("144");
}

pub fn handle145() callconv(.Interrupt) void {
    generic_handle("145");
}

pub fn handle146() callconv(.Interrupt) void {
    generic_handle("146");
}

pub fn handle147() callconv(.Interrupt) void {
    generic_handle("147");
}

pub fn handle148() callconv(.Interrupt) void {
    generic_handle("148");
}

pub fn handle149() callconv(.Interrupt) void {
    generic_handle("149");
}

pub fn handle150() callconv(.Interrupt) void {
    generic_handle("150");
}

pub fn handle151() callconv(.Interrupt) void {
    generic_handle("151");
}

pub fn handle152() callconv(.Interrupt) void {
    generic_handle("152");
}

pub fn handle153() callconv(.Interrupt) void {
    generic_handle("153");
}

pub fn handle154() callconv(.Interrupt) void {
    generic_handle("154");
}

pub fn handle155() callconv(.Interrupt) void {
    generic_handle("155");
}

pub fn handle156() callconv(.Interrupt) void {
    generic_handle("156");
}

pub fn handle157() callconv(.Interrupt) void {
    generic_handle("157");
}

pub fn handle158() callconv(.Interrupt) void {
    generic_handle("158");
}

pub fn handle159() callconv(.Interrupt) void {
    generic_handle("159");
}

pub fn handle160() callconv(.Interrupt) void {
    generic_handle("160");
}

pub fn handle161() callconv(.Interrupt) void {
    generic_handle("161");
}

pub fn handle162() callconv(.Interrupt) void {
    generic_handle("162");
}

pub fn handle163() callconv(.Interrupt) void {
    generic_handle("163");
}

pub fn handle164() callconv(.Interrupt) void {
    generic_handle("164");
}

pub fn handle165() callconv(.Interrupt) void {
    generic_handle("165");
}

pub fn handle166() callconv(.Interrupt) void {
    generic_handle("166");
}

pub fn handle167() callconv(.Interrupt) void {
    generic_handle("167");
}

pub fn handle168() callconv(.Interrupt) void {
    generic_handle("168");
}

pub fn handle169() callconv(.Interrupt) void {
    generic_handle("169");
}

pub fn handle170() callconv(.Interrupt) void {
    generic_handle("170");
}

pub fn handle171() callconv(.Interrupt) void {
    generic_handle("171");
}

pub fn handle172() callconv(.Interrupt) void {
    generic_handle("172");
}

pub fn handle173() callconv(.Interrupt) void {
    generic_handle("173");
}

pub fn handle174() callconv(.Interrupt) void {
    generic_handle("174");
}

pub fn handle175() callconv(.Interrupt) void {
    generic_handle("175");
}

pub fn handle176() callconv(.Interrupt) void {
    generic_handle("176");
}

pub fn handle177() callconv(.Interrupt) void {
    generic_handle("177");
}

pub fn handle178() callconv(.Interrupt) void {
    generic_handle("178");
}

pub fn handle179() callconv(.Interrupt) void {
    generic_handle("179");
}

pub fn handle180() callconv(.Interrupt) void {
    generic_handle("180");
}

pub fn handle181() callconv(.Interrupt) void {
    generic_handle("181");
}

pub fn handle182() callconv(.Interrupt) void {
    generic_handle("182");
}

pub fn handle183() callconv(.Interrupt) void {
    generic_handle("183");
}

pub fn handle184() callconv(.Interrupt) void {
    generic_handle("184");
}

pub fn handle185() callconv(.Interrupt) void {
    generic_handle("185");
}

pub fn handle186() callconv(.Interrupt) void {
    generic_handle("186");
}

pub fn handle187() callconv(.Interrupt) void {
    generic_handle("187");
}

pub fn handle188() callconv(.Interrupt) void {
    generic_handle("188");
}

pub fn handle189() callconv(.Interrupt) void {
    generic_handle("189");
}

pub fn handle190() callconv(.Interrupt) void {
    generic_handle("190");
}

pub fn handle191() callconv(.Interrupt) void {
    generic_handle("191");
}

pub fn handle192() callconv(.Interrupt) void {
    generic_handle("192");
}

pub fn handle193() callconv(.Interrupt) void {
    generic_handle("193");
}

pub fn handle194() callconv(.Interrupt) void {
    generic_handle("194");
}

pub fn handle195() callconv(.Interrupt) void {
    generic_handle("195");
}

pub fn handle196() callconv(.Interrupt) void {
    generic_handle("196");
}

pub fn handle197() callconv(.Interrupt) void {
    generic_handle("197");
}

pub fn handle198() callconv(.Interrupt) void {
    generic_handle("198");
}

pub fn handle199() callconv(.Interrupt) void {
    generic_handle("199");
}

pub fn handle200() callconv(.Interrupt) void {
    generic_handle("200");
}

pub fn handle201() callconv(.Interrupt) void {
    generic_handle("201");
}

pub fn handle202() callconv(.Interrupt) void {
    generic_handle("202");
}

pub fn handle203() callconv(.Interrupt) void {
    generic_handle("203");
}

pub fn handle204() callconv(.Interrupt) void {
    generic_handle("204");
}

pub fn handle205() callconv(.Interrupt) void {
    generic_handle("205");
}

pub fn handle206() callconv(.Interrupt) void {
    generic_handle("206");
}

pub fn handle207() callconv(.Interrupt) void {
    generic_handle("207");
}

pub fn handle208() callconv(.Interrupt) void {
    generic_handle("208");
}

pub fn handle209() callconv(.Interrupt) void {
    generic_handle("209");
}

pub fn handle210() callconv(.Interrupt) void {
    generic_handle("210");
}

pub fn handle211() callconv(.Interrupt) void {
    generic_handle("211");
}

pub fn handle212() callconv(.Interrupt) void {
    generic_handle("212");
}

pub fn handle213() callconv(.Interrupt) void {
    generic_handle("213");
}

pub fn handle214() callconv(.Interrupt) void {
    generic_handle("214");
}

pub fn handle215() callconv(.Interrupt) void {
    generic_handle("215");
}

pub fn handle216() callconv(.Interrupt) void {
    generic_handle("216");
}

pub fn handle217() callconv(.Interrupt) void {
    generic_handle("217");
}

pub fn handle218() callconv(.Interrupt) void {
    generic_handle("218");
}

pub fn handle219() callconv(.Interrupt) void {
    generic_handle("219");
}

pub fn handle220() callconv(.Interrupt) void {
    generic_handle("220");
}

pub fn handle221() callconv(.Interrupt) void {
    generic_handle("221");
}

pub fn handle222() callconv(.Interrupt) void {
    generic_handle("222");
}

pub fn handle223() callconv(.Interrupt) void {
    generic_handle("223");
}

pub fn handle224() callconv(.Interrupt) void {
    generic_handle("224");
}

pub fn handle225() callconv(.Interrupt) void {
    generic_handle("225");
}

pub fn handle226() callconv(.Interrupt) void {
    generic_handle("226");
}

pub fn handle227() callconv(.Interrupt) void {
    generic_handle("227");
}

pub fn handle228() callconv(.Interrupt) void {
    generic_handle("228");
}

pub fn handle229() callconv(.Interrupt) void {
    generic_handle("229");
}

pub fn handle230() callconv(.Interrupt) void {
    generic_handle("230");
}

pub fn handle231() callconv(.Interrupt) void {
    generic_handle("231");
}

pub fn handle232() callconv(.Interrupt) void {
    generic_handle("232");
}

pub fn handle233() callconv(.Interrupt) void {
    generic_handle("233");
}

pub fn handle234() callconv(.Interrupt) void {
    generic_handle("234");
}

pub fn handle235() callconv(.Interrupt) void {
    generic_handle("235");
}

pub fn handle236() callconv(.Interrupt) void {
    generic_handle("236");
}

pub fn handle237() callconv(.Interrupt) void {
    generic_handle("237");
}

pub fn handle238() callconv(.Interrupt) void {
    generic_handle("238");
}

pub fn handle239() callconv(.Interrupt) void {
    generic_handle("239");
}

pub fn handle240() callconv(.Interrupt) void {
    generic_handle("240");
}

pub fn handle241() callconv(.Interrupt) void {
    generic_handle("241");
}

pub fn handle242() callconv(.Interrupt) void {
    generic_handle("242");
}

pub fn handle243() callconv(.Interrupt) void {
    generic_handle("243");
}

pub fn handle244() callconv(.Interrupt) void {
    generic_handle("244");
}

pub fn handle245() callconv(.Interrupt) void {
    generic_handle("245");
}

pub fn handle246() callconv(.Interrupt) void {
    generic_handle("246");
}

pub fn handle247() callconv(.Interrupt) void {
    generic_handle("247");
}

pub fn handle248() callconv(.Interrupt) void {
    generic_handle("248");
}

pub fn handle249() callconv(.Interrupt) void {
    generic_handle("249");
}

pub fn handle250() callconv(.Interrupt) void {
    generic_handle("250");
}

pub fn handle251() callconv(.Interrupt) void {
    generic_handle("251");
}

pub fn handle252() callconv(.Interrupt) void {
    generic_handle("252");
}

pub fn handle253() callconv(.Interrupt) void {
    generic_handle("253");
}

pub fn handle254() callconv(.Interrupt) void {
    generic_handle("254");
}

pub fn handle255() callconv(.Interrupt) void {
    generic_handle("255");
}

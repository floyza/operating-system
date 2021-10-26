const native_endian = @import("builtin").target.cpu.arch.endian();
usingnamespace @import("io.zig");

const SerialError = error{
    MissingPort,
    FaultyPort,
};

// returns first serial port avaliable
pub fn get_serial_bios() SerialError!u16 {
    const bios_data_serial = @intToPtr([*]volatile u16, 0x0400);
    var i: u8 = 0;
    while (i < 4) : (i += 1) {
        if (bios_data_serial[i] != 0)
            return bios_data_serial[i];
    }
    return SerialError.MissingPort;
}

const active_serial: u16 = 0x3F8;

pub fn initialize() SerialError!void {
    if (native_endian == .Big) {
        // we do not support big endian
        @compileError("big endian not supported for serial communication");
    }
    // active_serial = try get_serial_bios();

    outb(active_serial + 1, 0x00); // Disable interupts

    outb(active_serial + 3, 0x1 << 7); // enable dlab (set baud rate divisor)
    outb(active_serial + 0, 0x03); // set divisor to 3 (lo byte) 38400 baud
    outb(active_serial + 1, 0x00); //                  (hi byte)
    outb(active_serial + 3, 0x03); // disable dlab, set 8 bits, no parity, one stop bit

    // Test serial port
    outb(active_serial + 2, 0xC7); // Enable FIFO, clear them, with 14-byte threshold
    outb(active_serial + 4, 0x0B); // IRQs enabled, RTS/DSR set
    outb(active_serial + 4, 0x1E); // loopback mode
    outb(active_serial + 0, 0xAE);
    if (inb(active_serial + 0) != 0xAE) {
        return SerialError.FaultyPort;
    }
    // Set it back to normal operation:
    // (loopback disabled, IRQS enabled, OUT#1 and OUT#2 bits enabled)
    outb(active_serial + 4, 0x0F);
}

pub fn get() u8 {
    while ((inb(active_serial + 5) & 1) == 0) {
        // wait
    }
    return inb(active_serial + 0);
}

pub fn put(c: u8) void {
    while ((inb(active_serial + 5) & (1 << 5)) == 0) {
        // wait until Transmitter holding register empty (THRE) is set so data can be sent
    }
    outb(active_serial + 0, c);
}

pub fn write(data: []const u8) void {
    for (data) |c| {
        put(c);
    }
}

pub fn write_ln(data: []const u8) void {
    write(data);
    put('\r');
    put('\n');
}

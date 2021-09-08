const native_endian = @import("builtin").target.cpu.arch.endian();

const SerialPort = packed struct {
    // when DLAB=1, data+interupt_enable is a u16 for setting baud rate
    data: u8,
    interupt_enable: u8,
    inter_id_fifo_control: u8,
    line_ctrl: u8,
    modem_ctrl: u8,
    line_status: u8, // msb is DLAB
    modem_status: u8,
    scratch: u8,
};

const SerialError = error{
    MissingPort,
    FaultyPort,
};

// returns first serial port avaliable
pub fn get_serial() SerialError!*volatile SerialPort {
    const bios_data_serial = @intToPtr([*]volatile u16, 0x0400);
    var i: u8 = 0;
    while (i < 4) : (i += 1) {
        if (bios_data_serial[i] != 0)
            return @intToPtr(*volatile SerialPort, bios_data_serial[i]);
    }
    return SerialError.MissingPort;
}

var active_serial: *volatile SerialPort = undefined;

pub fn initialize() !void {
    if (native_endian == .Big) {
        // we do not support big endian
        @compileError("big endian not supported for serial communication");
    }
    // active_serial = try get_serial();
    active_serial = @intToPtr(*volatile SerialPort, 0x3F8);

    active_serial.interupt_enable = 0x00; // Disable interupts

    active_serial.line_ctrl |= 0x1 << 7; // enable dlab
    active_serial.data = 0x03; // set divisor to 3 (lo byte) 38400 baud
    active_serial.interupt_enable = 0x00; //       (hi byte)
    active_serial.line_ctrl ^= 0x1 << 7; // disable dlab

    active_serial.line_ctrl |= 0b10; // 8 data bits
    active_serial.line_ctrl &= ~@intCast(u8, 0x1 << 6); // 1 stop bit
    active_serial.line_ctrl &= ~@intCast(u8, 0x1 << 5); // no parity

    // Test serial port
    active_serial.modem_ctrl = 0x1E; // loopback mode
    active_serial.data = 0xAE;
    if (active_serial.data != 0xAE) {
        return SerialError.FaultyPort;
    }
    // Set it back to normal operation:
    // (loopback disabled, IRQS enabled, OUT#1 and OUT#2 bits enabled)
    active_serial.modem_ctrl = 0x0F;
}

pub fn read() u8 {
    while (active_serial.line_status & 1 == 0) {
        // wait
    }
    return active_serial.data;
}

pub fn write(c: u8) void {
    while (active_serial.line_status & 0x20 == 0) {
        // wait
    }
    active_serial.data = c;
}

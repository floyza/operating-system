// Hardware text mode color constants
const VgaColor = u8;
const VGA_COLOR_BLACK = 0;
const VGA_COLOR_BLUE = 1;
const VGA_COLOR_GREEN = 2;
const VGA_COLOR_CYAN = 3;
const VGA_COLOR_RED = 4;
const VGA_COLOR_MAGENTA = 5;
const VGA_COLOR_BROWN = 6;
const VGA_COLOR_LIGHT_GREY = 7;
const VGA_COLOR_DARK_GREY = 8;
const VGA_COLOR_LIGHT_BLUE = 9;
const VGA_COLOR_LIGHT_GREEN = 10;
const VGA_COLOR_LIGHT_CYAN = 11;
const VGA_COLOR_LIGHT_RED = 12;
const VGA_COLOR_LIGHT_MAGENTA = 13;
const VGA_COLOR_LIGHT_BROWN = 14;
const VGA_COLOR_WHITE = 15;

fn vga_entry_color(fg: VgaColor, bg: VgaColor) u8 {
    return fg | (bg << 4);
}

fn vga_entry(uc: u8, vga_color: u8) u16 {
    var c: u16 = vga_color;

    return uc | (c << 8);
}

const VGA_WIDTH = 80;
const VGA_HEIGHT = 25;

var row: usize = 0;
var column: usize = 0;

var color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);

// TODO: use (volatile?) [VGA_HEIGHT][VGA_WIDTH]u16 instead of unknown
const buffer = @intToPtr([*]volatile [VGA_WIDTH]u16, 0xB8000);

pub fn initialize() void {
    var y: usize = 0;
    while (y < VGA_HEIGHT) : (y += 1) {
        var x: usize = 0;
        while (x < VGA_WIDTH) : (x += 1) {
            putCharAt(' ', color, x, y);
        }
    }
}

pub fn setColor(new_color: u8) void {
    color = new_color;
}

pub fn advance() void {
    column += 1;
    if (column == VGA_WIDTH) {
        advance_line();
    }
}

pub fn advance_line() void {
    column = 0;
    row += 1;
    if (row == VGA_HEIGHT) {
        scroll();
        row -= 1;
    }
}

pub fn putCharAt(c: u8, new_color: u8, x: usize, y: usize) void {
    buffer[y][x] = vga_entry(c, new_color);
}

pub fn putChar(c: u8) void {
    putCharAt(c, color, column, row);
    advance();
}

pub fn write(data: []const u8) void {
    for (data) |c|
        putChar(c);
}

pub fn writeLn(data: []const u8) void {
    write(data);
    advance_line();
}

pub fn copyLineFromTo(lineSrc: usize, lineDest: usize) void {
    var i: usize = 0;
    while (i < VGA_WIDTH) : (i += 1) {
        buffer[lineDest][i] = buffer[lineSrc][i];
    }
}

pub fn deleteLine(line: usize) void {
    var i: usize = 0;
    while (i < VGA_WIDTH) : (i += 1) {
        buffer[line][i] = 0;
    }
}

pub fn scroll() void {
    var i: usize = 1;
    while (i < VGA_HEIGHT) : (i += 1) {
        copyLineFromTo(i, i - 1);
    }
    deleteLine(VGA_HEIGHT - 1);
}

usingnamespace @import("io.zig");

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

var row: u16 = 0;
var column: u16 = 0;

var color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);

// TODO: use (volatile?) [VGA_HEIGHT][VGA_WIDTH]u16 instead of unknown
const buffer = @intToPtr([*]volatile [VGA_WIDTH]u16, 0xC03FF000);

pub fn initialize() void {
    var y: usize = 0;
    while (y < VGA_HEIGHT) : (y += 1) {
        var x: usize = 0;
        while (x < VGA_WIDTH) : (x += 1) {
            put_char_at(' ', color, x, y);
        }
    }
    enable_cursor(13, 14);
    row = 0;
    column = 0;
    set_cursor(0, 0);
}

pub fn enable_cursor(cursor_start: u8, cursor_end: u8) void {
    outb(0x3D4, 0x0A);
    outb(0x3D5, (inb(0x3D5) & 0xC0) | cursor_start);

    outb(0x3D4, 0x0B);
    outb(0x3D5, (inb(0x3D5) & 0xE0) | cursor_end);
}

pub fn disable_cursor() void {
    outb(0x3D4, 0x0A);
    outb(0x3D5, 0x20);
}

pub fn set_cursor(x: u16, y: u16) void {
    const pos: u16 = y * VGA_WIDTH + x;

    outb(0x3D4, 0x0F);
    outb(0x3D5, @truncate(u8, pos));

    outb(0x3D4, 0x0E);
    outb(0x3D5, @truncate(u8, pos >> 8));
}

pub fn update_cursor() void {
    set_cursor(column, row);
}

pub fn set_color(new_color: u8) void {
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

pub fn put_char_at(c: u8, new_color: u8, x: usize, y: usize) void {
    buffer[y][x] = vga_entry(c, new_color);
}

pub fn put_char(c: u8) void {
    put_char_at(c, color, column, row);
    advance();
}

pub fn write(data: []const u8) void {
    for (data) |c|
        put_char(c);
    update_cursor();
}

pub fn write_ln(data: []const u8) void {
    write(data);
    advance_line();
    update_cursor();
}

pub fn copy_line_from_to(line_src: usize, line_dest: usize) void {
    var i: usize = 0;
    while (i < VGA_WIDTH) : (i += 1) {
        buffer[line_dest][i] = buffer[line_src][i];
    }
}

pub fn delete_line(line: usize) void {
    var i: usize = 0;
    while (i < VGA_WIDTH) : (i += 1) {
        buffer[line][i] = 0;
    }
}

pub fn scroll() void {
    var i: usize = 1;
    while (i < VGA_HEIGHT) : (i += 1) {
        copy_line_from_to(i, i - 1);
    }
    delete_line(VGA_HEIGHT - 1);
}

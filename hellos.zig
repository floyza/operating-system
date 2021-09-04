const builtin = @import("std").builtin;

const MultiBoot = packed struct {
    magic: i32,
    flags: i32,
    checksum: i32,
};

const ALIGN = 1 << 0;
const MEMINFO = 1 << 1;
const MAGIC = 0x1BADB002;
const FLAGS = ALIGN | MEMINFO;

export var multiboot align(4) linksection(".multiboot") = MultiBoot{
    .magic = MAGIC,
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

export var stack_bytes: [16 * 1024]u8 align(16) linksection(".bss") = undefined;
const stack_bytes_slice = stack_bytes[0..];

export fn _start() callconv(.Naked) noreturn {
    @call(.{ .stack = stack_bytes_slice }, kmain, .{});

    while (true) {}
}

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    terminal.write("KERNEL PANIC: ");
    terminal.write(msg);
    while (true) {}
}

fn kmain() void {
    terminal.initialize();
    terminal.writeLn("Kernel started");
    var a: usize = 1;
    var protected_mode: usize = asm volatile (
        \\ mov %%cr0, %[ret]
        : [ret] "=r" (-> usize)
    );
    if (protected_mode & 1 == 1) {
        terminal.writeLn("Protected mode on.");
    } else {
        terminal.writeLn("Protected mode off.");
    }
}

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

fn vga_entry(uc: u8, color: u8) u16 {
    var c: u16 = color;

    return uc | (c << 8);
}

const VGA_WIDTH = 80;
const VGA_HEIGHT = 25;

const terminal = struct {
    var row: usize = 0;
    var column: usize = 0;

    var color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);

    // TODO: use (volatile?) [VGA_HEIGHT][VGA_WIDTH]u16 instead of unknown
    const buffer = @intToPtr([*]volatile [VGA_WIDTH]u16, 0xB8000);

    fn initialize() void {
        var y: usize = 0;
        while (y < VGA_HEIGHT) : (y += 1) {
            var x: usize = 0;
            while (x < VGA_WIDTH) : (x += 1) {
                putCharAt(' ', color, x, y);
            }
        }
    }

    fn setColor(new_color: u8) void {
        color = new_color;
    }

    fn advance() void {
        column += 1;
        if (column == VGA_WIDTH) {
            advance_line();
        }
    }

    fn advance_line() void {
        column = 0;
        row += 1;
        if (row == VGA_HEIGHT) {
            scroll();
            row -= 1;
        }
    }

    fn putCharAt(c: u8, new_color: u8, x: usize, y: usize) void {
        buffer[y][x] = vga_entry(c, new_color);
    }

    fn putChar(c: u8) void {
        putCharAt(c, color, column, row);
        advance();
    }

    fn write(data: []const u8) void {
        for (data) |c|
            putChar(c);
    }

    fn writeLn(data: []const u8) void {
        write(data);
        advance_line();
    }

    fn copyLineFromTo(lineSrc: usize, lineDest: usize) void {
        var i: usize = 0;
        while (i < VGA_WIDTH) : (i += 1) {
            buffer[lineDest][i] = buffer[lineSrc][i];
        }
    }

    fn deleteLine(line: usize) void {
        var i: usize = 0;
        while (i < VGA_WIDTH) : (i += 1) {
            buffer[line][i] = 0;
        }
    }

    fn scroll() void {
        var i: usize = 1;
        while (i < VGA_HEIGHT) : (i += 1) {
            copyLineFromTo(i, i - 1);
        }
        deleteLine(VGA_HEIGHT - 1);
    }
};

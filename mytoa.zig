pub fn uintToStr(val: u32, buf: []u8) []u8 {
    const digitPairs = "00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899";
    var size: u32 = undefined;

    if (val >= 10000) {
        if (val >= 10000000) {
            if (val >= 1000000000) {
                size = 10;
            } else if (val >= 100000000) {
                size = 9;
            } else {
                size = 8;
            }
        } else {
            if (val >= 1000000) {
                size = 7;
            } else if (val >= 100000) {
                size = 6;
            } else {
                size = 5;
            }
        }
    } else {
        if (val >= 100) {
            if (val >= 1000) {
                size = 4;
            } else {
                size = 3;
            }
        } else {
            if (val >= 10) {
                size = 2;
            } else {
                size = 1;
            }
        }
    }

    var i: usize = size - 1;
    buf[i + 1] = 0;
    var nt_buf = buf[0..size :0];

    var v = val;

    while (val >= 100) {
        var pos: u32 = (v % 100) * 2;
        v /= 100;
        buf[i - 1] = digitPairs[pos];
        buf[i] = digitPairs[pos + 1];
        i -= 2;
    }

    if (v < 10) {
        buf[i] = '0' + @intCast(u8, v);
    } else {
        buf[i - 1] = digitPairs[v * 2];
        buf[i] = digitPairs[v * 2 + 1];
    }
    return nt_buf;
}

pub fn intToStr(n: i32, buf: []u8) void {
    var sign: i32 = -(n < 0);
    var val: u32 = (n ^ sign) - sign;

    if (sign) {
        buf[0] = '-';
    }

    uintToCStr(val, buf[1..]);
}

/**
 * Binary Tile is is a physical representation of binary data.
 *
 * Byte representation:
 * [0][1][2][3]
 * [4][5][6][7]
 *
 * Creator: Hristo Iankov
 **/


// The message to reresent as binary.
message = "The Answer to the Ultimate Question of Life, The Universe, and Everything.";

// The size of each bit (in mm).
bit_s = 2; // [0.5:0.5:8]

// Generate a binary tile with the given message and bit size.
module binary_tile(message, bit_s) {
    difference() {
        print_tile(message, bit_s);
        print_indicator(bit_s);
        //print_key(message);
    }
}

// create the tile
module print_tile(message, bit_s) {
    N = len(message);
    byte_w = bit_s * 4;
    byte_h = bit_s * 2;
    byte_cols = ceil(sqrt(N/2));
    byte_rows = ceil(N / byte_cols);
    w = byte_cols * byte_w;
    h = byte_rows * byte_h;
    union() {
        cube([h, w, 1]);
        echo(str("size (in mm): ", w, , " x ", h, ", N: ", N));
        for (i = [0:N]) {
            byte_c = (i % byte_cols);
            byte_r = floor(i / byte_cols);
            byte_x = byte_c * byte_w;
            byte_y = byte_r * byte_h;
            height = (!(isEven(byte_c) == isEven(byte_r))) ? 1 + bit_s : 1;
            //height = 1;
            translate([byte_y, byte_x, height]) {
                create_byte(ord(message[i]), bit_s);
            }
            if (height > 1) {
                translate([byte_y, byte_x, 1]) {
                    cube([2*bit_s, 4*bit_s, bit_s]);
                }
            }
        }
    }
}

// create first byte indicator
module print_indicator(bit_s) {
    translate([-bit_s/4,-bit_s/4,-1]) {
        linear_extrude(height=1+bit_s+1, false) {
            polygon([[0,0], [0, bit_s], [bit_s,0]]);
        }
    }
}

// deprecated: prints a key at the bottom of the tile.
module print_key(message) {
    font_size = 2;
    N = len(message);
    linear_extrude(0.4) {
        union() {
            translate([4, font_size * 7,0]) {
                rotate([0,180,90]) {
                    text("[0][1][2][3]", font_size);
                    translate([0, -font_size-1, 0]) {
                        text("[4][5][6][7]", font_size);
                    }
                    translate([0, (-font_size-1) * 2, 0]) {
                        text(str(N), font_size);
                    }
                }
            }
        }
    }
}

// create a single byte
module create_byte(byte, bit_s) {
    //echo("byte", byte);
    for (i = [0:7]) {
        //echo("bit: ", i, " val: ", getBit(byte, i));
        if (getBit(byte, (7 - i)) == 1) {
            bit_x = floor(i % 4) * bit_s;
            bit_y = floor(i / 4) * bit_s;
            translate([bit_y, bit_x]) {
                cube([bit_s, bit_s, bit_s]);
            }
        }
    }
}

function isEven(number) = floor(number % 2) == 0;

function getBit(byte, i) = floor((byte / pow(2, i)) % 2);

function ord(char) = ascii(char, 0);

function ascii(char, i) = i > 255 ? -1 
    : (char == chr(i)) ? i : ascii(char, i+1);

binary_tile(message, bit_s);
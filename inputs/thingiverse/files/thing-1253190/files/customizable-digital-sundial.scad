/* *** CUSTOMISABLE DIGITAL SUNDIAL ***

Author: Nathanael Jourdane
Email: nathanael@jourdane.net
Date: december 30, 2015
Licence: GPL v2 http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html#SEC1
Thingiverse: http://www.thingiverse.com/thing:1253190
GitHub: https://github.com/roipoussiere/Customizable-Digital-Sundial*/

/*** Customizer parameters ***/


/* [Main] */

// preview[view:south west]

// For each positions, separated by ';'.
text = "The;quick;brown;fox;jumps;over;the;lazy;dog.";

// In minutes
digit_duration = 20; // [5:120]

// Used to display the digits.
font = 0; // [0:ASCII (5x7),1:Numbers (4x6)]

// Duration between each digits (in %).
transition = 45; // [0:100]

// Where are you ?
hemisphere = 0;  // [0:Northen hemisphere, 1:Southen hemisphere]

gnomon_shape = 0; // [0:Boat, 1:Half-cylinder]

// To hold the gnomon.
holder = 1; // [1:Yes,0:No]

// To hold pieces together with a rod.
rod = 0; // [0:No, 1:2mm, 2:3mm, 3:4mm, 4:5mm]

/* [Advanced] */

// Usually your slicer software do this. Take a very long time to process.
remove_thin_parts = 0; // [0:Nope, 1:0.05mm, 2:0.10mm, 3:0.15mm, 4:0.20mm, 5:0.30mm]
gnomon_radius = 25; // [5:50]
pixel_width = 6; // [2:20]
pixel_height = 1; // [0.5:5]
space_between_columns = 1; // [0.5:5]
space_between_rows = 7.5; // [0.5:10]
space_between_digits = 3; // [1:10]
// ...on the bottom of the gnomon.
enlarge_slots = 2; // [0: No, 1: XS (x1.25), 2:S (x1.5), 3: M(x2), 4: L (x2.5), 5: XL (x3)]
screw_size = 3; // [0:M3, 1:M4, 2:M5, 3:M6, 4:M8, 5:M10]

/*** Fonts ***/

/* You can edit the following arrays to customize your font, or create new
ones. Each font is stored in `chars_lists` and `char_fonts` on the same index.
`chars_lists` is the characters list of the fonts, while `char_fonts` is the
fonts itself.

**To modify a character:**
Edit an entry in `char_font`[font_index][char_index].

**To add a new character to a font:**
Add your character in `chars_lists`[font_index][any_char_index], then add its
font in `char_font`[font_index][same_char_index].

**To add a new font:**
Add an array of characters in `chars_lists`[any_index], then add the
corresponding array of your font in `chars_fonts`[same_font_index]

Each char in `chars_fonts` is an array of numbers representing the decimal
value of a column, where the most significant bit is the bottom of the digit.

The 5x7 font comes from: http://sunge.awardspace.com/glcd-sd/node4.html. */

/* Characters lists */

chars_lists =
// ASCII font (5x7)
[" !\"#%$&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~#",
// Numbers font (4x6)
"0123456789:"];

/* Characters fonts */

chars_fonts = [[
// ASCII font 5x7
[  0,   0,   0,   0,   0], // (space)
[  0,   0,  95,   0,   0], // !
[  0,   7,   0,   7,   0], // "
[127, 127, 127, 127, 127], // # = full dark
[ 36,  42, 127,  42,  18], // $
[ 35,  19,   8, 100,  98], // %
[ 54,  73,  85,  34,  80], // &
[  0,   5,   3,   0,   0], // '
[  0,  28,  34,  65,   0], // (
[  0,  65,  34,  28,   0], // )
[  8,  42,  28,  42,   8], // *
[  8,   8,  62,   8,   8], // +
[  0,  80,  48,   0,   0], // ,
[  8,   8,   8,   8,   8], // -
[  0,  96,  96,   0,   0], // .
[ 32,  16,   8,   4,   2], // /
[ 62,  81,  73,  69,  62], // 0
[  0,  66, 127,  64,   0], // 1
[ 66,  97,  81,  73,  70], // 2
[ 33,  65,  69,  75,  49], // 3
[ 24,  20,  18, 127,  16], // 4
[ 39,  69,  69,  69,  57], // 5
[ 60,  74,  73,  73,  48], // 6
[  1, 113,   9,   5,   3], // 7
[ 54,  73,  73,  73,  54], // 8
[  6,  73,  73,  41,  30], // 9
[  0,  54,  54,   0,   0], // :
[  0,  86,  54,   0,   0], // ;
[  0,   8,  20,  34,  65], // <
[ 20,  20,  20,  20,  20], // =
[ 65,  34,  20,   8,   0], // >
[  2,   1,  81,   9,   6], // ?
[ 50,  73, 121,  65,  62], // @
[126,  17,  17,  17, 126], // A
[127,  73,  73,  73,  54], // B
[ 62,  65,  65,  65,  34], // C
[127,  65,  65,  34,  28], // D
[127,  73,  73,  73,  65], // E
[127,   9,   9,   1,   1], // F
[ 62,  65,  65,  81,  50], // G
[127,   8,   8,   8, 127], // H
[  0,  65, 127,  65,   0], // I
[ 32,  64,  65,  63,   1], // J
[127,   8,  20,  34,  65], // K
[127,  64,  64,  64,  64], // L
[127,   2,   4,   2, 127], // M
[127,   4,   8,  16, 127], // N
[ 62,  65,  65,  65,  62], // O
[127,   9,   9,   9,   6], // P
[ 62,  65,  81,  33,  94], // Q
[127,   9,  25,  41,  70], // R
[ 70,  73,  73,  73,  49], // S
[  1,   1, 127,   1,   1], // T
[ 63,  64,  64,  64,  63], // U
[ 31,  32,  64,  32,  31], // V
[127,  32,  24,  32, 127], // W
[ 99,  20,   8,  20,  99], // X
[  3,   4, 120,   4,   3], // Y
[ 97,  81,  73,  69,  67], // Z
[  0,   0, 127,  65,  65], // [
[  2,   4,   8,  16,  32], // "\"
[ 65,  65, 127,   0,   0], // ]
[  4,   2,   1,   2,   4], // ^
[ 64,  64,  64,  64,  64], // _
[  0,   1,   2,   4,   0], // `
[ 32,  84,  84,  84, 120], // a
[127,  72,  68,  68,  56], // b
[ 56,  68,  68,  68,  32], // c
[ 56,  68,  68,  72, 127], // d
[ 56,  84,  84,  84,  24], // e
[  8, 126,   9,   1,   2], // f
[  8,  20,  84,  84,  60], // g
[127,   8,   4,   4, 120], // h
[  0,  68, 125,  64,   0], // i
[ 32,  64,  68,  61,   0], // j
[  0, 127,  16,  40,  68], // k
[  0,  65, 127,  64,   0], // l
[124,   4,  24,   4, 120], // m
[124,   8,   4,   4, 120], // n
[ 56,  68,  68,  68,  56], // o
[124,  20,  20,  20,   8], // p
[  8,  20,  20,  24, 124], // q
[124,   8,   4,   4,   8], // r
[ 72,  84,  84,  84,  32], // s
[  4,  63,  68,  64,  32], // t
[ 60,  64,  64,  32, 124], // u
[ 28,  32,  64,  32,  28], // v
[ 60,  64,  48,  64,  60], // w
[ 68,  40,  16,  40,  68], // x
[ 12,  80,  80,  80,  60], // y
[ 68, 100,  84,  76,  68], // z
[  0,   8,  54,  65,   0], // {
[  0,   0, 127,   0,   0], // |
[  0,  65,  54,   8,   0], // }
[  28, 62, 124,  62,  28], // ~ = heart
[127, 127, 127, 127, 127]  // # = full dark

],[
// Numbers font 4x6
[30, 41, 37, 30], // 0
[34, 63, 32, 0 ], // 1
[50, 41, 41, 38], // 2
[18, 33, 37, 30], // 3
[15, 8,  8,  63], // 4
[39, 37, 37, 25], // 5
[30, 37, 37, 25], // 6
[33, 17, 9,  7 ], // 7
[26, 37, 37, 26], // 8
[38, 41, 41, 30], // 9
[0,  20, 0,  0 ]  // :

]];
include <fonts.scad>

/*** Generic functions for strings, vectors and numbers operations ***/

// ** remove_thin_parts() { `object()`; `small_object()`; } **
// Remove thin parts of an `object`, with a *corrosive* `small_object()`.
module remove_thin_parts() {
  render(convexity = 1) {
    reverse() minkowski() {
      reverse() minkowski() { children(0); children(1); }
      children(1);
    }
  }
}

// ** reverse() { `object()`; } **
// Reverse an object. Solids becames holes, holes becames solids.
module reverse() {
  difference() {
    cube([1000, 1000, 1000], center=true);
    children();
  }
}

// ** [int] binary_size([int] `n`) **
// Returns the binary size of the number `n`, ie: 63 (0b111111) returns 6.
// - `n`: The number to converts.
function binary_size(n, s=0) =
  n == 1 ? s :
  binary_size(ceil(n/2), s+1);

// ** [vect] dec2bin([int] num, [[int] `len`]) **
// Returns a vector of booleans corresponding to the binary value of `num`.
// - `num`: The number to convert.
// - `len` (optional): The vector length. If specified, fill the MSBs with 0.
// dec2bin(42, 8); // [0, 0, 1, 0, 1, 0, 1, 0]
function dec2bin(num, length=8, v=[]) =
  len(v) == length ? v :
  num == 0 ? dec2bin(0, length, concat(0, v)) :
  dec2bin(floor(num/2), length, concat(num%2, v));

// ** [vect] split([str] `str`, [[char] `sep`]) **
// Returns a vector of substrings by cutting `str` each time where `sep` appears
// - `str`: The original string.
// - `sep`: The separator who cuts the string (" " by default).
// split("foo;bar;baz", ";"); // ["foo", "bar", "baz"]
function split(str, sep=" ", i=0, word="", v=[]) =
  i == len(str) ? concat(v, word) :
  str[i] == sep ? split(str, sep, i+1, "", concat(v, word)) :
  split(str, sep, i+1, str(word, str[i]), v);

// ** [vect] new_vector([int] `len`, [[any_type] `val`]) **
// Returns a vector with `len` elements initialised to the `val` value.
// - `len`: The length of the vector.
// - `val`: The values filled in the vector *(0 by default)*.
// new_vector(5); // [0, 0, 0, 0, 0]
function new_vector(n, val=0, v=[]) =
  n == 0 ? v :
  new_vector(n-1, val, concat(v, val));

/*** Functions to get the number of rows and columns ***/

// ** [int] get_nb_rows() **
// Returns the number of pixel rows of the display: it's the heighter letter
// used in the text (based on the chars_fonts[font]).
function get_nb_rows(i=0, nbrow=0) =
  i==len(chars_fonts[font]) ? binary_size(nbrow) :
  get_nb_rows(i+1, max(chars_fonts[font][i][1]) > nbrow ?
  max(chars_fonts[font][i][1]) : nbrow);

// ** [int] get_nb_cols() **
// Returns the number of pixel columns of the display: it's the maximum text
// width ( = summ of each digit width) for all positions.
function get_nb_digits(i=-1, nb_digits=0, v=[]) =
  i == -1 ? get_nb_digits(0, 0, split(text, ";")) :
  i == len(v)-1 ? nb_digits :
  get_nb_digits(i+1, len(v[i]) > nb_digits ? len(v[i]) : nb_digits, v);

/*** Functions to make the pixel array from the customized text ***/

// [vect] char2digit([str] `char`)
// Returns an array representing a digit who displays the specified `char`.
// - `char`: the character to convert.
// char2digit("1"); // [[0, 1, 1, 1, 1, 0], [1, 0, 0, 1, 0, 1],
// [1, 0, 1, 0, 0, 1], [0, 1, 1, 1, 1, 0]]
function char2digit(char, i=-1, digit=[]) =
  i == -1 ?
    (len(char) != 1 || search(chars_fonts[font], char) == undef) ? undef :
    char2digit(chars_fonts[font][search(char, chars_lists[font])[0]], 0):
  i == len(char) ? digit :
    char2digit(char, i+1, concat(digit, [dec2bin(char[i], nb_rows)]));

// [vect] word2digits([str] `word`)
// Returns an array of digits columns who displays the specified string `str`.
// - `word`: The string to converts.
// word2digits("123"); // vector digits made with char2digit()
function word2digits(word, v=[], i=0) =
  i == len(word) ? v :
  i == len(word)-1 ? word2digits(word, concat(v, char2digit(word[i])), i+1) :
  word2digits(word, concat(v, char2digit(word[i])), i+1);

// [vect] text2digits([str] `txt`)
// Returns an array of digits columns who displays the user specified `txt`
// - `txt`: a string with words for all positions, separated by a semicolon.
// text2digits("12;34"); // vector of vectors of digits made with word2digits()
function text2digits(txt, i=-1, v=[]) =
  i == -1 ? text2digits(split(txt, ";"), 0) :
  i == len(txt) ? v :
  text2digits(txt, i+1, concat(v, [word2digits(txt[i])]));
include <functions.scad>

/*** Useful shortcuts :-) ***/

module t(x=0,y=0,z=0) { translate([x,y,z]) children(); }
module r(x=0,y=0,z=0) { rotate([x,y,z]) children(); }

gnom_rad = gnomon_radius;
px_w     = pixel_width;
px_h     = pixel_height / 2; // because the holes rotation increase it
sp_col   = space_between_columns;
sp_row   = space_between_rows;
sp_char  = space_between_digits;

/*** Hidden variables on the Customizer-GUI ***/

holder_dist = 2; // distance between the nut hole and the digits
washer_dist = 2; // distance between the washer and the top of the gnomon
diam_dist   = 2; // difference between the washer and the holder diameter

/*** Computed variables ***/

/* Numbers */
nb_rows = get_nb_rows(); // number of rows
nb_digits = get_nb_digits(); // number of digits (maximum of each positions)
nb_col = nb_digits * len(chars_fonts[font][0]); // number of columns
nb_pos = len(split(text, ";")); // number of solar positions

digit_angle = digit_duration * 360/24/60; // angle between each position
total_angle = digit_angle * nb_pos ; // angle between the first to the last pos

/* Pieces dimentions */
gnom_len = nb_col*(px_w+sp_col) + (nb_digits-1)*sp_char + sp_col;
holes_diam = gnomon_shape == 1 ? // holes arcs diameter
  (gnom_rad+5)*2 / cos(total_angle/2) + 1 :  // half-cylinder shape
  gnom_rad*2 / sin((180-total_angle)/2) + 1; // boat shape
grid_width = sp_row * (nb_rows-1);
// pixel width on the surface of the cylinder
surface_px_h = (100-transition)/100*holes_diam*3.1415 * digit_angle/(360*px_h);
slots_factor = [1, 1.25, 1.5, 2, 2.5, 3][enlarge_slots];
rod_diam = [0, 2, 3, 4, 5][rod] + 0.3;
remove_box_size = [0, 0.05, 0.10, 0.15, 0.20, 0.30][remove_thin_parts];
/* Positions */
gnomon_center_y = (grid_width+4)/2 + px_h; // position of gnomon center
pixel_pos_y = gnom_rad - grid_width/2; // y pos of the first pixel
pixels = text2digits(text); // array of pixels representing the text

/* Holder */

// screw size:  M3   M4   M5   M6   M8   M10
screw_diam   = [3  , 4  , 5  , 6  , 8  , 10 ][screw_size] + 0.5;
nut_thick    = [2.4, 3.2, 4.7, 5.2, 6.8, 8.4][screw_size] + 1;
nut_width    = [5.5, 7  , 8  , 10 , 13 , 17 ][screw_size] + 0.5;
washer_diam  = [12 , 14 , 16 , 18 , 22 , 27 ][screw_size] + 1;
washer_thick = [0.8, 0.8, 1  , 1.2, 1.5, 2  ][screw_size] + 1;
holder_len = washer_dist + washer_thick + nut_thick + holder_dist;

/*** Modules to build the gnomon ***/

// Build positive holes for each pixel. Need to be substracted from the gnomon.
module holes() {
  // position of the first pixel
  t(x = px_w/2 - sp_char + sp_col, y = pixel_pos_y)
  // for each pixel, build a positive hole by extruding a square.
  for(i=[0:nb_col-1], j=[0:nb_rows-1], k=[0:nb_pos])
    if(pixels[k][hemisphere==1 ? nb_col-1-i : i][j] == 1) {
      t(x = i * (px_w+sp_col) + sp_char*(ceil((i+1)/len(chars_fonts[font][0]))),
            y = (hemisphere==1 ? nb_rows-1-j : j) * sp_row) {
        t(x=-sp_char) r(y=90)
          cylinder(d=px_h*slots_factor, h=px_w, $fn=10);
        r(x = (nb_pos-0.5-k)*digit_angle - (90-(180-total_angle)/2) )
        t(z = holes_diam/4 - 0.5)
        linear_extrude(height=holes_diam/2, scale=[1,surface_px_h], center=true)
          square([px_w, px_h], center=true);
      }
    }
}

module cleaned_holes() {
  if(remove_thin_parts == 0) {
    holes();
  } else {
    remove_thin_parts() {
      holes();
      cube([remove_box_size, remove_box_size, remove_box_size]);
    }
  }
}
// Build the holder
module holder() {
  difference() {
    t(x=-holder_len, y=gnomon_center_y, z=washer_diam/2) r(y=90)
      cylinder(d=washer_diam+2*diam_dist, h=holder_len, $fn=30);
    union() {
      t(x=-holder_len, z=-10)
        cube([holder_len, grid_width+4, 10]);

      t(x=-holder_dist, y=gnomon_center_y, z=-0.1) {
        t(x=-nut_thick, y=-nut_width/2)
          cube([nut_thick, nut_width, washer_diam/2]);
        t(x=-nut_thick, z=washer_diam/2) r(y=90)
          cylinder(d=(nut_width)*1.14, h=nut_thick, $fn=6);

        t(x=-nut_thick-washer_thick, y=-washer_diam/2)
          cube([washer_thick, washer_diam, washer_diam/2]);
        t(x=-nut_thick-washer_thick, z=washer_diam/2) r(y=90)
          cylinder(d=washer_diam, h=washer_thick, $fn=50);

        t(x=-nut_thick-washer_thick-washer_dist-1, z=washer_diam/2) r(y=90)
          cylinder(d=screw_diam, h=washer_dist+1, $fn=30);
      }
    }
  }

}

// Build the half of the gnomon.
module half_gnomon() {
t(y=-gnom_rad)
  intersection() {
    t(y=pixel_pos_y) r(y=90)
      cylinder(r=gnom_rad, h=gnom_len, $fn=100);
    union() {
      t(y=pixel_pos_y-2) r(x=(90-(180-total_angle)/2))
        cube([gnom_len, gnom_rad*2, gnom_rad*2]);
      if (rod !=0 ) t(y=-rod_diam*0.63) difference() {
        union() {
          cube([gnom_len, rod_diam+3, rod_diam+3]);
          t(z=(rod_diam+3)/2) r(y=90)
            cylinder(d=rod_diam+3, h=gnom_len, $fn=20);
        }
        t(z=(rod_diam+3)/2) r(y=90)
          cylinder(d=rod_diam, h=gnom_len, $fn=20);
      }
    }
  }
}

// Build the basic shape of the gnomon, without the holes.
module gnomon() {
  if(holder)
    holder();
  if(gnomon_shape == 0) { // boat shape
    t(y=gnom_rad) {
      half_gnomon();
      mirror([0,1,0]) half_gnomon();
    }
  t(y=pixel_pos_y-2)
    cube([gnom_len, grid_width+4, gnom_rad]);
  } else { // half-cylinder shape
    t(y=(-5))
    intersection() {
      cube([gnom_len, (gnom_rad+5)*2, gnom_rad+5]);
      r(90, 0, 90) t(gnom_rad+5, 0, 0)
        cylinder(r=gnom_rad+5, h=gnom_len, $fn=100);
    }
  }
}

difference() { gnomon(); cleaned_holes(); }

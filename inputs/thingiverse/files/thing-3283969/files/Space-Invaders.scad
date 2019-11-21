// Parametric 8bit Space Invader Ornaments
// https://www.thingiverse.com/thing:3283969
// by Bikecyclist
// https://www.thingiverse.com/Bikecyclist
// 
// Remix of
// Parametric 8bit Space Invader Ornaments
// https://www.thingiverse.com/thing:5080
// by 4volt
// https://www.thingiverse.com/4volt

// Size of "Pixel" in x Direction
x_scale = 4;

// Size of "Pixel" in y Direction
y_scale = 4;

// Thickness of Invader (in z Direction)
z_scale = 4;

// Diameter of Hole for Suspending the Invader (0 = no hole)
d_hole = 3;

// Extra size of "oversized" Pixel to ensure overlap with otherwise floating pixels
overlap = 1;

// Number of Facets
$fn = 32;

// Derived Parameters
X_scale = x_scale + overlap;
Y_scale = y_scale + overlap;

/* [Hidden] */

// Maximum Pixel Count in X Direction (one less than actual Pixels)
x_max = 15;

// Maximum Pixel Count in y Direction (one less than actual Pixels)
y_max = 7;

// Maximum Invader Count (one less than actual Invaders)
inv_max = 3;


// Invaders Definition
//
// invader [0]: without holes
// invader [1]: with holes
// invader [*][0:inv_max]: invader variant
// invader [*][*][0:ymax]: invader variant horizontal line
//
// Symbols used:
// SPACE - empty Pixel
// x - normal solid Pixel
// X - oversized solid Pixel to ensure overlap with "floating" pixels
// o - normal solid pixel with round hole
// q - two horizontally adjacent normal solid pixels with round hole ... works only if the next pixel to the right is defined as empty, though it will be rendered as solid


invader =
    [
        [
            [
                "    xx    ",
                "   xxxx   ",
                "  xxxxxx  ",
                " xx xx xx ",
                " xxxxxxxx ",
                "   X  X   ",
                "  X XX X  ",
                " x x  x x ",
            ],
            [
                "  X     X  ",
                "   X   X   ",
                "  xxxxxxx  ",
                " xx xxx xx ",
                "xxxxxxxxxxx",
                "x XxxxxxX x",
                "x X     X x",
                "   xx xx   ",
            ],
            [
                "    xxxx    ",
                " xxxxxxxxxx ",
                "xxxxxxxxxxxx",
                "xxx  xx  xxx",
                "xxxxxxxxxxxx",
                "   XX  XX   ",
                "  XX XX XX  ",
                "xx        xx",
            ],
            [
                "     xxxxxx     ",
                "   xxxxxxxxxx   ",
                "  xxxxxxxxxxxx  ",
                " xx xx xx xx xx ",
                "xxxxxxxxxxxxxxxx",
                "  xxx  xx  xxx  ",
                "   x        x   "
            ],
        ],
        [
            [
                "    q     ",
                "   xxxx   ",
                "  xxxxxx  ",
                " xx xx xx ",
                " xxxxxxxx ",
                "   X  X   ",
                "  X XX X  ",
                " x x  x x ",
            ],
            [
                "  O     O  ",
                "   X   X   ",
                "  xxxxxxx  ",
                " xx xxx xx ",
                "xxxxxxxxxxx",
                "x XxxxxxX x",
                "x X     X x",
                "   xx xx   ",
            ],
            [
                "    xq x    ",
                " xxxxxxxxxx ",
                "xxxxxxxxxxxx",
                "xxx  xx  xxx",
                "xxxxxxxxxxxx",
                "   XX  XX   ",
                "  XX XX XX  ",
                "xx        xx",
            ],
            [
                "     xxq xx     ",
                "   xxxxxxxxxx   ",
                "  xxxxxxxxxxxx  ",
                " xx xx xx xx xx ",
                "xxxxxxxxxxxxxxxx",
                "  xxx  xx  xxx  ",
                "   x        x   "
            ]
        ]
    ];


for (i = [0:inv_max])
    translate ([i * x_scale * (x_max + 2), 0, 0])
    invader (i, d_hole==0?0:1);

module invader (i, j)
{
    for (x = [0:x_max], y = [0:y_max])
        translate ([x * x_scale, -y * y_scale, 0])
            linear_extrude (z_scale)
                invader_tile (invader [j][i][y][x]);
}

module invader_tile (tile)
{
    if (tile == "x")
        square ([x_scale, y_scale], center = true);
    else if (tile == "X")
        square ([X_scale, Y_scale], center = true);
    else if (tile == "o")
        difference ()
        {
            square ([x_scale, y_scale], center = true);
            
            circle (d = d_hole);
        }
    else if (tile == "O")
        difference ()
        {
            square ([X_scale, Y_scale], center = true);
            
            circle (d = d_hole);
        }
    else if (tile == "q")
        translate ([x_scale/2, 0])
        difference ()
        {
            square ([2 * x_scale, y_scale], center = true);
            
            circle (d = d_hole);
        }
}

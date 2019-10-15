//
// Minecraft Tools v1.00
// (c) 2014 IronCreek Software
//
// This work is licensed under the Creative Commons
// Attribution-ShareAlike 4.0 International License.
// To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/4.0/.
//

/* --- PARAMETERS --------------------------------------------- */

// Which tool do you want to draw?
PART = "All"; // [All, Pickaxe, Sword, Axe, Shovel]

// How big should a single "block" be (in mm)?
BLOCK_SIZE = 2.5;

// How to draw the top of the tool
STYLE = "Fancy"; // [Fancy, Plain]

/* --- IMPLEMENTATION ----------------------------------------- */

tools();

module tools()
{
    if (PART == "Pickaxe") pickaxe();
    else if (PART == "Sword") sword();
    else if (PART == "Axe") axe();
    else if (PART == "Shovel") shovel();
    else all();
}

module all()
{
    translate([b(1), b(1), 0]) pickaxe();
    rotate([0, 0, 90]) translate([b(1), b(1), 0]) sword();
    rotate([0, 0, 180]) translate([b(1), b(1), 0]) axe();
    rotate([0, 0, 270]) translate([b(1), b(1), 0]) shovel();
}

module shovel()
{
    translate([b(1), b(1), 0]) handle(11);
    translate([b(1), b(0), 0]) block();
    translate([b(0), b(1), 0]) block();
    translate([b(2), b(0), 0]) block();
    translate([b(0), b(2), 0]) block();
    translate([b(8), b(7), 0]) handle(5);
    translate([b(7), b(8), 0]) handle(5);
    for (i = [0 : 3])
    {
        translate([b(6+i), b(9+i), 0]) block();
        translate([b(9+i), b(6+i), 0]) block();
    }
}

module axe()
{
    handle(11);
    translate([b(12), b(7), 0]) rotate([0, 0, 90]) handle(6);
    translate([b(11), b(6), 0]) rotate([0, 0, 90]) handle(6);
    translate([b(4), b(9), 0]) handle(5);
    translate([b(5), b(8), 0]) handle(5);
}

module sword()
{
    handle(16);
    translate([b(10), b(2), 0]) rotate([0, 0, 90]) handle(8);
    translate([b(0), b(2), 0]) block();
    translate([b(2), b(0), 0]) block();
    translate([b(3), b(6), 0]) block();
    translate([b(6), b(3), 0]) block();
    for (i = [0 : 7])
    {
        translate([b(8+i), b(6+i), 0]) block();
        translate([b(6+i), b(8+i), 0]) block();
    }
}

module pickaxe()
{
    handle(12);
    translate([b(10), b(3), 0]) pickaxe_blade();
    translate([b(10), b(10), 0]) rotate([0, 0, 90]) pickaxe_blade();
}

module pickaxe_blade()
{
    for (i = [0 : 6])
    {
        translate([b(1), b(i), 0]) block();
        if (i > 0 && i < 6)
        {
            translate([0, b(i), 0]) block();
            translate([b(2), b(i), 0]) block();
        }
    }

}
module handle(length)
{
    for (z = [0 : length-2])
    {
        translate([b(z), b(z), 0]) block();
        translate([b(z+1), b(z), 0]) block();
        translate([b(z), b(z+1), 0]) block();
    }
    translate([b(length-1), b(length-1), 0]) block();
}

module block()
{
    trim = BLOCK_SIZE * 0.1;
    if (STYLE == "Fancy")
    {
        hull()
        {
            cube([manifold(BLOCK_SIZE), manifold(BLOCK_SIZE), BLOCK_SIZE-trim]);
            translate([trim/2, trim/2, 0]) cube([BLOCK_SIZE-trim, BLOCK_SIZE-trim, BLOCK_SIZE]);
        }
    } else {
        cube([manifold(BLOCK_SIZE), manifold(BLOCK_SIZE), BLOCK_SIZE]);
    }
}

function b(x) = x * BLOCK_SIZE;
function manifold(x) = x + 0.02;
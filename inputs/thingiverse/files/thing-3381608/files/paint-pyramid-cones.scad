////////////////
// Variables that you can change for customizations to fit your needs.
////////////////

// The row and column values can be modified to fit you needs
rows = 4; // If the number of rows is > 2 then the columns get offset and
          // the rows get compressed. This is done to provide a more solid
          // base for objects to sit on.

columns = 5;

void = false; // Whether or not to cut out voids in the cones. No matter what 
              // value is chosen the cones are hollowed out.



cone_short = true; // Should the cones be short or tall. Taller cones allow for
                   // easier lifting of objects.

////////////////
// other Variables
////////////////
// Change these at your own risk
x = 0;
y = 0;

cone_base = 14; // You can change the width of the cone by adjusting this 
                // value. I would suggest not changing it but it is up to you.
                // I have not fully tested this script with different bases.
                // What testing I have done seems to indicate it works.

cone_height = (cone_short) ? cone_base * .75 : cone_base * 1.5;
cone_offset = cone_base *.9714;
cone_inset_z = -cone_height * .2;

////////////////
// Main
////////////////
difference() {
    union() {
        for (row = [0: rows - 1]) {
            render_columns = (rows > 2 && ((row - 1) / 2) == round((row - 1) / 2)) ? columns - 1 : columns;
            for (column = [0: render_columns - 1]) {
                Cone(GetConeX(row, rows, 0, cone_offset), GetConeY(row, rows, column, cone_offset), cone_base, cone_height, cone_offset);
            }
        }
        x_render_offset = (rows > 2) ? -cone_offset / 4 : -cone_offset / 4;
        translate([-cone_offset / 2 - cone_base/14, -cone_offset / 2 - cone_base/14, 0])
        cube([GetBaseWidth(rows, cone_offset), columns * (cone_offset) + cone_base/7, 1]);
    }

    for (row = [0: rows - 1]) {
        render_columns = (rows > 2 && ((row - 1) / 2) == round((row - 1) / 2)) ? columns - 1 : columns;
        for (column = [0: render_columns - 1]) {
            Void(GetConeX(row, rows, 0, cone_offset), GetConeY(row, rows, column, cone_offset), cone_base, cone_height, cone_offset, void);
        }
    }

}

////////////////
// Functions
////////////////
function GetBaseWidth(rs, co) =
rs <= 2 ?
    rs * (co + 1) :
    (rs) * (co) - (co / 4 * rs) + co / 2 - 1;

function GetConeX(r, rs, c, co) =
(r > 0 && rs > 2) ?
r * co + -co / 4 * r:
    r * co;

function GetConeY(r, rs, c, co) =
((rs > 2 && (r / 2 == round(r / 2))) || (rs <= 2)) ?
c * co:
    c * co + co / 2;


////////////////
// Modules
////////////////
module Cone(x, y, cb, ch, co) {
    difference() {
        translate([x, y, 0])
        union() {
            rotate([0, 0, 90]) cylinder(h = ch, r1 = cb / 2, r2 = 0, center = false);
        }

    }
}

module Void(x, y, cb, ch, co, void = true) {

    translate([x, y, -ch * .2])
    cylinder(h = ch, r1 = cb / 2, r2 = 0, center = false);
    if (void) {
        TriangleVoid(x, y, cb, ch);
        rotate([0, 0, 90]) TriangleVoid(y, -x, cb, ch);
    }
}

module TriangleVoid(x, y, cb, ch) {

    y1 = -cb / 2 + y;
    y2 = cb / 2 + y;
    z1 = ch * .15;
    x1 = -cb / 2 + cb / 3 + x;
    x2 = cb / 2 - cb / 3 + x;
    x3 = 0 + x;
    z2 = ch * .7;

    polyhedron(
        points = [
            [x1, y1, z1],
            [x2, y1, z1],
            [x3, y1, z2],
            [x1, y2, z1],
            [x2, y2, z1],
            [x3, y2, z2]
        ],
        faces = [
            [0, 1, 2],
            [0, 2, 5, 3],
            [0, 3, 4, 1],
            [1, 4, 5, 2],
            [3, 5, 4]
        ]
    );
}


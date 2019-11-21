/* Customizable High-tech Koozie
 * By DrLex, v1.1 2019/10
 * Based on original High-Tech Soda Can Cooler, Thing:1771124
 * Released under Creative Commons - Attribution - Non-Commercial - Share Alike license */

/* [Dimensions] */
// Diameter of the cylinder that fits in the koozie. All dimensions are in mm.
can_dia = 66.2; //[10:0.1:240]

// Height of the cylinder covered by the koozie.
can_height = 99.0; //[1:0.1:250]

// Tolerance between the can and the koozie. Use this to compensate for printing inaccuracies and material shrinkage.
tolerance = 0.10; //[0:0.01:1]

// Space between the can and the outer wall. Larger values offer better insulation, smaller values a sleeker design.
air_gap = 5.0; //[0.1:0.1:30]

// Sliced wall thickness of the inner baffles. Preferably set this to a value that will yield exactly 1, 2, or another integer number of perimeters.
baffle_wall = 0.76; //[0.1:0.01:2]

// Outer wall thickness. Avoid using values smaller than baffle_wall.
outer_wall = 0.76; //[0.1:0.01:2]

// Bottom thickness
bottom_thick = 0.80; //[0.1:0.01:2]

// Generate only the topmost part with 2 baffles, for making a test print to check for correct fit.
test_slice = "no"; //[yes, no]


/* [Advanced] */

// Vertical distance between the baffles
baffle_dist = 8.0; //[1:0.1:30]

// Height of the support/reinforcement bars in the bottom
support_height = 3.0; //[0:0.1:10]

// Width of the support bars in the bottom
support_width = 1.2; //[0.1:0.01:3]

// Number of segments (detail) in the cylinders. At lower values, the effective inside diameter will be smaller than expected.
segments = 80; //[16:128]

// Cut off the top edge of the baffles to avoid a very thin single-line extrusion that tends to detach when sliding cans into the koozie. This must be well below baffle_wall to maintain correct dimensions.
top_cut = 0.4; //[0:0.01:1]

/* [Hidden] */
outer_dia = can_dia + 2*(tolerance + air_gap + outer_wall);
chamfer = 0.6;
in_wall_radius = outer_dia/2 - outer_wall;
inside_radius = can_dia / 2 + tolerance;
// Make uncut baffles wide enough for good overlap
baffle_radius = outer_dia / 2 + baffle_wall + .5;
baffle_cut = (outer_dia  - outer_wall) / 2;  // in the middle of the outer wall
baffle_height = in_wall_radius - inside_radius + baffle_wall - top_cut;  // effective height
num_comparts = floor((can_height - baffle_height) / baffle_dist);
baffle_offset = can_height - baffle_height - (num_comparts * baffle_dist);

cylinder_h = bottom_thick + support_height + can_height - baffle_height - (outer_wall -baffle_wall);
inside_chamfer = max(chamfer, 0.8 * support_height);

gap_fill_r = outer_dia/2 - baffle_wall/2;

echo(["Outer diameter", outer_dia]);
echo(["Baffle height", baffle_height]);
echo(["Number of compartments", num_comparts]);

if(test_slice == "yes") {
    total_h = bottom_thick + support_height + can_height;
    shift = total_h - baffle_height - baffle_dist - 3;
    chop_r = total_h/2 + 1;
    difference() {
        // Not very efficient computation-wise, but easy
        translate([0, 0, -shift]) koozie();
        translate([0, 0, -chop_r]) cube(2*chop_r, center=true);
        // Remove any leftovers of lower baffles
        translate([0, 0, -.2]) cylinder(r2=0, r1=in_wall_radius, h=in_wall_radius, $fn=segments);
    }
}
else {
    koozie();
}


// Generate one baffle, positioned such that the lower intersection with the inside wall is at z=0.
module baffle()
{
    shift = baffle_radius - in_wall_radius - baffle_wall;
    translate([0, 0, -shift])
    difference() {
        cylinder(r2=0, r1=baffle_radius, h=baffle_radius, $fn=segments);
        translate([0, 0, -baffle_wall]) cylinder(r2=0, r1=baffle_radius, h=baffle_radius, $fn=segments);
        if(top_cut > 0) {
            translate([0, 0, baffle_height + baffle_radius + shift]) cube(2*baffle_radius, center=true);
        }
    }
}

module koozie()
{
    translate([0, 0, bottom_thick + support_height + baffle_offset]) {
        difference() {
            union() {
                if(num_comparts > 0) {
                    intersection() {
                        union() {
                            for(i = [0: 1: num_comparts-1]) {
                                translate([0, 0, i*baffle_dist]) baffle();
                            }
                        }
                        cylinder(r=baffle_cut, h=can_height+10, $fn=segments);
                    }
                }
                intersection() {
                    translate([0, 0, num_comparts*baffle_dist]) baffle();
                    cylinder(r=outer_dia/2, h=can_height+10, $fn=segments);
                }
            }

            cylinder(r=inside_radius, h=can_height+baffle_radius+10, $fn=segments);
        }
    }
    intersection() {
        union() {
            difference() {
                union() {
                    cylinder(r=outer_dia/2, h=cylinder_h, $fn=segments);
                    if(outer_wall > baffle_wall) {
                        translate([0, 0, cylinder_h]) cylinder(r1=gap_fill_r, r2=0, h=gap_fill_r, $fn=segments);
                    }
                }
                translate([0, 0, bottom_thick]) {
                    intersection() {
                        cylinder(r=in_wall_radius, h=can_height + bottom_thick + support_height + outer_dia, $fn=segments);
                        translate([0, 0, inside_chamfer - in_wall_radius]) cylinder(r1=0, r2=cylinder_h+outer_dia, h=cylinder_h+outer_dia, $fn=segments);
                    }
                }
            }
            if(support_height > 0) {
                difference() {
                    translate([0, 0, bottom_thick + support_height/2]) for(i = [0:1:2]) {
                        rotate([0, 0, 60*i]) cube([outer_dia - outer_wall, support_width, support_height], center=true);
                    }
                    translate([0, 0, bottom_thick-outer_dia/6]) rotate([0,0,30]) cylinder(r1=0, r2=outer_dia/3, h=outer_dia/3, $fn=6);
                }
            }
        }
        // Intersect with a cone to create the chamfer
        translate([0, 0, chamfer - outer_dia/2]) cylinder(r1=0, r2=cylinder_h+outer_dia, h=cylinder_h+outer_dia, $fn=segments);
    }
}

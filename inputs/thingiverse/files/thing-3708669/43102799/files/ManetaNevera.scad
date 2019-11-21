// Written by Jordi Riera-Babures <jrierab@gmail.com>
// ManetaNevera V2.0 - Parameterisized for Customizer
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

// Hole_Separation (mm)
Hole_Separation = 156;      // [50:300]
// Width of the refrigerator handle (mm)
Handle_Width = 18;          // [10:30]
// Height of the refrigerator handle (mm)
Handle_Height = 22;         // [10:40]
// Overhang (extension) on handle ends (mm)
Handle_Overhang = 20;       // [0:50]
// Height of the top/base horizontal bars (mm)
Bar_Height = 6;             // [3:10]
// Base bar width (mm)
Base_Width = 12;            // [5:20]
// Base Length to support the columns (mm)
Base_Length = 40;           // [14:60]
// Column_Length (mm)
Column_Length = 12;         // [4:20]
// Base screw radius (mm)
Base_Screw_Radius = 2;      // [1:10]
// Base screw head radius (mm)
Base_Screw_Head_Radius = 4; // [2:20]
// Number of holes in top
Num_Top_Holes = 7;          // [2:15]
// Top holes radius (mm)
Top_Hole_Radius = 4;        // [1:20]


// Build the handle
refrigerator_handle();


module refrigerator_handle() {
    // Smooth the handle
    Rounded_Corner_Radius = 2;

    // Correct the width position to account for the round corner
    HWC = -(Handle_Width - Base_Width) / 2;
    // Correct the length position to account for the round corners and overhang
    HLC = -(Rounded_Corner_Radius + Handle_Overhang);
    // Calculates the real handle length
    Handle_Length = Hole_Separation + Base_Length + 2*Handle_Overhang + 2*Rounded_Corner_Radius;
    // Calculates the top holes separation
    THS = Hole_Separation / (Num_Top_Holes - 1);

    // First base (screw hole + columns)
    base_hole();
    // Second base (screw hole + columns)
    translate([0, Hole_Separation, 0]) base_hole();

    // Top bar with holes
    difference() {
        // Top bar
        translate([HWC, HLC, Handle_Height - Bar_Height])
            roundedcube_simple([Handle_Width, Handle_Length, Bar_Height], false, Rounded_Corner_Radius);

        // Top holes
        translate([Base_Width/2, Base_Length/2, Handle_Height - Bar_Height])
            for (n =[0:Num_Top_Holes - 1])
                translate([0, n*THS, 0])
                    cylinder(h = Bar_Height, r1 = Top_Hole_Radius, r2 = Top_Hole_Radius);
    }
}


module base_hole() {
    Column_Height = Handle_Height - 2*Bar_Height;

    union() {
        // Base (with screw hole)
        difference() {
            cube([Base_Width, Base_Length, Bar_Height], false);
            translate([Base_Width/2, Base_Length/2, 0])
                // Reduces 0.1 mm to allow building without supports
                cylinder(h = Bar_Height-0.1, r1 = Base_Screw_Radius, r2 = Base_Screw_Head_Radius);
        }
        // Laterals - support columns
        translate([0, 0, Bar_Height])
            cube([Base_Width, Column_Length, Column_Height], false);
        translate([0, Base_Length - Column_Length, Bar_Height])
            cube([Base_Width, Column_Length, Column_Height], false);
    }
}


// https://gist.github.com/groovenectar/292db1688b79efd6ce11
module roundedcube_simple(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}


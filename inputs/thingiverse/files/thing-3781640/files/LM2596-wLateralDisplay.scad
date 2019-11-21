// Written by Jordi Riera-Babures <jrierab@gmail.com>
// LM2596 with lateral voltage window V1.0 - Parameterisized for Customizer
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

// Length of the board (mm)
Board_Length = 61;          // [40:300]
// Width of the board (mm)
Board_Width = 38;           // [10:40]
// Height of the board and its components (mm)
Board_Height = 15;          // [10:40]
// Volatge Window width (mm)
Voltage_Window_Width = 15;  // [10:20]
// Volatge Window legnth (mm)
Voltage_Window_Length = 23; // [0:30]

// Input/output hole radius
Hole_radius = 2.5;          // [2:10]

// Space to take into account around the board (mm)
Security_Margin = 0.5;      // [0.:5.]
// Wall thickness (mm)
Wall_Thickness = 1.6;       // [1.:5.]

// Account for security margins and walls
Xtra = Security_Margin + 2*Wall_Thickness;
// Hole pos
Hole_pos_x = (Board_Length + Xtra) / 2;



// Build the box
translate([0, -Board_Width, (Board_Height + Xtra)/2]) LM2596_case();
// And the lidl
mirror([0, 0, 1]) translate([0, Board_Width, -1.5*Wall_Thickness]) LM2596_lid();



module LM2596_lid() {
    difference() {
        union() {
            // Internal lid
            cube([Board_Length - Security_Margin, Board_Width - Security_Margin, Wall_Thickness], true);
            translate([0, 0, Wall_Thickness])
                cube([Board_Length + Xtra, Board_Width + Xtra, Wall_Thickness], true);
        }
        union() {
            // Voltage window hole
            translate([(Board_Length - Voltage_Window_Width)/2 - Voltage_Window_Length - Security_Margin, (Board_Width - Voltage_Window_Width)/2, 0])
                cube([Voltage_Window_Length, Voltage_Window_Width, 3*Wall_Thickness], true);
        }
    }

}

module LM2596_case() {
    // Smooth the case
    Rounded_Corner_Radius = 2;

    // Hole extension
    Hole_h = 1*(Wall_Thickness + Security_Margin);
    // Input hole Y tanslation
    Hole_y = (Board_Width - Hole_radius - 4*Security_Margin)/2;

    // Case
    difference() {
        // External case
        roundedcube_simple([Board_Length + Xtra, Board_Width + Xtra, Board_Height + Xtra], true, Rounded_Corner_Radius);
        // "Empty" inside block
        union() {
            // Internal board space
            cube([Board_Length, Board_Width, Board_Height], true);
            // Remove the top
            translate([0, 0, Board_Height])
                cube([Board_Length, Board_Width, Board_Height], true);
            // Input hole
            translate([Hole_pos_x - Hole_h, 0, 0])
                rotate([90, 0, 90])
                    cylinder(Hole_h, r = Hole_radius, true);
            // Output hole
            translate([-Hole_pos_x, 0, 0]) 
                rotate([90, 0, 90])
                    cylinder(Hole_h, r = Hole_radius, true);
        }
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


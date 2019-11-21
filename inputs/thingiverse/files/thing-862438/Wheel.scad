// Original script by Mark Benson
// http://www.thingverse.com/thing:122070
// 23/07/2013

// Wheel for maze mouse
// Shaft fitting for 28BYJ-48 geared stepper

// Modified by 648.ken@gmail.com Jun 2015
// Lengthened hub
// increased shaft cutout
// Included M3 set screw hole (might need to be tapped)
// Added parameters for customizer

// Creative commons non commercial


// http://www.thingiverse.com/thing:16193/
use <write/Write.scad>


/* [Global] */
features = "spokes"; // [spokes, text, plain, hub-only]

/* [Wheel] */
// Diameter of wheel in mm.
wheel_diameter = 60;

// Increase shaft cutout size in mm if your printer is not calibrated.
fudge_factor = 0;

/* [Text] */

// You will have to flip it around to see it. 
text = "ChickTech  Rules!";

// Font selection
font = "orbitron.dxf"; // [orbitron.dxf, BlackRose.dxf, knewave.dxf, braille.dxf, Letters.dxf]

// 8mm goes all the way through, but may cause trouble with letters like "B".
letter_depth = 1; // [0:8]

// Letter spacing
letter_spacing = 1.2; 

// Letter height in mm.
letter_height = 8;


difference(){
	union()	{
		//rim
        if (features != "hub-only"){
            cylinder(r=wheel_diameter / 2, h=4, $fn=100);
        }

		//boss
		cylinder(r=12 / 2, h=10, $fn=100);
	}


	union()	{
		//shaft cutout (shaft with flat)
		translate([0, 0, 0.6])
		intersection(){
			cylinder(r=5.5 / 2 + fudge_factor, h=12, $fn=40); // was 5
			translate([0, 0, 4]) cube([3.0 + fudge_factor, 12, 12], 
                                       center=true); // was 2.5
		}

		// set screw for M3
		translate([0, 0, 7])		
		rotate([90, 0, 90])
		cylinder(r=1.5, h=60, center=true, $fn=40); // was 1

		//rim groove cutout
		translate([0, 0, 2])
		rotate_extrude(convexity=10, $fn=100)
		translate([wheel_diameter / 2, 0, 10])
		rotate([0,0,45])
		square([2,2],center=true);

        // add text to face
        if (features == "text"){
            if(letter_depth > 0){
                rotate(180, [1, 0, 0]){
                    writecircle(text, [0, 0, 0], 
                                wheel_diameter / 2 - letter_height, 
                                font=font, space=letter_spacing, 
                                t=letter_depth, h=letter_height);
                }
            }
        }
        // add spokes (circular cut-outs)        
        if (features == "spokes"){
            for(i = [0:5]){
                rotate(i * 360 / 6, [0, 0, 1])
                translate([wheel_diameter / 3.2, 0, -1])
                cylinder(r=wheel_diameter / 8, h=8, $fn=40);
            }
        }
	}
}




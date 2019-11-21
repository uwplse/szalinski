/* ********************
//
// Lamy Ink Cartridge Holder - Container z.B. für Lamy Tintenpatronen
// CC-BY-SA November 2017 by ohuf@Thingiverse
//
// www.thingiverse.com/thing:2654631

// Version 2 - 2017-11-17
//
// 
// License: CC-BY-SA
// read all about it here: http://creativecommons.org/licenses/by-sa/4.0/
// ********************** */

/* [Anzahl] */
//Anzahl der Kammern || Number of cartridge chambers
amount=2;	// [1:30]


/* [Hidden] */
$fn=150;
ix=0.005;	// This is just some static value to beautify the cutout

sl=0.3;		// static value to widen concave walls


//// === Unterteil: === 
for(a = [1:amount] )
{
	translate([a*10.3, 0, 0])
	bottom_cutout_round();
}
//// === Deckel: ===
translate([0, 15, 0])
for(a = [1:amount] )
{
	translate([a*10.3, 0, 0])
	top_round();
}




//// ================================
//// runde Variante (Unterteil):
module bottom_cutout_round(){
	difference(){
		difference(){
			color("red")
			union(){
			translate([0,0,0])
				cylinder(d=9, h=60);
				cylinder(d=11, h=53);
			}
			
			translate([0, 0, 1])
			union(){
				cylinder(d=7.7, h=59 + ix );
			}
		}

		//// Cutout im Body:
		union(){
		translate([0,0,45])
			rotate([90,0,0])
				cylinder(d=5, h=40, center=true);
		translate([0,0,25])
			rotate([90,0,0])
				cylinder(d=5, h=40, center=true);
		translate([-2.5,-20,25])
			cube([5,40,20]);
		}
	}
}




//// Runder Deckel:
module top_round(){
	adj2=0.15;
	difference(){
		color("green")
		cylinder(d=11, h=22);
		translate([0,0,1.0])
			cylinder(d=9.0+adj2, h=21+ix);
	}
}


// serious bank
//
// money goes in, but it doesn't come out. So you have to seriously want the money to smash
// the bank open.

use <write/Write.scad>;

// Rounded
round = 0; // [0:Cube, 1:Rounded]
// Size of bank (mm). 50mm is small, 100mm is large.
l=100;
// Wall thickness (mm). 0.5 makes walls one layer thick.
t=0.5;
// Inner rib size.
i=20;
// Width of inner ribs.
iw = 2;
// Money slot length
slotL = 45;
// Money slot width
slotW = 5;
// Thickness of lip around money slot.
slotLip = 2;
// Turn on to see into bank. Turn off to print.
slice = 0; //[0:Off, 1:On]

// Shape of bank
module bankShape(s) {
	echo("bank shape ",s);
	intersection() {
		difference () {
			rotate([0,55,0]) rotate([0,0,45]) cube(s, center=true);
			translate([s/10,0,0]) translate([0,0,-s]) cube(s, center=true);
			}
		if (round) cylinder(h=2*s,r=s*.7, center=true);
		}
	}

// Draw the bank
module bank() {
	// outer shell of bank
	difference() {
		color("yellow") union() {
			bankShape(l);
			// corner supports
			for (a=[0:120:359]) rotate([0,0,a]) {
				translate([0,-0.5,-l/2]) cube([l*0.7,t,l*.21]);
				// disk to hold corners down
				rotate([0,0,30]) translate([0,l*.7,-l/2]) cylinder(r=5, h=0.5);
				}
			}
		color("grey") bankShape(l-t*2);
		if (slice) cube(100);
		rotate([0,55,0]) rotate([0,0,0]) 
			translate([0,0,l/2]) 
				cube([slotL,slotW,l], center=true);
		}
	
	// inner ribs
	intersection() {
		bankShape(l);	// so ribs stay inside
		difference() {
			union() {
				for (a=[0:60:359]) rotate([0,0,a]) translate([0,-0.5,-l/2]) cube([l*0.81,t,l*1.5]);
				rotate([0,55,0]) rotate([0,0,0]) 
					translate([0,0,l/2-i/2]) 
						cube([slotL+2*slotLip,slotW+2*slotLip,i], center=true);
				}
			bankShape(l-i);
			rotate([0,55,0]) rotate([0,0,0]) 
				translate([0,0,l/2]) 
					cube([slotL,slotW,l], center=true);
			}
		}		
	}

translate([0,0,l/2]) bank();
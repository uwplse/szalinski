/*
 * Parametric spoke for straw construction kit
 *
 * By Michael A. Hohensee, Jan. 2013.
 * Licensed under LGPL2 or later.
 */

use <MCAD/polyholes.scad>

// The amount of space to leave between objects that fit into or around your print.  Choose something slightly larger than the diameter of your extruder nozzle.
clearance=0.3; //[0.3:0.25mm,0.42:0.35mm,0.6:0.5mm]

// nspokes == number of pegs on piece
nspokes=6; // [1:100]


// innerdiam == peg diameter (inner diameter of your straws, in microns)
innerdiam = 5780; // [0:10000]

// peglen == peg length (how long to make the pegs)
peglen = 9; 

// flatnessFactor == factor to make the pegs flat on top and bottom, so they won't fall off the print bed.
flatnessFactor = 2; // [0:9]

// centerholediam == (outer diameter of your straws, in microns)
centerholediam = 7200; // [5000:20000]
centerholerad = (centerholediam/1000)/2+clearance;

// minbasediam == minimum diameter of disk linking the spokes. (in mm)
minbasediam = 14; // [1:50]


flatness=flatnessFactor/10;
minbaserad = minbasediam/2;


rad = (innerdiam/1000)/2 - clearance;
len = peglen-rad/2;

cuberad=2*rad;

baserad = max(minbaserad,2*(rad)*nspokes/(2*(3.1415)));


// facet number on curved surfaces
fnum = 30;




module peg() {
	translate([0,0,(1-flatness)*rad]) {
		rotate([0,90,0]) {
			difference() {
	
				hull() {
					translate([0,0,-2]) {
						cylinder(r=rad,h=len+2,$fn=fnum);
					}
					translate([0,0,len]){
						sphere(r=rad,$fn=fnum);
					}
				}
	
				translate([rad+0.5*cuberad-flatness*rad,0,1.5*rad]) {
					cube(size=[cuberad,cuberad,20*len],center=true);
				}

				translate([-(rad+0.5*cuberad-flatness*rad),0,1.5*rad]) {
					cube(size=[cuberad,cuberad,20*len],center=true);
				}

			}
		}
	}
}


difference() {
	union() {
		cylinder(r=baserad,h=2*(1-flatness)*rad,$fn=fnum);

		for (i=[0:(nspokes-1)]) {
			rotate([0,0,i*(360/nspokes)]) {
				translate([baserad,0,0]) {
					peg();
				}
			}
		}
	}
	translate([0,0,-3*(1-flatness)*rad]) {
		polyhole(d=2*centerholerad,h=6*(1-flatness)*rad,center=true);
	}
}

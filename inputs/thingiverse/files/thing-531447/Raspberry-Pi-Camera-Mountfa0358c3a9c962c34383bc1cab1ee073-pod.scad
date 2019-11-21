//
// raspberry pi cameras mount
//
// copyright 2014 Sebastien Roy
// Licence: Public domain
//

/* [General] */

// Reduce the diameter of the pegs (units are 0.01mm, so for 0.1mm enter 10)
tolerance=0; // [0:100]

// to stop customizer
module nop() { }


module centercube(sz) {
	translate(sz/-2) cube(sz);
}

//
// peg: radius of the peg cylinder. Normally 1mm
//
module camera(peg=1.0) {
	// trous
	translate([-21,-12.5,0]/2) cylinder(r=peg,h=3,$fn=32);
	translate([21,-12.5,0]/2) cylinder(r=peg,h=3,$fn=32);
	translate([-21,12.5,0]/2) cylinder(r=peg,h=3,$fn=32);
	translate([21,12.5,0]/2) cylinder(r=peg,h=3,$fn=32);
	// bras
	hull() {
	translate([-21,-12.5,-4]/2) centercube([2,2,4]);
	translate([-21,12.5,-4]/2) centercube([2,2,4]);
	}
	hull() {
	translate([21,-12.5,-4]/2) centercube([2,2,4]);
	translate([21,12.5,-4]/2) centercube([2,2,4]);
	}
	// base
	hull() {
	translate([-21,-12.5,-10]/2-[2,0,0]) centercube([2,2,2]);
	translate([-21,12.5,-10]/2) centercube([2,2,2]);
	translate([21,-12.5,-10]/2+[2,0,0]) centercube([2,2,2]);
	translate([21,12.5,-10]/2) centercube([2,2,2]);
	}
	// patte
	hull() {
	translate([-21-2,-12.5,-10]/2) centercube([4,2,2]);
	translate([-21-8,-12.5,-10]/2-[0,30,0]) centercube([10,2,2]);
	}
	hull() {
	translate([21+2,-12.5,-10]/2) centercube([4,2,2]);
	translate([21+8,-12.5,-10]/2-[0,30,0]) centercube([10,2,2]);
	}
	// plate
	hull() {
	translate([-21-8,-12.5,-10]/2-[0,30,0]) centercube([10,2,2]);
	translate([-21,-12.5,-10]/2-[0,30,-15/2]) centercube([2,2,2+15]);
	translate([21+8,-12.5,-10]/2-[0,30,0]) centercube([10,2,2]);
	translate([21,-12.5,-10]/2-[0,30,-15/2]) centercube([2,2,2+15]);
	}	

}

// call with the radius of the peg
camera(1-tolerance/200);


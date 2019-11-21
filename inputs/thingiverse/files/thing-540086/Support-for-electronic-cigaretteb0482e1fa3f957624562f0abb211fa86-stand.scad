//
// porte cigarette électronique
//
// copyright 2014 Sébastien Roy
//
// Licence: public domain
//


/* [Basics] */

// Hole diameter (mm)
holeDiameter=16; // [4:40]

// Hole height (mm)
holeHeight=20; // [10:80]




/* [Thickness] */

// Thickness around the hole (mm)
thickness=2; // [1:10]

// Extra thickness around the top. This defines how the legs will look. >0 will make a larger top, and <0 will make the legs connect below the top.
topExtraThickness=1; // [-20:20]




/* [Legs] */

// Number of legs
nbLegs=3; // [1:8]

// Distance from leg base to center (mm)
legDistance=40; // [10:120]

// Diameter of the leg base (mm)
legDiameter=4; // [1:40]

// Space under the middle (mm)
bottomSpace=3; // [0:30]




/* [Rendering] */

// Cut the model in half to see inside
cut=0; // [0:No,1:Yes]

// Rotate the model for printing
rotate=0; // [0:No,1:Yes]

// Make the hole wider by 2*tolerance, (units are 1/10mm, so 5=0.5mm)
tolerance=5; // [0:20]

// Resolution of everything round
resolution=32; //  [16:Low,32:Normal,64:High,128:Super High]






module nop() { }

$fn=resolution;

clearance=(holeDiameter/2+thickness)/2+thickness;
echo(clearance);

topD=max(holeDiameter/2+thickness+topExtraThickness,1);
echo(topD);


module oneLeg(angle) {
	hull() {
		translate([0,0,holeHeight]) cylinder(r=topD,h=0.01);
		rotate([0,0,angle]) translate([legDistance,0,-clearance-bottomSpace]) cylinder(r=legDiameter/2,h=0.1);
	}
}

module externalCylinder() {
	translate([0,0,-thickness-0.02]) cylinder(r=holeDiameter/2+thickness,holeHeight+thickness);
	translate([0,0,-thickness-0.02]) scale([1,1,0.5]) sphere(r=holeDiameter/2+thickness);
}

module internalCylinder() {
	translate([0,0,0]) cylinder(r=holeDiameter/2+tolerance/10,h=holeHeight+0.02);
	translate([0,0,-clearance+thickness+0.02]) cylinder(r2=holeDiameter/2+0.5,r1=0,h=clearance-thickness);
}


module support() {
	difference() {
		union() {
			for( i=[0:360/nbLegs:359] ) { oneLeg(i); }
			externalCylinder();
		}
		internalCylinder();
	}
}


translate([0,0,clearance]) intersection() {
	if( cut ) translate([-50,0,-50]) cube([100,100,100]);
	if( rotate ) rotate([180,0,0]) support();
	else support();
}



// Rasperry Pi Free Range / Epson TM-T88 printer stand
//
// Box for holding Raspberry Pi under an Epson TM-T88 receipt printer or similar
// Customizable.
//
// (c) 2014, Laird Popkin laird@popk.in
//


/* [Hidden] */

piWidth = 56;
piLen = 85;
piHeight = 20;
piStandHeight = 5;
piThick = 2;

screwD = 2.9;
screwR = screwD/2;
standR = screwR+2;

sy1 = 25.5;
sx1 = 18;
sy2 = piLen-5;
sx2 = piWidth-12.5;

/* [Parameters] */

// Part to render
part = 2; //[0:Assemble, 1:Base, 2:Top]
// Width in mm
printerWidth = 140;
// Length in mm
printerLen = 155;
// Cable Gap in mm
cableGap = 10;
// Want an LED hole?
haveLED = 1; //[0:No LED, 1:LED]
// LED diameter
ledD = 5;
ledR = ledD/2;
// Does the Pi have standoff holes? Older ones don't.
piStandoffs = 0; //[1:Standoffs, 0:No standoffs]

// compute pi offsets from edge (box width - pi width, etc.)

piWOffset = (printerWidth - piWidth)/2;
piLOffset = (printerLen - piLen)/2;

// Height of stand in mm
height = 40;
// Thickness of walls in mm
thick = 1;
// Gap between inner and outer wall, should be fairly loose
gap = 0.4;

clipHeight = piStandHeight+thick+piThick;

module base() {
	difference() {
		cube([printerWidth+2*thick,printerLen+2*thick,height+thick]);
		translate([thick,thick,thick]) cube([printerWidth, printerLen, height+thick]);
		translate([printerWidth/2+thick, printerLen, height-cableGap/2])
			cube([printerWidth/2, 10, height], center=true);
		translate([-thick-gap,-thick-gap,gap]) led();
		rotate([45,0,0]) translate([-1,-thick/2,-thick/2]) cube([printerWidth+2*thick+2*gap+2,thick,thick]);
		translate([0,printerLen+2*thick,0]) rotate([45,0,0]) translate([-1,-thick/2,-thick/2]) cube([printerWidth+2*thick+2*gap+2,thick,thick]);
		rotate([0,45,0]) translate([-thick/2,-1,-thick/2]) cube([thick,printerLen+2*thick+2*gap+2,thick]);
		translate([printerWidth+2*thick,0,0]) rotate([0,45,0]) translate([-thick/2,-1,-thick/2]) cube([thick,printerLen+2*thick+2*gap+2,thick]);
		}
	translate([piWOffset,piLOffset,thick]) {
		cube([piWidth,piLen,thick]);
		difference() {
			union() {
				translate([-thick,-thick,0]) cube([10,10,clipHeight]);
				translate([-thick,piLen-10+thick,0]) cube([10,10,clipHeight]);
				translate([piWidth+thick-2,-thick,0]) cube([4,10,clipHeight]);
				translate([piWidth+thick-2,piLen-10+thick,0]) cube([4,10,clipHeight]);
				}
			translate([0,0,piStandHeight]) cube([piWidth,piLen,piThick]);
			translate([thick,thick,0]) cube([piWidth-2*thick,piLen-2*thick,10]);
			}
		translate([sx1,sy1,0]) standoff();
		translate([sx2,sy2,0]) standoff();
		}
	difference() {
		translate([-thick-gap,-thick-gap,gap]) ledTube();
		translate([-thick-gap,-thick-gap,gap]) led();
		}
	}

// goes below pi to hold it up
module standoff() {
	if (piStandoffs) {
		cylinder(r=screwR,h=piStandHeight+5);
		cylinder(r=standR,h=piStandHeight);
		}
	}

// goes on top of pi to hold it down (onto standoffs)
module standon() {
	if (piStandoffs) {
		difference() {
			translate([0,0,piStandHeight+piThick]) cylinder(r=standR,h=height-piStandHeight+2*gap-piThick);
			cylinder(r=screwR+gap,h=height);
			}
		}
	}

module led() {
	if (haveLED) {
		translate([printerWidth-height/2,0,height/2+thick])
			rotate([90,0,0]) cylinder(r=ledR+gap, h=20, center=true);
		}
	}

module ledTube() {
	if (haveLED) {
		translate([printerWidth-height/2,8+thick+gap,height/2+thick]) {
			rotate([90,0,0]) cylinder(r=ledR+gap+thick, h=8, center=false);
			translate([-thick/2,-8,-height/2-thick]) cube([thick,8,height/2]);
			}
		}
	}

module cover() {
	translate([-thick-gap,-thick-gap,gap]) difference() {
		cube([printerWidth+4*thick+2*gap,printerLen+4*thick+2*gap,height+2*thick]);
		translate([thick,thick,-1]) cube([printerWidth+2*thick+2*gap, printerLen+2*thick+2*gap, height+thick+1]);
		translate([printerWidth/2+thick, printerLen, cableGap/2])
			cube([printerWidth/2, 10, height], center=true);
		led();
		translate([0,0,height+2*thick]) {
			rotate([45,0,0]) translate([-1,-thick/2,-thick/2]) cube([printerWidth+4*thick+4*gap+2,thick,thick]);
			translate([0,printerLen+4*thick+2*gap,0]) rotate([45,0,0]) translate([-1,-thick/2,-thick/2]) cube([printerWidth+4*thick+4*gap+2,thick,thick]);
			rotate([0,45,0]) translate([-thick/2,-1,-thick/2]) cube([thick,printerLen+4*thick+4*gap+2,thick]);
			translate([printerWidth+4*thick+2*gap,0,0]) rotate([0,45,0]) translate([-thick/2,-1,-thick/2]) cube([thick,printerLen+4*thick+4*gap+2,thick]);
			}
		}
	translate([piWOffset,piLOffset,thick]) {
		//cube([piWidth,piLen,thick]);
		translate([sx1,sy1,0]) standon();
		translate([sx2,sy2,0]) standon();
		}
	}

if ((part==0) || (part==1)) base();
if ((part==0) || (part==2)) cover();

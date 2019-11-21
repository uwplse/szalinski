// Created  by James Trimble - keybase.io/jamestrimble
// Released under Creative Commons - Attribution - Share Alike license

// preview[view:north east, tilt:top diagonal]
Number_Of_4mm_Slots = 3;
Number_Of_8mm_Slots = 3;
Reenforcement = true; //[true,false]


cablerack(Number_Of_4mm_Slots,Number_Of_8mm_Slots,Reenforcement);

module cablerack(num4mm, num8mm, reenforcements) {
	$fn = max($fn, 160);
	spacing = 8;
	thickness = 3;
	backHeight = 30;
	fingerLength = 100;
	rackWidth = num4mm*4+num8mm*8+(2+(num4mm+num8mm-1))*spacing;
	screwHoleRadius = 3.5;
	loc = 8;
	rsize = 16;

	
	difference() {
		union() {
			if (reenforcements==true) {
				// Create the re-enforcement area
				difference() { 
					translate([0,0,-2]) cube([rsize,rackWidth,rsize]);
					translate([rsize-1,-4,rsize+1]) rotate([-90,0,0]) cylinder(r=16,h=rackWidth*2, center=false);
				}
			}

			difference() {
				// Create the solid cable rack
				union() {
					translate([-2,0,0]) cube([2,rackWidth,backHeight]); // back plate
					translate([fingerLength,0,-2]) rotate([0,-60,0]) cube([6,rackWidth,2]); // edge lip
					translate([-2,0,1]) rotate ([0,90,0]) cube([3,rackWidth,fingerLength+2]);
				}

				// subtract the slots
				for (i4mm = [loc:4+spacing:loc+(4+spacing)*num4mm]) {
					translate([1,i4mm,-8]) cube([2*fingerLength,4,2*backHeight]);
				}

				for (i8mm = [loc+(4+spacing)*num4mm:8+spacing:(loc+(4+spacing)*num4mm)+((8+spacing)*num8mm)]) {
					translate([1,i8mm,-8]) cube([2*fingerLength,8,2*backHeight]);
				}
			}
		}
		
		// create the screw holes
		if (num4mm+num8mm<=2) {
			translate([0,rackWidth/2,backHeight-1.5*screwHoleRadius]) rotate([0,90,0]) cylinder(r=screwHoleRadius,h=thickness*3, center=true);
			translate([0,rackWidth/2,backHeight/2]) rotate([0,90,0]) cylinder(r=screwHoleRadius,h=thickness*3, center=true);
		} else {
			translate([0,2*spacing,backHeight*.75]) rotate([0,90,0]) cylinder(r=screwHoleRadius,h=thickness*3, center=true);
			translate([0,rackWidth-2*spacing,backHeight*.75]) rotate([0,90,0]) cylinder(r=screwHoleRadius,h=thickness*3, center=true);
		}

	}
}
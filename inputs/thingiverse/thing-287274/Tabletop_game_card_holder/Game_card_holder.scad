// How wide should the slot be that is cut down the middle? e.g. (How thick is your card, in millimeters?)
slotWidth = 2; // the slot width in millimeters
slotOffset = (10 - slotWidth)/2;


difference() {
	// Draw the base and the three vertical bars
	union() {
		translate([0,0,0]) {
			cube([38.5, 10, 2]);
		}
		translate([10,0,2]) {
			cube([2,5,4]);
		}
		translate([18.25,5,2]) {
			cube([2,5,4]);
		}
		translate([26.5,0,2]) {
			cube([2,5,4]);
		}
	}
	// Cut out a slot down the middle for the card to fit into
	translate([0,slotOffset,2]) {
		cube([38.5,slotWidth,4]);
	}
}

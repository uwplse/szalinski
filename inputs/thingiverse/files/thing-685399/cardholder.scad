// Customizable Business Card Holder by Jim DeVona
// http://www.thingiverse.com/thing:685399/

// Based on Business Card Holder by Markus Ortner
// http://www.thingiverse.com/thing:677783/

/* [Cards] */

number_of_cards = 24;

card_preview = "Show"; // [Show,Hide]

// (mm) Determines size of slots in base.
card_thickness = 1;

// (mm) Card width and height for preview. Consult https://en.wikipedia.org/wiki/Business_card#Dimensions for some common business card sizes.
card_width = 85.6;

// (mm)
card_height = 54;

/* [Card Orientation] */

// (%) Insert cards in base at this distance from inner edge.
card_position = 22; // [0:100]

// (degrees) Tilt 
tilt = -10; // [-15:15]

// (degrees)
lean = 25; // relative to tangent

// (mm)
slot_height = 4;

/* [Base] */

// (mm)
base_radius = 30;

// (mm)
base_height = 12;

// (%) Ring thickness as percentage of height
base_ratio = 100; // [75:200]

difference() {
	Base();
	
	if (card_preview == "Show") {
		#Cards(number_of_cards);
	} else {
		Cards(number_of_cards);
	}
}

module Cards(n) {
	for (i = [1:n]) {
		rotate([0, 0, i * 360/n])
		translate([base_radius, 0, slot_height])
		Card();
	}
}

module Card() {
	rotate([lean, tilt, 0])
	translate([-(card_position/100 * card_width), -card_thickness/2, 0])
	cube([card_width, card_thickness, card_height]);
}

module Base() {
	difference() {

		rotate_extrude($fn = number_of_cards * 3)
		translate([base_radius, 0, 0])
		scale([base_ratio / 2 / 100, 1]) circle(r = base_height);
		
		translate([0, 0, -base_height])
		cube([1 + (base_radius + base_height) * 2, 1 + (base_radius + base_height) * 2, base_height * 2], center=true);
	}
}
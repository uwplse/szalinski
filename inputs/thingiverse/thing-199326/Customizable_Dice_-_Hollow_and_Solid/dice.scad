/**
 *
 * Customizable Dice
 * Made by Dave de Fijter - 2013
 *
**/

// preview[view:south east, tilt:top diagonal]

/* [Global] */

// The radius of the 'digit' circles, 2x the radius is the diameter
circle_radius = 1; 

// The depth of the 'digit' circles
digit_depth = 0.2;

// The extra rounding that's added to the sides of the dice, use 0.01 for no rounding
rounding = 2;

// The size of one side, excluding the rounding
dice_size = 13;

// Do you want a solid dice, or a more filament economic hollow one?
dice_type = "solid"; // [solid, hollow]

// If you pick the hollow version, how much % hollow should it be? 80% or lower is adviced to keep it strong enough
hollowness = 80; // [0:99]

/* [Hidden] */

$fn = 64;

wall_thickness = rounding;

if(dice_type == "hollow") {

	difference() {
		difference() {
			hull() {
				dice(6);
	}
			hull() {
				scale(hollowness/100)
				dice(6);
			}
		}
		dice(0);
	}
} else {
	difference() {
		hull() {
			dice(6);
		}
		dice(0);
	}
}

module dice(minus) {

	side(1-minus);
	rotate([90, 0, 0])
		translate([0, 0-dice_size / 2, dice_size/2])
			side(2-minus);
	rotate([-90, 0, 0])
		translate([0, dice_size / 2, dice_size/2])
			side(5-minus);
	rotate([0, 90, 0])
		translate([dice_size/2, 0, dice_size/2])
			side(4-minus);
	rotate([0, 180, 0])
		translate([0, 0, dice_size])
			side(6-minus);
	rotate([90, 0, 270])
		translate([0, 0-dice_size/2, dice_size/2])
			side(3-minus);
}


module side(digit) {
	if(digit < 1) {	
		union() {
			cube([dice_size, dice_size, wall_thickness], center=true);
			
			rotate([90, 0, 0])
			translate([0-dice_size/2, 0, 0-dice_size/2]) 
			cylinder(r=wall_thickness/2, h=dice_size);
			
			rotate([90, 0, 90])
			translate([0-dice_size/2, 0, 0-dice_size/2]) 
			cylinder(r=wall_thickness/2, h=dice_size);
			rotate([90, 180, 0])
			translate([0-dice_size/2, 0, 0-dice_size/2]) 
			cylinder(r=wall_thickness/2, h=dice_size);
			
			rotate([90, 180, 90])
			translate([0-dice_size/2, 0, 0-dice_size/2]) 
			cylinder(r=wall_thickness/2, h=dice_size);
			
			
		}
	} else {
		translate([0, 0, (wall_thickness/2)-digit_depth])
			scale([1, 1, 1.1]) 
			number(digit);
	}
	
}

module number(digit) {
	/**
	 * This module creates the dots for a dice
	 * 1-6 is possible, other digits are not available
	 */
	offset = 3;	

	if(digit == 1) {
		cylinder(r=circle_radius, h=digit_depth);
	}

	if(digit == 2) {
		translate([-circle_radius*offset, circle_radius*offset, 0])
			cylinder(r=circle_radius, h=digit_depth);
		translate([circle_radius*offset, -circle_radius*offset, 0])
			cylinder(r=circle_radius, h=digit_depth);
	}

	if(digit == 3) {
		number(1);
		translate([circle_radius*offset, circle_radius*offset, 0])
			cylinder(r=circle_radius, h=digit_depth);
		translate([-circle_radius*offset, -circle_radius*offset, 0])
			cylinder(r=circle_radius, h=digit_depth);
	}

	if(digit == 4) {
		number(2);
		translate([circle_radius*offset, circle_radius*offset, 0])
			cylinder(r=circle_radius, h=digit_depth);
		translate([-circle_radius*offset, -circle_radius*offset, 0])
			cylinder(r=circle_radius, h=digit_depth);
	}

	if(digit == 5) {
		number(4);
		number(1);
	}

	if(digit == 6) {
		number(4);
		translate([circle_radius*offset, 0, 0])
			cylinder(r=circle_radius, h=digit_depth);
		translate([-circle_radius*offset, 0, 0])
			cylinder(r=circle_radius, h=digit_depth);
	}

}
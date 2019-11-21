include <utils/build_plate.scad>;



// The outer diameter of the coupler
outer_diameter = 20; 

// The total height of the coupler
height = 30;

// Diameter of the bottom axis (the smallest)
diameter_bottom = 5;

// Diameter of the top axis (the biggest)
diameter_top = 8;

// The aperture width
opening_width = 2;

// The y-thickness of the contact between the coupler's two parts
articulation_thickness = 1.5;

// Tightening bolts diameter
bolt_diameter = 3;

// Bolt head or washer diameter
washer_diameter = 5.5;

// Nut 'big' diameter
nut_diameter = 6.25;

// Thickness under the nut / washer, if too thin it may break :(
pressure_point_thickness = 4.5;

/* [Hidden] */
// The cylinder and holes resolution
resolution = 20;

//offset to avoid zero thickness plans
ozp = 1; 


module main_cylinder(d, h) {
	cylinder(h=h, r=d/2, center=false, $fn=resolution);
}

module bottom_hole(d) {
	translate([0,0,-ozp]) {
		cylinder(h=height/2 + ozp, r=d/2, center=false, $fn=resolution);
	}
}

module top_hole(d) {
	translate([0,0,height/2 - ozp]) {
		cylinder(h=height/2 + 2*ozp, r=d/2, center=false, $fn=resolution);
	}
}

module opening_left() {
	translate([-opening_width/2,-outer_diameter/2,-ozp]) {
		cube(size=[opening_width, outer_diameter / 2, height + 2*ozp], center=false);
	}
}

module opening_right() {

	y_offset = (diameter_top/2) + opening_width/2 + articulation_thickness;
	translate([0, y_offset, -ozp]) {
		cylinder(h=height + 2*ozp, r=opening_width/2, center=false, $fn=20);
	}

	translate([-opening_width/2,y_offset,-ozp]) {

		cube(size=[opening_width, outer_diameter / 2, height + 2*ozp], center=false);
	}
}

module bolt_hole(z) {

	y_offset_bolt = -((outer_diameter-diameter_top)/4 + (diameter_top*1/3));

	//main hole:
	translate([0,y_offset_bolt,z]){
		rotate([0,90,0]) {
			cylinder(h=outer_diameter, r=bolt_diameter/2, center=true, $fn=resolution);
		}
	}
	
	//nut:
	translate([(opening_width/2) + pressure_point_thickness, y_offset_bolt, z]) {
		rotate([0,90,0]) {
			cylinder(h=outer_diameter, r=nut_diameter/2, center=false, $fn=6);
		}
	}
	
	//washer:
	translate([-outer_diameter - (opening_width/2) - pressure_point_thickness, y_offset_bolt, z]) {
		rotate([0,90,0]) {
			cylinder(h=outer_diameter, r=washer_diameter/2, center=false, $fn=resolution);
		}
	}
	
	
}

module debug(name, value) {
	echo(name, value);
}

module main() {
	difference() {
		main_cylinder(outer_diameter, height);
		bottom_hole(diameter_bottom);
		top_hole(diameter_top);	
		opening_left(); 	
		opening_right();
		bolt_hole(height * 1/4);
		bolt_hole(height * 3/4);
	}
}


main();
//bolt_hole(0);
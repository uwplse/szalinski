/*
 * An LED spotlight shade.
 *
 * To prevent the can from glowing, cut a piece of flexible
 * opaque reflective material (aluminum foil, shiny anti-static bag)
 * to fit between the LED and the can wall. This should be 10x26mm (this
 * gives you 2mm overlap).
 */

// Diameter of the LED (mm)
led_diameter = 6.5;

// Clearance between the LED wall and the LED.
interior_clearance = 1;

// Thickness of the wall.
wall_thickness = .75;

// Height of the shade.
shade_height = 12;

// Diameter of the top holes, for the LED leads to go through.
top_hole = 1.25;

// Distance between the top holes. This is from the edge of the holes, not the
// centers, so calipers can be used to measure this accurately for your LED.
top_hole_separation=2;

base_radius = interior_clearance + led_diameter/2;

// Resolution of the cylinders (the number of facets).
resolution = 40;

module shade(){
difference(){
    cylinder(h = shade_height+wall_thickness, r = base_radius+wall_thickness, $fn = resolution);
    cylinder(h = shade_height, r = base_radius, $fn = resolution);
	// Top holes
	translate([0, 0, 10]){
	    translate([(top_hole_separation+top_hole)/2,0,0])
	    cylinder(h = shade_height, r = top_hole/2, $fn = resolution);
	    translate([-(top_hole_separation+top_hole)/2,0,0])
	    cylinder(h = shade_height, r = top_hole/2, $fn = resolution);
	}
    }
}

rotate([180, 0, 0]){
    translate([0, 0, -shade_height-wall_thickness]){
	shade();
    }
}

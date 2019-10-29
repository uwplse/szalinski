// Part to generate
part = "fbl"; // [fbl:All,f:Frame,b:Box,l:Lid,fb:Frame & box,bl:Box & lid,fl:Frame & lid]
// Wall thikness of all parts
wall_thickness = 1; // [.2:.1:3]
// Gap between all sides of all parts
gap = 0.2; // [0:.1:1]
// Length of the notes you want to keep safe
notes_length = 158; // [50:0.5:300]
// Width of the notes you want to keep safe
notes_width = 68.5; // [25:0.5:150]
// Height of the notes you want to keep safe
notes_height = 15; // [1:50]
// Hole radius on the bottom of box, put 0 to make it without any hole
hole_radius = 10; // [0:0.5:20]
// Relative hole position in percents
hole_position = 10; // [0:100]
// Width of the guide rail, don't make it greater than leading guide rail length
guide_rail_width = 10; // [0:0.5:75]
// Adds bridge to make frame sturdier
leading_bridge = "y"; // [y:Yes,n:No]
// Length of the leading guide rail, don't make it less than guide rail width
leading_rail_length = 30; // [0:50]
// Diameter for screw holes
screw_diameter = 4; // [0:0.5:5]

/* [Hidden] */
e = 1e-2;
$fn = 50;

module box() {
	difference() {
		cube([notes_width + 2 * wall_thickness, notes_length + 2 * wall_thickness, notes_height + wall_thickness]);
		translate([wall_thickness, wall_thickness, wall_thickness]) cube([notes_width, notes_length, notes_height + e]);
		translate([wall_thickness + notes_width / 2, wall_thickness + hole_radius + (notes_length - 2 * hole_radius) * hole_position / 100, -e]) cylinder(r = hole_radius, h = wall_thickness + 2 * e);
	}
	
}

module frame() {
	difference() {
		union() {
			cube([notes_width + 2 * (gap + 2 * wall_thickness), notes_length + 3 * wall_thickness + gap, 2 * wall_thickness + notes_height + gap]);
			translate([wall_thickness * sin(45), -wall_thickness * sin(45), 0]) rotate(a = 135, v = [0, 0, 1]) translate([wall_thickness - guide_rail_width, 0, 0]) cube([guide_rail_width, leading_rail_length, 2 * wall_thickness + notes_height + gap]);
			translate([notes_width + 2 * (gap + 2 * wall_thickness) - wall_thickness * sin(45), -wall_thickness * sin(45), 0]) rotate(a = 225, v = [0, 0, 1]) translate([-wall_thickness, 0, 0]) cube([guide_rail_width, leading_rail_length, 2 * wall_thickness + notes_height + gap]);
			cylinder(r = guide_rail_width, h = 2 * wall_thickness + notes_height + gap);
			translate([notes_width + 2 * (gap + 2 * wall_thickness), 0, 0]) cylinder(r = guide_rail_width, h = 2 * wall_thickness + notes_height + gap);
			translate([0, notes_length + 3 * wall_thickness + gap - guide_rail_width, 0]) cylinder(r = guide_rail_width, h = 2 * wall_thickness + notes_height + gap);
			translate([notes_width + 2 * (gap + 2 * wall_thickness), notes_length + 3 * wall_thickness + gap - guide_rail_width, 0]) cylinder(r = guide_rail_width, h = 2 * wall_thickness + notes_height + gap);
		}
		translate([wall_thickness, -e - guide_rail_width / sin(45), wall_thickness]) cube([notes_width + 2 * (gap + wall_thickness), notes_length + 2 * wall_thickness + gap + e + guide_rail_width / sin(45), 2 * wall_thickness + notes_height + gap + e]);
		translate([guide_rail_width, -e + (leading_bridge=="y"?guide_rail_width:0), -e]) cube([notes_width + 2 * (gap + 2 * wall_thickness) - 2 * guide_rail_width, notes_length + 3 * wall_thickness + gap - guide_rail_width + e - (leading_bridge=="y"?guide_rail_width:0), wall_thickness + 2 * e]);
		translate([wall_thickness, -wall_thickness * sin(45), wall_thickness]) rotate(a = 135, v = [0, 0, 1]) translate([0 - guide_rail_width, 0, 0]) cube([guide_rail_width, leading_rail_length + wall_thickness, 2 * wall_thickness + notes_height + gap]);
		translate([notes_width + 2 * (gap + 2 * wall_thickness) - wall_thickness, -wall_thickness * sin(45), wall_thickness]) rotate(a = 225, v = [0, 0, 1]) translate([0, 0, 0]) cube([guide_rail_width, leading_rail_length + wall_thickness, 2 * wall_thickness + notes_height + gap]);
		translate([-guide_rail_width / 2, 0, -e]) cylinder(r = screw_diameter / 2, h = 2 * wall_thickness + notes_height + gap + 2 * e);
		translate([notes_width + 2 * (gap + 2 * wall_thickness) + guide_rail_width / 2, 0, -e]) cylinder(r = screw_diameter / 2, h = 2 * wall_thickness + notes_height + gap + 2 * e);
		translate([-guide_rail_width / 2, notes_length + 3 * wall_thickness + gap - guide_rail_width, -e]) cylinder(r = screw_diameter / 2, h = 2 * wall_thickness + notes_height + gap + 2 * e);
		translate([notes_width + 2 * (gap + 2 * wall_thickness) + guide_rail_width / 2, notes_length + 3 * wall_thickness + gap - guide_rail_width, -e]) cylinder(r = screw_diameter / 2, h = 2 * wall_thickness + notes_height + gap + 2 * e);
	}
}

module lid() {
	cube([notes_width - 2 * gap, notes_length - 2 * gap, wall_thickness]);
}

if (len(search("b", part)) > 0) box();

if (len(search("f", part)) > 0) translate([-wall_thickness - gap, 0, -(wall_thickness + gap)]) frame();

if (len(search("l", part)) > 0) translate([wall_thickness + gap, wall_thickness + gap, notes_height]) lid();
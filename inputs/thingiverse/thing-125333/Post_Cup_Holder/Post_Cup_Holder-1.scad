// Inside diameter of the opening that will hold your cup, in mm
cup_diameter = 80;
// Height of the inside of the opening that will hold your cup, in mm
cup_height = 25;
// Thickness of the printed walls, in mm
wall_thickness = 2;
// Diameter of the post that this will slip over, in mm
post_diameter = 86;
// Height of the post covered by holder, in mm
post_height = 15;

$fn=250;

module ring(inner_diameter, height, thickness)
{
	difference()
	{
		cylinder(h = height, r = inner_diameter / 2 + wall_thickness);
		translate(v=[0, 0, -.01])
			cylinder(h = height + .02, r = inner_diameter / 2);
	}
}

module cup(cup_diameter, cup_height, post_diameter, post_height, wall_thickness)
{
	ring(cup_diameter, cup_height);
	translate(v=[0, 0, -post_height - wall_thickness])
		ring(post_diameter, post_height, wall_thickness);

	plate_diameter = max(cup_diameter, post_diameter) + 2 * wall_thickness;
	translate(v = [0, 0, -wall_thickness])
		cylinder(h = wall_thickness, r = plate_diameter / 2);
}

cup(cup_diameter, cup_height, post_diameter, post_height, wall_thickness);
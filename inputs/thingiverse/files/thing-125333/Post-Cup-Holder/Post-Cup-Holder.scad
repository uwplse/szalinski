// Inside diameter for the cup
cup_diameter = 80;
// Height of the cup covered by holder
cup_depth = 20;
// Thickness of the printed walls
wall_thickness = 2.5;
// Diameter of the post
post_diameter = 88;
// Height of the post covered by holder
post_height = 15;

$fn=250;

module open_cup(inner_diameter, height, thickness)
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
	open_cup(cup_diameter, cup_height);
	translate(v=[0, 0, -post_height - wall_thickness])
		open_cup(post_diameter, post_height, wall_thickness);

	plate_diameter = max(cup_diameter, post_diameter) + 2 * wall_thickness;
	translate(v = [0, 0, -wall_thickness])
		cylinder(h = wall_thickness, r = plate_diameter / 2);
}

cup(cup_diameter, cup_depth, post_diameter, post_height, wall_thickness);
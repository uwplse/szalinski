$fn = 50;

shaker_radius = 25;
shaker_height = 25;

handle_radius = 5;
handle_height = 25;

wall_thickness = 3;

bead_radius = 6;

difference()
{
	color("grey") union()
	{
		cylinder(r = shaker_radius, h = shaker_height);
		translate([0,0,shaker_height]) cylinder(r1 = shaker_radius, r2 = handle_radius, h = handle_height);
		$translate([0,0,shaker_height+handle_height]) cylinder(r = handle_radius, h = handle_height);
	}
	
	color("red") union()
	{
		translate([0,0,wall_thickness]) cylinder(r = shaker_radius-wall_thickness, h = shaker_height-wall_thickness);
		translate([0,0,shaker_height]) cylinder(r1 = shaker_radius-wall_thickness, r2 = handle_radius, h = handle_height-wall_thickness);
	}
	
	color("green") union()
	{
		translate([0,0,-wall_thickness]) cylinder(r = bead_radius*0.65, h = 3*wall_thickness);
		
		for(i = [0:5])
		{
			rotate([0,0, i*360/6]) translate([0,shaker_radius/2,-wall_thickness]) cylinder(r = bead_radius*0.65, h = 3*wall_thickness);
		}
	}
	
	cube(size = [shaker_radius, 2*shaker_radius, shaker_height+handle_height]);
}

color("blue") union()
{
	rotate([0,0, i*360/6]) translate([0,0,0]) cylinder(r = bead_radius*0.5, h =  wall_thickness);
		
	rotate([0,0, i*360/6]) translate([0,0,wall_thickness]) cylinder(r1 = bead_radius*0.5, r2 = bead_radius, h =  bead_radius);
	for(i = [0:5])
	{
		rotate([0,0, i*360/6]) translate([0,shaker_radius/2,0]) cylinder(r = bead_radius*0.5, h =  wall_thickness);
		
		rotate([0,0, i*360/6]) translate([0,shaker_radius/2,wall_thickness]) cylinder(r1 = bead_radius*0.5, r2 = bead_radius, h =  bead_radius);
	}
}
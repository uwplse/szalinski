//resistor box
//purpose: make a box with rounded corners and variable number of holes on one face
//and add a lid.
//all holes are identical

$fn = 50;
//CUSTOMIZER VARIABLES
//box width (interior)
p_width = 50; //

//box height (interior)
p_height = 34; //

//box depth (interior)
p_depth = 30; //

//corner rounding radius
p_round = 4; 

//top and bottom wall thickness
p_wall_top = 4; 

//panel cutout for jack (radius)
p_hole_r_small = 3.2; 

//outside size of jack (radius) 
p_hole_r_large = 4.25; 

//number of holes across width
p_num_holes_x = 4; 

//number of holes across height
p_num_holes_z = 2; 
//CUSTOMIZER VARIABLES END


p_wall = .1; //inside wall (will be added to p_round for total wall)
null = 1; //unit used to ensure intersections

//find inter-hole spacing
space_x = ((p_width - (2 * p_hole_r_large * p_num_holes_x)) / (p_num_holes_x + 1)) + 2 * p_hole_r_large;
space_z = ((p_height - (2 * p_hole_r_large * p_num_holes_z)) / (p_num_holes_z + 1))+ 2 * p_hole_r_large;


//make the box
difference()
{
	difference() 
	{
		minkowski() //make a rounded box
		{
		cylinder(r = p_round , h = null);
		cube([p_width  , p_depth, p_height ]);
		}

		translate([p_wall , p_wall , p_wall_top]) //hollow the rounded box
		cube([p_width - 2 * p_wall , p_depth - 2 * p_wall, p_height - 2 * p_wall]);
	}
	
	for (z = [1 : 1: p_num_holes_z] ) //drill holes
	{
		for (x = [1 : 1: p_num_holes_x] )
		{
		translate( [(x * space_x) - ( p_hole_r_large), - p_round - null ,( z * space_z ) - (p_hole_r_large)])
		rotate([-90 , 0 , 0])
		cylinder( r = p_hole_r_small , p_round + p_wall + 2 * null);
		}	
	}
	//cut the top off
	translate([-p_width , -p_depth , p_height - p_wall_top]) 
	cube(p_width * 100 , p_depth * 100 , p_height * 100);

	//notch the top
	translate([ (p_width / 2) - 0.5 * p_wall_top , -p_round , p_height - 2.0 * p_wall_top])
	cube([p_wall_top , p_depth + p_round + p_round ,  p_wall_top]);
}

union()
{
	//add top placed at zero height and out of the way
	translate([0 , -p_depth -2 * p_round - 3 * null, 0])
	minkowski() //make a rounded box
		{
		cylinder(r = p_round , h = null);
		cube([p_width  , p_depth, p_wall_top ]);
		}
	//add alignment beam
	translate([ (p_width / 2) - 0.5 * p_wall_top , -p_depth -2 * p_round - 3 * null - p_round, p_wall_top])
	cube([p_wall_top , p_depth + p_round + p_round ,  p_wall_top]);
}

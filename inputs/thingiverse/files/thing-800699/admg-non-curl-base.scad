// Customisable non-curl base plate
// v1.0 
// (c)Alex Gibson 30/04/2015
// admg consultancy
// Please credit any use, and tweet @alexgibson3d



//model_name = "House_Scale_1-87_repaired.stl";
//resize_model_percent = 80;

base_width_x = 150;
base_depth_y = 100;
base_height_z = 10;

thickness = 1.5;
tower_radius = 1.5*thickness;

x_segments = 5;//	[0:6]
y_segments = 4;//	[0:6]

$fn=50;

x_space = (base_width_x-thickness)/x_segments;
y_space = (base_depth_y-thickness)/y_segments;


waffle_cutout_x = (base_width_x-(thickness*(x_segments+1)))/x_segments;
waffle_cutout_y = (base_depth_y-(thickness*(y_segments+1)))/y_segments;

//translate([0,0,-0.01])
//	scale([resize_model_percent/100,resize_model_percent/100,resize_model_percent/100])
//		import(model_name);


module base_block()
	{
	translate([0,0,-base_height_z/2])
		cube([base_width_x,base_depth_y,base_height_z],center=true);
	}


xpos_limit_squares = (x_segments/2)-0.5;
ypos_limit_squares = (y_segments/2)-0.5;

echo ("xpos_limit_squares =", xpos_limit_squares);
echo ("ypos_limit_squares =", ypos_limit_squares);

xpos_limit_cones = (x_segments/2);
ypos_limit_cones = (y_segments/2);

module base_waffle_cutouts()
	{
	for
		(
		xpos = [-(x_space*xpos_limit_squares) : x_space : x_space*xpos_limit_squares], 
		ypos = [-(y_space*ypos_limit_squares) : y_space : y_space*ypos_limit_squares]
		) 
			translate([xpos, ypos,-(base_height_z/2+thickness)])     
				cube([waffle_cutout_x,waffle_cutout_y,base_height_z],center = true);

	}


module base_waffle()
	{
	difference()
		{
		base_block();
		base_waffle_cutouts();
		}
	}



module cones()
	{
	for 
		(
		xpos = [-(x_space*xpos_limit_cones) : x_space : x_space*xpos_limit_cones], 
		ypos = [-(y_space*ypos_limit_cones) : y_space : y_space*ypos_limit_cones]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness/2)])     
				cylinder(base_height_z-thickness,tower_radius,thickness/2,center = true);
	}
module cones2()
	{
	for 
		(
		xpos = [-(x_space*xpos_limit_cones) : x_space : x_space*xpos_limit_cones], 
		ypos = [-(y_space*ypos_limit_cones) : y_space : y_space*ypos_limit_cones]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness)])     
				cylinder(base_height_z-thickness,tower_radius-thickness/2,0,center = true);
	}

module waffle_with_cones()
	{
	difference()
		{
		union()
			{
			base_waffle();
			cones();
			}
		cones2();
		}
	}


//cones();

waffle_with_cones();



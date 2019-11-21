// Customisable non-curl base plate 2
// v1.0 
// (c)Alex Gibson 05/05/2015
// admg consultancy
// Please credit any use, and tweet @alexgibson3d



//model_name = "input.stl";
//resize_model_percent = 80;

base_width_x = 200;
base_depth_y = 150;
base_height_z = 20;

thickness = 1.5;
corner_radius = 3;
tower_radius = thickness*4;
texture_radius = thickness*1.5;
ridges = 4;

x_segments = 6;//	[0:6]
y_segments = 5;//	[0:6]

$fn=50;

x_space = (base_width_x-thickness)/x_segments;
y_space = (base_depth_y-thickness)/y_segments;

x_edge = (base_width_x)/x_segments;
y_edge = (base_depth_y)/y_segments;


waffle_cutout_x = (base_width_x-(thickness*(x_segments+1)))/x_segments;
waffle_cutout_y = (base_depth_y-(thickness*(y_segments+1)))/y_segments;

//translate([0,0,-0.01])
//	scale([resize_model_percent/100,resize_model_percent/100,resize_model_percent/100])
//		import(model_name);


module base_block()
	{
	translate([0,0,-base_height_z/2])
		minkowski()
			{
			cube([base_width_x-corner_radius*2,base_depth_y-corner_radius*2,base_height_z/2],center=true);
			cylinder(base_height_z/2,corner_radius,corner_radius,center = true);
			}
	}


xpos_limit_squares = (x_segments/2)-0.5;
ypos_limit_squares = (y_segments/2)-0.5;

echo ("xpos_limit_squares =", xpos_limit_squares);
echo ("ypos_limit_squares =", ypos_limit_squares);

xpos_limit_towers = (x_segments/2)-1;
ypos_limit_towers = (y_segments/2)-1;

xpos_limit_edge_texture = (x_segments/2);
ypos_limit_edge_texture = (y_segments/2);

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



module towers()
	{
	for 
		(
		xpos = [-(x_space*xpos_limit_towers) : x_space : x_space*xpos_limit_towers], 
		ypos = [-(y_space*ypos_limit_towers) : y_space : y_space*ypos_limit_towers]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness/2)])     
				cylinder(base_height_z-thickness,tower_radius,tower_radius,center = true);
	}
module towers_cutouts()
	{
	for 
		(
		xpos = [-(x_space*xpos_limit_towers) : x_space : x_space*xpos_limit_towers], 
		ypos = [-(y_space*ypos_limit_towers) : y_space : y_space*ypos_limit_towers]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness)])     
				cylinder(base_height_z-thickness,tower_radius-thickness/2,tower_radius-thickness/2,center = true);
	}




module edge_texture_outer_x()
	{
	for 
		(
		xpos = [-((x_space*xpos_limit_edge_texture)-x_space/ridges) : x_space/ridges : ((x_space*xpos_limit_edge_texture)-x_space/ridges)],
		ypos = [-(y_edge*ypos_limit_edge_texture), y_edge*ypos_limit_edge_texture]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness/2)])     
				cylinder(base_height_z-thickness,thickness*2,thickness*2,center = true);
	}
module edge_texture_inner_x()
	{
	for 
		(
		xpos = [-((x_space*xpos_limit_edge_texture)-x_space/ridges) : x_space/ridges : ((x_space*xpos_limit_edge_texture)-x_space/ridges)],
		ypos = [-(y_edge*ypos_limit_edge_texture), y_edge*ypos_limit_edge_texture]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness)])     
				cylinder(base_height_z-thickness,thickness*1.5,thickness*1.5,center = true);
	}

module edge_texture_outer_y()
	{
	for 
		(
		xpos = [-(x_edge*xpos_limit_edge_texture), x_edge*xpos_limit_edge_texture], 
		ypos = [-((y_space*ypos_limit_edge_texture)-y_space/ridges) : y_space/ridges : ((y_space*ypos_limit_edge_texture)-y_space/ridges)]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness/2)])     
				cylinder(base_height_z-thickness,thickness*2,thickness*2,center = true);
	}
module edge_texture_inner_y()
	{
	for 
		(
		xpos = [-(x_edge*xpos_limit_edge_texture), x_edge*xpos_limit_edge_texture], 
		ypos = [-((y_space*ypos_limit_edge_texture)-y_space/ridges) : y_space/ridges : ((y_space*ypos_limit_edge_texture)-y_space/ridges)]
		) 
			translate([xpos, ypos, -(base_height_z/2+thickness)])     
				cylinder(base_height_z-thickness,thickness*1.5,thickness*1.5,center = true);
	}

module waffle_with_towers()
	{
	difference()
		{
		union()
			{
			base_waffle();
			towers();
			edge_texture_outer_x();
			edge_texture_outer_y();
			}
		towers_cutouts();
		edge_texture_inner_x();
		edge_texture_inner_y();
		difference()
			{
			cube([base_width_x*3,base_depth_y*3,base_height_z*3],center=true);
			cube([base_width_x,base_depth_y,base_height_z*4],center=true);
			}
		}
	}


//cones();

waffle_with_towers();



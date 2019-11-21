///////////////////////////////////////////
// Copyright 2013 Ross Hendrickson
// BSD - License
// v0.08.03.13
/////////////////////////////////////////

///////////////////////////////////////////
//
// Customizer Variables
//
/////////////////////////////////////////

// The dimensions of the size of the object you want to have inside
internal_x = 100;
internal_y = 100;
internal_z = 100;

// How thick your material is to cut, or how thick of walls you want to print
material_z = 4;

// Measure whatever screws you want to use with whatever nuts and set it accordingly
screw_outside_diameter = 3;
screw_length = 12;

nut_outside_diameter = 5.5;
nut_height = 2.5;

// Related to the anchors themselves
// Anchor Count determines how many anchoring points there will be along a face
anchor_count = 3; 
// Determines how wide the teeth are that will be pushed into the opposing face
tooth_width = 3;
// Determines where the nut will rest, based on a percentage
channel_position =70; // [0:100]

//Select what part you want to export - make your own build plates
part = "assembled"; // [assembled:Assembled, bottom:Bottom, top:Top, west:West Wall, east:East Wall, north:North Wall, south:South Wall]

// preview[view:south, tilt:top diagonal]
print_part();

module print_part() {
	if (part == "bottom") {
		bottom();
	} else if (part == "top") {
		top();
	} else if (part == "west") {
		west_wall();
	}else if (part == "east") {
		east_wall();
	 }else if (part == "north") {
		north_wall();
	 }else if (part == "south") {
		south_wall();
	 }else if (part == "assembled") {
		assembled();
	 }else {
		print_me();
	}
}

///////////////////////////////////////////
//
// Internal Variables - Not customizable
//
/////////////////////////////////////////
material_thickness = material_z;

wall_height = internal_z;
north_buffer = 0;

a_c = anchor_count;

mill_space = 60;
board_x = internal_x;
board_y = internal_y;
board_z = internal_z;

main_buffer = 0;
main_x = board_x + material_thickness + main_buffer;
main_y = board_y + material_thickness + main_buffer/2;
main_z = material_thickness;

fn = 40;

///////////////////////////////////////////
//
// Basic Case design
//
// print_me() - an attempt to make a plate
// mill_me() - will take the plate and make a projection
// assemble() - will assemble the box for preview
/////////////////////////////////////////

module east_wall()
{
	//east_x = main_x + 6.6; //- harbor_offset * 2 - (material_thickness * 4) ;
	offset = (harbor_offset * 2) + (material_thickness * 2);
	east_x = main_x - offset;
	east_y = wall_height;

	pylons = [a_c,a_c,a_c,a_c]; 
	types = [1,1,1,1];
	
	offsets = [offset, offset,offset, offset];
	offcenters = [0,0,0,0];
	
	generate_cube([east_x,east_y,main_z], true, pylons, types, offsets, 	offcenters);
}

module north_wall()
{
	pylons = [a_c,a_c,a_c,a_c]; 
	types = [1,0,1,0];
	offset = (harbor_offset * 2) + (material_thickness * 2);
	offsets = [0, 0, 0, 0];

	south_x = main_x;
	south_y = wall_height;
	
	generate_cube([main_x, wall_height, material_thickness], true, pylons, types, offsets);
}

module top()
{
	
	pylons = [a_c,a_c,a_c,a_c]; 
	types = [0,0,0,0];

	top_x = main_x;
	top_y = main_y;

	generate_cube([top_x,top_y,main_z], true, pylons, types);
}



module bottom()
{

	pylons = [a_c,a_c,a_c,a_c]; 
	types = [0,0,0,0];

	below_z = 7;
	above_z = 11;
	generate_cube([main_x,main_y,main_z], true, pylons, types);
}

module south_wall()
{
	pylons = [a_c,a_c,a_c,a_c]; 
	types = [1,0,1,0];

	south_x = main_x;
	south_y = wall_height;

	generate_cube([south_x,south_y,main_z], true, pylons, types);

}

module west_wall()
{

	east_wall();
}



module assembled() 
{
	translate([0,0,-wall_height/2])
	bottom();

	color("green") 
	//translate([0,harbor_offset/2,0])
	mirror([0,0,1])
	translate([main_x/2 -material_thickness/2 - harbor_offset,0, -material_thickness/2])
	rotate([90,0,-90])
	east_wall();

	color("orange")
	//translate([0,harbor_offset/2,0])
	mirror([1,0,0])
	mirror([0,0,1])
	translate([main_x/2 -material_thickness/2 - harbor_offset, 0, -material_thickness/2])
	rotate([90,0,-90])
	west_wall();

	color("grey")
	translate([0, main_y/2 - material_thickness/2 - harbor_offset, material_thickness/2])
	mirror([0,1,0])
	rotate([270,0,0])
	north_wall();

	color("red")
	translate([0, -(main_y/2 - material_thickness/2 - harbor_offset), material_thickness/2])
	rotate([90,0,0])
	south_wall();
	
	color("white")
	translate([0,0,wall_height/2 + material_thickness])
	top();


}

module mill_me()
{
	projection(cut = true){
	bottom();
	
	translate([mill_space,0,0])
	rotate([0,0,90])
	east_wall();

	mirror([1,0,0])
	translate([mill_space,0,0])
	rotate([0,0,90])
	east_wall();

	translate([0,-mill_space, 0])
	south_wall();

	translate([0,mill_space, 0])
	north_wall();

	translate([0, main_y/2 + wall_height + mill_space,0])
	top();
	}
	
}



module print_me()
{
	bottom();
	
	translate([mill_space,0,0])
	rotate([0,0,90])
	color("blue")
	east_wall();

	mirror([1,0,0])
	translate([mill_space,0,0])
	rotate([0,0,90])
	color("orange")
	east_wall();

	translate([0,-mill_space, 0])
	south_wall();

	translate([0,mill_space, 0])
	north_wall();

	translate([0, main_y/2 + wall_height + mill_space,0])
	top();

}


///////////////////////////////////////////
//
// Library modules
//
/////////////////////////////////////////

///////////////////////////////////////////////////////////
/// Copyright 2013 Ross Hendrickson
///
///  BSD License
///
/////////////////////////////////////////////////////////

//test();

///////////////////////////
//Customizer Variables
///////////////////////////

//////////Library Variables related to customizer///////////////
retain_screw_od = screw_outside_diameter;
retain_screw_height = screw_length;

retain_nut_od = nut_outside_diameter;
retain_nut_height = nut_height;
anchor_width = tooth_width;

//Position where the nut should be in the channel
channel_top = channel_position/100;
channel_bottom = 1 - channel_top;

////////////////////////////////
//Non-Customizer Variables
////////////////////////////////

//Related to anchors and harbors
buffer = 0.1;
anchor_target_width = material_z;
harbor_offset = material_z;
harbor_width = anchor_width*2 + retain_screw_od + buffer;

module test()
{
	//North, East, South, West
	pylons = [3,2,1,2];
	types = [1,0,1,0];
	offsets = [0,0,0,0];
	offcenters = [0,0,0,0];
	generate_cube([100,110,1], true, pylons, types, offsets, offcenters);	
}

module generate_negative_grid(dim, p, t, offsets = [0,0,0,0],  offcenters = [0,0,0,0])
{
	cube_x = dim[0];
	cube_y = dim[1];
	side_off = cube_y - cube_x;

	for ( i = [ 0 : 3 ] )
	{
		if ( t[i] == 1)
		{
		echo("POSITIVE:" ,p[i]);
		//North
		if ( i == 0)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			translate([offcenters[i],0,0])
			generate_shafts(cube_x + offsets[0], cube_y, p[i]); 
		}
		
		//East
		if ( i == 1)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			translate([-side_off/2,0,0])
			rotate([0,0,270])
			translate([offcenters[i],0,0])
			generate_shafts(cube_x + offsets[i], cube_y, p[i]); 
		}

		//South
		if ( i == 2)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			mirror([0,1,0])
			translate([offcenters[i],0,0])
			generate_shafts(cube_x + offsets[i], cube_y, p[i]); 
		}

		//West
		if ( i == 3)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			
			translate([side_off/2,0,0])
			mirror([1,0,0])
			rotate([0,0,-90])
			translate([offcenters[i],0,0])
			generate_shafts(cube_x + offsets[i], cube_y, p[i]); 
		}
		
	////////////////
		}else{
	////////////////
		echo("NEGATIVE", p[i]);
		//North
		if ( i == 0)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			translate([offcenters[i],0,0])
			generate_harbors(cube_x + offsets[i], cube_y, p[i]); 
		}
		
		//East
		if ( i == 1)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			
			translate([-side_off/2,0,0])
			rotate([0,0,270])
			translate([offcenters[i],0,0])
			generate_harbors(cube_x + offsets[i], cube_y, p[i]); 
		}

		//South
		if ( i == 2)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			
			mirror([0,1,0])
			translate([offcenters[i],0,0])
			generate_harbors(cube_x + offsets[i], cube_y, p[i]); 
		}

		//West
		if ( i == 3)
		{
			echo("OFFCENTERS: ", offcenters[i]);
			translate([side_off/2,0,0])
			mirror([1,0,0])
			rotate([0,0,-90])
			translate([offcenters[i],0,0])
			generate_harbors(cube_x + offsets[i], cube_y, p[i]); 
		}

		}

	}

}


module generate_positive_grid(dim, p, t, offsets = [0,0,0,0], offcenters = [0,0,0,0])
{
	cube_x = dim[0];
	cube_y = dim[1];
	side_off = cube_y - cube_x;
	echo("OFFCENTERS_POSITIVE: ", offcenters);
	echo("OFFSETS", offsets);
	for ( i = [ 0 : 3 ] )
	{
		if ( t[i] == 1)
		{
		//North
		if ( i == 0)
		{
			translate([offcenters[i],0,0])
			generate_anchors(cube_x + offsets[0], cube_y, p[i]); 
			
		}
		
		//East
		if ( i == 1)
		{
			translate([-side_off/2,0,0])
			rotate([0,0,270])
			translate([offcenters[i],0,0])
			generate_anchors(cube_x + offsets[i], cube_y, p[i]); 		
		}

		//South
		if ( i == 2)
		{
			mirror([0,1,0])
			translate([offcenters[i],0,0])
			generate_anchors(cube_x + offsets[i], cube_y, p[i]); 		
		}

		//West
		if ( i == 3)
		{
			translate([side_off/2,0,0])
			mirror([1,0,0])
			rotate([0,0,-90])
			translate([offcenters[i],0,0])
			generate_anchors(cube_x + offsets[i], cube_y, p[i]); 
		}
		}
	}

}

module generate_cube(dim, centered, points, types, offsets = [0,0,0,0], offcenters = [0,0,0,0])
{
	
	x = dim;
	y = dim;
	z = dim;

	if ( len(dim) > 1 )
	{
		assign( x = dim[0], y = dim[1], z = dim[2])
		{
			gen_cube(x , y, z, centered, points, types, offsets, offcenters);
		}
		
	}else{
		assign(x = dim, y = dim, z = dim)
		{
			gen_cube(x, y, z, centered,  points, types, offsets, offcenters);
		}
	}
	
	
}

module gen_cube(x, y , z, centered, points, types, offsets = [0,0,0,0], offcenters = [0,0,0,0] )
{
	union(){
	difference(){
	
	cube([x,y,z], center = centered);
	
	//difference out shafts
	//difference out harbor
		generate_negative_grid([x,y,z], points, types, offsets, offcenters);
	}
	//union anchors
		generate_positive_grid([x,y,z], points, types, offsets, offcenters);
	}
}


module generate_anchors(c_x, c_y, num)
{
	width = c_x / (num + 1);

	reset_y = (c_y/2);
	reset_x =  (width * (num-1))/2;

	if ( num > 0)
	{
	translate([-reset_x,reset_y,0])
	gen_anchor_span(c_x, c_y, num);
	}
}

module gen_anchor_span(c_x, c_y, num)
{
	width = c_x / (num + 1);
	
	number = num -1;
	for ( x = [0 : number ])
	{
		translate([ width * x,0,0])
		anchors();
	}
}




module generate_harbors(c_x, c_y, num){
	
	width = c_x / (num + 1);
	//if the harbor is going to go into a thicker target modify anchor_target_width
	reset_y = (c_y/2) - anchor_target_width/2 - harbor_offset;
	reset_x =  (width * (num-1))/2;

	if(num > 0)
	{
	translate([-reset_x,reset_y,0])
	gen_harbor_span(c_x, c_y, num);
	}
}

module gen_harbor_span(c_x, c_y, num){
	
	width = c_x / (num + 1);
	number = num -1;
	for ( x = [0 : number ])
	{
		translate([ width * x,0,0])
		harbor();
	}

}

module generate_shafts(c_x, c_y, num){

width = c_x / (num + 1);

	reset_y = (c_y/2);
	reset_x =  (width * (num-1))/2;

	translate([-reset_x,reset_y,0])
	if( num > 0)
	{

	
	gen_shaft_span(c_x, c_y, num);
	}

}

module gen_shaft_span(c_x, c_y, num){
	
	width = c_x / (num + 1);
	
	number = num -1;
	for ( x = [0 : number ])
	{
		translate([ width * x,0,0])
		shaft();
	}

}



module base(){

	cube([cube_x, cube_y, 4], center = true);
}

module generate_retaining_nut(c_x, c_y, p, t){

	for ( i = [ 0 : 3 ] )
	{
		if ( t[i] == 1)
		{
		echo("POSITIVE:" ,p[i]);

		generate_pylons(c_x, c_y, p[i]);
		
		}else{
		echo("NEGATIVE", p[i]);
		}

	}

}

module fake_pylon()
{
	cube(pylon_width, center = true);
}



module anchors()
{
	y_off =  retain_screw_height/2 + anchor_target_width/2;
	translate([0,- retain_screw_height/2,0])
	union(){
	
	translate([retain_screw_od/2 + anchor_width/2, y_off, 0])
	color("Red")
	cube([anchor_width, anchor_target_width, material_z], center = true);
	
	translate([-(retain_screw_od/2 + anchor_width/2), y_off, 0])
	color("Orange")
	cube([anchor_width, anchor_target_width, material_z], center = true);
	}
}

module shaft(){

	translate([0, - (retain_screw_height - anchor_target_width)/2,0])
	union()
	{
	//nut trap
	translate([0, -((retain_screw_height - anchor_target_width )/2 - ((retain_screw_height - anchor_target_width ) * channel_bottom)), 0])
	cube([retain_nut_od, retain_nut_height, material_z], center = true);

	//main pillar
	color("Blue")
	cube([retain_screw_od, retain_screw_height - anchor_target_width, material_z], center = true);

	}
}

module pylon()
{
	union()
	{
	translate([0, - (retain_screw_height - anchor_target_width)/2,0])
	shaft();
	translate([0,- retain_screw_height/2,0])
	anchors();
	}
	
}

module harbor()
{
	color("White")
	cube([harbor_width, anchor_target_width, material_z], center = true);
}


module main()
{
	translate([0, cube_y + 5, 0])
	color("Brown")
	difference()
	{
	cube([cube_x, cube_y/1.25, anchor_target_width], center = true);
	translate([0, (cube_y/2) , 0]) 
	harbor();
	}
	
	union()
	{
	difference()
	{
	cube([cube_x,cube_y,material_z], center = true);
	translate([0,(cube_y/2),0])
	shaft();
	}

	translate([0,(cube_y/2),0])
	anchors();
	}
}





















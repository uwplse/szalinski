//vent settings
	//options are
		//left_side
		//right_side
		//top_side
		//back_side
vent								= "left_side";

//door settings
door_width					= 200;
door_height				= 150;

//handle settings
handle_height			= 30;
handle_width				= 6;

//other settings
air_vent_diamiter		=	20;
box_height					= 200;
box_width					= 300;
box_depth					= 400;
power_hole_diamiter= 7;

//screw settings
head_depth				= 2;
head_diamiter			= 6;
screw_size					= 3.5;

//corner settings
wall_thickness			= 5;
corner_size				= 30;

//hindge settings
extra_gap					= .25;
thickness					= 3;
hindge_height			= 30;
//hindge
//corner
//cut_files
//handle
render = "handle";

//if you choose cut_files you can choose what side if you want
side	=	"all";
	//options are
		//all
		//left_side
		//right_side
		//top_side
		//back_side
		//front_side
		//bottom_side

// modules
if (render == "corner"){
	corner();
} else if (render == "hindge"){
	hindge();
} else if (render == "cut_files"){
	single_side();
} else if (render == "handle"){
	handle();
}

module screws(){
	translate([wall_thickness*2,0,wall_thickness*2])  rotate([90,0,0]) cylinder(h=10, d=screw_size, center=true);
	translate([wall_thickness*5,0,wall_thickness*5])  rotate([90,0,0]) cylinder(h=10, d=screw_size, center=true);
	translate([wall_thickness*2,0,wall_thickness*2])  rotate([90,0,0]) cylinder(h=head_depth*2, d=head_diamiter, center=true);
	translate([wall_thickness*5,0,wall_thickness*5])  rotate([90,0,0]) cylinder(h=head_depth*2, d=head_diamiter, center=true);
}
module corner(){
	difference(){
		cube([wall_thickness*6,wall_thickness*6,wall_thickness*6]);
		translate([wall_thickness,wall_thickness,wall_thickness]) cube([100,100,100]);
		screws();
		rotate([0,0,90]) screws();
		#rotate([90,0,90]) screws(head_diamiter=3);
	}
}

module handle(){
	difference(){
		union(){
			cube([handle_height,handle_width,6], center=true);
			translate([handle_height/2-screw_size,0,-3]) cylinder(r=screw_size, h=20);
			translate([-handle_height/2+screw_size,0,-3]) cylinder(r=screw_size, h=20);
		}
		translate([handle_height/2-screw_size,0,-3]) cylinder(d=screw_size, h=20);
		translate([-handle_height/2+screw_size,0,-3]) cylinder(d=screw_size, h=20);
	}
}

module hindge(){
	difference(){
		intersection(){
			cube([hindge_height,20,screw_size+thickness*2]);
			union(){
				rotate([0,90,0]) translate([-screw_size*1.25,screw_size*1.25,0]) cylinder(d=screw_size+thickness, h=hindge_height, $fn=50);
				translate([0,screw_size*.25,0]) cube([hindge_height,20,screw_size]);
			}
		}
		rotate([0,90,0]) translate([-screw_size*1.25,screw_size*1.25,0]) cylinder(d=screw_size, h=hindge_height);
		for ( i = [-1 : 5] ){
			translate([i*10,0,0]) cube([5+extra_gap,screw_size+thickness+1.5,50]);
			translate([i*10,0,screw_size]) rotate([-90,0,0]) screws(wall_thickness=7);
		}
	}
}

module left_side(){
	difference(){
		square([box_depth,box_height]);
		if (vent == "left_side"){
			translate([box_depth/2,box_height/2]) circle(d=air_vent_diamiter);
		}
	}
}

module right_side(){
	difference(){
		square([box_depth,box_height]);
		if (vent == "right_side"){
			translate([box_depth/2,box_height/2]) circle(d=air_vent_diamiter);
		}
	}
}

module back_side(){
	difference(){
		square([box_width,box_height]);
		if (vent == "back_side"){
			translate([box_width/2,box_height/2]) circle(d=air_vent_diamiter);
		}
		translate([power_hole_diamiter*2,power_hole_diamiter*2]) circle(d=power_hole_diamiter);
	}
}

module bottom_side(){
	square([box_width,box_depth]);
}

module top_side(){
	difference(){
		square([box_width,box_depth]);
		if (vent == "top_side"){
			translate([box_width/2,box_depth/2]) circle(d=air_vent_diamiter);
		}
	}
}

module front_side(){
	difference(){
		square([box_width,box_height], center=true);
		square([door_width,door_height], center=true);
	}
	translate([door_width/2-5,handle_height/2]) circle(d=screw_size);
	translate([door_width/2-5,-handle_height/2]) circle(d=screw_size);
}

module single_side(){
	if (side == "left_side"){
		left_side();
	} else if (side == "right_side"){
		right_side();
	} else if (side == "top_side"){
		top_side();
	} else if (side == "bottom_side"){
		bottom_side();
	} else if (side == "front_side"){
		front_side();
	} else if (side == "back_side"){
		back_side();
	} else{
		sides();
	}
}

module sides(){
	translate([-box_depth-1,0]) left_side();
	translate([1,0]) right_side();
	translate([1,box_height+1]) top_side();
	translate([-box_width-1,-box_depth-1]) bottom_side();
	translate([box_width/2+1,-box_height/2-1]) front_side();
	translate([-box_width-1,box_height+1]) back_side();
}
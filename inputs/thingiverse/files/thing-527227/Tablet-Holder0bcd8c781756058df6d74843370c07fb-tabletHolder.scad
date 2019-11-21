holder_width = 100; // [1:500]

holder_height = 300; // [1:500]

holder_depth = 50; // [1:200]

tablet_thickness = 15; // [1:40]

frame_height = 15; // [0:40]

//tablet_width = 205; // [0:500]


difference(){

	cube([holder_width,holder_height,holder_depth],center = true);
	translate([0, holder_height/3, (holder_depth/2)-frame_height+1])
	linear_extrude(height=frame_height)
	square([holder_width+10,tablet_thickness],center=true);
	
	translate([0,-holder_height/10,holder_depth/5])
	cube([holder_width-5,holder_height*3/4,holder_depth],center = true);
	//translate([(holder_height/8), -(tablet_width/5), (holder_depth/2)-frame_height+1])
	//linear_extrude(height=frame_height)
	//rotate(90) square([tablet_width+10,tablet_thickness],center=true);

	//translate([holder_width/2-3, -(tablet_width/5), 20])
	//	cube([8,tablet_width,frame_height],center = true);
}
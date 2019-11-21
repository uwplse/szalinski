//This is the height from the center of the large ball to the cente of the small ball, not the overall height of the object.
//Height of the shaft, not the full object
height=30; //[10:50]

//This is the reidus of the inner pipe (The amount of space you have to run cables.
//Inner Pipe radius
inner_pipe_radius=4;//[2:10] 

//This is the outer raidus of the small joint and the inner raidus of the outter joint.
//Outer joint size of the small ball joint and inner joint size of the large ball joint.
large_joint_inner_radius=8;//[4:12]

// How thick are the walls.
// Thickness of the walls
thickness=2;//[1:5]

difference(){
	union(){
		//The large ball joint, outter
		sphere(large_joint_inner_radius+thickness);

		//The outter shaft
		cylinder(h=height,r=inner_pipe_radius+thickness);

		//The small ball joint, outter
		translate([0,0,height]) sphere(large_joint_inner_radius);
	}

	//This cuts the inner pipe.  The place for the cables
	cylinder(h=height,r=inner_pipe_radius);
	
	//This cuts the inner part of the large ball joint
	sphere(large_joint_inner_radius);

	//This cuts the inner part of the small ball joint
	translate([0,0,height]) sphere(large_joint_inner_radius-thickness);

	//This cuts the bottom of the large outter joint
	translate([-large_joint_inner_radius-thickness,-large_joint_inner_radius-thickness,-large_joint_inner_radius-thickness]) cube([(large_joint_inner_radius+thickness)*2,(large_joint_inner_radius+thickness)*2,(large_joint_inner_radius+thickness)*.7]);

	//This cuts the top of the small inner joint.  Needed a little more than calculated.  Needed to be a little more then calculated.
	translate([-large_joint_inner_radius,-large_joint_inner_radius,height+((large_joint_inner_radius+thickness)*.3)]) cube([large_joint_inner_radius*2,large_joint_inner_radius*2,(large_joint_inner_radius*2)]);
	
	//This is the slot
	translate([-inner_pipe_radius+(thickness/2),-large_joint_inner_radius-thickness,-large_joint_inner_radius-thickness]) cube([(inner_pipe_radius*2)-thickness,large_joint_inner_radius+thickness,height+((large_joint_inner_radius+thickness)*2)]) cube([((large_joint_inner_radius+thickness)*.7)+(large_joint_inner_radius*.7)]);
}
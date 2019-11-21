// These settings worked with my printer for a Koni Yellow adjustable shock.
// Your results may vary - adjust if necessary (scaling the model could work too).

/* [Tool Head] */

// The X in mm of the shock adjustor head
shock_adjuster_x = 6; 
// Y in mm of the shock adjustor head
shock_adjuster_y = 3.5;
// depth for the tool head.
shock_adjuster_height = 4;

// You probably don't need to change these but they're around for you anyway.

/* [Advanced Dimensions] */

// The radius of the outer "gripper" component
grip_radius = 25;
// The thickness of the "gripper" piece.
gripper_thickness = 2; // Less than 2mm seems pretty weak in ABS.
// The height of the gripper piece.
gripper_height = 10; // Less than 1cm is hard to grip
// The center cylinder which supports the narrow tool head
center_reinforcement_radius = 8;
// The length which the tool head extends beyond the gripper
tool_head_height = 10;
// The radius of the actual tool head
tool_head_radius = 6; 

/* [Rounded Corners] */

// Prevents "dangling" edges from the cylinder by making the rounded edge a bit bigger.
pad = .1; // Too low and you'll get non-manifold parts. Too high and you'll get gaps.

// Radius of the rounded edge.
round_radius = 4;
// How smooth to make the rounded edge
round_smooth = 32;	// Higher = smoother but big STL.

//Gripper
difference(){
	union(){
		// Hand-holder cylinder
		cylinder(r=grip_radius,h=gripper_height);
	}
	translate([0,0,0]){
		translate([0,0,gripper_thickness])
			cylinder(r=grip_radius - gripper_thickness / 2, h=gripper_height);
	}
// Bottom Round
	difference() {
		rotate_extrude(convexity=10,  $fn = round_smooth)
			translate([grip_radius-round_radius+pad,-pad,0])
				square(round_radius+pad,round_radius+pad);
		rotate_extrude(convexity=10,  $fn = round_smooth)
			translate([grip_radius-round_radius,round_radius,0])
				circle(r=round_radius,$fn=round_smooth);
	}
}
// Adjustment head
difference(){
	union(){
		// center cylinder taper (support)
		cylinder(r=center_reinforcement_radius, h=10);
    //center cylinder
		cylinder(r=tool_head_radius, h=gripper_height+tool_head_height);
	}
	// Cut-out for shock adjustor
	translate([0,0,gripper_height+tool_head_height])
		cube(size=[shock_adjuster_x,shock_adjuster_y,shock_adjuster_height*2], center=true);
}
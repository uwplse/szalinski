// hook for angle rack
// ver.140615 by junnno

// the width of the back plate
base_width = 20;
// the height of the back plate
base_height = 30;
// the thickness of the back plate
base_thickness = 2;

// the thickness of the groove hooking on angle body
hook_groove_gap = 2;
// the depth of the groove hooking on angle body
hook_groove_depth = 4;
// the theckness of the part connecting the hook root and the arm
hook_transition_length = 2;
// the height of the root block to restrict rotation
hook_block_height = 4;

// the diameter of the arm
arm_diameter = 7;
// the length of the arm from the edge of the groove to the most tip
arm_length = 18;
// the height of the bump at the arm tip
arm_tip_height = 3;
// the length of the bump at the arm tip
arm_tip_length = 2;

// the horizontal offset of the arm root from the center of the base plate
arm_offset_horizontal = 0;
// the vertical offset of the arm root from the center of the base plate
arm_offset_vertical = 4;

$fn = 36;

module quater_cylinder(h=1,r=1,intrusion=0)
{
	intersection(){
		cylinder(h=h, r=r);
		translate([-intrusion,-intrusion,-1]) cube([r+1+intrusion,r+1+intrusion,h+2],center=false);
	}
}
//#quater_cylinder(10,10);

module hook01()
{
	// the base plate
	translate([-arm_offset_horizontal,-arm_offset_vertical,base_thickness/2])
		cube([base_width, base_height, base_thickness], center = true);

	// the hook area of the arm
	translate([0,0,base_thickness])
		cylinder(h = hook_groove_gap + hook_transition_length, r = arm_diameter/2);
	translate([0,hook_groove_depth/2,base_thickness+hook_groove_gap+hook_transition_length/2])
		cube([arm_diameter,abs(hook_groove_depth),hook_transition_length], center = true);
	
	// the hook block
	translate([0,-hook_block_height/2, base_thickness+(hook_groove_gap+hook_transition_length)/2])
		cube([arm_diameter,hook_block_height,hook_groove_gap+hook_transition_length], center = true);
	translate([-arm_diameter/2, -hook_block_height, base_thickness])
		rotate([-90,-90,-90])
			quater_cylinder(h=arm_diameter,r=hook_groove_gap+hook_transition_length,intrusion=0.1);
	
	// the body of the arm
	translate([0,hook_groove_depth,base_thickness+hook_groove_gap])
		cylinder(h = arm_length, r = arm_diameter/2);

	// the tip of the arm
	translate([0,hook_groove_depth-arm_tip_height,base_thickness+hook_groove_gap+arm_length-arm_tip_length])
		cylinder(h = arm_tip_length, r = arm_diameter/2);
	translate([0,hook_groove_depth-arm_tip_height/2,base_thickness+hook_groove_gap+arm_length-arm_tip_length/2])
		cube([arm_diameter,abs(arm_tip_height),arm_tip_length], center = true);
		
}

rotate([0,90,0])
	hook01();


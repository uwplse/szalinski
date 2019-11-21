$fn=50;

arm_diameter = 10;
arm_radius = arm_diameter/2;
split_width = 3;
body_heft = 10;
wrap_width = 50;
wrapped_diameter = 75;
wrap_side_clearance = 4;
wrapped_rear_clearance = 20;
wrapped_front_clearance = 40;
crank_length = 30;
crank_handle_length = 50;
body_height = 40;
guidebar_front_clearance = 20;

body_inner_length = wrapped_rear_clearance + wrapped_diameter + wrapped_front_clearance + arm_diameter + guidebar_front_clearance;
body_outer_width = 2*body_heft + wrap_width + wrap_side_clearance;

bracket_flange_depth = 30;
bracket_inner_width = 52;
screw_hole_diameter = 13.7;
screw_hole_radius = screw_hole_diameter/2; 

module RollerArm() {
	
	module SplitPin(split_part_length) {
			difference() {
				translate([0, arm_radius])
					union() {
						rotate([270, 0, 0])	
							cylinder(d=arm_diameter, h=split_part_length - arm_radius); // main split pin body
						
						sphere(d=arm_diameter);
					}
				
				translate([-split_width/2, -arm_radius, -arm_radius])
					cube([split_width, split_part_length + arm_diameter - 2, arm_diameter]); // minus the split
			}
	}


	split_part_length = 3*body_heft + wrap_width + wrap_side_clearance;
	
	// make the split pin part	
	SplitPin(split_part_length);	
	
	// make the crank arm piece
	hull() {
		translate([0, split_part_length, 0])
			rotate([270, 0, 0])			
				cylinder(d=arm_diameter, h=body_heft);
		
		translate([crank_length, split_part_length, 0])
			rotate([270, 0, 0])			
				cylinder(d=arm_diameter, h=body_heft);
	}
	
	// make the crank handle
	translate([crank_length, split_part_length + body_heft, 0])
		rotate([270, 0, 0])			
			cylinder(d=arm_diameter, h=crank_handle_length);
}

module RollerBody() {
	module RollerBodySide() {	
		difference() {
			cube([body_inner_length, body_heft, body_height]);
			
			translate([wrapped_rear_clearance + wrapped_diameter/2 + arm_radius, -1, body_height/2])
				rotate([270, 0, 0])
					cylinder(d=arm_diameter + 1, h=body_heft+2);
		}
	}
	
	module RollerBodyRear() {	
		cube([body_heft, body_outer_width, body_height]);
	}
	
	RollerBodyRear(); // rear
	
	translate([body_heft, 0, 0])
		RollerBodySide(); // left side
	
	translate([body_heft, body_outer_width - body_heft, 0])
		RollerBodySide(); // right side
	
	translate([body_inner_length + body_heft, 0, 0]) 
		RollerBodyRear(); // front
	
	color("blue")
	translate([body_inner_length + body_heft - guidebar_front_clearance - arm_radius, 0, body_height/2])
		rotate([270, 0, 0])
			cylinder(d=arm_diameter, h=body_outer_width); // guide bar
}

module RollerBodyWithBracket() {
	// figure out the mid line position
	bracket_outer_width = bracket_inner_width + 2*body_heft;
	mid_pos = max(body_outer_width, bracket_outer_width) / 2;
	
	difference() {
		union() {
			// bracket
			translate([0, mid_pos - bracket_outer_width/2, 0])
				union() {
					cube([bracket_flange_depth, body_heft, body_height]); // left side
					
					translate([bracket_flange_depth, 0, 0])
						cube([body_heft, bracket_outer_width, body_height]); // right
					
					translate([0, bracket_inner_width + body_heft, 0])
						cube([bracket_flange_depth, body_heft, body_height]); // right side
				}
			
			// body
			translate([bracket_flange_depth + body_heft, mid_pos - body_outer_width/2, 0])
				RollerBody();
		}	
		// mounting hole
		color("blue")
		translate([bracket_flange_depth, mid_pos, body_height/2])
			rotate([0, 90, 0])
				cylinder(d=screw_hole_diameter, h=2*body_heft);
	}
}

//translate([80, -150, 0])
//RollerArm();
//RollerBody();
RollerBodyWithBracket();
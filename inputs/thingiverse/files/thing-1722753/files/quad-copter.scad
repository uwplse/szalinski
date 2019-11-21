//full prop diamiter in mm
prop_size = 152;
screw_distance_one = 7;
screw_distance_two = 5;
screw_diamiter = 3;
motor_tilt = 10;
frame_thickness = 3;
frame_width = 50;
arm_width = 15;
slot_width = 12;
slot_spacing = 25;


difference(){
	basic_added();
	basic_taken();
}



  ////////////
 //modules//
////////////

module arm_slots(){
	for (z = [((-prop_size/slot_spacing)/2)+1 : ((prop_size/slot_spacing)/2)-1]) // two iterations, z = -1, z = 1
	{
		translate([0,z*slot_spacing,0]) hull(){
			translate([arm_width/2-3,-slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
			translate([arm_width/2-3,slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
		}
		translate([0,z*slot_spacing,0]) hull(){
			translate([-arm_width/2+3,-slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
			translate([-arm_width/2+3,slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
		}
	}
}

module body_slots(){
	rotate([0,0,90]) for (z = [((-prop_size/slot_spacing)/2)+1 : ((prop_size/slot_spacing)/2)-1]) // two iterations, z = -1, z = 1
	{
		translate([0,z*slot_spacing,0]) hull(){
			translate([frame_width/2-3,-slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
			translate([frame_width/2-3,slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
		}
		translate([0,z*slot_spacing,0]) hull(){
			translate([-frame_width/2+3,-slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
			translate([-frame_width/2+3,slot_width/2,0]) cylinder(h=frame_thickness*2, d=3 ,center=true);
		}
	}
}

module basic_added(){
	translate([prop_size/2,0,0]) arm_bar();
	translate([-prop_size/2,0,0]) arm_bar();
}
module basic_taken(){
	translate([0,0,-25]) cube([prop_size+arm_width*2,prop_size+arm_width*2,50], center=true);
	translate([-prop_size/2,-prop_size/2,0]) motor_holes();
	translate([-prop_size/2,prop_size/2,0]) motor_holes();
	translate([prop_size/2,-prop_size/2,0]) motor_holes();
	translate([prop_size/2,prop_size/2,0]) motor_holes();
	translate([prop_size/2,0,0]) arm_slots();
	translate([-prop_size/2,0,0]) arm_slots();
}
module body(){
	translate([0,0,frame_thickness/2]) cube([prop_size,frame_width,frame_thickness], center=true);
}
difference(){
	body();
	translate([prop_size/2,0,0]) arm_slots();
	translate([-prop_size/2,0,0]) arm_slots();
	body_slots();
}
module arm_bar(){
	hull(){
		translate([0,prop_size/2,-motor_tilt]) rotate([0,-motor_tilt,0]) cylinder(h=frame_thickness+motor_tilt, d=arm_width);
			translate([0,-prop_size/2,-motor_tilt]) rotate([0,-motor_tilt,0]) cylinder(h=frame_thickness+motor_tilt, d=arm_width);
	}
}

module motor_holes(){
	translate([screw_distance_one/2,0,-motor_tilt]) rotate([0,-motor_tilt,0])  cylinder(h=frame_thickness+motor_tilt+5, d=screw_diamiter , $fn=20);	
	translate([-screw_distance_one/2,0,-motor_tilt]) rotate([0,-motor_tilt,0]) cylinder(h=frame_thickness+motor_tilt+5, d=screw_diamiter , $fn=20);
	translate([0,screw_distance_two/2,-motor_tilt]) rotate([0,-motor_tilt,0]) cylinder(h=frame_thickness+motor_tilt+5, d=screw_diamiter , $fn=20);
	translate([0,-screw_distance_two/2,-motor_tilt]) rotate([0,-motor_tilt,0]) cylinder(h=frame_thickness+motor_tilt+5, d=screw_diamiter , $fn=20);
}
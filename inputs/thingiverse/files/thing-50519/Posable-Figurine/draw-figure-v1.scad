//Torso

torso_height = 7;          //[5,6,7,8,9,10]
torso_width = 4;           //[2,3,4,5,6]
torso_thickness = 2.5;     //[1,1.5,2,2.5,3,3.5]

arm_length=10;             //[1:30]

arm_r=(torso_thickness/2) *0.8; //Arm Radius
arm_upper_to_lower_ratio = 0.5;   //[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]


//ARMS

arm_forarm_to_wrist_ratio = 1.5; //[0.5,1.0,1.5,2.0,2.5] 
hand_thickness = 0.3;             //[0.1,0.2,0.3,0.4,0.5] 
hand_width = 1;                  //[0.5,1,1.5]
hand_lenth_width_ratio = 2;      //[1,1.5,2,2.5,3]

left_arm_angle_out =   30;  //[0:90] 
left_arm_angle_front = 60;  //[0:180]
left_arm_elbow_bend = 70;   //[0:140]

right_arm_angle_out = 50;   //[0:90]
right_arm_angle_front = 40; //[0:180]
right_arm_elbow_bend = 70;  //[0:140]

shoulders_h = 2*arm_r; //percentage of torso Height
shoulders_w =2*arm_r; //percentage wider than width of body

//HEAD

head_side_tilt_angle = 20;  //[-30:30]
head_angle_forward = 40;    //[-20:30]
head_radius = 2;            //[1,1.5,2,2.5,3]
neck_length = 1;            //[0.5,1,1.5,2,2.5,3,3.5,4]
neck_radius = 0.8;   	    //[0.5,0.6,0.7,0.8,0.9,1,1.1,1.2,1.3,1.4,1.5]

//LEGS

leg_length = 13;            //[1:30]
leg_u_r=torso_thickness/2;          //Upper leg radius
knee_r = torso_thickness/2 * 0.80;   //knee radius
ankle_r = knee_r * 0.75;             //Ankle radius
leg_upper_to_lower_ratio = 0.5;     //[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]

foot_length  =  3;                 //[1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6]

legs_space_between = torso_width *.9;

right_leg_angle_out = 23;    //[0:30]
right_leg_angle_front = 30;  //[0:90]
right_leg_knee_bend = 40;    //[0:140] 
right_foot_angle = 0;       //[-16:16]

left_leg_angle_out = 3;      //[0:30]
left_leg_angle_front = 30;   //[0:90]
left_leg_knee_bend = 60;     //[0:140]
left_foot_angle = 6;         //[-16:16]

rotate ([0,180,130]) {
	draw_torso();
	draw_head();
	draw_arms();
	draw_legs();
}
module draw_torso() {

	//draw body block
	cube([torso_width,torso_thickness,torso_height]);

	//draw shoulders
	//idea shoulders should stick out half their current width as a cube and then a sphere where
	//r=1/width should origin on center of end to give shoulders roundness.
	translate([-(shoulders_w),0,0])
	cube([torso_width+(shoulders_w*2),torso_thickness,shoulders_h]);
}

module draw_legs() {
	//Hips
	translate([torso_width-legs_space_between,leg_u_r,torso_height])
	color("red")
	sphere(leg_u_r);

	translate([legs_space_between,leg_u_r,torso_height])
	color("red")
	sphere(leg_u_r);

	//Right Leg	
	//Upper
	translate([torso_width-legs_space_between,leg_u_r,torso_height])
	rotate([right_leg_angle_front,-right_leg_angle_out,0])
	cylinder(leg_length*leg_upper_to_lower_ratio,leg_u_r,knee_r);

	
	//knee
	//Calculate the x,y,z of the knee
	r_y_off_out = sin(right_leg_angle_front)*leg_length*leg_upper_to_lower_ratio;
	r_z_off_out = cos(right_leg_angle_front)*leg_length*leg_upper_to_lower_ratio;
	r_x_for = sin((180 - right_leg_angle_out)/2)* sin(right_leg_angle_out/2)*r_z_off_out*2;
	r_z_for = cos((180 - right_leg_angle_out)/2)* sin(right_leg_angle_out/2)*r_z_off_out*2;	
	
	r_kn_x = torso_width-legs_space_between-r_x_for;
	r_kn_y = leg_u_r-r_y_off_out;
	r_kn_z = torso_height + r_z_off_out - r_z_for;

	translate([r_kn_x,r_kn_y,r_kn_z])
	color("red")
	sphere(torso_thickness/2);

	//Lower Leg
	translate([r_kn_x,r_kn_y,r_kn_z])
	rotate([right_leg_angle_front,-right_leg_angle_out,0]) //Match angle of upper leg
	rotate([-right_leg_knee_bend,0,0])
	cylinder(leg_length*(1-leg_upper_to_lower_ratio),knee_r,ankle_r);

	//Ankle
	//Calculate the x,y,z of the end of the ankle.
	ra_y_off_out = sin(right_leg_angle_front-right_leg_knee_bend)*leg_length*(1-leg_upper_to_lower_ratio);
	ra_z_off_out = cos(right_leg_angle_front-right_leg_knee_bend)*leg_length*(1-leg_upper_to_lower_ratio);
	ra_x_for = sin((180 - right_leg_angle_out)/2)* sin(right_leg_angle_out/2)*ra_z_off_out*2;
	ra_z_for = cos((180 - right_leg_angle_out)/2)* sin(right_leg_angle_out/2)*ra_z_off_out*2;	
	 
	r_an_x = r_kn_x - ra_x_for;
	r_an_y = r_kn_y - ra_y_off_out;
	r_an_z = r_kn_z + ra_z_off_out - ra_z_for;

	translate([r_an_x,r_an_y,r_an_z])
	color("red")
	sphere(ankle_r);

	//Foot
	translate([r_an_x-ankle_r,r_an_y-foot_length+ankle_r,r_an_z])
	rotate([-right_foot_angle,0,0])
	cube([ankle_r*2,foot_length,ankle_r*1.75]);

	//Left Leg
	
	//Upper
	translate([legs_space_between,leg_u_r,torso_height])
	rotate([left_leg_angle_front,left_leg_angle_out,0])
	cylinder(leg_length*leg_upper_to_lower_ratio,leg_u_r,knee_r);

	
	//knee
	//Calculate the x,y,z of the knee
	l_y_off_out = sin(left_leg_angle_front)*leg_length*leg_upper_to_lower_ratio;
	l_z_off_out = cos(left_leg_angle_front)*leg_length*leg_upper_to_lower_ratio;
	l_x_for = sin((180 - left_leg_angle_out)/2)* sin(left_leg_angle_out/2)*l_z_off_out*2;
	l_z_for = cos((180 - left_leg_angle_out)/2)* sin(left_leg_angle_out/2)*l_z_off_out*2;	
	
	l_kn_x = legs_space_between+l_x_for;
	l_kn_y = leg_u_r-l_y_off_out;
	l_kn_z = torso_height + l_z_off_out - l_z_for;

	translate([l_kn_x,l_kn_y,l_kn_z])
	color("red")
	sphere(torso_thickness/2);

	//Lower Leg
	translate([l_kn_x,l_kn_y,l_kn_z])
	rotate([left_leg_angle_front,-left_leg_angle_out,0]) //Match angle of upper leg
	rotate([-left_leg_knee_bend,0,0])
	cylinder(leg_length*(1-leg_upper_to_lower_ratio),knee_r,ankle_r);

	//Ankle
	//Calculate the x,y,z of the end of the ankle.
	la_y_off_out = sin(left_leg_angle_front-left_leg_knee_bend)*leg_length*(1-leg_upper_to_lower_ratio);
	la_z_off_out = cos(left_leg_angle_front-left_leg_knee_bend)*leg_length*(1-leg_upper_to_lower_ratio);
	la_x_for = sin((180 - left_leg_angle_out)/2)* sin(left_leg_angle_out/2)*la_z_off_out*2;
	la_z_for = cos((180 - left_leg_angle_out)/2)* sin(left_leg_angle_out/2)*la_z_off_out*2;	
	 
	l_an_x = l_kn_x - la_x_for;
	l_an_y = l_kn_y - la_y_off_out;
	l_an_z = l_kn_z + la_z_off_out - la_z_for;

	translate([l_an_x,l_an_y,l_an_z])
	color("red")
	sphere(ankle_r);

	//Foot
	translate([l_an_x-ankle_r,l_an_y-foot_length+ankle_r,l_an_z])
	rotate([-left_foot_angle,0,0])
	cube([ankle_r*2,foot_length,ankle_r*1.75]);

}

module draw_head() {
	//Neck
	translate([torso_width/2,torso_thickness/2,0])
	color("red")
	sphere(neck_radius);

	translate([torso_width/2,torso_thickness/2,0])
	rotate([180-head_angle_forward,head_side_tilt_angle,0])
	cylinder(neck_length,neck_radius,neck_r);
	
	//Head
	//Calculate the x,y,z of the end of the for-arm.
	h_y_off_out = sin(head_angle_forward)*neck_length;
	h_z_off_out = cos(head_angle_forward)*neck_length;
	h_x_for = sin((180-head_side_tilt_angle)/2)* sin(head_side_tilt_angle/2)*h_z_off_out*2;
	h_z_for = cos((180-head_side_tilt_angle)/2)* sin(head_side_tilt_angle/2)*h_z_off_out*2;	
	
	h_n_x = torso_width/2-h_x_for;
	h_n_y = -h_y_off_out+torso_thickness/2;
	h_n_z = -h_z_off_out+h_z_for;

	translate([h_n_x,h_n_y,h_n_z])
	color("red")
	sphere(neck_radius);

	translate([h_n_x,h_n_y,h_n_z-head_radius])
	sphere(head_radius, $fn=50);

}


module draw_arms() {

	//right arm

	//Upper Arm.
	//x,y,z
	translate([-arm_r,arm_r,arm_r])
	rotate([right_arm_angle_front,-right_arm_angle_out,0])
	cylinder(arm_length*arm_upper_to_lower_ratio,arm_r,arm_r);

	//elbow
	//Calculate the x,y,z of the end of the for-arm.
	r_y_off_out = sin(right_arm_angle_front)*arm_length*arm_upper_to_lower_ratio;
	r_z_off_out = cos(right_arm_angle_front)*arm_length*arm_upper_to_lower_ratio;
	r_x_for = sin((180 - right_arm_angle_out)/2)* sin(right_arm_angle_out/2)*r_z_off_out*2;
	r_z_for = cos((180 - right_arm_angle_out)/2)* sin(right_arm_angle_out/2)*r_z_off_out*2;	
	
	r_el_x = -arm_r-r_x_for;
	r_el_y = arm_r-r_y_off_out;
	r_el_z = arm_r+r_z_off_out-r_z_for;

	translate([r_el_x,r_el_y,r_el_z])
	color("red")
	sphere(torso_thickness/2);

	//Forarm
	translate([r_el_x,r_el_y,r_el_z])
	rotate([right_arm_angle_front,-right_arm_angle_out,0]) //Match angle of upper arm
	rotate([right_arm_elbow_bend,0,0])
	cylinder(arm_length*(1-arm_upper_to_lower_ratio),arm_r,arm_r/arm_forarm_to_wrist_ratio);

	//Wrist
	//Calculate the x,y,z of the end of the for-arm.
	rw_y_off_out = sin(right_arm_angle_front+right_arm_elbow_bend)*arm_length*(1-arm_upper_to_lower_ratio);
	rw_z_off_out = cos(right_arm_angle_front+right_arm_elbow_bend)*arm_length*(1-arm_upper_to_lower_ratio);
	rw_x_for = sin((180 - right_arm_angle_out)/2)* sin(right_arm_angle_out/2)*rw_z_off_out*2;
	rw_z_for = cos((180 - right_arm_angle_out)/2)* sin(right_arm_angle_out/2)*rw_z_off_out*2;	
	 
	r_wr_x = r_el_x - rw_x_for;
	r_wr_y = r_el_y - rw_y_off_out;
	r_wr_z = r_el_z + rw_z_off_out - rw_z_for;

	translate([r_wr_x,r_wr_y,r_wr_z])
	color("red")
	sphere(arm_r/arm_forarm_to_wrist_ratio);


	//Hand
	//the shape used for hand rotates on center not edge so we need to calculate the center of hand so it always stays
	//attached to same part of wrist.
	//Calculate the x,y,z of the end of the for-arm.
	rh_y_off_out = sin(right_arm_angle_front+right_arm_elbow_bend)*hand_lenth_width_ratio*hand_width/2;
	rh_z_off_out = cos(right_arm_angle_front+right_arm_elbow_bend)*hand_lenth_width_ratio*hand_width/2;
	rh_x_for = sin((180 - right_arm_angle_out)/2)* sin(right_arm_angle_out/2)*rh_z_off_out*2;
	rh_z_for = cos((180 - right_arm_angle_out)/2)* sin(right_arm_angle_out/2)*rh_z_off_out*2;	
	 
	r_ha_x = r_wr_x - rh_x_for;
	r_ha_y = r_wr_y - rh_y_off_out;
	r_ha_z = r_wr_z + rh_z_off_out - rh_z_for;

	translate([r_ha_x,r_ha_y,r_ha_z])
	rotate([right_arm_angle_front,-right_arm_angle_out,0]) //Match angle of upper arm
	rotate([right_arm_elbow_bend,0,0])  //apply elbow transfor to match angle of lower arm
	rotate([90,90,270])
	scale (v=[hand_lenth_width_ratio,1,1]) cylinder(h = hand_thickness, r=hand_width/2, $fn=12);

	//LEFT ARM

	//Upper Arm.
	//x,y,z
	translate([arm_r+torso_width,arm_r,arm_r])
	rotate([left_arm_angle_front,left_arm_angle_out,0])
	cylinder(arm_length*arm_upper_to_lower_ratio,arm_r,arm_r);

	//elbow
	//Calculate the x,y,z of the end of the for-arm.
	l_y_off_out = sin(left_arm_angle_front)*arm_length*arm_upper_to_lower_ratio;
	l_z_off_out = cos(left_arm_angle_front)*arm_length*arm_upper_to_lower_ratio;
	l_x_for = sin((180 - left_arm_angle_out)/2)* sin(left_arm_angle_out/2)*l_z_off_out*2;
	l_z_for = cos((180 - left_arm_angle_out)/2)* sin(left_arm_angle_out/2)*l_z_off_out*2;	
	
	l_el_x = arm_r+torso_width+l_x_for;
	l_el_y = arm_r-l_y_off_out;
	l_el_z = arm_r+l_z_off_out-l_z_for;

	translate([l_el_x,l_el_y,l_el_z])
	color("red")
	sphere(torso_thickness/2);

	//Forarm
	translate([l_el_x,l_el_y,l_el_z])
	rotate([left_arm_angle_front,left_arm_angle_out,0]) //Match angle of upper arm
	rotate([left_arm_elbow_bend,0,0])
	cylinder(arm_length*(1-arm_upper_to_lower_ratio),arm_r,arm_r/arm_forarm_to_wrist_ratio);

      //Wrist
	//Calculate the x,y,z of the end of the for-arm.
	lw_y_off_out = sin(left_arm_angle_front+left_arm_elbow_bend)*arm_length*(1-arm_upper_to_lower_ratio);
	lw_z_off_out = cos(left_arm_angle_front+left_arm_elbow_bend)*arm_length*(1-arm_upper_to_lower_ratio);
	lw_x_for = sin((180 - left_arm_angle_out)/2)* sin(left_arm_angle_out/2)*lw_z_off_out*2;
	lw_z_for = cos((180 - left_arm_angle_out)/2)* sin(left_arm_angle_out/2)*lw_z_off_out*2;	
	 
	l_wr_x = l_el_x + lw_x_for;
	l_wr_y = l_el_y - lw_y_off_out;
	l_wr_z = l_el_z + lw_z_off_out - lw_z_for;

	translate([l_wr_x,l_wr_y,l_wr_z])
	color("red")
	sphere(arm_r/arm_forarm_to_wrist_ratio);

	//Hand
	//the shape used for hand rotates on center not edge so we need to calculate the center of hand so it always stays
	//attached to same part of wrist.
	//Calculate the x,y,z of the end of the for-arm.
	lh_y_off_out = sin(left_arm_angle_front+left_arm_elbow_bend)*hand_lenth_width_ratio*hand_width/2;
	lh_z_off_out = cos(left_arm_angle_front+left_arm_elbow_bend)*hand_lenth_width_ratio*hand_width/2;
	lh_x_for = sin((180 - left_arm_angle_out)/2)* sin(left_arm_angle_out/2)*lh_z_off_out*2;
	lh_z_for = cos((180 - left_arm_angle_out)/2)* sin(left_arm_angle_out/2)*lh_z_off_out*2;	
	 
	l_ha_x = l_wr_x + lh_x_for;
	l_ha_y = l_wr_y - lh_y_off_out;
	l_ha_z = l_wr_z + lh_z_off_out - lh_z_for;

	translate([l_ha_x,l_ha_y,l_ha_z])
	rotate([left_arm_angle_front,left_arm_angle_out,0]) //Match angle of upper arm
	rotate([left_arm_elbow_bend,0,0])  //apply elbow transfor to match angle of lower arm
	rotate([90,90,90])
	scale (v=[hand_lenth_width_ratio,1,1]) cylinder(h = hand_thickness, r=hand_width/2, $fn=12);
}
// preview[view:east]

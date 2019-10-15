/* [Global] */
screw_diameter_scale = 1.1; //Global scale for screw diameter. 
tube_diameter_scale = 1.1; //Global scale for tube diameter. 

/* [Motor] */
motor_angle = 45; //Rotate motor screw holes around center.
motor_diameter = 28.0; //Motor diameter 
motor_screw_diameter = 3.0; //Diameter of motor screw holes .
motor_screwcap_diameter = 6.0; //Diameter of motor screw caps. 
motor_shaft_diameter = 8.0; //Motor shaft diameter.
motor_hole_dist_1 = 19.0; //Distance of motor holes.
motor_hole_dist_2 = 15.9; //Distance of motor holes.

/* [Tube] */
tube_diameter = 5.0; //Tube diameter
tube_offset = 2.0; //Increases the distance of the motor hole from the motor
tube_wall = 2.0; //Wall thickness around the tube hole.
tube_overlapping = 28; //Set the length of the tube hole.

/* [Servo] */
servo_diameter = 2.0; //Diameter of the hole to mount the servo arm.
servo_offset = 3.0; //Increases the distance of the hole to the motor.
servo_wall = 1.5; //Wall thickness around the hole.
servo_armlength = 30.0; //Servo arm length. This will change the width at the end where the servo mounting holes are.
servo_length = 5.0; //Length of the servo mounting hole.

// preview[view:south, tilt:top]

yaw_mount();

module motor_holes(distance, radius = 1.5) {
	rotate ([0,0,90]) translate([distance / 2,0,0]) cylinder (h = 50, r=radius, center = true, $fn=100);
	mirror([0,1,0]) rotate ([0,0,90]) translate([distance/2,0,0]) cylinder (h = 50, r=radius, center = true, $fn=100);
 }

module motor_mount(radius) {
	motor_holes(motor_hole_dist_1, radius);
	rotate ([0,0,90]) motor_holes(motor_hole_dist_2, radius);
}

module motor_plate() {
	motor_r = motor_diameter / 2.0;
	tube_r = (tube_diameter / 2.0) * tube_diameter_scale;
	servo_r =  (servo_diameter / 2.0) * tube_diameter_scale;
	tubebox_pos = [0, tube_overlapping / 2, 0];
	box_extend = [servo_armlength / 2 - servo_r - servo_wall, motor_r , 2];
	difference() {
		union(){
			hull()
			{
				rotate ([0,0,90]) translate([0,0,0]) cylinder (h = 4, r = motor_r, center = true, $fn=100);
				translate(box_extend) tube_mount(servo_r, 5, 3, servo_wall);
				mirror() translate(box_extend) tube_mount(servo_r, 5, 3, servo_wall);
			}

			translate(box_extend) tube_mount(servo_r, servo_length, servo_offset, servo_wall);
			mirror() translate(box_extend) tube_mount(servo_r, servo_length,servo_offset, servo_wall);
			translate([0, motor_r, 2]) tube_mount(tube_r, tube_overlapping, tube_offset, tube_wall);
		}

		//holes
		translate([0, motor_r, 2]) tube_mount_hole(tube_r, motor_diameter, tube_offset, tube_wall);
		translate(box_extend) tube_mount_hole(servo_r, servo_length, servo_offset);
		mirror() translate(box_extend) tube_mount_hole(servo_r, servo_length, servo_offset);
	}
}

module tube_mount(radius, length, offset=1.0, wall_t=1.0) {
	cube_z = radius + wall_t + offset;
	union() {
   		translate([-1*(radius+wall_t), -length, -cube_z]) cube([2*(radius + wall_t), length, cube_z]);
		translate([0, -length/2, -cube_z]) rotate ([90,0,0]) cylinder (h = length, r=radius + wall_t, center = true, $fn=100);
	}
}

module tube_mount_hole(radius, length, offset=1.0, wall_t=1.0) {
	cube_z = radius + wall_t + offset;
	translate([0, -length/2, -cube_z]) rotate ([90,0,0]) cylinder (h = length + 1, r=radius, center = true, $fn=100);
}

module yaw_mount() {
	
	difference() {
		difference() {
   			motor_plate();

   			// motor mounting holes
	 		rotate ([0,0, motor_angle]) motor_mount((motor_screw_diameter  / 2) * screw_diameter_scale);
	 		//bottom
	 		translate([0,0, -27]) rotate ([0,0,motor_angle]) motor_mount((motor_screwcap_diameter / 2) * screw_diameter_scale);
		}

		// shaft cutout
		rotate ([0,0,0]) translate([0,0,0]) cylinder (h = 5, r=motor_shaft_diameter / 2, center = true, $fn=100);
	}
}

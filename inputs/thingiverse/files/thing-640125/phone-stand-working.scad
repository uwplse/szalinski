/* [Basic] */
// Lay flat on bed ?
lay_flat = "yes";	//	[yes,no]

// How large is the support
width = 75; // [10:200]
// How long is the base
base_length = 80; // [10:200]
// How long is the back
back_length = 110; // [10:200]
// How long is the front
front_length = 62; // [10:100]
// How much space for the phone (leave some space)
phone_space = 16; // [5:100]

// Incline of the back
back_angle = 23;  // [0:90]

/* [Advanced] */
// How tick is the base
base_tickness = 3; // [1:10]
// How tick is the back
back_thickness = 3; // [1:10]
// How tick is the front
front_thickness = 3; // [1:10]
// How long is the retainer
retainer_length  = 8; // [1:50]
// Incline of the front
front_angle = 37;  // [0:90]

module stand() {
	//	base
	cube([width,base_length,base_tickness]);
	
	//back
	translate([0,base_length,0])
	rotate(back_angle,[1,0,0])
	cube([width,back_thickness,back_length]);
	
	//front
	real_front_angle = front_angle + back_angle;
	front_transY = base_length - sin(back_angle) * back_length;
	front_transZ = cos(back_angle) * back_length;
	translate([0,front_transY, front_transZ])
	rotate(real_front_angle + 180, [1,0,0])
	cube([width,front_length,front_thickness]);
	
	//houder
	h_transY = front_transY - cos(real_front_angle) * (front_length - front_thickness);
	h_transX = cos(back_angle) * back_length - sin(real_front_angle) * (front_length - front_thickness);
	translate([0,h_transY,h_transX]) //-7, 46?
	rotate(real_front_angle + 90,[1,0,0])
	cube([width,phone_space + front_thickness, front_thickness]);
	
	
	//stuff
	s_transY = h_transY - sin(real_front_angle) * (phone_space);
	s_transX = h_transX + cos(real_front_angle) * (phone_space);
	translate([0,s_transY,s_transX]) //-7, 46?
	rotate(real_front_angle,[1,0,0])
	cube([width, retainer_length, front_thickness]);
}
//Render
if(lay_flat == "yes") {
	rotate(270,[0,1,0]) stand();
}else {
	stand();
}
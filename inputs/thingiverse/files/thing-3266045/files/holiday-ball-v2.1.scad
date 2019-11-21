
//------------------------------
// customizable parameters
//------------------------------

// number of curves in each direction (total number of curves will be x2
number_of_curves = 6; // [2:1:30]

// ball height without the hinge
ball_height = 80; // [40:1:150]

ball_diameter = 80; // [40:1:150]

// How smooth the curves are ** bigger the number = smoother the object = VERY slow rendering (keep it 20 until decided on other parameters)
curves_smoothness = 20; // [20:10:60]

$fn=curves_smoothness; // [20:10:60]

//------------------------------
// internal parameters
//------------------------------

curves_angle = 360/number_of_curves; 
curve_slide = (ball_diameter - 6)/4;


//------------------------------
//  MAIN PROGAM
//------------------------------

// curves in one direction
translate([0,0,1])
for(zangle=[0:curves_angle:360-curves_angle])
	rotate([0,0,zangle])
	curve(1);

// curves in other direction
translate([0,0,1])
for(zangle=[0:curves_angle:360-curves_angle])
	rotate([0,0,zangle])
	curve(-1);

// hanger
translate([0,0,ball_height+0.5])
hanger();

// base of the hanger
translate([0,0,ball_height+1])
linear_extrude(height=2, scale=[0.4,0.2])
circle(d=8);

// base of the ball
translate([0,0,2])
difference() {
	resize([9,9,4])
	sphere(d=14);
	
	cylinder(d=10,h=4);
}


/*---------------------------
** MODULES
*----------------------------*/
module curve(pdirection) {
	translate([-curve_slide,0,0])
	linear_extrude(height=ball_height, twist=360*pdirection)
	translate([curve_slide,0,0])
	rotate([0,0,135])
	resize([5,8,1])
	circle(d=8);
}


module hanger() {
// ball hanger
	translate([0,0,5.5])
	rotate([90,0,0])
	difference() {
		resize([7,9,4])
		sphere(d=10);
		
		resize([3,4,5])
		cylinder(d=3,h=5, center=true);
	}
}


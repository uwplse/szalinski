// #skateforce wall mounted skateboard holder
// Neon22 - 2017 copyright 
// License: CC BY-SA 3.0
// https://www.thingiverse.com/thing:2332629

// preview[view:north west, tilt:top diagonal]

/* [Dimensions] */
Upright_width = 30;    //[20:2:50]
Upright_height = 98;   //[90:200]
Upright_thickness = 6; //[5:12]
// Overall smoothness.
Rounding = 4;          //[2:6]
// Top and bottom wall screws.
Drill_hole_size = 6;   //[3:8]
Wheel_diameter = 54;   // [35:100]
// A low angle means more security from falling but harder to hang up.
Lip_angle = 25;        //[0:5:45]

/* [Support] */
// Section supporting the wheel. (Same or smaller than your wheels.)
Wheel_support_width = 40;    //[30:2:100]
Wheel_support_thickness = 6; //[4:12]
// The vertical rib supporting the wheel.
Rib_thickness = 7;     //[4:20]
// Double for more strength.
Rib_count = "Single";         //[Single,Double]
// Angle the Rib for even stronger Doubles.
Rib_lean = "yes";    // [yes,no]
// Start with this set to 0. Decrease for smooth join at base.
Rib_angle_tweak = 0; //[-10:0.5:5]

/* [Draw] */
// Smooth will take longer to draw(<5mins). Only smooth before Export.
Draw_smooth = "no";             //[yes,no]
Draw_Single_or_Pair = "Single"; //[Single,Pair]
// Enable to visualise lifesize scale with board.
Draw_guide_wheels = "yes";      //[yes,no]
// From your Board.
Guide_wheel_width = 50;         //[30:100]
// From your Board.
Guide_wheel_separation = 129;   //[80:200]

/* [Hook] */
Add_hook = "yes";    // [yes,no]
Hook_side = "Left";  // [Left, Right]

/* [Hidden] */
countersink_depth = 2;
Delta = 0.1;
cyl_res = 40;//(Draw_smooth =="no") ? 20 : 40;
// calculated
hole_pos = Upright_height/2-Upright_width/3;
rounding_factor = (Draw_smooth=="yes")? Rounding/2 : 0;
void_diam = Wheel_diameter + 4 + rounding_factor;
support_diam = void_diam + Wheel_support_thickness*2;
rib_position = Upright_height/2-max(Wheel_diameter/4,Upright_width*2/4) ;


//--------------------------

// Rounded slab for the Uprights
module slab() {
	minkowski() {
		linear_extrude(height = Upright_thickness)
			square(size=[Upright_width-Rounding, Upright_height-Rounding], center=true);
		//
		sphere(d=Rounding, $fn=cyl_res);
	}
}

// Each upright is a nice rounded support with countersunk drill holes
module upright() {
	difference() {
		slab();
		// give it a flat back
		translate([0,0,-Upright_thickness/2])
		cube(size=[Upright_width+Rounding*2, Upright_height+Rounding*2, Upright_thickness],center=true);
		// drill two holes
		for (side=[-1:2:1]) // -1,1
			translate([0, hole_pos*side,-Delta]) {
				cylinder(h=Upright_thickness*2, d = Drill_hole_size, $fn=cyl_res);
				translate([0,0,Upright_thickness-countersink_depth/2+Rounding/2+Delta])
					cylinder(h=countersink_depth, d1 = Drill_hole_size, d2=Drill_hole_size*2.5, $fn=cyl_res);
			}
	}
}

module rib(angle, length) {
	thick = (Draw_smooth=="no") ? Rib_thickness : max(1,Rib_thickness-Rounding);
	rotate([0,0,angle])
	translate([0,length/2,0])
		cube(size=[support_diam, length, thick], center=true);
}

// Core wheel support
module core_support() {
	tuning = 5;// fiddle factors
	// calc angle of rib to miss bottom hole
	initial_angle = 90-atan((rib_position-void_diam/4)*2/support_diam);
	block_angle = initial_angle-5-tuning*(Upright_height-90)/110; // ease it in
	// echo(initial_angle,block_angle,(Upright_height-90)/110);
	block_Y = max((Upright_height+support_diam)*cos(block_angle), Upright_height);
	// support ring
	cylinder(h=Wheel_support_width-rounding_factor*2, d=support_diam, $fn=cyl_res, center=true);
	// Rib
	if (Rib_count == "Single")
		rib(block_angle-Rib_angle_tweak, block_Y);
	else {
		lean = (Rib_lean=="yes") ? 10 : 0;
		for (side=[-1:2:1]) // -1,1
			translate([0,0,Upright_width/4*side])
			translate([-void_diam/2,0,0])
			rotate([0,-lean*side,0])
			translate([void_diam/2,0,0])
				rib(block_angle-Rib_angle_tweak, block_Y);
	}
}

// wheel support
module wheel_support() {
	render(convexity=2) { // so if smoothed - will be faster for some param changes
		difference() {
				core_support();
				// inner void for wheel
				cylinder(h=Wheel_support_width+Delta*2, d=void_diam, $fn=cyl_res, center=true);
				// remove top
				translate([0,-void_diam/2,0])
					cube(size=[void_diam*4, void_diam, Wheel_support_width+Delta*2], center=true);
				// angle front
				rotate([0,0,Lip_angle])
				translate([0,-void_diam,0])
					cube(size=[void_diam*2, void_diam*2, Wheel_support_width+rounding_factor+Delta*2], center=true);
				// unused rib
				translate([-support_diam*2,support_diam*2-Delta,0])
					cube(size=[support_diam*3, support_diam*8, Rib_thickness*10], center=true);
				// hole region trim
				translate([-support_diam/2,hole_pos+rib_position+support_diam/2-Rounding/2,0])
					cube(size=[support_diam, support_diam+Rounding*3,Rib_thickness*6],center=true);
			}
		}
}

//
module mount() {
	render() {
		if (Draw_smooth == "no") 
			wheel_support();
		else {
			translate([Rounding/2,0,0])
			minkowski() {
				wheel_support();
				//
				sphere(d=Rounding, $fn=10);
			}
		}
	}
}

// hook on left or right at bottom of upright
module hook() {
	side = (Hook_side == "Left") ? 1 : -1;
	rotate([])
	translate([Upright_width/2.5*side, Upright_height/2-Rounding-Upright_thickness*0.5,Upright_thickness*0.75])
		hull() {
			sphere(d=Upright_thickness*1.5, $fn=cyl_res);
			translate([Upright_width/3*side, -Upright_width/3, Upright_width/2])
				sphere(d=Upright_thickness, $fn=cyl_res);
			translate([Upright_width/2*side, -Upright_width/2, Upright_width/2])
				sphere(d=Upright_thickness, $fn=cyl_res);
		}
}

//
module one_support() {
	lift = Rounding/2+max(Upright_thickness-Wheel_support_thickness,0);
	upright();
	if (Add_hook == "yes") {
		hook();
	}
	translate([0,-rib_position+rounding_factor,support_diam/2+lift])
	rotate([0,-90,0])
		mount();
		// core_support();
	// wheel 
	if (Draw_guide_wheels == "yes") {
		color([0.8,0.8,0])
		translate([0,-rib_position+rounding_factor, support_diam/2+lift+Rounding/2 ])
		rotate([0,90,0])
			cylinder(h=Guide_wheel_width, d=Wheel_diameter, $fn=cyl_res*2, center=true);
	}
}

// Create the Hangar
if (Draw_Single_or_Pair == "Single") {
	one_support();
} else {
	for (side=[-1:2:1]) // -1,1
		translate([(Guide_wheel_width+Guide_wheel_separation)/2*side,0,0])
			one_support();
		if (Draw_guide_wheels == "yes") {
			lift = Rounding/2+max(Upright_thickness-Wheel_support_thickness,0);
			color([0.8,0.8,0])
			translate([0,-rib_position,support_diam/2+rounding_factor+Rounding/2+lift])
			rotate([0,90,0])
				cylinder(h=Guide_wheel_separation, d=8, $fn=cyl_res*2, center=true);
		}
}

// Todo maybe:
// - 2 holes if wide
// - bridge between Uprights
// - bottom two wheels wall protector
// - with hook (top and/or bottom) for hanging bag as well (below truck core)
// - flying toaster angled ground-off emblem on bridge.
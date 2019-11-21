
/* [Basics] */

outer_diameter = 110;
inner_diameter = 70;
gap_diameter = 95;
bearing_height=12;
ball_diameter=6;

show_outer_race = "yes"; // [yes,no]
show_inner_race_a= "yes"; // [yes,no]
show_inner_race_b= "yes"; // [yes,no]
show_pins = "yes"; // [yes,no]

show_crossection="yes"; // [yes,no]

/* [Holes] */

// You may need to screw the inner races...
inner_race_screw_holes = 4;
inner_race_screw_hole_diameter = 3;
inner_race_screw_cap_depth = 3;
inner_race_screw_cap_diameter = 6;
inner_race_screw_diameter = 40;

// You could use a flange. Flange parameter is added to outer diameter.
flange=0;
flange_height=8;

outer_race_screw_holes = 4; 
outer_race_screw_hole_diameter = 3;
outer_race_screw_cap_depth = 3;
outer_race_screw_cap_diameter = 6;
outer_race_screw_diameter = 60;

/* [Advanced] */

// The difference between Inner and Outer races on Z axis. This will increase the total height of the bearing
slew_gap = 1;

// The tolerance applied on ball diameter to let them run
tolerance=0.24;

// A factor the gap between races relative to ball diameter
gap_factor=0.1;

// Resolution
fn=100;


/* [Hidden] */
flange_params=(flange)? [flange,flange_height] : 0;

function radius_to_balls(r_ball, r) = 180 / asin(r_ball / r);
function ball_to_radius(n, r) = r * sin(180 / n);

module Bearing(outer, inner, ball_radius, gap, hole, height, outer_flange=0, slew=0, pr=0.5) {
	echo(radius_to_balls(ball_radius, inner));
	n = round(radius_to_balls(ball_radius, inner));
	r = ball_to_radius(n, inner);
	theta = 360 / n;
	pinRadius = pr * r;
	
	height1 = (len(height)==2) ? height[0]:height;
	height2 = (len(height)==2) ? height[1]:height;
	

// The pins:
	if (show_pins=="yes"){
	for(i = [0 : n])
		rotate(a = [0, 0, theta * i])
			translate([inner, 0, 0])
				union() {
					color("red")
						sphere(r = r - 0.5*gap, center = true, $fn = 45);
					assign(rad = pinRadius - gap)
						color("red")
							cylinder(r1 = rad, r2 = rad, h = height, center = true, $fn = 45);
				}
	}

// The inner race:
	if (show_inner_race_a=="yes"){
		difference() {
			assign(rad = inner - pinRadius - gap)
				translate([0,0,-slew-(height1/4)])
					cylinder(r1 = rad, r2 = rad, h = height1/2, center = true, $fn = fn);
			rotate_extrude(convexity = 10,$fn=fn)
				translate([inner, 0, 0])
					circle(r = r + gap, $fn = fn);
			cylinder(r1 = hole, r2 = hole, h = height1 + 5, center = true, $fn = fn);
			
		}
	}
	if (show_inner_race_b=="yes"){
		translate([0,0,1])
		difference() {
			assign(rad = inner - pinRadius - gap)
				translate([0,0,-slew+(height1/4)])
					cylinder(r1 = rad, r2 = rad, h = height1/2, center = true, $fn = fn);
			rotate_extrude(convexity = 10,$fn=fn)
				translate([inner, 0, 0])
					circle(r = r + gap, $fn = fn);
			cylinder(r1 = hole, r2 = hole, h = height1 + 5, center = true, $fn = fn);
			
		}
	}
// The outer race:
	if (show_outer_race=="yes"){
	union(){
		difference() {
			cylinder(r1 = outer, r2 = outer, h = height2, center = true, $fn = fn);
			assign(rad = inner + pinRadius + gap)
				cylinder(r1 = rad, r2 = rad, h = height2 + 5, center = true, $fn = fn);
			rotate_extrude(convexity = 10,$fn = fn)
				translate([inner, 0, 0])
					circle(r = r + gap, $fn = fn);
		}
		
		if (len(outer_flange)==2) {
			translate([0,0,height2/2-outer_flange[1]/2])
			color("green")
				difference(){
					cylinder(r1 = outer+outer_flange[0], r2 = outer+outer_flange[0], h = outer_flange[1], center = true, $fn = fn);
//					translate([0,0,-0.5])
						cylinder(r1 = outer-((outer-inner)/2), r2 = outer-((outer-inner)/2), h = outer_flange[1]+1, center = true, $fn = fn);
				}
		}
	}
	}
}

module crown(inner,elements, height, r,center=true){
	theta = 360/elements;
	for(i = [0 : elements])
		rotate(a = [0, 0, theta * i])
			translate([inner, 0, 0])
				assign(rad = r)
					cylinder(r1 = rad, r2 = rad, h = height, center = center, $fn = 45);
				
}

difference(){
	Bearing(outer = outer_diameter/2, inner = gap_diameter/2, ball_radius = ball_diameter/2, gap = tolerance, height = bearing_height, hole = inner_diameter/2,outer_flange=flange_params,slew=slew_gap,pr=gap_factor);
	// inner holes
		crown(inner_race_screw_diameter,inner_race_screw_holes,bearing_height+slew_gap+2,inner_race_screw_hole_diameter/2);
	// inner hole caps
		translate([0,0,bearing_height/2-inner_race_screw_cap_depth])
			crown(inner_race_screw_diameter,inner_race_screw_holes,inner_race_screw_cap_depth+1,inner_race_screw_cap_diameter/2,false);
		translate([0,0,-bearing_height/2-inner_race_screw_cap_depth+1])
			crown(inner_race_screw_diameter,inner_race_screw_holes,inner_race_screw_cap_depth+1,inner_race_screw_cap_diameter/2,false);
	if (flange){
		// outer holes
			translate([0,0,bearing_height/2-flange_height-1])
				crown(outer_race_screw_diameter,outer_race_screw_holes,flange_height+2,outer_race_screw_hole_diameter/2,false);
			
			translate([0,0,bearing_height/2-outer_race_screw_cap_depth])
				crown(outer_race_screw_diameter,outer_race_screw_holes,flange_height+2,outer_race_screw_cap_diameter/2,false);
	}

	if (show_crossection=="yes")	{
		translate([0,0,-bearing_height])
			cube([outer_diameter,outer_diameter,bearing_height*2]);
	}
}

	

	



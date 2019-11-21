// customizer version of colorimeter case v1

// customizable parameters

render_part=1; // [1:Case, 2:Lid, 3:Cuvette holder, 4:Cuvette cover]

// distance from center of cuvette to detector or LED
signal_half_path = 45; // [45:60]

// This sets the number of straight signal paths; 2 paths will generate a square, 3 a hexagon, 4 an octagon...
signal_paths = 4; // [2:4]

// Width of boards sensors and sources are mounted on (mm)
board_width = 20; // [20:30]

// Thickness of boards (mm)
board_thickness = 1.8;

// Board standoff (mm)
board_standoff = 3; // [3:5]

// Cuvette diameter (mm)
cuvette_diameter = 25.4;

// 1=hemispherical bottom; 0=flat bottom
hemispherical_bottom = 1; // [0:1] 

// Overall length of the cuvette (mm)
cuvette_length = 75; // [30:100]

// Amount of cuvette in analysis area (mm)
analysis_depth = 25; // [20:55]

render();

module render() {

	if (render_part == 1)
		case();

	if (render_part == 2)
		lid();

	if (render_part == 3)
		translate([0, 0, analysis_depth+t_wall_ext*2])
			mirror([0, 0, 1])
				holder();

	if (render_part == 4)
		cover();
}

// ignore variable values

// clearances, wall thicknesses, etc.
pad_board = 3;
clear_board = 0.4;
clear_cuvette = 0.4;
t_wall_ext = 2.8; // exterior wall thickness
t_wall_int = 2.1; // interior wall thickness
r_apex_ext = 4; // radius of exterior corners
r_apex_int = 5; // radius of interior corners
overlap_lid = 3.5;
flange_holder = 5;

// segment dimensions representing exterior of case
// everything is calculated in terms of circular segments from which trapezoids are constructed
a_seg = 360/signal_paths/2; // angle of segment arc
tan_h_a_seg = tan(a_seg/2);
cos_h_a_seg = cos(a_seg/2);
sin_h_a_seg = sin(a_seg/2);
h_ext = signal_half_path+t_wall_ext+board_standoff; // height of the triangle making up the segment
r_ext = h_ext/cos_h_a_seg; // radius of the segment; distance from center to corner
t_ext = analysis_depth+t_wall_ext; // thickness of the segment

// cuvette holder dimensions -- like the case, it is based on a segment
h_holder = 25.4/2+2.8; // this is the height of triangle making up the holder, must be big enough for the largest cuvette and have allowance for wall thickness
r_holder = h_holder/cos_h_a_seg;
clear_holder = 0.5;

// radii of rounded apex centers
r_c_apex_ext = r_ext-r_apex_ext/cos_h_a_seg;
r1_c_apex_int = r_ext-(r_apex_int+t_wall_ext)/cos_h_a_seg;
r2_c_apex_int = r_holder+r_apex_int/cos_h_a_seg;

// cavities are trapezoids with rounded apexes:
b1 = r1_c_apex_int*sin_h_a_seg*2-(2*r_apex_int+t_wall_int)/cos_h_a_seg;
b2 = r2_c_apex_int*sin_h_a_seg*2-(2*r_apex_int+t_wall_int)/cos_h_a_seg;
h = (r1_c_apex_int-r2_c_apex_int)*cos_h_a_seg;

d_M3_screw = 3.5; // measured 2.9
d_M3_screw_head = 5.8; // measured 5.5
d_M3_washer = 6.9; // measured 6.7
d_M3_nut = 6.2;
h_M3_nut = 2.7; // measured 2.35
d_M3_cap = 5.5;
h_M3_cap = 3;

d_M4_screw = 4.3;
d_M4_cap = 7.4; // measured 12
h_M4_cap = 4;
d_M4_nut = 8.7;
h_M4_nut = 3.5; // measured 3.1
h_M4_locknut = 5;
d_M4_washer = 9; // measured 8.75
h_M4_washer = 0.75;

d_M6_screw = 6.5;
d_M6_nut = 11.3;
h_M6_nut = 4.2;

d_M8_screw = 8.4;
d_M8_nut = 15;
h_M8_nut = 6.35;
d_M8_washer= 16;
h_M8_washer = 1.5;

module exterior(height) {
	hull() {
		for (i=[0:signal_paths*2-1]) {
			rotate([0, 0, a_seg*i])
				translate([0, r_c_apex_ext, 0])
					cylinder(r=r_apex_ext, h=height, $fn=24);
		}
	}
}

module cavity() {
	x_retainer = board_width+2*(clear_board+pad_board);
	y_retainer = 2*board_standoff;

	translate([0, -h/2-r_apex_int, 0])
	difference() {
		union() {
			// trapezoid with rounded apexes:
			hull() {
				translate([-b1/2, -h/2, 0])
					cylinder(r=r_apex_int, h=t_ext);
		
				translate([b1/2, -h/2, 0])
					cylinder(r=r_apex_int, h=t_ext);
		
				translate([b2/2, h/2, 0])
					cylinder(r=r_apex_int, h=t_ext);
		
				translate([-b2/2, h/2, 0])
					cylinder(r=r_apex_int, h=t_ext);
			}
	
			// wire race
			translate([-b1/2+r_apex_int*sin_h_a_seg, -h/2+r_apex_int*cos_h_a_seg, t_ext-t_wall_ext])
				rotate([0, -90, -a_seg/2])
					cylinder(r=3.5, h=t_wall_int+r_apex_int+1);
		}
	
		// sensor/LED board retainers
		translate([-x_retainer/2, -h/2-r_apex_int, -1])
			difference() {
				cube([x_retainer, y_retainer, t_ext-4]);

				translate([pad_board, board_standoff, -1])
					cube([x_retainer-2*pad_board, board_thickness, t_ext-2]);

				translate([pad_board+2, 0, -1])
					cube([board_width-4, y_retainer+1, t_ext-2]);
			}

		// lip at bottom of cuvette holder
		translate([-b2*2, h/2+1, -1])
			cube([b2*4, 3, 2.5]);

	}
}

module case() {
	difference() {
		rotate([0, 0, a_seg/2])
			exterior(t_ext);
		
		for (i=[0:signal_paths*2-1]) {
			rotate([0, 0, a_seg*i])
				// cavities
				translate([0, -h_holder, t_wall_ext])
					cavity();
		}

		rotate([0, 0, a_seg/2]) {
			translate([0, 0, t_ext-16+t_wall_ext])
				holes(d_M3_screw/2, 16-t_wall_ext+1, 24);
	
			translate([0, 0, -1])
				holes((d_M3_nut+1)/2, t_ext-16+t_wall_ext-0.25+1, 6);
		}
	
		// cuvette holder
		translate([0, 0, t_wall_ext])
			rotate([0, 0, (1-signal_paths%2)*a_seg/2])
				cylinder(r=r_holder+clear_holder, h=t_ext, $fn=signal_paths*2);

		// wire entry
		translate([0, h_ext-t_wall_ext-1, t_ext])
			rotate([-90, 0, 0])
				hull() {
					translate([-b1/4, 0, 0])
						cylinder(r=overlap_lid-1, h=t_wall_ext+2);

					translate([b1/4, 0, 0])
						cylinder(r=overlap_lid-1, h=t_wall_ext+2);
				}
	}

/*
	// following to check wall thicknesses are correct
	translate([0, h_ext-t_wall_ext/2, 0])
		#cylinder(r=t_wall_ext/2, h=100, $fn=48);
	
	rotate([0, 0, a_seg/2])
	translate([0, r_holder, 0])
		#cylinder(r=t_wall_int/2, h=100, $fn=48);
*/
}

module holes(radius, height, fn) {
	for (i=[0:signal_paths*2-1]) {
		rotate([0, 0, a_seg*i])
			translate([0, -r_c_apex_ext, 0])
				cylinder(r=radius, h=height, $fn=fn);
	}
}

module holder() {
	rotate([0, 0, a_seg/2])
		difference() {
			union() {
				// body
				cylinder(r=r_holder+clear_cuvette/2, h=analysis_depth+t_wall_ext, $fn=signal_paths*2);
	
				// flange
				translate([0, 0, analysis_depth+t_wall_ext])
					cylinder(r=r_holder+flange_holder, h=t_wall_ext, $fn=signal_paths*2);
			}

			if (hemispherical_bottom == 0) {
				cylinder(r=cuvette_diameter/2+clear_cuvette/2, h=analysis_depth+2*t_wall_ext+1);
			}
			else {
				translate([0, 0, cuvette_diameter/2])
					union() {
						sphere(r=cuvette_diameter/2+clear_cuvette);

						cylinder(r=cuvette_diameter/2+clear_cuvette, h=analysis_depth+2*t_wall_ext+1);
					}
			}

			for(i=[0:signal_paths-1]) {
				rotate([0, 0, a_seg*i+a_seg/2])
				translate([-1.5, -(r_holder*2+2)/2, 1])
					cube([3, r_holder*2+2, analysis_depth-2]);
			}
		}
}

module lid() {
	overlap_case = 0.2;
	f_scale = 1+overlap_case/r_apex_ext/4;
	difference() {
		hull() {
			for (i=[0:signal_paths*2-1]) {
				rotate([0, 0, a_seg*i])
					translate([0, r_c_apex_ext, 0])
						union() {
							cylinder(r1=r_apex_ext, r2=r_apex_ext+t_wall_ext/2/cos_h_a_seg+overlap_case, h=t_wall_ext, $fn=24);
							translate([0, 0, t_wall_ext-0.1])
								cylinder(r=r_apex_ext+t_wall_ext/2/cos_h_a_seg+overlap_case, h=overlap_lid, $fn=24);
						}
			}
		}
	
		translate([0, 0, -1])
			holes(d_M3_screw/2, t_wall_ext+2);
	
		translate([0, 0, t_wall_ext])
			scale([f_scale, f_scale, 1])
				exterior(overlap_lid+1);
	
		translate([0, 0, -1])
			cylinder(r=r_holder+clear_holder, h=t_wall_ext+overlap_lid+2, $fn=signal_paths*2);

		translate([0, 0, -1])
			difference() {
				hull() {
					for (i=[0:signal_paths*2-1]) {
						rotate([0, 0, a_seg*i])
							translate([0, r_holder+flange_holder+0.5+t_wall_ext, 0])
								cylinder(r=2, h=t_wall_ext/2+1);
					}
				}
			
				translate([0, 0, -1])
					cylinder(r=r_holder+flange_holder+0.5, h=t_wall_ext*2, $fn=signal_paths*2);
			}
	}
}

module cover() {
			difference() {
				hull() {
					for (i=[0:signal_paths*2-1]) {
						rotate([0, 0, a_seg*i])
							translate([0, r_holder+flange_holder+t_wall_ext, 0])
								cylinder(r=2, h=cuvette_length-analysis_depth+6);
					}
				}
			
				translate([0, 0, t_wall_ext])
					cylinder(r=r_holder+flange_holder+1, h=cuvette_length-analysis_depth-t_wall_ext+7, $fn=signal_paths*2);
			}
}
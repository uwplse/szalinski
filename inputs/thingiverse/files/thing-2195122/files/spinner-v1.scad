//spinner v1.1

/* [Global] */

//Number of arms
num_arms = 2; //[0:10]
//Thickness of spinner (for 608 bearing set to 7)
thickness = 5; //[3:20]
//Round edges: set to 0 for flat, 1 for fully round, and anywhere inbetween for slightly rounded
rounding = 0.5; //[0:0.1:1]
//Width of the arms
spinner_mid_width = 7; //[1:50]
//Gap between spinner hubs
arm_spacing = 2; //[1:50]
//Hole diameter (for 608 bearing set to 22.5)
spinner_hole_diameter = 12; //[5:50]
//cap height
cap_height = 2; //[2:0.5:5]
//Tweak this is the spinner cap is slightly too tight or loose
clearance = 0.75; //[0:0.05:1]
//Choose view. Part 3 is only for visualisation, it won't print properly
PART = 1; //[1:Body, 2:Cap, 3:Assembly]

/* [Hidden] */

bulge = thickness/2 * rounding;
spinner_solid_diameter = spinner_hole_diameter + cap_height*2.5;
spinner_top_diameter = spinner_solid_diameter - cap_height;
arm_length = spinner_solid_diameter/2 + arm_spacing;

$fs = 1;
$fa = 5;

if (PART==0) outline();
if (PART==1) body();
if (PART==2) {
	cap(1);
	translate([spinner_top_diameter+1,0,0]) cap(2);
}
if (PART==3) {
	difference() {
		union() {
			color("red") body();
			color("grey") translate([0,0,((thickness+clearance/3)/2 + cap_height+0.05)]) rotate([180,0,0]) cap(1);
			color("white") translate([0,0,-((thickness+clearance/3)/2 + cap_height)]) cap(2);
		}
		translate([50,0,0]) cube(100,center=true);
	}
}

module cap(type, top_d=spinner_top_diameter) {
	nub_height = (thickness+clearance/3)/2;
	difference() {
		union() {
			cylinder(d=spinner_top_diameter, h=cap_height);
			cylinder(d=spinner_hole_diameter-clearance, h=nub_height + cap_height, $fs=$fs/2);
			if (type == 2) {
				translate([0,0,nub_height + cap_height - 0.01]) 
					cylinder(d=spinner_hole_diameter/2, h=nub_height-clearance, $fn=8);
			}
		}
		circleBevel(cap_height/(2), spinner_top_diameter, int=false);
		if (type == 1) {
			translate([0,0,cap_height + 0.01])
				cylinder(d=spinner_hole_diameter/2, h=nub_height + clearance/2);
			translate([0,0,nub_height + cap_height]) rotate([180,0,0])
				circleBevel(0.5, spinner_hole_diameter/2, int=true);
		}
	}
}

module body() {
	difference() {
		minkowski() {
			if (num_arms>0) {
				linear_extrude(height=0.01, center=true, convexity=20, twist=0) {
					outline();
				}
			} else {
				cylinder(r=spinner_solid_diameter/2, h=0.01, center=true);
			}
			if (bulge>0) {
				if(bulge<thickness/2) {
					bulb(r=bulge, h=thickness, 3d=true);
				} else {
					sphere(d=thickness);
				}
			} else {
				cylinder(r=0.01, h=thickness, center=true);
			}
		}
		cylinder_cutout(d=spinner_hole_diameter, h=thickness, bevel=0.6);
		if (num_arms>0)
			for (i=[0:num_arms])
				rotate(i*360/num_arms+0.1)
					translate([spinner_solid_diameter + arm_spacing*2, 0, 0])
						cylinder_cutout(d=spinner_hole_diameter, h=thickness, bevel=0.6);
	}
}

module outline() {
	for (i=[0:num_arms-1])
		rotate(i*360/num_arms)
			translate([arm_length, 0, 0])
				dogbone_polygon(r=spinner_solid_diameter/2, mid_width=spinner_mid_width, x_dist=spinner_solid_diameter/2 + arm_spacing);
}

module dogbone_polygon(r, mid_width, x_dist, full=true, center=true) {
	//$fs=1;
	center_gap = (x_dist - r) * 2;
	a = r + center_gap/2;
	cut_r = (pow(mid_width/2,2) + pow(center_gap/2,2) + 2*r*center_gap/2)/(2*(r - mid_width/2));
	b = cut_r + mid_width/2;
	theta_b = atan(a/b);
	theta_a = 90 + theta_b;
	function big_arc(x) = r * [cos(x), sin(x)] + [a, 0];
	function small_arc(y) = cut_r * [cos(y-90), sin(y-90)] + [0, b];
	big_step = $fs/(2*3.14159*r) * 360;
	small_step = $fs/(2*3.14159*cut_r) * 360;
	list_big_arc = [ for (i = [0 : big_step : theta_a]) big_arc(i) ];
	list_small_arc = [ for (i = [theta_b-small_step : -small_step : 0]) small_arc(i) ];
	whole_list = cat(list_big_arc, list_small_arc);
	quarter_shape = reverse(cat(whole_list, [[0, mid_width/2]]));
	half_shape = cat(quarter_shape, reverse(invert_y(quarter_shape)));
	full_shape = cat(half_shape, reverse(invert_x(half_shape)));
	//echo("half");
	//echo(half_shape);
	//echo("full");
	//echo(full_shape);
	if (mid_width==r*2) {
		hull() {
			mirX()
				translate([r+center_gap/2,0,0])
					circle(r);
		}
	} else {
		if (full) {
			polygon(full_shape);
		} else {
			polygon(half_shape);
		}
	}
}

module bulb(r=1, h=5, 3d=false) {
	rad = (pow(h/2,2)/r + r)/2;
	module bulb_2d() {
		intersection() {
			translate([rad - r,0,0])
				circle(r=rad);
			translate([r - rad,0,0])
				circle(r=rad);
			translate([0,-rad,0])
				square(rad*2);
		}
	}
	if (3d==false) {
		bulb_2d();
	} else {
		rotate_extrude(convexity=10) {
			bulb_2d();
		}
	}
}


function reverse(list) = [for (i = [len(list)-1:-1:0]) list[i]];
function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
function invert_x(poly) = [ for (i = [0:len(poly)-1]) [-poly[i][0], poly[i][1]]];
function invert_y(poly) = [ for (i = [0:len(poly)-1]) [poly[i][0], -poly[i][1]]];

module cylinder_cutout(d=10, h=10, bevel=0.6) {
	union() {
		cylinder(d=d, h=h+0.1, $fs=$fs/2, center=true);
		mirZ() translate([0, 0, h/2]) rotate([180,0,0]) circleBevel(bevel,d,int=true);
	}
}

module mir(plane=[1,0,0]) {
	children();
	mirror(plane)
		children();
}
module mirX() {children(); mirror([1,0,0]) children();}
module mirY() {children(); mirror([0,1,0]) children();}
module mirZ() {children(); mirror([0,0,1]) children();}

module circleBevel(h, d, int=false, overlap=0.1) {
    if (int==false) {
        difference() {
            translate([0,0,-overlap])
                cylinder(d=d+overlap*2, h=h+overlap*2);
            translate([0,0,h-d/2])
                cylinder(d1=0, d2=d+overlap*2, h=d/2+overlap*2);
        }
    }
    if (int==true) {
        translate([0,0,-overlap])
            cylinder(d1=(d-overlap*4)+(h+overlap*2)*2, d2=d-overlap*4, h=h+overlap);
    }
}

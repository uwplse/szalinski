//Spinner V2.3

/* [Global] */

//Number of arms
num_arms = 1; //[0:10]
//Thickness of spinner (for 608 bearing set to 7)
thickness = 10; //[7:20]
//Round edges: set to 0 for flat, 1 for fully round, and anywhere inbetween for slightly rounded
rounding = 0.5; //[0:0.1:1]
//Gap between spinner hubs
arm_spacing = 4; //[4:50]
//Hole diameter (for 608 bearing set to 22.5)
spinner_hole_diameter = 12; //[8:50]
//cap height
cap_height = 2.5; //[2:0.5:5]
//Tweak this if the spinner cap is slightly too tight or loose
clearance = 0.75; //[0:0.05:1]
//For asymmetric spinners, enter a manual arm angle. Leave at 0 for automatic
arm_angle = 0; //[0:5:180]
//Choose view. Part 4 is only for visualisation, it won't print properly
PART = 4; //[1:Body, 2:Cap, 3:Pin, 4:Assembly]

/* [Hidden] */

$fs = 1;
$fa = 5;
bevel = 0.6;
bulge = thickness/2 * rounding;
spinner_solid_diameter = spinner_hole_diameter + cap_height*2.5;
spinner_top_diameter = spinner_solid_diameter - cap_height;
spinner_mid_width = thickness - bulge*2;
nub_height = (thickness+clearance/2)/2;
pin_lip = arm_spacing;
pin_lip_dia = bevel*2;
pin_head_height = (spinner_solid_diameter - spinner_hole_diameter - clearance)/2;
aa = (arm_angle > 0) ? arm_angle : 360/num_arms;
arm_length = spinner_solid_diameter/2 + arm_spacing;

if (PART==0) outline();
if (PART==1) body();
if (PART==2) {
	cap(1);
	translate([spinner_top_diameter+1,0,0]) cap(2);
}
if (PART==3) pin("pin");
if (PART==4) {
	f=0.0;
	translate([-(arm_length+f),0,0]) {
		color("FireBrick") difference() {
			body(); 
			translate([0,-100,0]) cube(200,center=true);
		}
		color("grey") difference() {
			translate([0,0,nub_height + cap_height + f]) rotate([180,0,0]) cap(1); 
			translate([0,-100.01,0]) cube(200,center=true);
		}
		color("white") difference() {
			translate([0,0,-(nub_height + cap_height + f)]) cap(2); 
			translate([0,-100.02,0]) cube(200,center=true);
		}
	}
	color("DarkRed") difference() {
		translate([arm_length+f,0,0]) rotate([90,0,180]) body(); 
		translate([0,-100.03,0]) cube(200,center=true);
		}
	color("SteelBlue") rotate([0,-90,90]) pin("pin");
}


module cap(type, top_d=spinner_top_diameter, hole_d=spinner_hole_diameter-clearance, cap_h=cap_height, nub_h=nub_height, c=clearance, bevel=cap_height/2) {
	difference() {
		union() {
			cylinder(d=top_d, h=cap_h);
			cylinder(d=hole_d, h=nub_h + cap_h, $fs=$fs/2);
			if (type == 2) {
				nub_pin = (nub_h-c/2 < 2) ? nub_h-c/2 : 2;
				translate([0,0,nub_h + cap_h - 0.01]) 
					cylinder(d=hole_d/2, h=nub_pin, $fn=8);
			}
		}
		circleBevel(bevel, top_d, int=false);
		if (type == 1) {
			translate([0,0,cap_h + 0.01])
				cylinder(d=hole_d/2, h=nub_h + c/2, $fs=$fs/2);
			translate([0,0,nub_h + cap_h]) rotate([180,0,0])
				circleBevel(0.5, hole_d/2, int=true);
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
		cylinder_cutout(d=spinner_hole_diameter, h=thickness, bevel=bevel);
		if (num_arms>0)
			for (i=[0:num_arms-1])
				rotate(i*aa+0.1) {
					translate([arm_length, 0, 0])
						rotate([90,0,-90]) {
							pin("hole");
						}
					translate([spinner_solid_diameter + arm_spacing,0,0])
						cube(spinner_solid_diameter,center=true);
				}
	}
}

module outline() {
	for (i=[0:num_arms-1])
		rotate(i*aa + 180)
			translate([-spinner_solid_diameter/2 - arm_spacing, 0, 0])
				dogbone_polygon(r=spinner_solid_diameter/2, mid_width=spinner_mid_width, x_dist=arm_length, full=false);
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

module cylinder_cutout(d=10, h=10, bevel=1) {
	union() {
		cylinder(d=d, h=h+0.1, $fs=$fs/2, center=true);
		mirZ() translate([0, 0, h/2]) rotate([180,0,0]) circleBevel(bevel,d,int=true);
	}
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

module pin(type="pin", h=arm_spacing+pin_head_height, r=thickness/2-2, lh=3, lt=1, tol=0.2, flat_cut=true) {
	// type = "pin", "hole", or "pin single"
	// h = shaft height
	// r = shaft radius
	// lh = lip height
	// lt = lip thickness
	// tol = tolerance
	// flat_cut = true or false, flatten a side so it can be printed horizontally
	$fs = 0.5;
	$fa = 2;
	if(type=="hole") {
		union() {
			translate([0, 0, h-lh]) cylinder(h=lh/4, r1=r, r2=r+(lt*1));
			translate([0, 0, h-lh+lh/4]) cylinder(h=lh/4, r=r+lt);
			translate([0, 0, h-lh+lh/2]) cylinder(h=lh/2, r1=r+lt, r2=r);
			cylinder(h=h, r=r);
			translate([0, 0, -0.1]) 
				cylinder(h=lh/3, r2=r, r1=r+lt/1.5);
		}
	}
	if(type=="pin") {
		mirY() rotate([90, 0, 0]) pin_single();
	}
	if(type=="pin single") {
		pin_single();
	}
	module pin_single() {
		r = r - tol;
		h = h - tol;
		cl = r*2.1;
		cz = h - (r*2) + r/4;
		difference() {
			union() {
				scale(v=[1,r/(r+lt)*1.05,1]) {
					translate([0, 0, h-lh]) cylinder(h=lh/4, r1=r, r2=r+lt*2/3);
					translate([0, 0, h-lh+lh/4]) cylinder(h=lh/4, r=r+lt*2/3);
					translate([0, 0, h-lh+lh/2]) cylinder(h=lh/2, r1=r+lt*2/3, r2=r-lt/2);
				}
				cylinder(h=h-(lh/2), r=r);
			}
			// center cut
			translate([-r*0.5/2, -(r*2+lt*2)/2, cz]) cube([r*0.5, r*2+lt*2, cl]);
			translate([0, 0, cz+r/4]) 
				scale(v=[1,r/(r+lt)*1.05,1]){
					sphere(r=r/2);
					cylinder(h=cl-r/4, r1=r*1/2, r2=r);
				}
			translate([0, 0, cz]) rotate([90, 0, 0]) cylinder(h=cl, r=r/4, center=true);
			// side cuts
			if(flat_cut) translate([-r*2, -lt-r*1.125, -0.1]) cube([r*4, lt*2, h+0.2]);
		}
	}

	module pin_shape(h, r, lh, lt) {
		union() {
			translate([0, 0, h-lh]) cylinder(h=lh/4, r1=r, r2=r+(lt*1));
			translate([0, 0, h-lh+lh/4]) cylinder(h=lh/4, r=r+lt);
			translate([0, 0, h-lh+lh/2]) cylinder(h=lh/2, r1=r+lt, r2=r);
		}
	}
}



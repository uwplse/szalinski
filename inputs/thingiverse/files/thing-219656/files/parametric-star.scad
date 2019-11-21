// preview[view:south, tilt:top]

/* [Starfish Parameters] */

// Select which part of the starfish would like to render.
part=1; //[1:All, 2:Plate, 3:Center, 4:Seg1, 5:Seg2, 6:Seg3, 7:Seg4, 8:Seg5]

// How many legs should the starfish have?
legs = 5; // [3:12]

// How many segments should each leg have?
segments = 4; // [0:5]

// How long should the leg segment be (mm)?
length = 16; // [13:23]

// How large should the gap be between segments (mm)?
gap = 0.1;

/* [Hidden] */

slope = -99;
radius = 10;
shell = 0.8;
scale = 0.7;
r_ratio = 0.45;
s_angle = 10;
$fn=48;

// IMPORTANT!!! - Comment out starfish before running make

starfish(part);

// -------------- BUILD TARGETS FOR MAKEFILE

module star_segment_1() { // MAKE_TARGET
	segment(radius - shell, shell, length, segments - 1);
}

module star_segment_2() { // MAKE_TARGET
	segment(radius - (shell * 2), shell, length, segments - 2);
}

module star_segment_3() { // MAKE_TARGET
	segment(radius - (shell * 3), shell, length, segments - 3);
}

module star_segment_4() { // MAKE_TARGET
	segment(radius - (shell * 4), shell, length, segments - 4);
}

module star_segment_5() { // MAKE_TARGET
	segment(radius - (shell * 5), shell, length, segments - 5);
}

module star_center() { // MAKE_TARGET
	all(legs, 0);
}

module star_plate() { // MAKE_TARGET
	x_offset = radius * 2 + 5;
	y_offset = radius + length + 5;
	rotate([0,0,90])
	translate([-x_offset * (legs-1) / 2, -y_offset * segments / 2, 0])
	for(leg = [0: legs - 1])
	for(seg = [0: segments - 1]) {
		translate([x_offset * leg, y_offset * seg, 0])
		segment(radius - (shell * seg), shell, length, segments - seg);
	}
	// cube([280,150,1], center=true);
}

// -------------- STARFISH

module starfish(part) {
	if(part == 1) {
		all(legs, 1);
	}
	else if (part == 2) {
		star_plate();
	}
	else if (part == 3) {
		star_center();
	}
	else if (part == 4) {
		star_segment_1();
	}
	else if (part == 5) {
		star_segment_2();
	}
	else if (part == 6) {
		star_segment_3();
	}
	else if (part == 7) {
		star_segment_4();
	}
	else if (part == 8) {
		star_segment_5();
	}	
}

module horn(r, n) {
	o = n * 0.3;
	translate([0,0,r + o]) sphere(r * 0.35);
	translate([0,0,(r/2) + o]) cylinder(r / 2, r * 0.55, r * 0.35);
}

module trim(r, d, l) {
	// socket hole
	sphere(r - d + gap);
	// socket back
	translate([-r * 3/2,-r -r/2, -r]) cube([r * 3, r, r * 2]);
	// ball edges
	translate([0,-r/2,0]) cube([r*1.1, r, r*2], center=true);
	// top
	translate([-r,-r,r*scale]) cube([r*2, r*2+l, r]);
	// bottom
	translate([-r,-r,-r-r*scale]) cube([r*2, r*2+l, r]);
}

module ball(r, r2, d, l) {
	rotate([slope, 0, 0]) cylinder(l, r, r2);
	translate([0,l,-d*scale]) sphere(r-(d*2));
}

module tip(r, r2, d, l) {
	rotate([slope+1, 0, 0]) cylinder(l, r, r2);
	translate([0,l,-r*0.25]) sphere((r-(d*2)) * 3/4);
}

module segment(r, d, l, n) {
	r2 = (r-(d*2)) * r_ratio;
	if(n >= 0) {
		translate([0,0,r*scale]) {
			if(n) translate([0,l,0]) horn(r - d, n - 1);
			difference() {
				union() {
					sphere(r+d);
					if(n) {
						ball(r, r2, d, l);
					}
					else {
						tip(r, r2, d, l);
					}
				}
				trim(r, d, l);
			}
		}
	}
	else {
		rotate([0,0,45]) cube([10,30,10], center=true);
		rotate([0,0,-45]) cube([10,30,10], center=true);
	}
}

module segment5(r, d, l, n) {
	r2 = (r-(d*2)) * r_ratio;
	translate([0,0,r*scale]) {
		horn(r, n);
		difference() {
			union() {
				sphere(r+d);
				tip(r, r2, d, l);
			}
			trim(r, d, l);
		}
	}
}

module segment4(r, d, l, n, a) {
	r2 = (r-(d*2)) * r_ratio;
	if(n) translate([0, l, 0]) rotate([0,0,a]) segment5(r - d, d, l, n - 1);
	translate([0,0,r*scale]) {
		horn(r, n);
		difference() {
			union() {
				sphere(r+d);
				if(n) {
					ball(r, r2, d, l);
				}
				else {
					tip(r, r2, d, l);
				}
			}
			trim(r, d, l);
		}
	}
}

module segment3(r, d, l, n, a) {
	r2 = (r-(d*2)) * r_ratio;
	if(n) translate([0, l, 0]) rotate([0,0,a]) segment4(r - d, d, l, n - 1, a, 1);
	translate([0,0,r*scale]) {
		horn(r, n);
		difference() {
			union() {
				sphere(r+d);
				if(n) {
					ball(r, r2, d, l);
				}
				else {
					tip(r, r2, d, l);
				}
			}
			trim(r, d, l);
		}
	}
}

module segment2(r, d, l, n, a) {
	r2 = (r-(d*2)) * r_ratio;
	if(n) translate([0, l, 0]) rotate([0,0,a]) segment3(r - d, d, l, n - 1, a, 1);
	translate([0,0,r*scale]) {
		horn(r, n);
		difference() {
			union() {
				sphere(r+d);
				if(n) {
					ball(r, r2, d, l);
				}
				else {
					tip(r, r2, d, l);
				}
			}
			trim(r, d, l);
		}
	}
}

module segment1(r, d, l, n, a) {
	r2 = (r-(d*2)) * r_ratio;
	if(n) translate([0, l, 0]) rotate([0,0,a]) segment2(r - d, d, l, n - 1, a, 1);
	translate([0,0,r*scale]) {
		horn(r, n);
		difference() {
			union() {
				sphere(r+d);
				if(n) {
					ball(r, r2, d, l);
				}
				else {
					tip(r, r2, d, l);
				}
			}
			trim(r, d, l);
		}
	}
}

module segment0(r, d, l, n, a, s) {
	r2 = (r-(d*2)) * r_ratio;
	if(n && s) translate([0, l, 0]) rotate([0,0,a]) segment1(r - d, d, l, n - 1, a);
	translate([0,0,r*scale]) {
		horn(r, n);
		if(n && s==0) translate([0,l,0]) horn(r - d, (n - 1) * 0.4);
		difference() {
			union() {
				rotate([slope, 0, 0]) cylinder(l * 2, r * 1.4, r2, center=true);
				if(n) {
					translate([0,l,-d*scale]) sphere(r-(d*2));
				}
				else {
					translate([0,l,-r*0.25]) sphere((r-(d*2)) * 3/4);
				}
			}
			translate([-r*2,-r-l,r*scale]) cube([r*4, (r+l)*2, r]);
			translate([-r*2,-r-l,-r-r*scale]) cube([r*4, (r+l)*2, r]);
		}
	}
}

module all(n, s) {
	a = 360 / n;
	r = n  * length / 6.7;
	r2 = n * length / 4.5;
	o = (radius * scale) + (segments * 0.4);
	rotate([0,0,a/2]) {
		translate([0, r2, 0])
			segment0(radius, shell, length, segments, s_angle, s);
		for(i = [1: n - 2]) {
			rotate([0, 0, i * a])
			translate([0, r2, 0])
				segment0(radius, shell, length, segments, i > 1 && i < n - 2 ? (i < n /2 ? -s_angle : s_angle) : 0, s);
		}
		rotate([0, 0, (n - 1) * a])
		translate([0, r2, 0])
			segment0(radius, shell, length, segments, -s_angle, s);
	}
	cylinder(radius*2*scale, r, r, s);
	if(legs > 4) {
		translate([0,0,radius + o]) sphere(radius * 0.35);
		translate([0,0,(radius/2) + o]) cylinder(radius / 2, radius * 0.55, radius * 0.35);
		if(legs > 7) {
			for(i = [0: n - 1]) {
				rotate([0, 0, i * a])
				translate([0, r*0.9, 0])
				union() {
					translate([0,0,radius + o]) sphere(radius * 0.3);
					translate([0,0,(radius/2) + o]) cylinder(radius / 2, radius * 0.5, radius * 0.3);
				}
			}
		}
	}
}

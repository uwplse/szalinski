// Customisable GT2 Gear / Pulley
// v1, 06/4/2019
// by inks007
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (CC BY-NC-SA 4.0)

// GT2 teeth
teeth = 39;
// GT2 teeth detail %
detail = 100; // [10:1:100]
// Belt width
belt_wd = 6;
// Shaft/bearing diameter
shaft_d = 5;
// Gear lip (first 1.5mm is chamfered towards belt)
lip = 2;
// Nut type
nut = "square"; // ["square","hex","none"]
// Offset screws - needed if not using grub screws; mandatory if nuts cannot fit in gear body
mount_offset = false;
/* [Hidden] */
shaft_r = shaft_d/2;
gear_pc = teeth*2; // Pitch circumference
gear_pd = gear_pc/PI; // Pitch diameter
gear_pr = gear_pd/2; // Pitch radius
gear_or = gear_pr-0.376; // Outer radius
gear_od = gear_or*2; // Outer diameter
gear_oc = gear_od*PI; // Outer circumference
gear_ir = gear_or-0.75; // Inner radius
gear_id = gear_ir*2; // Inner diameter
belt_hwd = belt_wd/2;
offset = mount_offset || shaft_r+(nut == "none" ? 1 : 5.25) > gear_ir;
lip_chamfer = min(lip,1.5);
lip_flat = max(lip-1.5,0);
df = detail/100;
phi = 360/teeth;
layer_ht = 0.1;

//half_profile_gt2(true);
//profile_gt2_involuted();
gear();

module profile_gt2_involuted() {
	mirror_duplicate([1,0,0]) {
		half_profile_gt2(true);
		involute(gear_pr,30*sqrt(df)) half_profile_gt2();
	}
}

module involute(radius,steps) {
	circumference = PI*radius*2;
	arc_inv = 113.6*pow(teeth,-sqrt(2)/2);
	for (a=[arc_inv:-arc_inv/steps:0.001]) {
		c = [radius*sin(a),-radius+radius*cos(a)];
		os = [a/360*circumference,0];
//		color([(a==arc_inv?1:0),0,0.5]) translate(c) rotate(-a) translate(-os) children();
		translate(c) rotate(-a) translate(-os) children();
	}
}

module half_profile_gt2(fillet=false) {
	translate([0,-0.571]) circle(r=0.555,$fn=1080*df);
	intersection() {
		translate([0.4,-0.376]) circle(r=1.0,$fn=1080*df);
		rotate(180) square(0.8127);
	}
	if (fillet) {
		fillet_r = -0.9283/teeth+0.1493;
		theta = asin(0.15/1.15);
		point_c = [0.4-(1+fillet_r)*cos(theta),-0.376-(1+fillet_r)*sin(theta)];
		gamma = asin(-point_c.x/(gear_or-fillet_r));
		point_t = point_c+[-fillet_r*sin(gamma),fillet_r*cos(gamma)];
		point_s = point_c+[fillet_r*cos(theta),fillet_r*sin(theta)];
//	#translate(point_c) circle(r=0.001);
//	#translate(point_t) circle(r=0.001);
//	#translate(point_s) circle(r=0.001);
		difference() {
			polygon([[0,0],point_s,point_t,[point_t.x,0]]);
			translate(point_c) circle(r=fillet_r,$fn=360/df);
		}
	}
//	rotate(180) square([1,0.376]);
//	difference() {
//		rotate(180) square(1);
//		translate([0,-gear_pr]) circle(gear_or,$fn=1080);
//	}
}

module gear() {
	gear_mr = max(gear_ir+lip_chamfer,gear_or); // Maximum radius, with lip
	gear_wd = belt_wd+lip*2+(offset ? 6.6-lip_flat : 0);
	offset_d = 11.5+shaft_d;
	offset_mirror = gear_mr*2 < offset_d;
	difference() {
		union() {
			if (offset) mirror([0,0,(offset_mirror?1:0)]) translate([0,0,belt_hwd+lip_chamfer+3.299]) rotate(90+phi/2) cylinder(d=offset_d,h=6.6,$fn=teeth,center=true);
			linear_extrude(belt_wd+lip_chamfer*2,center=true,convexity=2) rotate(phi/2) difference() {
				circle(r=gear_or,$fn=teeth*32);
				rotate_duplicate(teeth) translate([0,gear_pr]) profile_gt2_involuted();
			}
			mirror_duplicate([0,0,1]) rotate(90) {
				if (lip_chamfer > 0) translate([0,0,-belt_hwd-lip_chamfer]) cylinder(r1=gear_ir+lip_chamfer,r2=gear_ir,h=lip_chamfer,$fn=teeth);
				if (lip_flat > 0) translate([0,0,-belt_hwd-1.5-lip_flat]) cylinder(r=gear_ir+1.5,h=lip_flat+0.001,$fn=teeth);
			}
		}
		mirror([0,0,(offset_mirror ? 1 : 0)]) {
			translate([0,0,(offset ? 3.3-lip_flat/2 : 0)]) cylinder(d=shaft_d,h=gear_wd+2,$fn=90,center=true);
			if (nut != "none") translate([0,0,offset ? belt_hwd+lip_chamfer+3.3 : 0]) {rotate_duplicate(4) {
					if (nut == "square") {
						translate([shaft_r+3,0,2]) cube([1.75,5.6,5.6+4],center=true);
					} else {
						translate([shaft_r+3,0,0]) rotate([0,90,0]) {
							cylinder(d=6.45,h=2.5,$fn=6,center=true);
							translate([-5,0,0]) cube([10,6.4*cos(30),2.5],center=true);
						}
					}
					rotate([0,90,0]) rotate(22.5) cylinder(d=3.25,h=30,$fn=8);
				}
				// Chamfer bolt holes
				if (offset) {
					rotate_duplicate(4) bolt_chamfer(1);
				} else {
					for (a=[0:1:3]) rotate(a*90) bolt_chamfer(a*teeth/4%1);
				}
			}
		}
	}
}

module bolt_chamfer(mod) {
	a = 2*gear_ir*sin(phi/2);
	if (mod == 0) {
		translate([0,gear_or,0]) rotate([45,0,0]) cube([a,3.12+layer_ht,3.12+layer_ht],center=true);
	} else if (mod == 0.25) {
		rotate(-phi/4) translate([0,gear_or,0])  rotate([45,0,0]) cube([a,3.26,3.26],center=true);
	} else if (mod == 0.5) {
		translate([0,gear_or,0]) rotate([45,0,0]) cube([3,3.18,3.18],center=true);
	} else if (mod == 0.75) {
		rotate(phi/4) translate([0,gear_or,0])  rotate([45,0,0]) cube([a,3.26,3.26],center=true);
	} else {
		translate([0,8.25,0]) rotate([45,0,0]) cube([3,2.6,2.6],center=true);
	}
}

module mirror_duplicate(axis) {
	x = axis.x ? [0,1] : [0];
	y = axis.y ? [0,1] : [0];
	z = axis.z ? [0,1] : [0];
	for (a=x) mirror([a,0,0]) for (b=y) mirror([0,b,0]) for (c=z) mirror([0,0,c]) children();
}

module rotate_duplicate(n=2,v=[0,0,1]) {
	step = 360/n;
	for (a=[0:step:359]) rotate(a=a,v=v) children();
}
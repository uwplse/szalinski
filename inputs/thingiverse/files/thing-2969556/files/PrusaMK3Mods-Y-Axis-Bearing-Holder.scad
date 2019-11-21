// Prusa MK3 Bearing Holder
// v1, 20/6/2018
// by inks007
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (CC BY-NC-SA 4.0)

// Bearing outer diameter (max = 15)
bearing_od = 15;
// Loosen bearing fit
bearing_od_loosen = 0;
// A lip would allow for bearings to be inserted from only one end
bearing_lip = true;
// Bearing length [if lip is set] (max = 25.7)
bearing_ln = 23.8;

/* [Hidden] */
inset_loosen = 0.1;
inset_wd = 16.4;
inset_wd2 = 9.8;
inset_ln = 25.9;
inset_ht = 6.2;
inset_r = 5.5/2;
shell_wd = 10.2*2+inset_wd2;
shell_ht = 18.1-inset_ht+3;
bearing_r = bearing_od/2;
bearing_ln_mod = bearing_lip ? 23.8 : inset_ln;
bearing_ln_loosen = 0.05;
bearing_os = [0,(bearing_ln_mod+bearing_ln_loosen*2-inset_ln+inset_loosen*2)/2-0.1,11.90];
screw_os = 10.1;
nut_r = 3.12;
$fn=45;

rotate([270,0,180]) bearing_holder();
//bearing_holder();

module bearing_holder() {
	difference() {
		union() {
			linear_extrude(inset_ht,convexity=2) {
				hull() duplicate(1,0,0) translate([inset_wd/2-inset_r,inset_ln/2-inset_r]) {
					intersection() {
					circle(inset_r-inset_loosen);
					translate([0,inset_r-inset_loosen,0]) rotate(-135) square(inset_r*2);
					}
				}
				hull() duplicate(1,0,0) translate([inset_wd/2-inset_r,-inset_ln/2+inset_r]) {
					intersection() {
					union() {
						circle(inset_r-inset_loosen);
						translate([-inset_r+inset_loosen,0,0]) square(inset_r*2-inset_loosen*2,center=true);
					}
						translate([-1.9,-1.9,0]) rotate(-135) square(inset_r*3,center=true);
					}
				}
				square([inset_wd2-inset_loosen*2,inset_ln-inset_loosen*2],center=true);
			}
			translate([0,0,shell_ht/2+inset_ht-2]) cube([shell_wd,inset_ln-inset_loosen*2,shell_ht-4],center=true);
			translate([0,0,bearing_os[2]]) rotate([90,0,0]) linear_extrude(inset_ln-inset_loosen*2,center=true) intersection() {
				rotate(22.5) circle(bearing_r+3.5,$fn=8);
				translate([-bearing_r-4,0,0]) square(bearing_r*2+8);
			}
		}
		subtract_bearing();
		subtract_shaft();
		subtract_screws();
		for (r=[0,180]) rotate(r) translate([-shell_wd/2,0,inset_ht+(shell_ht-4)/2]) rotate([-90,0,90]) linear_extrude(1,convexity=2,center=true) text(str(bearing_od_loosen==0?"±": bearing_od_loosen>0?"+":"",bearing_od_loosen),size=6,halign="center",valign="center");
		rotate([180,0,90]) linear_extrude(1,convexity=2,center=true) text(str(bearing_od),size=6,halign="center",valign="center");
	}
}

module subtract_shell() {
	translate([shell_wd/2-4,0,shell_ht+inset_ht+9.2-3.5]) rotate([90,0,0]) rotate(22.5) cylinder(r=10,h=inset_ln+4,$fn=8,center=true);
}

module subtract_screws() {
	duplicate(1,0,0) translate([screw_os,0,0]) {
		rotate(22.5) cylinder(r=1.6,h=shell_ht+inset_ht+1,$fn=8);
		translate([0,0,16-2.5]) rotate(30) cylinder(r=nut_r,h=8,$fn=6);
	}
}

module subtract_shaft() {
	translate(bearing_os) rotate([90,0,0]) cylinder(r=bearing_r-1,h=inset_ln+4,$fn=90,center=true);
}

module subtract_bearing() {
	translate(bearing_os) rotate([90,0,0]) cylinder(r=bearing_r+bearing_od_loosen/2,h=bearing_ln_mod+bearing_ln_loosen*2,$fn=90,center=true);
}

module duplicate(x,y,z) {
x1 = x ? [0,1] : [0];
y1 = y ? [0,1] : [0];
z1 = z ? [0,1] : [0];
	for (a=x1) mirror([a,0,0]) for (b=y1) mirror([0,b,0]) for (c=z1) mirror([0,0,c]) children();
}

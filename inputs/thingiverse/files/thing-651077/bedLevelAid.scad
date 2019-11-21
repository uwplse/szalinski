// bed diameter (mm)
d=127;
// extrusion width
ed=0.55;
// ring perimeters
rp=2;
// thickness
h=0.4;
// center diameter
cd=8;
// # of inner rings
ir=1;

$fn=150;
union() {
difference() {
	cylinder(d=d,h=h, center=true);
	cylinder(d=d-(rp*ed)*2, h=h+1, center=true);
}

for(y=[1:ir]) {
	innerRing(ir, y);
}

cylinder(d=cd,h=h,center=true);

for(x=[1:3]) {
	axis(360/3*x, x);
}
}

module innerRing(rings, ring) {
	difference() {
		cylinder(d=d/(rings+1)*ring,h=h, center=true);
		cylinder(d=d/(rings+1)*ring-(rp*ed)*2, h=h+1, center=true);
	}	
}

module axis(r, axis) {
	rotate([0,0,r])
	union(){
		translate([0,d/4,0])
		cube([ed*rp,d/2,h], center=true);

		if(axis==1) x();
		if(axis==2) y();
		if(axis==3) z();
	}
}

module x() {
	translate([0,d/2/4*3,0])
	union() {
		rotate([0,0,45])
		cube([8,ed*rp,h], center=true);
		rotate([0,0,-45])
		cube([8,ed*rp,h], center=true);
	}
}

module y() {
	translate([0,d/2/4*3,0])
	union() {
		translate([-1.5,-1,0])
		rotate([0,0,45])
		cube([4,ed*rp,h], center=true);
		translate([-1.5,1,0])
		rotate([0,0,-45])
		cube([4,ed*rp,h], center=true);
		translate([1.5,0,0])
		cube([4,ed*rp,h], center=true);
	}
}

module z() {
	translate([0,d/2/4*3,0])
	union() {
		translate([-2.7,.15,0])
		rotate([0,0,90])
		cube([4,ed*rp,h], center=true);
		translate([2.7,-.15,0])
		rotate([0,0,-90])
		cube([4,ed*rp,h], center=true);
		rotate([0,0,-35])
		cube([6,ed*rp,h], center=true);
	}
}



















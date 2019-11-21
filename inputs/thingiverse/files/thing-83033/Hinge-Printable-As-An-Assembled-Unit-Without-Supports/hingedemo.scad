// What diameter or thickness should the hinge have (in 0.01 mm units)?
hinge_dia = 635; // [1:5000]

// How much gap should be left between separate parts (in 0.01 mm units)?
hinge_gap = 40; // [1:2000]

$fn = 90;

module hingepair() {
	union() {
		cylinder(h=0.25, r=0.5);
		translate([0,0,0.25]) cylinder(h=0.25, r1=0.5, r2=0.25);
		translate([0,0,1]) cylinder(h=0.25, r1=0.25, r2=0.5);
		translate([0,0,1.25]) cylinder(h=0.25, r=0.5);
	}
}

module hingecore(gap) {
	union() {
		difference() {
			union() {
				cylinder(h=1.5, r=0.5);
				translate([-0.5,0,0.25+gap])
					cube(size=[1,1,1-gap-gap]);
				translate([0,-0.5,0.25+gap])
					cube(size=[0.5,0.5,1-gap-gap]);
			}
			translate([0,0,0.25+gap-0.5]) cylinder(h=0.75, r1=1, r2=0.25);
			translate([0,0,1-gap]) cylinder(h=0.75, r1=0.25, r2=1);
		}
		translate([-0.5,0.5+gap,0])
			cube(size=[1,0.5-gap,1.5]);
	}
}

module hingeedge(gap) {
	union() {
		hingepair();
		translate([-0.5,-1,0])
			cube(size=[1,0.5-gap,1.5]);
		translate([-0.5,-1,0])
			cube(size=[1,1,0.25]);
		translate([-0.5,-1,1.25])
			cube(size=[1,1,0.25]);
		translate([0,0,1.25])
			cube(size=[0.5,0.5,0.25]);
		translate([0,0,0])
			cube(size=[0.5,0.5,0.25]);
	}
}

module hinge(thick, realgap) {
	hingeedge(realgap / thick);
	hingecore(realgap / thick);
}

module demo(t, rg) {
	scale([t,t,t])
	translate([-2.75,0,0.5])
	rotate(a=[0,90,0])
	union() {
		hinge(t, rg);
		translate([0,0,1.25]) hinge(t, rg);
		translate([0,0,2.5]) hinge(t, rg);
		translate([0,0,3.75]) hinge(t, rg);
		translate([-0.5,1,0]) cube(size=[1,2,5.25]);
		translate([-0.5,-3,0]) cube(size=[1,2,5.25]);
	}
}

demo(hinge_dia/100, hinge_gap/100);

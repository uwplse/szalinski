// Ashtray
// TrevM 29/04/2014

/* [Global] */

// What quality?
$fn = 100;	// [20,40,60,80,100,120,140,160,180]

// Outside radius?
or = 64;	// [20:100]

// Inside radius?
ir = 60;	// [20:100]

// Height?
hi = 35;	// [10:50]

// Number of slots?
num = 8;	// [2:10]

// Base bevel height?
bh = 2;		// [2:5]

/* [Hidden] */

ang = 360/num;
thk = or-ir+2;
fr = 3.5;
fr2 = fr * 2;

// base
cylinder( r1 = ir, r2 =or, h = bh);
translate([0,0,bh-0.1])
	difference()
	{
		// outside
		cylinder(r = or, h = hi);
		// inside
		translate([0,0,-0.1])	cylinder(r = ir, h = hi+0.2);
		// fag slots
		translate([0,0,hi-7])	for (n=[1:num])
			rotate([0,0,(n-1)*ang])	slot();
	}

module slot()
	translate([ir-1,0,0])
	{
		rotate([0,90,0])	cylinder(r=3.5,h=thk);
		translate([0,-fr,0])	rotate([-8,0,0])	cube([thk,fr2,10]);
		translate([0,-fr,0])	rotate([8,0,0])	cube([thk,fr2,10]);
	}


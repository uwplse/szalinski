//12_point.scad

side=12;

translate([0,0,side/2])
rotate([0,45,0])

difference()
{
	rotate([0,45,0])
	cube([side, side*2*1.414, side], center=true);

	union()
	{
		translate([0,side/1.414,side/1.414])
		rotate([0,45,90])
		cube([side, side*2*1.414, side], center=true);
		translate([0,-side/1.414,side/1.414])
		rotate([0,45,90])
		cube([side, side*2*1.414, side], center=true);

		translate([0,-side*2*1.205,0])
		rotate([0,0,45])
		cube([side*1.414, side*2*2, side*1.414], center=true);
		translate([0,-side*2*1.205,0])
		rotate([0,0,-45])
		cube([side*1.414, side*2*2, side*1.414], center=true);

		translate([0,side*2*1.205,0])
		rotate([0,0,45])
		cube([side*1.414, side*2*2, side*1.414], center=true);
		translate([0,side*2*1.205,0])
		rotate([0,0,-45])
		cube([side*1.414, side*2*2, side*1.414], center=true);

	}
}


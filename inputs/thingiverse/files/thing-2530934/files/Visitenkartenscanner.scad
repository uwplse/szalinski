$fn=400;

// Block
difference()
{
	linear_extrude(height=95)
	square([90,20]);

	translate([2.5,2.5,2.5])
	linear_extrude(height=90)
	square([85,15]);
}

// Verbinder
translate([0,-45,0])
linear_extrude(height=2.5)
square([10,50]);

translate([0,-45,0])
rotate([0,0,90])
linear_extrude(height=2.5)
square([10,15]);

// Säule
translate([-15,-40,0])
linear_extrude(height=95)
circle(10.0);
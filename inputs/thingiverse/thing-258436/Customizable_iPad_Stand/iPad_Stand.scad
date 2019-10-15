
// preview[view:south west, tilt:top diagonal]

// Angle of iPad on stand;
Angle = 45; // [10:80]
// Angle of back support;
BackAngle = 25; // [10:80]
// Length of support
SupportLength = 120; // [50:240]
// Length of connecting bars
BarLength = 80; // [20:200]
Tolerance = 0.1; // [0, 0.1, 0.2, 0.3, 0.4, 0.5]


part = "Assembled"; // [Assembled: Assembled, Side: Side, Bar: Bar]


SubAngle = -(90-Angle);

SharedAngle = -SubAngle + BackAngle;
comp = (10/sin(SharedAngle));

truecomp = (SharedAngle > 90 ? comp : (SharedAngle == 90 ? 1 : 0));

echo(truecomp);


SubBackAngle = (90-BackAngle);

if(part=="Assembled")
{
	rotate([90, 0, 0]) Leg(Angle, BackAngle, SupportLength, Tolerance);
	
	translate([0, BarLength+10, 0])rotate([90, 0, 0]) Leg(Angle, BackAngle, SupportLength, Tolerance);
	rotate([-90, 0, 90]) translate([-10, -10, -10]) Bar(BarLength, Tolerance);
	rotate([-90, 0, 90]) translate([-10, -10, -10 - (cos(Angle)*SupportLength + sin(BackAngle)*(sin(Angle)*SupportLength)/cos(BackAngle)-10 + 10 - 10*tan(BackAngle))]) Bar(BarLength, Tolerance);
}
if(part=="Side")
{
	Leg(Angle, BackAngle, SupportLength, Tolerance);
}
if(part=="Bar")
{
	Bar(BarLength, Tolerance);
}

module Bar(BarLength, Tolerance)
{
	difference()
	{
		cube([BarLength+20, 10, 10]);
		translate([-0.5, 7 - Tolerance, -0.5]) cube([10.5+ Tolerance, 4 + Tolerance, 11]);
		translate([-0.5, -1 + Tolerance, -0.5]) cube([10.5+ Tolerance, 4, 11]);
		translate([-0.5, -0.5, 7 - Tolerance * 2]) cube([10.5+ Tolerance, 11, 4 + Tolerance * 2]);
		translate([BarLength+10 - Tolerance, 7 - Tolerance, -0.5]) cube([10.5 + Tolerance, 4 + Tolerance, 11]);
		translate([BarLength+10 - Tolerance, -1 + Tolerance, -0.5]) cube([10.5+ Tolerance, 4, 11]);
		translate([BarLength+10 - Tolerance, -0.5, 7 - Tolerance * 2]) cube([10.5+ Tolerance, 11, 4 + Tolerance * 2]);
	}
}

module Leg(Angle, BackAngle, SupportLength, Tolerance)
{
difference()
{
	union()
	{
		cube([10, 10, 10]);
		rotate([0, 0, SubAngle]) translate([-24, 0, 0]) cube([24, 10, 10]);
		rotate([0, 0, Angle]) translate([0, 14, 0]) cube([20, 10, 10]);
//		rotate([0, 0, SubAngle]) translate([-14, 10, 0]) %cube([10, 10, 10]);
		translate([10, 0, 0]) rotate([0, 0, Angle]) translate([0, 0, 0]) cube([SupportLength, 10, 10]);
		
		difference()
		{
			cube([cos(Angle)*SupportLength + sin(BackAngle)*(sin(Angle)*SupportLength)/cos(BackAngle) + 10 - 10*tan(BackAngle), 10, 10]);
//			translate([10, 0, 0]) rotate([0, 0, Angle]) translate([SupportLength, 0, 0]) rotate([0, 0, -Angle + BackAngle+90]) translate([(-sin(Angle)*SupportLength)/cos(BackAngle), -10, -0.5]) cube([(sin(Angle)*SupportLength)/cos(BackAngle), 10, 11]);
		}
		
		difference()
		{
			translate([10, 0, 0]) rotate([0, 0, Angle]) translate([SupportLength, 0, 0]) rotate([0, 0, -Angle + BackAngle+90]) translate([(-sin(Angle)*SupportLength)/cos(BackAngle), 0, 0]) cube([(sin(Angle)*SupportLength)/cos(BackAngle) + truecomp, 10, 10]);
			translate([0, -10, -0.5]) cube([cos(Angle)*SupportLength + sin(BackAngle)*(sin(Angle)*SupportLength)/cos(BackAngle) + 10*tan(SubBackAngle), 10, 11]);
		}
	}
	translate([3 + Tolerance, 3, -0.5]) cube([7, 4, 11]);
	translate([cos(Angle)*SupportLength + sin(BackAngle)*(sin(Angle)*SupportLength)/cos(BackAngle)- 7 + Tolerance + 10 - 10*tan(BackAngle), 3, -0.5]) cube([8, 4, 11]);
	translate([cos(Angle)*SupportLength + sin(BackAngle)*(sin(Angle)*SupportLength)/cos(BackAngle) + 10 - 10*tan(BackAngle), -10, -0.5]) cube([20, 20, 11]);
}
}
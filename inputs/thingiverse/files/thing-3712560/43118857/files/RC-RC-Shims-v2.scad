/* Shims for adjusting roll center (RC) or any other distance

Like Yokomo ZCR-A3614/ZCR-A3615/ZCR-A3615G (2x6x1.5)

*/

$fn=42;

translate([0, 0, 0])
difference()
{
	cylinder(d=6.0, h=0.5, center=false);
	cylinder(d=3.0, h=0.5, center=false);
}

translate([10, 0, 0])
difference()
{
	cylinder(d=6.0, h=1.0, center=false);
	cylinder(d=3.0, h=1.0, center=false);
}

translate([20, 0, 0])
difference()
{
	cylinder(d=6.0, h=1.5, center=false);
	cylinder(d=3.0, h=1.5, center=false);
}

translate([00, 10, 0])
difference()
{
	cylinder(d=6.0, h=2.0, center=false);
	cylinder(d=3.0, h=2.0, center=false);
}

translate([10, 10, 0])
difference()
{
	cylinder(d=6.0, h=3.0, center=false);
	cylinder(d=3.0, h=3.0, center=false);
}

translate([20, 10, 0])
difference()
{
	cylinder(d=6.0, h=4.0, center=false);
	cylinder(d=3.0, h=4.0, center=false);
}
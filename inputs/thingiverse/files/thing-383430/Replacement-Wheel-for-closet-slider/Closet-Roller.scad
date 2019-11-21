/* [Global] */

//Thickness of the roller
thickness = 8; //[1:100]

//Larger diameter of the wheel
large_dia=40;

//Smaller diameter of the wheel
small_dia=35;

//Mounting bolt diameter
bolt_size=8;

difference()
{
	union()
	{
		cylinder(h=thickness/2, r1=small_dia/2, r2=large_dia/2, center=false, $fn=60);
		translate([0,0,thickness/2]) cylinder(h=thickness/2, r1=large_dia/2, r2=small_dia/2, center=false, $fn=60);
	}
	union()
	{
		cylinder(h=thickness, r=bolt_size/2, $fn=20);
	}
}
	

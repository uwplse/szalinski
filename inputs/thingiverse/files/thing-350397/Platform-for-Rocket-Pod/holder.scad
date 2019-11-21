
//width of the rocket pod that needs to fit in the holder. Minimum = 20 mm
width = 27;

module holder_half(w)
{
	difference(){
	union()
	{
	difference()
	{
		translate([0,-4,-5])cube([w,5,15]);
		translate([-1,-4.5,-6])cube([8.5,7,6]);
	}

	translate([w/2+12,4, 0])rotate([90,0,0])cylinder(r=w/2+2, h=8);
	}
	translate([w/2+12,5, 0])rotate([90,0,0])cylinder(r=w/2, h=10);
	translate([8,-5,-14])rotate([0,-30,0])cube([10,10,5]);
	}
}

module holder(w)
{
	holder_half(w);
	mirror([1,0,0])holder_half(w);
}

rotate([90,0,0])holder(width);
$fn=50; //Faces

size=25; //Size of the circles
thickness=5; //Thickness of the amulet

translate([-size/2,0,0]) //Doing the circles
{
	difference()
	{
		cylinder(h=thickness,r=size, center=true); //Circle 1
		cylinder(h=thickness,r=size-3, center=true);
	}
	translate([size,0,0])
	{
		difference()
		{
			cylinder(h=thickness,r=size,center=true); //Circle 2
			cylinder(h=thickness,r=size-3,center=true);
		}
	}
}
	linear_extrude(height = thickness, center = true, convexity = 10, twist = 0) //Extruding the Diamons shape
	{
		projection(cut = true) //cutting from 3d to 2d shape
		{
			rotate([90,0,0])
			{
				cylinder(size-6,25-12,0,$fn=4); //the first PYRAMID
			}
			rotate([-90,0,0])
			{
				cylinder(size-6,25-12,0,$fn=4); //The second PYRAMID
			}
		}
	}
rotate([0,0,90])
{
	cube([2,90,thickness],center = true); //The line
}

translate([0,-size,0]) //The attachment point
{
	rotate([0,90,0])
	{
		difference()
		{
			cube([5,10,5],center=true);
			translate([0,-2,0])
				{
					cube([3.5,3.5,20],center=true);
				}
		}
	}
}
/* [Parameters] */
Axle_Radius = 2;
Mounting_Screw_Radius=1.2;

Number_of_Washers = 32;
Washer_Width = 2;

/* [Hidden] */
$fn=64;

difference()
{
    union(){
        cylinder(h=2,r=26);
		  translate([0,0,2])
	         cylinder(h=1,r=27.75);
        translate([0,0,3])
            cylinder(h=1,r1=27.75,r2=26.75);
        
    }
	for(i = [0: Number_of_Washers - 1])
	{
		rotate(i*360/Number_of_Washers)
		{
   		translate([-Washer_Width/2,21.25,-1])
			{ 
				cube([Washer_Width,7.5,6]);
			}
		}
	}
	for(i = [0:3])
	{
		rotate(i*90)
		{
			translate([0,6.25,-1])
			{
				cylinder(h=6,r=Mounting_Screw_Radius);
			}
		}
	}
	translate([0,0,-1])
	{
		cylinder(h=6,r=Axle_Radius);
	}
}
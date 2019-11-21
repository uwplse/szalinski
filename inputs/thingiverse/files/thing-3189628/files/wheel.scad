 
 rounding=4;
 diameter=50; 
 diameterIn=diameter-rounding*2;
 rimThickness=2;
 width=10;
 
 difference()
 {
	$fs=0.8;
 	$fa=0.1;
    union()
	{
        difference()
        {
            minkowski()
            {
                translate([0,0,rounding])cylinder(d=diameter-rounding, h=width-2*rounding);
                sphere(r=rounding);
            }
            translate([0,0,rimThickness])cylinder(d=diameterIn+rounding, h=100);
        }
           
		difference()
		{
            cylinder(r = 7, h = rimThickness+4.5);
            translate([0,0,3])cylinder($fn = 6, d = 8.75, h =100);
		}
    }
 
	translate([0,0,-3])cylinder(d = 4, h =100);
	union()
	{
    	for (a =[0:45:360])rotate(a=[0,0,a])translate([diameterIn*0.35,0,-3])cylinder(d = 8, h =30);
	}
 }
//it's torus time


//number of windings, keep windings low if revs is high
windings = 1; //[0:5]

//number of revolutions around the z axis
revs = 10; //[0:20]

//central radius from the z axis to the center of the helix
R = 9; //[0:20]

//radius of the helix
r = 6; //[0:10]

//size of the spheres(fattness of the tubes)
fattness = 8; //[1:30]

//tube resolution. higher resolution is a longer render
resolution = 10; //[10:20]

//direction of the winding. -1 or 1
direction = 1; //[1, -1]

for(t=[0:359*revs])
{
	hull()
	{
		translate([cos(t)*(R-r*cos(360+direction*(windings+1/revs)*t)), 
				   sin(t)*(R-r*cos(360+direction*(windings+1/revs)*t)), 
				   r*sin(360+direction*(windings+1/revs)*t)])
		{
			sphere($fn=resolution, .1*fattness, true);
		}
		translate([cos(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))), 
				   sin(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))), 
				   r*sin(360+(windings+1/revs)*direction*(t+1))])
		{
			sphere($fn=resolution, .1*fattness, true);
		}		
	}
}
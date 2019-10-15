


//number of windings around the donut
windings = 0; //[0:1]

//number of revolutions around the z axis
revs = 6; //[2:12]

//size of the spheres(fattness of the tubes)
fattness = 2; //[1:4]

//x coordinate of the inversion
x0 = .5; //[.5, 0]

//y coordinate of the inversion
y0 = .5; //[.5, 0]

//z coordinate of the inversion
z0 = .5; //[.5, 0]

//radius of the inversion
k = 4; //[3, 4]

//large radius
R = 9; //[9, 7]

//small radius
r = 6; //[6, 7]

//tube resolution
resolution = 10; //[10, 15]

//spiral direction
direction = 1; //[1, -1]

for(t=[0:360*revs])
{
	hull()
	{
		translate([x0 + k*k*(cos(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - x0)/(pow((cos(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - x0), 2)+pow((sin(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - y0), 2)+pow((r*sin(360+direction*(windings+1/revs)*t)-z0), 2)), 
				   y0 + k*k*(sin(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - y0)/(pow((cos(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - x0), 2)+pow((sin(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - y0), 2)+pow((r*sin(360+direction*(windings+1/revs)*t)-z0), 2)), 
				   z0 + k*k*(r*sin(360+direction*(windings+1/revs)*t) - z0)/(pow((cos(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - x0), 2)+pow((sin(t)*(R-r*cos(360+direction*(windings+1/revs)*t)) - y0), 2)+pow((r*sin(360+direction*(windings+1/revs)*t)-z0), 2))])
		{
			sphere($fn=resolution, .1*fattness, true);
		}
		translate([x0 + k*k*(cos(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - x0)/(pow((cos(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - x0), 2)+pow((sin(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - y0), 2)+pow((r*sin(360+direction*(windings+1/revs)*(t+1))-z0), 2)), 
				   y0 + k*k*(sin(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - y0)/(pow((cos(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - x0), 2)+pow((sin(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - y0), 2)+pow((r*sin(360+direction*(windings+1/revs)*(t+1))-z0), 2)), 
				   z0 + k*k*(r*sin(360+direction*(windings+1/revs)*(t+1)) - z0)/(pow((cos(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - x0), 2)+pow((sin(t+1)*(R-r*cos(360+direction*(windings+1/revs)*(t+1))) - y0), 2)+pow((r*sin(360+direction*(windings+1/revs)*(t+1))-z0), 2))])
		{
			sphere($fn=resolution, .1*fattness, true);
		}		
	}
}
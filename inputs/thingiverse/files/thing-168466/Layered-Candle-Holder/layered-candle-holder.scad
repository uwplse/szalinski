//Radius of each layer
radius = 3.5;
//Length of the side
length = 75;
//Number of layers
layers = 14;
//Resolution of primatives (cylinders and spheres)
resolution = 50;
//How much should each layer overlap
overlap_percent = .1; //min/max:[0.0:1.0]
overlap = 2 - overlap_percent*2;
//How big is the hole compared to the length
hole_percent = 0.9; //min/max:[0.0:1.0]

difference()
{
	union(){
		for ( i = [0 : layers - 1] )
		{
			translate([0,0,i*overlap*radius])
			{
				union()
				{
					translate([-length/2,-length/2,radius])
					{
						rotate([0,90,0],$fn=resolution)
							cylinder(h=length,r=radius);
						rotate([-90,0,0],$fn=resolution)
							cylinder(h=length,r=radius);
						sphere(r=radius,$fn=resolution);
					}
					translate([length/2,length/2,radius])
					{
						rotate([0,-90,0],$fn=resolution)
							cylinder(h=length,r=radius);
						rotate([90,0,0],$fn=resolution)
							cylinder(h=length,r=radius);
						sphere(r=radius,$fn=resolution);
					}
					translate([length/2,-length/2,radius])
						sphere(r=radius,$fn=resolution);
					translate([-length/2,length/2,radius])
						sphere(r=radius,$fn=resolution);
				}
			}
		}
		translate([0,0,((layers-1)*overlap*radius+2*radius)/2])
			cube(size=[length,length,(layers-1)*overlap*radius+2*radius], center=true);
	}
	translate([0,0,layers*2*radius/2+2*overlap*radius])
		cylinder(h=layers*2*radius, r=hole_percent*length/2, $fn=resolution, center=true);
}
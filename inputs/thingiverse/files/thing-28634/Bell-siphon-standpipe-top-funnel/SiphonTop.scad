/*
This part is to make a tapered funnel top for a bell siphon used in hydroponics/aquaponics.

According to http://affnan-aquaponics.blogspot.com the funnel siphon top helps the siphon start at stop at different water flows better.

Inspiration came from the flower shaped spillway at Kechut Reservoir near Jermuk in Armenia.

I am thinking that the flower shape increases the weir surface which may help prevent problems. That and it looks neat.

Parametric, you can set the number of 'petals' and size it to the pipe you are using for a stand pipe. 

Open scad appears to be unitless, so pick a unit for the parameters and stick to it. Your slicing may assume things are in mm, if so, scale by 2540 to get things in inches.

Created by Mike Creuzer - mike@creuzer.com on 2012-08-15
*/



// Cone parameters
petals = 5; // number of 'petals' in the cone
height = .5;
wallthickness = 1/8;
spiralofsset = -wallthickness;  // Not sure if this helps yet. It needs testing to see if the spiral flow will help with siphon start & stops. Make + or - to control the direction of the spin.
maxwidth = 2;

// Standpipe connection
standpipe = 17/16; // 3/4 ID looks to be about 1 1/16 OD 
depth = 1; // How tall you want the neck to be. A taller neck will allow you to have enough overlap that you can tweak the water height.
connectionthickness = 1/8;

// General settings
smoothness = .01; // 2 is the default & is pretty fast, smaller is smoother down to .01



//Render the part
rotate([180,0,0]) // Flip this over for easier printing
{
	union()
	{
			intersection()
			{
				difference()
				{
					cylinder(h = height, r=.5*maxwidth, $fs = smoothness);
					cylinder(h = height, r=.5*maxwidth -wallthickness, $fs = smoothness);
				}
				flowershell(wallthickness);
			}
			difference()
			{
				flower();
				difference()
				{
						cylinder(h = height, r=maxwidth, $fs = smoothness);
						cylinder(h = height, r=.5*maxwidth, $fs = smoothness);
				}
			}
	}
}




module flower()
{
	difference()
	{
		union() 
		{
			flowershell(wallthickness);
			standconnector();
			translate([0,0,-depth]) standconnector();
		}
		union()
		{
			flowershell();
			translate([0,0,height]) cylinder(h=3*height, r=4*height);
			translate([0,0,-depth]) cylinder(h = depth + height, r=.5*standpipe, $fs = smoothness);
		}
	
	}
}




module flowershell(thickness = 0)
{
		for (i = [0 : petals] ) 
		{
			rotate([0, 0 , i*360/petals]) petal(thickness);
		}

}




module petal(wall = 0)
{
		translate([spiralofsset,0,0])
			hull()
			{
				cylinder(h = height, r1 = .25*standpipe+wall, r2 = .25*standpipe+wall, $fs = smoothness);
				rotate([20,-45,0]) cylinder(h = 3*height, r1 = .25*standpipe+wall, r2 = .25*standpipe+wall, $fs = smoothness);
			}
}



module standconnector()
{
		cylinder(h = depth, r=.5*standpipe + connectionthickness, $fs = smoothness);
}

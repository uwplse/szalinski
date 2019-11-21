number_of_balls=10; 

//Thickness in mm, scaled by 0.6
Thickness_of_box=4;

//Distance between two balls in mm, scaled by 0.6
distance_between_balls=7;



// Configurable Abacus
// Version 3, March 2014

// By default, its a 10-ball version is for the board game Tikal to count the action points remaining
// Print it "upside down" with the feet up. It prints in one go.
// After printing, move the balls a bit and pull out the plastic fibers which are loose.

// Written by MC Geisler (m c genki at gmail dot com)

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
// See the GNU General Public License for more details.


//Scaling the Abacus
scale=0.6; 

ball_width_radius=15*scale; //if it would be pointy in the middle
ballabstand=distance_between_balls*scale; 
ball_height_radius=ball_width_radius*.8;//the radius of the flattening cylinder in the middle
ball_min_height_radius=ball_height_radius*.966;

stangenradius=ball_width_radius/4;
stangenluft=.75*scale; //bei 1mm*scale wackelts noch, entspricht 0.52356 -> 0,3
echo ("Distance rod to ball: ",stangenluft); 

//make the balls with 12 faces
$fn=12;


stangenlaenge=(ball_width_radius+ballabstand)*number_of_balls+ballabstand;

kistendicke=Thickness_of_box*scale;
kistenhoehe=ball_min_height_radius*2+stangenradius;
kisteninnenbreite=ball_height_radius*2.5;
kisteninnenlaenge=stangenlaenge;

kistenlaenge=kisteninnenlaenge+2*kistendicke;
kistenbreite=kisteninnenbreite+2*kistendicke;

echo ("Length of Abacus: ",kistenlaenge); 

module halberball()
{
	cylinder(h = ball_width_radius/2, r1 = ball_width_radius, r2 = ball_width_radius/2, center = false);
}

module ball()
{
	rotate([360/$fn/2,0,0])
	rotate([0,90,0])
	difference()
	{
		union()
		{
			halberball();
			mirror([0,0,1]) halberball();
		}
			cylinder(h = ball_width_radius*3, r = stangenradius+stangenluft,center=true);
			difference()
			{
				cylinder(h = ball_width_radius*3, r = ball_width_radius*2,center=true);
				cylinder(h = ball_width_radius*3, r = ball_height_radius,center=true);
			}
	}
}

//----------------------------------

difference()
{
	union()
	{
		//kugeln
		translate([-stangenlaenge/2,0,0])
		{
			for (i = [0:number_of_balls-1]) 
			{
					translate([ball_width_radius/2+ballabstand+i*(ball_width_radius+ballabstand),0,0])
						ball(i);
			}
			
			//stange
			rotate([0,90,0])
				translate([0,0,-kistendicke/2])
					cylinder(h=stangenlaenge+kistendicke, r=stangenradius);
		}

		//kiste
		translate([0,0,(kistenhoehe-ball_min_height_radius*2)/2])
		{
			difference()
			{
				cube([kistenlaenge,kistenbreite,kistenhoehe],center=true);
				cube([kisteninnenlaenge,kisteninnenbreite,kistenhoehe*2],center=true);

				translate([0,0,kistenhoehe/2+stangenradius])
					cube([kisteninnenlaenge-5,kisteninnenbreite*2,kistenhoehe],center=true);
				translate([0,0,kistenhoehe/2+stangenradius])
					cube([kisteninnenlaenge*2,kisteninnenbreite-5,kistenhoehe],center=true);
				
			}
		}
	}
	
	translate([0,0,-30/2-ball_min_height_radius+.1])
		cube([kisteninnenlaenge+2*kistendicke*2,kisteninnenbreite+2*kistendicke*2,30],center=true);
}
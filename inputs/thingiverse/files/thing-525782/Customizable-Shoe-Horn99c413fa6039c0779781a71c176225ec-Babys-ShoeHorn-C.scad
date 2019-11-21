//Length of the shoe horns straight part in mm
height=100; 

//Thickness of the shoe horn in mm
thick=3;

//Diameter of the hole to hang it
holesize=9;

//Radius of the circle for the main curvature at the end of the shoe horn
rad=30;

//Radius multiplier for the middle part of the shoe horn (make it flatter in the middle)
rad_multiplier1=1.5;

//Radius multiplier for the top end (make it even flatter and move it further out)
rad_multiplier2=2;

//How many degree from one face of the curvature to the next (bigger for faster rendering)
angle_step=5;

//Faces for the rounding at the ends of the shoe horn
faces=10;

// preview[view:left, tilt:side]

/* [Hidden] */

/*
Shoe Horn
Version C, November 2014
Written by MC Geisler (mcgenki at gmail dot com)

This is the baby sized version... Customize it to suit a yeti.

Have fun!

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/

width=rad*1.4;

module stickballs(rot,low_z,high_z,low_r,high_r,round_low)
{
	rotate([0,0,rot])
		{
			translate([-low_r,0,low_z+(1-cos(rot))*round_low])
				sphere(r=thick/2,center=true,$fn=faces);

			translate([-high_r,0,high_z])
				sphere(r=thick/2,center=true,$fn=faces);
		}
}

//lower part
module stickballslong(rot)
{
	stickballs(rot,-height/2,height/2,rad,rad*rad_multiplier1,height/2);
}

//upper part
module stickballsshort(rot)
{
	stickballs(rot,height/2,height/2+height*.1,rad*rad_multiplier1,rad*rad_multiplier2,0);
}

module shoehorn(length)
{
	angle=45;

	cutsize=max(length,thick,rad,width)*2+2*rad;
	difference()
	{
		union()
		{
			for(i=[-angle:angle_step:angle-angle_step])
			{
				hull()
				{
					stickballslong(i);
					stickballslong(i+angle_step);
				}
				hull()
				{
					stickballsshort(i);
					stickballsshort(i+angle_step);
				}
			}
		}
		translate([0,cutsize/2+width/2,0])
			cube(cutsize+2,center=true);
		translate([0,-(cutsize/2+width/2),0])
			cube(cutsize+2,center=true);
		translate([-rad*rad_multiplier1,0,height/2])
			rotate([0,45,0])
				rotate([0,0,45])
					cube([holesize,holesize,thick*50],center=true);
	}
}

rotate([90,0,0])
	shoehorn(height);


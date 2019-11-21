// Parametric ceiling hook
//
// Designed by Timothy_McPrint (https://www.thingiverse.com/Timothy_McPrint)
// Date: 2017-10-11
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (https://creativecommons.org/licenses/by-nc-sa/4.0/)

// Diameter of the hook (the inner diameter will be caluclated 'diameter-thickness', and the outer one 'diameter+thickness'):
diameter = 140;
// The thickness of the hook and the thickness and deept of the mounting plate:
thickness = 15;

// Diameter of the screw hole:
screw_diameter = 5.4;
// Diameter of the screw head:
screw_head_diameter = 9.0;
// Height of the screw head (countersunk screw!):
screw_head_height = 2.5;

// Draw a round shaped hook? (This feature requires OpenSCAD with version 2016.XX or higher!)
rotated_hook = false;

$fn=150;

//The hook:
if ( rotated_hook == false )
{
	rotate( [0 , 0, 90 ] )
		difference()
		{
			cylinder( h=thickness, d=diameter+thickness, center=true );
			cylinder( h=thickness+0.1, d=diameter-thickness, center=true );
			translate( [ 0, 0,-thickness/2-0.1 ] )
				cube( [ diameter, diameter, thickness+0.2 ] );
		}
	//The round edge at the end of the hook:
	translate( [ 0, diameter/2, 0 ] )
		cylinder( h=thickness, d=thickness, center=true );
}
else
{
	//A variation of the hook with a circular shape:
	rotate( [ 0, 0, 180 ] )
		rotate_extrude( convexity=10, angle=270 )
			translate( [diameter/2, 0, 0] )
				circle( d=thickness );
}

//The mounting plate:
difference()
{
	translate( [ -diameter/2-thickness/2, 0, 0 ] )
		rotate( [ 0, 90, 0 ] )
			linear_extrude( height=thickness )
				hull()
				{
				
					translate( [ 0, diameter/2+14, 0 ] )
						circle( thickness/2 );
					translate( [ 0, -diameter/2-14, 0 ] )
							circle( thickness/2 );
				}
	//The two holes for the screws:
	screw( -diameter/2+thickness/2, diameter/2+12 );
	screw( -diameter/2+thickness/2, -diameter/2-12 );
}


module screw( posx, posy )
{
	translate( [ posx, posy, 0 ] )
		rotate( [ 0, 270, 0 ] )
		{
			cylinder( d1=screw_head_diameter, d2=screw_diameter, h=screw_head_height, center=true );
			cylinder( d=screw_diameter, h=thickness+0.1 );
		}
}

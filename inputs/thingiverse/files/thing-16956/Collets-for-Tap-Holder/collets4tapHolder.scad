/*
 * collets4tapHolder.scad
 * 
 * Written by aubenc @ Thingiverse
 *
 * http://www.thingiverse.com/thing:16956
 *
 * This script is licensed under the
 * Attribution - Share Alike license
 *
 * This is a derivative work of "Tap holder" by Rasle500
 *
 *		http://www.thingiverse.com/thing:16682
 *
 * ...and the derivatives of that work:
 *
 *		http://www.thingiverse.com/thing:16839
 *		http://www.thingiverse.com/thing:16890
 *
 * Usage:
 *
 *    Set the parameters for the desired output, run the required module(s),
 *		render to check, compile and export to STL when/if satisfied.
 *
 */


/* *************** Parameters *********************************************** */

typ="H";		// "C" - Cylindrical, Drill Bit / "H" - Hex, Accessoire


// Parameters for type "C"

dbd=3.2;		// Drill Bit Diameter


// Parameters for type "H"

f2f=6.25;	// Distance between opposite faces
ffn=6;		// Faces number, should NOT work for any value but 6 (hex)
fop="V";		// opening at... "V" - Vertex / "F" - Face
fvs=0.5;		// Side length of the cube used to exagerate the cut for the vertex


// Common Parameters

gap=0.25;	// ...gap ...tolerance ... ... ...
ono=3;		// Number of openings, cuts, clamps, whatever
omn=0.5;		// Minimum size to keep it open (avoid the walls fusing together)


/* *************** Modules ************************************************** */

 collet(typ); 


/* *************** Code ***************************************************** */

module collet(typ)
{
	difference()
	{
		body();

		if( typ == "C" )
		{
			drill_bit();
			openings();
		}
		else if( typ == "H" )
		{
			union()
			{
				accessoire_bit();

				if( fop == "V" )
				{
					openings();
				}
				else if ( fop == "F" )
				{
					rotate([0,0,360/ffn/2]) openings();
				}
			}
		}
	}
}

module body()
{
	union()
	{
		cylinder(h=31.25, r=13.75/2, $fn=13.75*PI, center=false);

		translate([0,0,10])
		cylinder(h=31.25-10, r1=13.75/2, r2=15/2, $fn=13.75*PI, center=false);

		translate([0,0,10])
		cylinder(h=31.25-10-4, r1=13.75/2, r2=20/2, $fn=13.75*PI, center=false);
	}
}

module drill_bit()
{
   cfn=ono*round(dbd*PI/ono);

	union()
	{
		translate([0,0,-0.1])
		cylinder(h=10+0.2, r=(dbd-gap)/2, $fn=cfn, center=false);

		translate([0,0,7])
		cylinder(h=31.25-7+0.2, r=(dbd+gap)/2, $fn=cfn, center=false);

		translate([0,0,8.5])
		cylinder(h=8, r=(dbd+gap+1)/2, $fn=cfn, center=false);

		translate([0,0,8.5+8])
		cylinder(h=0.75, r1=(dbd+gap+1)/2, r2=(dbd+gap)/2, $fn=cfn, center=false);
	}
}

module openings()
{

	oy=dbd/ono > omn ? dbd/ono : omn;

	translate([0,0,9.5])
	for(i=[0:ono-1])
	{
		rotate([0,0,i*360/ono])
		translate([6,0,31.25/2])
		cube(size=[12,oy,31.25], center=true);
	}
}

module accessoire_bit()
{
	lf=360/ffn;
	fod=f2f/sin(lf);

	union()
	{
		translate([0,0,-0.1])
		cylinder(h=31.25+0.2, r=(fod+gap)/2, $fn=ffn, center=false);

		translate([0,0,8.5])
		cylinder(h=8, r=(fod+gap+1)/2, $fn=ffn, center=false);

		translate([0,0,8.5+8])
		cylinder(h=0.75, r1=(fod+gap+1)/2, r2=(fod+gap)/2, $fn=ffn, center=false);

		if( fvs != 0 )
		assign(xd=(fod+gap+fvs)/2-(fvs*cos(lf)/2/sin(lf))-0.05)
		{
			for(i=[0:ffn-1])
			assign(x=xd*cos(i*lf), y=xd*sin(i*lf))
			{
				translate([x,y,31.25/2+0.75])
				rotate([0,0,i*lf])
				cube([fvs,fvs,31.25], center=true);
			}
		}
	}
}
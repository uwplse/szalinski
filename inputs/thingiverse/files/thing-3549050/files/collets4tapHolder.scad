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
// "C" - Cylindrical, Drill Bit / "H" - Hex, Accessoire
typ="C";		

// Parameters for type "C"
// Drill Bit Diameter
dbd=3;

// Parameters for type "H"
// Distance between opposite faces (Hex only)
f2f=6.25;
// Faces number, should NOT work for any value but 6 (Hex only)
ffn=6;
// opening at... "V" - Vertex / "F" - Face (Hex only)
fop="V";
// Side length of the cube used to exagerate the cut for the vertex (Hex only)
fvs=0.5;

// Common Parameters
// ...gap ...tolerance ... ... ...
gap=0.15;
// Minimum size to keep it open (avoid the walls fusing together)
omn=0.5;

// higher values -> smoother circles (high values dont work with customizer though!)
$fn=25;

/* *************** Modules ************************************************** */

 collet(typ); 


/* *************** Code ***************************************************** */

module collet(typ)
{
	difference()
	{
        if( fop == "V" )
        {
            body();
        }
        else if( fop == "F" )
        {
            rotate([0,0,360/ffn/2]) body();
        }
        
        if( fop == "V" )
        {
            opening();
        }
        else if ( fop == "F" )
        {
            rotate([0,0,360/ffn/2]) opening();
        }
		

		if( typ == "C" )
		{
			drill_bit();
		}
		else if( typ == "H" )
		{
            accessoire_bit();
		}
	}
}

module body()
{
    difference()
	{
        union()
        {
            cylinder(h=31.25, r=13.75/2, center=false);

            translate([0,0,10])
            cylinder(h=31.25-10, r1=13.75/2, r2=15/2, center=false);

            translate([0,0,10])
            cylinder(h=31.25-10-4, r1=13.75/2, r2=20/2, center=false);
        };
        translate([8,0,15.9])
        cube(size=[6,18,32], center=true);
        translate([-8,0,15.9])
        cube(size=[6,18,32], center=true);
    }
}

module drill_bit()
{
    translate([0,0,10])
    cylinder(h=31.25-7+0.2, r=(dbd+gap)/2, center=false);
}

module opening()
{
    ono=2;
	oy=dbd/ono > omn ? dbd/ono : omn;

	translate([0,0,10])
	for(i=[0:ono-1])
	{
		rotate([0,0,i*360/ono])
		translate([6,0,31.25/2])
		cube(size=[12,oy,31.25], center=true);
	}
    
    // little cylinders at bottom of opening for better bending
    translate([0,oy/2,10])
    rotate([0,90,0])
    cylinder(h=11, r=0.5, center=true);
    
    translate([0,-oy/2,10])
    rotate([0,90,0])
    cylinder(h=11, r=0.5, center=true);
}

module accessoire_bit()
{
	lf=360/ffn;
	fod=f2f/sin(lf);

	union()
	{
		translate([0,0,10])
		cylinder(h=31.25+0.2, r=(fod+gap)/2, $fn=ffn, center=false);
		
		if( fvs != 0 )
		{
            xd=(fod+gap+fvs)/2-(fvs*cos(lf)/2/sin(lf))-0.05;
			for(i=[0:ffn-1])
			{
                x=xd*cos(i*lf);
                y=xd*sin(i*lf);
				translate([x,y,10+(31.25/2)])
				rotate([0,0,i*lf])
				cube([fvs,fvs,31.25], center=true);
			}
		}
	}
}
// How many nozzles do you want to hold?
nozzles = 6; // [1:12]

// How big are your nozzles, in mm?  Measure across the widest part (opposing points for hexes)
nozzle_diameter =14;		 // [7:30] 

// PrintrbotNozzleCaddy.scad
// A caddy for storing extruder nozzles for the Printrbot+.
// Fits on any corner of the top deck using existing mounting bolts.

// Original design by Michele31415, January 26, 2013.
// Feel free to use or modify but please keep the above line intact.

// Made parametric by Selmo 6/10/2013

// Be sure to set the path here to match where your own library is:
// include <C:/dev/GitHub/MCAD/regular_shapes.scad>
include  <MCAD/regular_shapes.scad>

nozzle_size = nozzle_diameter / 2;

// Well radius - set slightly smaller for a snug fit.
hexspacing = nozzle_size*2.0;

totalheight = nozzle_size*2.4 ;     	 // The overall height of the piece
width = (nozzles+0.25)*hexspacing;
lefthexstartx = hexspacing*0.8;	

// Build the caddy:
difference ()
   {
		cube(size = [5.3 + width, totalheight, 6.75], center = false);


	for (a = [0:(nozzles-1)])
	{
		assign (offset = lefthexstartx  + (hexspacing * a))
{
     	translate ([offset ,nozzle_size*1.2, -2]) rotate (a = [0, 0, 30]) {hexagon_prism(45, nozzle_size); }

     	 translate ([offset, (5*nozzle_size*1.2)/2, 2])  // lower grip relief, left
          	rotate (a = [0, 0, 45])
              { cylinder (r=nozzle_size, h = 6.75); }

     	 translate ([offset, -nozzle_size*1.2/2, 2])  // lower grip relief, left
          	rotate (a = [0, 0, 45])
              { cylinder (r=nozzle_size, h = 6.75); }
	}
}
		translate ([-2, totalheight/2, 0]) cylinder(h = totalheight, r=totalheight/4); // left bolt head relief

      translate ([width + 7.4, totalheight/2, 0]) cylinder(h = totalheight, r=totalheight/4); // right bolt head relief
	}

// add the mounting ears:
translate(v = [-1.5, totalheight/2, 0])  // left side
   {
    difference ()
        {
         cylinder(h = 1.5, r=totalheight/4); // make the tab
          translate ([0,0,-0.05])  cylinder(h = 1.6, r=totalheight/8); // make a screw hole
        }
   }

translate(v = [7.3-0.5 +width, totalheight/2, 0])  // right side
   {
    difference ()
        {
         cylinder(h = 1.5, r=totalheight/4); // make the tab
         translate ([0,0,-0.05]) cylinder(h = 1.6, r=totalheight/8); // make a screw hole
        }
   }



// in mm
bobbin_diameter = 22;

// in mm
wall_thickness = 3;

// flat or round?	
bottom = 0; // [1:flat bottom, 0:round bottom]

// to the inner edge
holder_radius = 50;
// 	should hold about 30 10mm-high bobbins, since from
// 	2*π*r ≈ x*10
//    and r = 50 follows x≈30.
// 	(more accurately:
// 	2*π*r = 31.415*10  ⇔  r = 50
// 	I planned to fit ~30 bobbins anyway, and
// 	liked that π gets canceled out instead 
// 	of having a real number for diameter.)

/* [Hidden] */

diameter = bobbin_diameter;
thickness = wall_thickness;
radius = diameter/2;
width = radius+thickness;
$fn=64;

module border()
	{
	translate([0, thickness]) square([thickness, thickness]);
	translate([thickness/2, 2*thickness]) circle(r=thickness/2);
	}

// create hollowed-out torus
rotate_extrude(convexity = 10)
	// move rotation-pattern to the right spot
	translate([holder_radius+radius, 0, 0])
	// create rotation-pattern
	difference()
		{
		union()
			{
			// inside border
			translate([-width, -thickness]){border();}
			// outside border
			translate([-width+diameter+thickness, -thickness]){border();}
			// flat bottom
			if(bottom) {translate([-width, -width]) square([2*width, width]);}
			// round bottom
			else
				{
				difference()
					{
					circle(r=width);
					translate([-width, 0]) square([2*width, width]);
					}
				}
			}
		// bobbin-groove
		circle(r=radius);
		}


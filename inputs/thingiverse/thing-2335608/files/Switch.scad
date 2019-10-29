$fn = 50;
/*[Nintendo Switch Support bracket parameters]*/
// (mm) Printed thickness of the bracket support beams (not including rail)
thickness = 4;
// (mm) Width of the support beams
beamwidth = 15;
// (mm) Length of the main beam
beamlength = 130;
// Angle of the top bracket
topangle = 45;
// Angle of the bottom bracket
bottomangle = 70;
// (0/!0) Include supports for bridging (omit these if you can reliably print support structures or use a support material with your slicer/printer)
supports = 0;

dual_switch_supports(thickness, beamwidth, beamlength, topangle, bottomangle, supports);

// Mount rail to fit the Nintendo Switch joystick keyway
module Joyrail(s, l)
{
	w = 9;
	//l = 50;
	h = 2.5;
	t = 1.5;
	gap = 1.0;
	key = h - gap;
	//translate([0,0,(h/4) + (h/2)])
	union() {
		translate([0,0,h/2])	// main support
			cube([w-h, l, h], true);
		translate([0,0,h - (key/2)])	// key plate
			cube([w, l, key], true);
		if(s != 0)
		{
			// Some little support blocks that should be bridgable on most printers
			translate([0,-(l - t)/2,h/2])	// end supports
				cube([w, t, h], true);
			translate([0, (l - t)/2,h/2])
				cube([w, t, h], true);
		}
	}
}

// Main bar of the support
module Bar(thickness, length, width, keylen, printsupports)
{
	w = width;
	h = thickness;
	l = length;
	translate([0,0,h/2])
		cube([w, l, h], true);
	translate([0,0, h])
		Joyrail(printsupports, keylen);
}

// A nicely shaped bar that makes up the feet of the support bracket (or an appropriate punchout)
module SupportBar(thickness, length, width, clipangle)
{
  w = width;
	h = thickness;
	l = length;
	
	//clipangle = 15;//atan(4.5/14);
	offset = width;
	cliplen = l * 1.5;
	union()
	{
		difference()
		{

			cube([w, l, h], true);

			translate([0, (l/2) + offset , 0])
				rotate([0,0,-clipangle])
					translate([0, -cliplen/2, 0])
						cube([w, cliplen, h+1], true);
		}
		translate([0, -length/2, 0])
			cylinder(h = thickness, d = width, center = true);
  }
}

// Pattern to make up a single support bracket (mirror it for the other side)
module SwitchSupport(thickness, barwidth, barlength, topangle, bottomangle, printsupports)
{
	length = barlength - barwidth;
	feet = 70;
	top = topangle;
	bottom = bottomangle;
	width = barwidth;
	clipangle = 15;
	punchdiff = 2 * ((thickness / sin(clipangle)) - (thickness));
	keylen = 2* (82 - (barlength / 2));
	difference()
	{
		union()
		{
			// mounting beam
			Bar(thickness, length, width, keylen, printsupports);
	
			// top foot
			translate([0, length/2, thickness/2])
				rotate([0,0,top])
					translate([0, -feet/2,0])
						mirror([0,1,0])
							SupportBar(thickness, feet, width, clipangle);
			// bottom foot
			translate([0, -length/2, thickness/2])
				rotate([0,0, 360 - bottom])
					translate([0, feet/2,0])
						SupportBar(thickness, feet, width, clipangle);
    }

		// punchouts
			translate([0, length/2, thickness/2])
				rotate([0,0,top])
					translate([0, -feet/2,0])
						mirror([0,1,0])
							translate([0, -(punchdiff)/2, 0])
								SupportBar(thickness + 1, feet - punchdiff, width - (thickness * 2), clipangle);


			translate([0, -length/2, thickness/2])
				rotate([0,0, 360 - bottom])
					translate([0, feet/2,0])
						translate([0, -(punchdiff)/2, 0])
							SupportBar(thickness + 1, feet - punchdiff, width - (thickness * 2), clipangle);
  }
}

// A pair of matched support brackets
module dual_switch_supports(thickness, barwidth, barlength, topangle, bottomangle, printsupports)
{
translate([ ((barwidth / 2) + 2),0,0])
	SwitchSupport(thickness, barwidth, barlength, topangle, bottomangle, printsupports);
translate([-((barwidth / 2) + 2),0,0])
	mirror([1,0,0])
		SwitchSupport(thickness, barwidth, barlength, topangle, bottomangle, printsupports);
}


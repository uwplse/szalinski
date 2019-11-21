/* [Main parameters] */

// Bone's diameter
d = 18;

// Length
h = 4;

// Width of each corner
w = 3;

// Number of polygon sides
sides = 7;

/* [Extra parameters] */

// Inner circle's (hole's) detail
detail = 10;

// More width to help with 3D printing (slicing)
extra_inner_w = 0;

/* [Hidden] */
r = d/2;

// The design is comprised of two mirror half rings.
// -
// This is the first one.
// -
module half_ring (r = r, w = w, h = h, sides = sides,
				  extra_inner_w = extra_inner_w)
{
	h = h/2;

	// Circumscribed, around the hole, radius of 
	// a heptagon.
	// -
	circumscr_r = (r + extra_inner_w) / cos(360/(2*sides));
	
	difference()
	{
		linear_extrude(height = h, 
					   scale=(r + w)/(r + extra_inner_w))
		circle(r = circumscr_r,$fn=sides);
		// Main hole.
		// -
		// Move it a bit to make it visible
		// -
		translate([0,0,-1])
		#cylinder(r = r, h = h + 2, 
				  $fn=2 * detail * sides);
	}
}

module ring (r = r, w = w, h = h, sides = sides)
{
	half_ring(r,w,h, sides);
	rotate([180,0,0])
	translate([0,0,-h])
	half_ring(r,w,h, sides);
}

color("lime")
ring(r,w,h);
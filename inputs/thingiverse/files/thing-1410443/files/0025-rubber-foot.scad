// This is a parametric version for the extrusion foot
// the following parameter for for a 2020 profile with a somewhat beefy flat head screw.

// This is a square design since most profiles are square (unless they are not) so the width is also the length
width = 20;

// height is the height of the foot without the 4 knobs that grip into the t-slots. So height is the distance between end of aluminium profile and table.
height = 15;

// the insert are those 4 knobs that grip into the t-slots of the profile. Insert height is how deep it will grip into the profile.
insertsHeight = 2;

// Inster width is the distance of the inserts along the edge of the foot
insertWidth = 5.5;

// Insert Depth is the other corner of the insert.
insertDepth = 5.5;

// Screw hole is the clearance radius if the threat part of the screw
screwHole = 3;

// Screw head is the clearance radius of the head of the screw, in this design i'm assuming you use a flat head screw.
screwHead = 5.5;

// screw head recess is how deep the screw will be hidden in the bottom of the foot.
screwHeadRecess = 4;

// set this to true if the screws has a flat head, Set this to false for pan head and other screw types that expect a level base
screwIsFlat = true;

// Cut view lets you cut the foot in halt to check the profile of the screw
cutView = false;

// Corner is the rounding radius sides an bottom of the foot
corner = 2;

$fn = 100;

torso(width, height, insertsHeight, insertWidth, insertDepth, screwHole, screwHead, screwHeadRecess, screwIsFlat, corner, cutView);


module torso(width, height, insertsHeight, insertWidth, insertDepth, screwHole, screwHead, screwHeadRecess, screwIsFlat, corner, cutView)
{

	difference()
	{
		union()
		{
			intersection()
			{
				hull()
				{
					translate([ (width * 0.5) - corner, (width * 0.5) - corner, corner ]) sphere(r = corner);
					translate([ -(width * 0.5) + corner, (width * 0.5) - corner, corner ]) sphere(r = corner);
					translate([ (width * 0.5) - corner, -(width * 0.5) + corner, corner ]) sphere(r = corner);
					translate([ -(width * 0.5) + corner, -(width * 0.5) + corner, corner ]) sphere(r = corner);

					translate([ (width * 0.5) - corner, (width * 0.5) - corner, height + corner ]) sphere(r = corner);
					translate([ -(width * 0.5) + corner, (width * 0.5) - corner, height + corner ]) sphere(r = corner);
					translate([ (width * 0.5) - corner, -(width * 0.5) + corner, height + corner ]) sphere(r = corner);
					translate([ -(width * 0.5) + corner, -(width * 0.5) + corner, height + corner ]) sphere(r = corner);
				}
				cube([ width, width, height * 2 ], center = true);
			}
			rotate([ 0, 0, 0 ]) insert(width, height, insertsHeight, insertWidth, insertDepth);
			rotate([ 0, 0, 90 ]) insert(width, height, insertsHeight, insertWidth, insertDepth);
			rotate([ 0, 0, 180 ]) insert(width, height, insertsHeight, insertWidth, insertDepth);
			rotate([ 0, 0, 270 ]) insert(width, height, insertsHeight, insertWidth, insertDepth);
		}
		cylinder(h = height * 2.1, r1 = screwHole, r2 = screwHole, center = true);
		cylinder(h = screwHeadRecess * 2, r1 = screwHead, r2 = screwHead, center = true);
		if(screwIsFlat)
		{
			translate([ 0, 0, screwHeadRecess - 0.05 ]) cylinder(h = screwHead * 0.5, r1 = screwHead, r2 = screwHole, center = false);
		}
		if (cutView)
		{
			translate([ 0, width * 0.5, 0]) cube([ width * 2, width, (height + insertsHeight) * 3], center = true);
		}

	}
}

module insert(width, height, insertsHeight, insertWidth, insertDepth, screwHole, screwHead)
{
	translate([ (width * 0.5) - (insertDepth * 0.5), 0, height + (insertsHeight * 0.5) ]) cube([ insertDepth, insertWidth, insertsHeight ], center = true);
}


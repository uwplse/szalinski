// preview[view:south, tilt:top]

// width of the clamp (mm)
width = 10;    

// thickness of the plastic (mm)
thickness = 3; 

// gap between tweezers (mm)
gap = 5.4;	 

// length of the pinching part (the tweezers, mm)
l1 = 6;

// length of the wider part (mm)
l2 = 7;

g2 = max(10, gap + 4);

r = 0.45 * thickness;
d = 0.1 * thickness;

hg = gap/2;
hg2 = g2/2;
$fn=50;

// the polygon that defines the cross-section of the clamp
p = [
	[ -l1, -hg - r],
	[ -l1, -hg - d - r],
	[ 0, -hg - d - r],
	[ l2, -hg2 - d - r],
	[ l2 + d, -hg2 - d - r],
	[ l2 + d, hg2 + d + r], 
	[ l2, hg2 + d + r],
	[ 0, hg + d + r],
	[ -l1, hg + d + r],
	[ -l1, hg + r],
	[ 0, hg + r],
	[l2, hg2 + r],
	[l2, -hg2 - r],
	[0, -hg - r]
];

minkowski()
{
linear_extrude( height = width/2)
	polygon( points = p, convexity = 40);
cylinder( r = r, h = width/2);
}


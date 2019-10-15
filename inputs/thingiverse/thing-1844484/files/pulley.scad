// easy print intersecting parts middle split idler pulley
// with optional recesses for ball bearings.
// 2016oct23,ls  v0.0.1 initial version
// 2016oct23,ls  v0.0.2 redesign, solving some oddnesses with v0.0.1

// --- customiser ---

// of whole pulley: barrel + guards
width       = 9; 							// [5:0.1:24]
// (barrel is what the belt runs on)
barrel_width = 6.8;							// [4:0.2:16]
// diameter
barrel      = 14;							// [5:32]
// raise over barrel;
guard       = 1;							// [0.2:0.1:4]

// diameter
axle        = 4.8;							// [2:0.1:12]
// no bearing if set same as axle, else outer bearing diameter.
bearing     = 7;							// [2:0.1:22]
// width of bearing. if no bearing (bearing = axle), don't care.
recess      = 2;							// [0:0.1:10]
// how deeply does one part push into the other
intersect   = 6.8;							// [0:0.1:8]
// fit parts by adding slack
slack       = 0.2;							// [0:0.01:1]
// of plate arrangement
spacing     = 5;							// [1:50]

$fn         = 0+100;

// --- derived vars ---
slack2      = 2 * slack;
inner       = bearing + slack2;
outer       = barrel + 2*guard;
wall        = (width - barrel_width) / 2;				// guard width
coupling    = (bearing + barrel) / 2;


// --- build ---
ring(wall, inner, outer);						// guard
ring(width-wall, coupling+slack2, barrel);				// roll
ring(width-wall-min(intersect, barrel_width)-slack, inner, barrel);	// fill, excluding intersection (recessed)

translate([barrel + 2*guard + spacing, 0, 0])  {
ring(wall, inner, outer);						// guard
ring(wall+min(intersect, barrel_width), inner, coupling-slack2);	// intersection (protruding)
}

if (bearing > axle)  {
translate([(outer+spacing)/2, bearing+spacing/2, 0])
ring(width - 2*recess - slack2, axle+slack, bearing);		// axle chuck
}

// --- libs ---
// --- include <pipe.scad> ---
// (inclusion of /home/l/3d-print/my/lib/pipe.scad done by /misc/bin/scad_include)
// 2016sep, ls

// h: height.  length of the pipe
// r: inner pipe radius
// t: wall thickness   2*(r+t)  gives outer pipe diameter

little = 0.01;
module pipe(h, r, t)  {
difference()  {
cylinder(h, r=r+t);
translate([0, 0, -little/2])
cylinder(h+little, r=r);
}
}

module pipe_help()  {
echo ("pipe(len, inner_radius, wall)");
}
// (inclusion of /home/l/3d-print/my/lib/pipe.scad finished)

module ring(h, i, o)  {
if ((o-i) < 0.5) echo("########## thin or negative walls:", o-i, "##########");
pipe(h, i/2, (o-i)/2);
}

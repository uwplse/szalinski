// Wheel chock for model display
// includes option for recess to underside for BluTak
// By misterC @ thingiverse

// input parameters
// Diameter of wheel to be chocked
dia=95;
// Width of chock required
width = 8;
// Length of chock required
chock = 40;
// Thickness of walls (best as multiple of extruder diameter)
wall_thick = 1.2;
// Cutouts required?
cutout = true;

/*	[Hidden]	*/

//working variables
// wheel radius
rad = dia/2;
// block length for chock diagonal
sides = pythag(chock/2);
// radius of under edge of chock
fullrad = rad + wall_thick;
cutout_warning = "Cutout is very small";

c = chock/2 - pythag(wall_thick);
D = 2*pow(fullrad,2) - pow(fullrad-c,2);
Y1 = 1/2 * (c + fullrad + sqrt(D));
Y2 = 1/2 * (c + fullrad - sqrt(D));
// we need the smaller value of Y
Y=(Y1>Y2)?Y2:Y1;

cutside = pythag(Y);
if (cutside<wall_thick) echo (cutout_warning);
cutmiddle = c - Y;

// System variables
$fn = 50;

// Progam here, calls modules below
intersection()
{
	// z=0 cutoff
	cylinder(d=dia,h=rad);
	difference()
	{
		// chock body
		toblerone(sides,width);

		// wheel
		translate([0,0,fullrad]) rotate([90,0,0]) cylinder(d=dia,h=2*width,center=true,$fn=50);
		// blutack cutouts
		if (cutout) mirrorme([1,0,0]) translate([cutmiddle,0,0]) toblerone(Y,width-2*wall_thick);
	}
}


module toblerone(length,depth)
{
	rotate([0,45,0,0]) cube([length,depth,length],center=true);
}

module mirrorme(axis)
// produces two items, mirrored in [axis]
{
    children();
    mirror(axis) children();
}

function pythag(length) = sqrt(2*(pow(length,2)));
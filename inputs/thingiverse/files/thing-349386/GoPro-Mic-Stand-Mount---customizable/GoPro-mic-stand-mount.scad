//
// A mount for a GoPro using a mic clip
// designed by James Brown (JAMESdotBROWNatBLDESIGNdotCOM)
//

// Musician's Gear Heavy Duty Basic Mic Clip
// Manufacturer part #: MS103-MG
// $2 each on Amazon w/ free shipping

// incorporates thing 6154 GoProHD Mount (Female)
// see http://www.thingiverse.com/thing:6154

// license: creative commons, attribution - non-commercial - share alike

// printed at 0.3mm layer height w/ no support on Solidoodle 2


//
// The following values are adjustable in the customizer
//

// Outside diameter of the base mic clip insert (measured) default:24
baseOD = 24;

// Diameter of the hole in the mic clip (measured; okay to be a little big) default:8
holeID = 8;

// Thickness of the mic clip insert (measured) default:5.5
thickness = 5.5;

// Height from the center of the hole to the base of the GoPro mount (allow clearance for mount to rotate around the mic clip base) default:18
height = 18;

//
// End customizer
//


//
// the following values are constants and should not be adjusted
// they have a +0 on the end so the customizer will not allow
// the user to set them
//

mountLen = 46 +0;	// the length of thing 6154, the GoPro mount

$fn=96 +0;		// how detailed to make circles


// needs to stand on end to have a hope of printing w/o supports
rotate([90,0,0])
{
	// import the existing GoPro mount
	// and position it correctly to mate with the other piece
	translate([height, (mountLen-baseOD)/2, thickness/2])
		rotate([0,90,0])
		import("GoProHD_mount.STL");	// thing 6154 GoProHD Mount (Female)
	
	difference()
	{
		// the hull call creates the roughly triangular piece that
		// gets inserted into the mic clip base

		// if you are not using hull, learn about it!
		// hull is an awesome tool for creating complex joined
		// shapes from two (or more) basic shapes
		hull()
		{
			// use the '#' prefix on one (or both) of the cylinder
			// calls below to see what hull is doing behind the scenes

			// the bottom round part of the insert
			cylinder(h=thickness, r=baseOD/2);

			// a cylinder as long as the GoPro mount
			translate([height, (mountLen-baseOD)/2, thickness/2])
				rotate([90,0,0])
				cylinder(h=mountLen, r=thickness/2, center=true);
		}
	
		// hole for mounting screw
		translate([0,0,-1])
			cylinder(h=thickness+2, r=holeID/2);
	
	}
}

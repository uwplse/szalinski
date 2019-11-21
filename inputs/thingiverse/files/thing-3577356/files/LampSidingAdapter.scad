
// Outer diameter of adapter ring, in millimeters.
ring_OD = 135;
// Inner diameter (flange) of adapter ring, in millimeters.
ring_ID = 130.75;
// Clearange diameter (the hole) of adapter ring, in millimeters.
ring_CD = 120;
// Nominal thickness (at zero degrees rotation) of adapter ring, in millimeters.  This is what you see on the outside.
ring_thickness = 5;
// Nominal thickness (at zero degrees rotation) of the inner ring, in millimeters.  Usually 2-4mm thicker than ring_thickness.
ring_inner_thickness = 7;
// The thickness of the siding in any units (so long as siding_reveal is given in the same units).
siding_thickness = 10;
// The reveal (visible width) of the siding in any units (so long as siding_thickness is given in the same units).
siding_reveal = 171;      

// OpenSCAD program which generates adapter rings for use between lamp flanges and lapped siding.
// NOTE: For the various diameter values, when printing in ABS, you might want to increase the diameter by
// about 1% to account for ABS thermal expansion (contraction, when it cools).

angle = atan2(siding_thickness, siding_reveal);
echo(str("angle=", angle));
ring_OR = ring_OD / 2;
ring_IR = ring_ID / 2;
ring_CR = ring_CD / 2;
difference()
{
	rotate([angle,0,0])
	{
		difference()
		{
			union()
			{
				cylinder(r=ring_OR, h=ring_thickness*2, center=true, $fn=240);
				cylinder(r=ring_IR, h=ring_inner_thickness*2, center=true, $fn=240);
			}
			cylinder(r=ring_CR, h=ring_thickness*4, center=true, $fn=240);
		}
	}
	translate([0,0,-ring_thickness*2]) cube([ring_OD*1.5, ring_OD*1.5, ring_thickness * 4], center=true);
}



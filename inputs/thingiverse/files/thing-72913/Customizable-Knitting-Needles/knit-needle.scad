$fn = 100;						// 100 sides on a circle
BODY_LENGTH = 250;			// Length of needle
BODY_DIAMETER = 5;			// Diameter of needle
TIP_TAPER_LENGTH = 15;		// Length of tapered portion
TIP_DIAMETER = 1;				// Diameter of tip end
SLEEVE_LENGTH = 3;			// Length of cap sleeve (overlaps needle body)
SLEEVE_THICKNESS = 1;		// Thickness of sleeve
TOP_DIAMETER = 10;			// Diameter of top
TOP_THICKNESS = 1;			// Thickness of top
TWO_NEEDLES = true;			// Generate two needles?

translate(v = [BODY_DIAMETER / 2, BODY_DIAMETER / 2, 0])
{
	needle();
}

if(TWO_NEEDLES)
{
	translate(v = [-(BODY_DIAMETER / 2), -(BODY_DIAMETER / 2), 0])
	{	
		needle();
	}
}

// Calculate cap positioning.
capOffset = (TOP_DIAMETER / 2) + BODY_DIAMETER;
capDepth = -((BODY_DIAMETER / 2) - (SLEEVE_LENGTH / 2) - TOP_THICKNESS);

translate(v = [capOffset, capOffset, capDepth])
{
	cap();
}

if(TWO_NEEDLES)
{
	translate(v = [-capOffset, -capOffset, capDepth])
	{
		cap();
	}
}

module needle()
{
	// Adjust to lay flat on 45 degree angle (ideal for printing as long as possible).
	rotate(a = [90, 0, 45])
	{
		// Build main needle body and tip.
		union()
		{
			// Create needle body.
			cylinder(r = BODY_DIAMETER / 2, h = BODY_LENGTH - TIP_TAPER_LENGTH, center = true);

			// Add tip.
			translate(v=[0, 0, BODY_LENGTH / 2])
			{
				cylinder(r1 = BODY_DIAMETER / 2, r2 = TIP_DIAMETER / 2, h = TIP_TAPER_LENGTH, center = true);
			}
		}
	}
}

module cap()
{
	union()
	{
		// Create sleeve.
		difference()
		{
			cylinder(r = (BODY_DIAMETER + SLEEVE_THICKNESS) / 2, h = SLEEVE_LENGTH, center = true);
			cylinder(r = BODY_DIAMETER / 2, h = SLEEVE_LENGTH, center = true);
		}

		// Add top.
		translate(v = [0, 0, -((SLEEVE_LENGTH / 2) + (TOP_THICKNESS / 2))])
		{
			cylinder(r = TOP_DIAMETER / 2, h = TOP_THICKNESS, center = true);
		}
	}
}
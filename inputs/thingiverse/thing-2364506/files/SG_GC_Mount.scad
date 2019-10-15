/* [Global] */

/* [Left-To-Right Adjustment] */

// Angle to tilt camera left-to-right, in degrees. Positive makes camera point right, negative points left
Angle_X = 0; // [-90:90]

// Higher numbers create more rounded angles, at the cost of a higher STIL file size. 100 is sufficient for most use cases.
Angle_X_Smoothing = 100; // [30:200]

/* [Ground-To-Sky Adjustment] */

// Angle to tilt camera ground-to-sky, in degrees. Positive makes camera point towards ground; negaitve points towards sky.
Angle_Y = 0; // [-90:90]

// Higher numbers create more rounded angles, at the cost of a higher STIL file size. 100 is sufficient for most use cases.
Angle_Y_Smoothing = 100; // [30:200]

/* [Standoffs] */

// Extra width to place on camera side, in mm. Reference: thin mount is 3mm, thick mount is 5mm
Camera_Standoff = 3; // [3:100]

// Extra width to place in between angled sections, in mm
Angle_Standoff = 0;

//Extra width to place on windshield side, in mm
Windshield_Standoff = 0;

/* [Miscellaneous] */

// True makes left-to-right adjustments apply on camera side, and ground-to-sky adjustments apply on windshield side. False reverses this.
Angle_X_Camera_Side = true;

/* [Hidden] */

Base_X = 45; //  Base X size of OEM mount, in mm
Base_Y = 35; //  Base Y size of OEM mount, in mm
Standoff_Tolerance = 0.1;
Half_Base_X = Base_X / 2;
Half_Base_Y = Base_Y / 2;
Double_Base_X = Base_X * 2;
Double_Base_Y = Base_Y * 2;
Double_Standoff_Tolerance = Standoff_Tolerance * 2;
Half_Camera_Standoff = Camera_Standoff / 2;
Half_Angle_Standoff = Angle_Standoff / 2;
Half_Windshield_Standoff = Windshield_Standoff / 2;
Sign_X = Angle_X == 0 ? 0 : abs(Angle_X) / Angle_X; //Angle_X: -1 for negative, 0 for 0, 1 for positive
Sign_Y = Angle_Y == 0 ? 0 : abs(Angle_Y) / Angle_Y; //Angle_Y: -1 for negative, 0 for 0, 1 for positive 

module Round_Rect(x, y, z, r, s)
{
	union()
	{
		translate([(x / 2) - r, ((-y) / 2) + r, 0])
			cylinder(z, r, r, center = true, $fn = s);
		translate([((-x) / 2) + r, ((-y) / 2) + r, 0])
			cylinder(z, r, r, center = true, $fn = s);
		translate([((-x) / 2) + r, (y / 2) - r, 0])
			cylinder(z, r, r, center = true, $fn = s);
		translate([(x / 2) - r, (y / 2) - r, 0])
			cylinder(z, r, r, center = true, $fn = s);
		cube([x - (r * 2), y, z], center = true);
		cube([x, y - (r * 2), z], center = true);
	}
}

module Make_Mount()
{
	//
	// Main mount
	//
	union()
	{
		//
		// Hook mechanism for dash cam
		//
		translate([0, 0, 1 + Camera_Standoff])
		union()
		{
			//
			// Flat top of hook
			//
			translate([0, 0, 2])
				Round_Rect(12, 10, 2, 1, 20);

			//
			// Thin inside of hook
			//
			translate([0, 1, 0])
				Round_Rect(6, 8, 2, 1, 20);

			//
			// Stopper of hook
			//
			translate([0, (-4), 0])
				Round_Rect(12, 2, 2, 1, 20);
		}

		//
		// Camera standoff
		//
		translate([0, 0, Camera_Standoff / 2])
			Round_Rect(Base_X, Base_Y, Camera_Standoff + Standoff_Tolerance, 3, 40);
	}
}

module Make_Angle_X()
{
	//
	// Angle X
	//
	difference()
	{
		rotate([90, 0, 0])
			cylinder(Base_Y, Base_X, Base_X, center = true, $fn = Angle_X_Smoothing);

		translate([0, 0, (-Half_Base_X)])
			cube([Double_Base_X, Base_Y + Standoff_Tolerance, Base_X], center = true);

		rotate([0, (-Angle_X), 0])
		translate([0, 0, Half_Base_X])
			cube([Double_Base_X, Base_Y + Standoff_Tolerance, Base_X], center = true);
	};
}

module Make_Angle_Y()
{
	//
	// Angle Y
	//
	difference()
	{
		rotate([0, 90, 0])
			cylinder(Base_X, Base_Y, Base_Y, center = true, $fn = Angle_Y_Smoothing);

		translate([0, 0, (-Half_Base_Y)])
			cube([Base_X + Standoff_Tolerance, Double_Base_Y, Base_Y], center = true);

		rotate([(-Angle_Y), 0, 0])
		translate([0, 0, Half_Base_Y])
			cube([Base_X + Standoff_Tolerance, Double_Base_Y, Base_Y], center = true);
	};
}

module Make_Angle_First()
{
	// SANITY CHECK: If angle to make is zero, don't do anything here
	if ((Angle_X_Camera_Side && Angle_X == 0) ||
		(!Angle_X_Camera_Side && Angle_Y == 0))
	{
		Make_Mount();
	}
	else
	{
		union()
		{
			if (Angle_X_Camera_Side)
			{
				//
				// Move unioned result back to origin
				//
				translate([Sign_X * (-Half_Base_X), 0, 0])
				union()
				{
					//
					// Make parts here and union together
					//
					rotate([0, (-Angle_X), 0])
					translate([Sign_X * Half_Base_X, 0, 0])
						Make_Mount();

					Make_Angle_X();
				}
			}
			else
			{
				//
				// Move unioned result back to origin
				//
				translate([0, Sign_Y * Half_Base_Y, 0])
				union()
				{
					//
					// Make parts here and union together
					//
					rotate([(-Angle_Y), 0, 0])
					translate([0, Sign_Y * (-Half_Base_Y), 0])
						Make_Mount();

					Make_Angle_Y();
				}
			}
		}
	}
}

module Make_Angle_Standoff()
{
	//
	// Move unioned result back to origin
	//
	translate([0, 0, Angle_Standoff])
	union()
	{
		//
		// Make parts here and union together
		//
		Make_Angle_First();


		// Only make standoff if required
		if (Angle_Standoff != 0)
		{
			//
			// Angle standoff
			//
			translate([0, 0, (-Half_Angle_Standoff) - Standoff_Tolerance])
				cube([Base_X, Base_Y, Angle_Standoff + Double_Standoff_Tolerance], center = true);
		}
	}
}

module Make_Angle_Second()
{
	// SANITY CHECK: If angle to make is zero, don't do anything here
	if ((!Angle_X_Camera_Side && Angle_X == 0) ||
		(Angle_X_Camera_Side && Angle_Y == 0))
	{
		Make_Angle_Standoff();
	}
	else
	{
		union()
		{
			if (Angle_X_Camera_Side)
			{
				//
				// Move unioned result back to origin
				//
				translate([0, Sign_Y * Half_Base_Y, 0])
				union()
				{
					//
					// Make parts here and union together
					//
					rotate([(-Angle_Y), 0, 0])
					translate([0, Sign_Y * (-Half_Base_Y), 0])
						Make_Angle_Standoff();

					Make_Angle_Y();
				}
			}
			else
			{
				//
				// Move unioned result back to origin
				//
				translate([Sign_X * (-Half_Base_X), 0, 0])
				union()
				{
					//
					// Make parts here and union together
					//
					rotate([0, (-Angle_X), 0])
					translate([Sign_X * Half_Base_X, 0, 0])
						Make_Angle_Standoff();

					Make_Angle_X();
				}
			}
		}
	}
}

module Make_Windshield_Standoff()
{
	//
	// Move unioned result back to origin
	//
	translate([0, 0, Windshield_Standoff])
	union()
	{
		//
		// Make parts here and union together
		//
		Make_Angle_Second();


		// Only make standoff if required
		if (Windshield_Standoff != 0)
		{
			//
			// Windshield standoff
			//
			translate([0, 0, (-Half_Windshield_Standoff)])
				cube([Base_X, Base_Y, Windshield_Standoff + Standoff_Tolerance], center = true);
		}
	}
}

//
// Convenient wrapper method for clarity
//
module Make_All()
{
	Make_Windshield_Standoff();
}

Make_All();;
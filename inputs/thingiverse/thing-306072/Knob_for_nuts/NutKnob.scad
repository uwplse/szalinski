// Knob for nut
// Hari Wiguna, 2014

nutHeight = 5.54;
nutWidestDiameter = 12.46;
knobHeight = 2.0;
knobDiameter = 17.0;
ridgeHeight = knobHeight;
ridgeRadius = 2;

// Computed
nutRadius = nutWidestDiameter / 2.0;
knobRadius = knobDiameter / 2.0;

difference()
{
	union()
	{
		// Knob
		cylinder( knobHeight, knobRadius, knobRadius, $fn=12 );
	
		// Knob ridges
		for (n=[0:1:13])
		{
			rotate(n*360/14,[0,0,1])
				translate([knobRadius,0,0]) 
					cylinder( ridgeHeight, ridgeRadius, ridgeRadius, $fn=12 );
		}
	}

	// Hexagon nut
	translate([0,0,-(nutHeight-knobHeight)/2]) 
		cylinder( nutHeight, nutRadius, nutRadius, $fn=6 );
}

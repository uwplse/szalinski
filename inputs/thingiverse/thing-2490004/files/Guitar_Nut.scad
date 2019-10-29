/* [Nut Settings] */
// Number of strings to use. All equally spaced.
String_Count = 6; // [1:8]

// Width of entire nut in millimeters
Nut_Width = 43; // [10:100]

// Thickness of horizontal part in millimeters
Nut_Height_Padding = 2; // [0:10]

// Depth of nut, measured in the direction of the strings, in millimeters
Nut_Depth = 6; // [1:10]

// Angle of strings within nut
String_Angle = 20; // [0:60]

/* [String Widths] */
// Width of string #1 in millimeters
String_Width_1 = 1.25; // [0.1:10]

// Width of string #2 in millimeters
String_Width_2 = 1.15; // [0.1:10]

// Width of string #3 in millimeters
String_Width_3 = 0.85; // [0.1:10]

// Width of string #4 in millimeters
String_Width_4 = 0.60; // [0.1:10]

// Width of string #5 in millimeters
String_Width_5 = 0.45; // [0.1:10]

// Width of string #6 in millimeters
String_Width_6 = 0.40; // [0.1:10]

// Width of string #7 in millimeters
String_Width_7 = 0.35; // [0.1:10]

// Width of string #8 in millimeters
String_Width_8 = 0.30; // [0.1:10]

/* [Hidden] */
String_Spacing = (Nut_Width / String_Count);
String_Padding = String_Spacing / 2;

/*
	Guitar nut for acoustic guitar
*/

function GetStringWidth(i) =
	lookup
	(
		i,
		[
			[0, String_Width_1],
			[1, String_Width_2],
			[2, String_Width_3],
			[3, String_Width_4],
			[4, String_Width_5],
			[5, String_Width_6],
			[6, String_Width_7],
			[7, String_Width_8]
		]
	);

module MakeGaps()
{
	for (i = [0:(String_Count - 1)])
	{
		translate([4.5 + Nut_Height_Padding, String_Padding + (String_Spacing * i), (-0.75)])
			rotate([0, (-String_Angle), 0])
				union()
				{
					cylinder(h = (Nut_Depth + 4), d = GetStringWidth(i), $fn = 50);
					translate([5, 0, (Nut_Depth / 2) + 2])
						cube([10, GetStringWidth(i), (Nut_Depth + 4)],center = true);
				}
	}
}

module Main()
{
	difference()
	{
		// The base cube
		cube([6 + Nut_Height_Padding, Nut_Width, Nut_Depth]);

		// Cutting off the end in angle
		translate([2.5 + Nut_Height_Padding, (Nut_Width / 2), (Nut_Depth + 2.6)])
			rotate(a = [0, 10, 0])
				cube([9, Nut_Width + 1, 6], center = true);

		// Gaps for the strings
		MakeGaps();
	}
}

Main();
/* [Hidden] */
X=0;
Y=1;
Z=2;

/* [Main Settings] */
PrintType = 3; //[0: Test Size, 1: Test Size (Hollow), 2: MESH, 3: Features]

// Only used in Test Size(Hollow) and Mesh Prints
PrintMargin = 2;
// Only used on MeshPrints
MeshSizeX = 9.7;
MeshSizeY = 13.6;

// Size of the 'Hole' in the case
ioSize = [158.8, 44.5, 1.0];

// The ioShield Part INSIDE the Computer Case
Oversize = [2, 2, 0.6];

// Font for Texts
mainFont = "Courier New:style=Italic";
/* [Feature 1] */
f1Type = 1; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f1Position = [6, 1.5, 0];
// Size X - FontSize
f1_X = 2;
// Size Y - Text Height
f1_Y = 2;
// Diameter
f1_D = 12;
// Gap
f1_G = 2.7;
// Count
f1_C = 2;
// FN
f1_F = 300;
// Text
f1_T = "";

/* [Feature 2] */
f2Type = 3;  //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f2Position = [20, 1, 0];
// Size X
f2_X = 32;
// Size Y
f2_Y = 12;
// Diameter
f2_D = 6.5;
// Gap
f2_G = 2.2;
// Count
f2_C = 2;
// FN
f2_F = 300;
// Text
f2_T = "";

/* [Feature 3] */
f3Type = 3;  //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f3Position = [54.2, 0, 0];
// Size X
f3_X = 38;
// Size Y
f3_Y = 12;
// Diameter
f3_D = 6.5;
// Gap
f3_G = 2.2;
// Count
f3_C = 2;
// FN
f3_F = 300;
// Text
f3_T = "";

/* [Feature 4] */
f4Type = 2;  //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f4Position = [94.7, 2, 0];
// Size X
f4_X = 29;
// Size Y
f4_Y = 8.5;
// Diameter
f4_D = 6.5;
// Gap
f4_G = 0;
// Count
f4_C = 2;
// FN
f4_F = 300;
// Text
f4_T = "";

/* [Feature 5] */
f5Type = 2; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f5Position = [127, 2, 0];
// Size X
f5_X = 14.3;
// Size Y
f5_Y = 30;
// Diameter
f5_D = 6.5;
// Gap
f5_G = 0;
// Count
f5_C = 1;
// FN
f5_F = 300;
// Text
f5_T = "";

/* [Feature 6] */
f6Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f6Position = [127, 18.15, 0];
// Size X
f6_X = 14.3;
// Size Y
f6_Y = 14;
// Diameter
f6_D = 6.5;
// Gap
f6_G = 0;
// Count
f6_C = 1;
// FN
f6_F = 300;
// Text
f6_T = "";

/* [Feature 7] */
f7Type = 1; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f7Position = [147, 5, 0];
// Size X
f7_X = 0;
// Size Y
f7_Y = 0;
// Diameter
f7_D = 9;
// Gap
f7_G = 2.4;
// Count
f7_C = 3;
// FN
f7_F = 300;
// Text
f7_T = "";

/* [Feature 8] */
f8Type = 4; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f8Position = [30, 20, 0];
// Size X - FontSize
f8_X = 7;
// Size Y - Text Height
f8_Y = .2;
// Diameter
f8_D = 0;
// Gap
f8_G = 0;
// Count
f8_C = 1;
// FN 
f8_F = 300;
// Text
f8_T = "Asrock H61M-S";

/* [Feature 9] */
f9Type = 10; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text Engraving, 10: Text Over]
// X Position, Y Position
f9Position = [30, 30, 0];
// Size X - FontSize
f9_X = 7;
// Size Y - Text Height
f9_Y = .4;
// Diameter
f9_D = 0;
// Gap
f9_G = 0;
// Count
f9_C = 1;
// FN
f9_F = 300;
// Text
f9_T = "Asrock H61M-S";

/* [Feature 10] */
f10Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f10Position = [0, 0, 0];
// Size X
f10_X = 0;
// Size Y
f10_Y = 0;
// Diameter
f10_D = 0;
// Gap
f10_G = 0;
// Count
f10_C = 1;
// FN
f10_F = 300;
// Text
f10_T = "";

/* [Feature 11] */
f11Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f11Position = [0, 0, 0];
// Size X
f11_X = 0;
// Size Y
f11_Y = 0;
// Diameter
f11_D = 0;
// Gap
f11_G = 0;
// Count
f11_C = 1;
// FN
f11_F = 300;
// Text
f11_T = "";

/* [Feature 12] */
f12Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f12Position = [0, 0, 0];
// Size X
f12_X = 0;
// Size Y
f12_Y = 0;
// Diameter
f12_D = 0;
// Gap
f12_G = 0;
// Count
f12_C = 1;
// FN
f12_F = 300;
// Text
f12_T = "";

/* [Feature 13] */
f13Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f13Position = [0, 0, 0];
// Size X
f13_X = 0;
// Size Y
f13_Y = 0;
// Diameter
f13_D = 0;
// Gap
f13_G = 0;
// Count
f13_C = 1;
// FN
f13_F = 300;
// Text
f13_T = "";

/* [Feature 14] */
f14Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f14Position = [0, 0, 0];
// Size X
f14_X = 0;
// Size Y
f14_Y = 0;
// Diameter
f14_D = 0;
// Gap
f14_G = 0;
// Count
f14_C = 1;
// FN
f14_F = 300;
// Text
f14_T = "";

/* [Feature 15] */
f15Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f15Position = [0, 0, 0];
// Size X
f15_X = 0;
// Size Y
f15_Y = 0;
// Diameter
f15_D = 0;
// Gap
f15_G = 0;
// Count
f15_C = 1;
// FN
f15_F = 300;
// Text
f15_T = "";

/* [Feature 16] */
f16Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f16Position = [0, 0, 0];
// Size X
f16_X = 0;
// Size Y
f16_Y = 0;
// Diameter
f16_D = 0;
// Gap
f16_G = 0;
// Count
f16_C = 1;
// FN
f16_F = 300;
// Text
f16_T = "";

/* [Feature 17] */
f17Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f17Position = [0, 0, 0];
// Size X
f17_X = 0;
// Size Y
f17_Y = 0;
// Diameter
f17_D = 0;
// Gap
f17_G = 0;
// Count
f17_C = 1;
// FN
f17_F = 300;
// Text
f17_T = "";

/* [Feature 18] */
f18Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f18Position = [0, 0, 0];
// Size X
f18_X = 0;
// Size Y
f18_Y = 0;
// Diameter
f18_D = 0;
// Gap
f18_G = 0;
// Count
f18_C = 1;
// FN
f18_F = 300;
// Text
f18_T = "";

/* [Feature 19] */
f19Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f19Position = [0, 0, 0];
// Size X
f19_X = 0;
// Size Y
f19_Y = 0;
// Diameter
f19_D = 0;
// Gap
f19_G = 0;
// Count
f19_C = 1;
// FN
f19_F = 300;
// Text
f19_T = "";

/* [Feature 20] */
f20Type = 0; //[0: None, 1: Round, 2: Rectangle, 3: VGA, 4: Text]
// X Position, Y Position
f20Position = [0, 0, 0];
// Size X
f20_X = 0;
// Size Y
f20_Y = 0;
// Diameter
f20_D = 0;
// Gap
f20_G = 0;
// Count
f20_C = 1;
// FN
f20_F = 300;
// Text
f20_T = "";

// Calcs
FN = 300;
ioOversize = [ioSize[X] + (2 * Oversize[X]), ioSize[Y] + (2 * Oversize[Y]), Oversize[Z]];
bodyZ = ioSize[Z] + Oversize[Z];
bodyZ5 = bodyZ * 5;

// Reciviendo el $fn calcula el valor, multiplicado por el radio, para obtener un ajuste EXTERIOR 
function rAdjustE( pFN ) = 1/cos(180/pFN);


module ioRound(Pos=[0,0,0], Diameter = 6, Height = 6, Gap = 2, Fn = 100, Qt=1)
{
	Rad = Diameter / 2;
	translate(Pos)
		translate([Rad, Rad, 0])
			for(i = [1:Qt])
			{
				translate([0, (Diameter * (i - 1)) + (Gap * (i-1)), 0])
					cylinder(r = Rad * rAdjustE(Fn), h = Diameter, center = true, $fn = Fn);
			}
}

module ioVga(Pos=[0,0,0], XSize = 6, YSize = 6, Height = 6, Diameter = 6, Fn = 100)
{
	Rad = Diameter / 2;
	translate(Pos)
	{
		translate([Diameter, 0, -Height / 2])
			cube([XSize - (2 * Diameter), YSize, Height]);
		translate([Rad, YSize / 2 - Rad, 0])
			union()
			{
				translate([0, Rad, 0])
					cylinder(r=Rad * rAdjustE(Fn), h=Height, center=true, $fn=Fn);
				translate([0, 0, -Height / 2])
					cube(size=[XSize - Diameter, Diameter, Height], center=false);
				translate([XSize - Diameter, Rad, 0])
					cylinder(r=Rad * rAdjustE(Fn), h=Height, center=true, $fn=Fn);
			}
	}
}

module ioSquare(Pos=[0,0,0], XSize = 6, YSize = 6, Height = 6, Gap = 2, Qt=1)
{
	// Size[Lenght (X), Height(Y), Z, Gap]
	_X = 0;
	_Y = 1;
	_Z = 2;
	_Gap = 3;

	translate(Pos)
		translate([0, 0,-Height / 2])
			for(i = [1:Qt])
			{
				translate([0, YSize * (i - 1), 0])
					cube([XSize, YSize, Height]);
			}
}

module ioMainBase()
{
	union()
	{
		cube(ioSize);
		translate([-Oversize[0], -Oversize[1],-Oversize[2]])
			cube(ioOversize);
	}
}

module ExtrudeText(txText = "Test", txFontsize = 5, txFont = "Courier New:style=Italic", txHalign = "left", txValign="baseline", txDirection = "ltr", txSpacing = 1, txLanguage = "es", txScript = "latin", leHeight = 2, leCenter = false, leConvexity = 0, leTwist = 0)
{
	// txHalign= [left, right, center] Default: left
	// txValign= [top, center, baseline, bottom] Default: baseline
	// txDirection = [ltr, rtl, ttb, btt] Left-to-Right, Right-to-Left, Top-to-Bottom, Bottom-to-Top (Default: ltr)
	linear_extrude(height = leHeight, center = leCenter, convexity = leConvexity, twist = leConvexity)
	{
		text( text = txText, size = txFontsize, font = txFont, halign = txHalign, valign = txValign, txdirection = txDirection, spacing = txSpacing, language = txLanguage, script = txScript);
	}
}

module ioTextEngrave(Pos=[0,0,0], Text="Text", fontSize = 5, fontHeight = 1)
{
	translate([0, 0, ioSize[Z] - fontHeight +.01]) //The Text is engraved donw the Surface of the IOShield (+.01 only for better preview)
	translate(Pos)
		ExtrudeText(txText = Text, txFontsize = fontSize, txFont = mainFont, leHeight = fontHeight);
}

module ioTextAdd(Pos=[0,0,0], Text="Text", fontSize = 5, fontHeight = 1)
{
	translate([0, 0, ioSize[Z]])
	translate(Pos)
		ExtrudeText(txText = Text, txFontsize = fontSize, txFont = mainFont, leHeight = fontHeight);
}

module ioFeature(fType = 0, fPosition = [0,0], fX, fY, fD, fG, fC, fF, fT)
{
	if (fType == 1)
	{
		// Circle Type Feature
		ioRound(fPosition, fD, bodyZ5, fG, fF, fC);
	}
	if (fType == 2)
	{
		// Rectangle Type Feature
		ioSquare(fPosition, fX, fY, bodyZ5, fG, fC);
	}
	if (fType == 3)
	{
		// VGA Type Feature
		ioVga(fPosition, fX, fY, bodyZ5, fD, fF);
	}
	if (fType == 4)
	{
		// Text Engraving Feature
		ioTextEngrave(fPosition, fT, fX, fY);
	}
	if (fType == 10)
	{
		// Text ADD Feature
		ioTextAdd(fPosition, fT, fX, fY);
	}
}

union()
{
	difference()
	{
		ioMainBase();

		if(PrintType > 0)
		{
			if(PrintType == 1)
			{
				translate([PrintMargin / 2, PrintMargin / 2, -bodyZ5 / 2])
					cube([ioSize[X] - PrintMargin, ioSize[Y] - PrintMargin, bodyZ5]);
			}
			if(PrintType == 2)
			{
				meshX = MeshSizeX - PrintMargin;
				meshY = MeshSizeY - PrintMargin;

				// create a "Mesh"
				for(j=[0:(ioSize[Y] / MeshSizeY) - 1])
				{
					for(i=[0:(ioSize[X] / MeshSizeX) - 1])
					{
						translate([i * MeshSizeX + PrintMargin, j * MeshSizeY + PrintMargin, -bodyZ5 / 2])
							cube([meshX, meshY, bodyZ5]);
					}
				}
			}
			if(PrintType == 3)
			{
				// Features Print
				if (f1Type > 0 && f1Type < 10)
				{
					ioFeature(f1Type, f1Position, f1_X, f1_Y, f1_D, f1_G, f1_C, f1_F, f1_T);
				}
				if (f2Type > 0 && f2Type < 10)
				{
					ioFeature(f2Type, f2Position, f2_X, f2_Y, f2_D, f2_G, f2_C, f2_F, f2_T);
				}
				if (f3Type > 0 && f3Type < 10)
				{
					ioFeature(f3Type, f3Position, f3_X, f3_Y, f3_D, f3_G, f3_C, f3_F, f3_T);
				}
				if (f4Type > 0 && f4Type < 10)
				{
					ioFeature(f4Type, f4Position, f4_X, f4_Y, f4_D, f4_G, f4_C, f4_F, f4_T);
				}
				if (f5Type > 0 && f5Type < 10)
				{
					ioFeature(f5Type, f5Position, f5_X, f5_Y, f5_D, f5_G, f5_C, f5_F, f5_T);
				}
				if (f6Type > 0 && f6Type < 10)
				{
					ioFeature(f6Type, f6Position, f6_X, f6_Y, f6_D, f6_G, f6_C, f6_F, f6_T);
				}
				if (f7Type > 0 && f7Type < 10)
				{
					ioFeature(f7Type, f7Position, f7_X, f7_Y, f7_D, f7_G, f7_C, f7_F, f7_T);
				}
				if (f8Type > 0 && f8Type < 10)
				{
					ioFeature(f8Type, f8Position, f8_X, f8_Y, f8_D, f8_G, f8_C, f8_F, f8_T);
				}
				if (f9Type > 0 && f9Type < 10)
				{
					ioFeature(f9Type, f9Position, f9_X, f9_Y, f9_D, f9_G, f9_C, f9_F, f9_T);
				}
				if (f10Type > 0 && f10Type < 10)
				{
					ioFeature(f10Type, f10Position, f10_X, f10_Y, f10_D, f10_G, f10_C, f10_F, f10_T);
				}
				if (f11Type > 0 && f11Type < 10)
				{
					ioFeature(f11Type, f11Position, f11_X, f11_Y, f11_D, f11_G, f11_C, f11_F, f11_T);
				}
				if (f12Type > 0 && f12Type < 10)
				{
					ioFeature(f12Type, f12Position, f12_X, f12_Y, f12_D, f12_G, f12_C, f12_F, f12_T);
				}
				if (f13Type > 0 && f13Type < 10)
				{
					ioFeature(f13Type, f13Position, f13_X, f13_Y, f13_D, f13_G, f13_C, f13_F, f13_T);
				}
				if (f14Type > 0 && f14Type < 10)
				{
					ioFeature(f14Type, f14Position, f14_X, f14_Y, f14_D, f14_G, f14_C, f14_F, f14_T);
				}
				if (f15Type > 0 && f15Type < 10)
				{
					ioFeature(f15Type, f15Position, f15_X, f15_Y, f15_D, f15_G, f15_C, f15_F, f15_T);
				}
				if (f16Type > 0 && f16Type < 10)
				{
					ioFeature(f16Type, f16Position, f16_X, f16_Y, f16_D, f16_G, f16_C, f16_F, f16_T);
				}
				if (f17Type > 0 && f17Type < 10)
				{
					ioFeature(f17Type, f17Position, f17_X, f17_Y, f17_D, f17_G, f17_C, f17_F, f17_T);
				}
				if (f18Type > 0 && f18Type < 10)
				{
					ioFeature(f18Type, f18Position, f18_X, f18_Y, f18_D, f18_G, f18_C, f18_F, f18_T);
				}
				if (f19Type > 0 && f19Type < 10)
				{
					ioFeature(f19Type, f19Position, f19_X, f19_Y, f19_D, f19_G, f19_C, f19_F, f19_T);
				}
				if (f20Type > 0 && f20Type < 10)
				{
					ioFeature(f20Type, f20Position, f20_X, f20_Y, f20_D, f20_G, f20_C, f20_F, f20_T);
				}
			}
		}
		// Else is a test size print, nothing to Difference
	}

	// For FeatureType >= 10, The feature is ADD to the ioShield only if the printType == 3
	if(PrintType == 3)
	{
		// Features Print
		if (f1Type > 0 && f1Type >= 10)
		{
			ioFeature(f1Type, f1Position, f1_X, f1_Y, f1_D, f1_G, f1_C, f1_F, f1_T);
		}
		if (f2Type > 0 && f2Type >= 10)
		{
			ioFeature(f2Type, f2Position, f2_X, f2_Y, f2_D, f2_G, f2_C, f2_F, f2_T);
		}
		if (f3Type > 0 && f3Type >= 10)
		{
			ioFeature(f3Type, f3Position, f3_X, f3_Y, f3_D, f3_G, f3_C, f3_F, f3_T);
		}
		if (f4Type > 0 && f4Type >= 10)
		{
			ioFeature(f4Type, f4Position, f4_X, f4_Y, f4_D, f4_G, f4_C, f4_F, f4_T);
		}
		if (f5Type > 0 && f5Type >= 10)
		{
			ioFeature(f5Type, f5Position, f5_X, f5_Y, f5_D, f5_G, f5_C, f5_F, f5_T);
		}
		if (f6Type > 0 && f6Type >= 10)
		{
			ioFeature(f6Type, f6Position, f6_X, f6_Y, f6_D, f6_G, f6_C, f6_F, f6_T);
		}
		if (f7Type > 0 && f7Type >= 10)
		{
			ioFeature(f7Type, f7Position, f7_X, f7_Y, f7_D, f7_G, f7_C, f7_F, f7_T);
		}
		if (f8Type > 0 && f8Type >= 10)
		{
			ioFeature(f8Type, f8Position, f8_X, f8_Y, f8_D, f8_G, f8_C, f8_F, f8_T);
		}
		if (f9Type > 0 && f9Type >= 10)
		{
			ioFeature(f9Type, f9Position, f9_X, f9_Y, f9_D, f9_G, f9_C, f9_F, f9_T);
		}
		if (f10Type > 0 && f10Type >= 10)
		{
			ioFeature(f10Type, f10Position, f10_X, f10_Y, f10_D, f10_G, f10_C, f10_F, f10_T);
		}
		if (f11Type > 0 && f11Type >= 10)
		{
			ioFeature(f11Type, f11Position, f11_X, f11_Y, f11_D, f11_G, f11_C, f11_F, f11_T);
		}
		if (f12Type > 0 && f12Type >= 10)
		{
			ioFeature(f12Type, f12Position, f12_X, f12_Y, f12_D, f12_G, f12_C, f12_F, f12_T);
		}
		if (f13Type > 0 && f13Type >= 10)
		{
			ioFeature(f13Type, f13Position, f13_X, f13_Y, f13_D, f13_G, f13_C, f13_F, f13_T);
		}
		if (f14Type > 0 && f14Type >= 10)
		{
			ioFeature(f14Type, f14Position, f14_X, f14_Y, f14_D, f14_G, f14_C, f14_F, f14_T);
		}
		if (f15Type > 0 && f15Type >= 10)
		{
			ioFeature(f15Type, f15Position, f15_X, f15_Y, f15_D, f15_G, f15_C, f15_F, f15_T);
		}
		if (f16Type > 0 && f16Type >= 10)
		{
			ioFeature(f16Type, f16Position, f16_X, f16_Y, f16_D, f16_G, f16_C, f16_F, f16_T);
		}
		if (f17Type > 0 && f17Type >= 10)
		{
			ioFeature(f17Type, f17Position, f17_X, f17_Y, f17_D, f17_G, f17_C, f17_F, f17_T);
		}
		if (f18Type > 0 && f18Type >= 10)
		{
			ioFeature(f18Type, f18Position, f18_X, f18_Y, f18_D, f18_G, f18_C, f18_F, f18_T);
		}
		if (f19Type > 0 && f19Type >= 10)
		{
			ioFeature(f19Type, f19Position, f19_X, f19_Y, f19_D, f19_G, f19_C, f19_F, f19_T);
		}
		if (f20Type > 0 && f20Type >= 10)
		{
			ioFeature(f20Type, f20Position, f20_X, f20_Y, f20_D, f20_G, f20_C, f20_F, f20_T);
		}
	}
}

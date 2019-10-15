// Card Holder

// Card Length
CardLength = 90;

// Card Width
CardWidth = 58;

// Tolerance
Tolerance = 2;

// Size Of Nozzle
SizeOfNozzle = 0.4;

// Outside Skirt
OutsideSkirt = 5;

//Wall Thickness In Layers
WallThicknessInLayers = 3;

//Wall Height
WallHeight = 27;

//Wall Length
WallLength = 10;

//BottomThickness
BottomThickness = 1.6;

//Cut Out Percentage
CutOutPercentage = 80;



WallThickness = WallThicknessInLayers * SizeOfNozzle;
Rim = CardWidth * ((100 - CutOutPercentage) / 2) / 100;
CutOutLength = (CardLength - 3 * Rim) / 2;
CutOutWidth = CardWidth * CutOutPercentage / 100;


// Bottom Layer
difference(){
	translate([	0 - Tolerance - OutsideSkirt,
					0 - Tolerance - OutsideSkirt,
					0])
	cube(size = [	CardLength + 2 * (Tolerance + OutsideSkirt),
						CardWidth + 2 * (Tolerance + OutsideSkirt),
						BottomThickness]);

	// Cut Out
	translate([	0 + Rim,0 + Rim,0])
	cube(size = [	CutOutLength,
						CutOutWidth,
						BottomThickness]);

	translate([	0 + 2 * Rim + CutOutLength,0 + Rim,0])
	cube(size = [	CutOutLength,
						CutOutWidth,
						BottomThickness]);

}


// Walls(LL)

	translate([	0 - Tolerance - WallThickness,
					0 - Tolerance - WallThickness,
				   BottomThickness])
	cube(size = [	WallThickness,
						WallThickness + WallLength,
						WallHeight]);

	translate([	0 - Tolerance - WallThickness,
					0 - Tolerance - WallThickness,
				   BottomThickness])
	cube(size = [	WallThickness + WallLength,
						WallThickness,
						WallHeight]);


// Walls(UL)

	translate([	0 - Tolerance - WallThickness,
					CardWidth + Tolerance - WallLength,
				   BottomThickness])
	cube(size = [	WallThickness,
						WallThickness + WallLength,
						WallHeight]);

	translate([	0 - Tolerance - WallThickness,
					CardWidth + Tolerance,
				   BottomThickness])
	cube(size = [	WallThickness + WallLength,
						WallThickness,
						WallHeight]);

// Walls(LR)

	translate([	CardLength + Tolerance - WallLength,
					0 - Tolerance - WallThickness,
				   BottomThickness])
	cube(size = [	WallThickness + WallLength,
						WallThickness,
						WallHeight]);

	translate([	CardLength + Tolerance,
					0 - Tolerance - WallThickness,
				   BottomThickness])
	cube(size = [	WallThickness,
						WallThickness + WallLength,
						WallHeight]);

// Walls(UR)

	translate([	CardLength + Tolerance - WallLength,
					CardWidth + Tolerance,
				   BottomThickness])
	cube(size = [	WallThickness + WallLength,
						WallThickness,
						WallHeight]);

	translate([	CardLength + Tolerance,
					CardWidth + Tolerance - WallLength,
				   BottomThickness])
	cube(size = [	WallThickness,
						WallThickness + WallLength,
						WallHeight]);






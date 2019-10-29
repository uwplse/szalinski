// Card Holder

// Card Length
CardLength = 63;

// Card Width
CardWidth = 41;

// Tolerance
Tolerance = 1;

// Size Of Nozzle
SizeOfNozzle = 0.4;

// Outside Skirt
OutsideSkirt = 2;

// Wall Thickness In Layers
WallThicknessInLayers = 3;

// Wall Height
WallHeight = 53;

// Wall Length
WallLength = 13;

// BottomThickness
BottomThickness = 2;

// Cut Out Percentage
CutOutPercentage = 80;

// Length Support
SupportHeight = 20;
HoleRadiusChange = 0.5;
HoleOffset = 4.5;

// Width Support (change Length Support first!)
WidthRadiusChange = 0.67; // percentage as a fraction
WidthOffset = -4.5;
WidthHeightChange = -7;



WallThickness = WallThicknessInLayers * SizeOfNozzle;
Rim = CardWidth * ((100 - CutOutPercentage) / 2) / 100;
CutOutLength = (CardLength - 3 * Rim) / 2;
CutOutWidth = CardWidth * CutOutPercentage / 100;
HoleRadius = (CardLength - 2 * WallLength + 2* Tolerance)/2 + HoleRadiusChange;
WidthRatio = CardWidth/CardLength;



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
                        
 // Width Support

    difference() {    
        translate([	CardLength + Tolerance, WallLength - Tolerance, BottomThickness]) cube(size = [WallThickness, CardWidth+2*Tolerance-2*WallLength, SupportHeight+WidthHeightChange]);
        translate([CardLength + Tolerance, (CardWidth)/2, (SupportHeight*WidthRatio+BottomThickness+HoleOffset)+WidthOffset]) rotate([0, 90, 0]) cylinder($fn=50, WallThickness, HoleRadius*WidthRatio*WidthRadiusChange, HoleRadius*WidthRatio*WidthRadiusChange, false);
    }
    
    difference() {    
        translate([	0 - WallThickness - Tolerance, WallLength - Tolerance, BottomThickness]) cube(size = [WallThickness, CardWidth+2*Tolerance-2*WallLength, SupportHeight+WidthHeightChange]);
        translate([0 - WallThickness - Tolerance, (CardWidth)/2, (SupportHeight*WidthRatio+BottomThickness+HoleOffset)+WidthOffset]) rotate([0, 90, 0]) cylinder($fn=50, WallThickness, HoleRadius*WidthRatio*WidthRadiusChange, HoleRadius*WidthRatio*WidthRadiusChange, false);
    }
                        
// Length Support
    
    difference() {    
        translate([	WallLength - Tolerance, 0 - Tolerance - WallThickness, BottomThickness]) cube(size = [CardLength - 2 * WallLength + 2* Tolerance, WallThickness, SupportHeight]);
        translate([CardLength/2, 0-Tolerance, SupportHeight+BottomThickness+HoleOffset]) rotate([90, 0, 0]) cylinder($fn=50, WallThickness, HoleRadius, HoleRadius, false);
    }
    
    difference() {    
        translate([	WallLength - Tolerance, CardWidth+Tolerance, BottomThickness]) cube(size = [CardLength - 2 * WallLength + 2* Tolerance, WallThickness, SupportHeight]);
        translate([CardLength/2, CardWidth+Tolerance+WallThickness, SupportHeight+BottomThickness+HoleOffset]) rotate([90, 0, 0]) cylinder($fn=50, WallThickness, HoleRadius, HoleRadius, false);
    }

//design and code by bioprint (http://www.thingiverse.com/bioprint)
//This code generates a holder for Microfluidics Chamber (customizable)
// 2015-01-16:	first design



// Size of nozzle
SizeOfNozzle = 0.4; // size of nozzle
// Endholder Width
EndholderWidth = 54; // 54 mm for Nikon Ti holder
// Endholder Lip
EndholderLip = 10; // 3 mm

// Objective Diameter
ObjectiveDiameter = 34; // 34 mm
// Objective Center X
ObjectiveCenterX = 42; // 42 mm
// Objective Center Y
ObjectiveCenterY = 33; // 33 mm
// Objective Rim
ObjectiveRim = 3; // 3 mm

// Bottom thickness measured in layers
BottomThicknessInLayers = 4; // number of layers
// Wall thickness measured in layers
WallThicknessInLayers = 4; // number of layers
// Inner Skirt Width
InnerSkirtWidth = 3; // 3 mm

// Outer Skirt Width
OuterSkirtWidth = 2; // 2 mm

// Wall Height
WallHeight = 13; // 10 mm
// NotchSize
NotchSize = 3; // 3 mm
// Inner Width
InnerWidth = 50; // 50 mm
// Inner Length
InnerLength = 72; // 72 mm


// NotchDistance
NotchDistance = 8; // 8 mm

// LidTolerance
LidTolerance = 0.5; // 1 mm
// Lid Height
LidHeight = 8; // 8 mm


WallThicknessInMM = WallThicknessInLayers*SizeOfNozzle;

//OuterSkirtWidth = MaximumWidth - 2*WallThicknessInMM - InnerWidth;

BottomThicknessInLayersInMM = BottomThicknessInLayers*SizeOfNozzle;
// this arrangement barely fits the 150 mm build table
// LidXOffset = InnerLength + 2*WallThicknessInMM + OuterSkirtWidth + InnerSkirtWidth; 

LidXOffset = 0;
LidYOffset = InnerWidth + 2*WallThicknessInMM + OuterSkirtWidth + InnerSkirtWidth; 

// cylinder(h = 10, r=20, $fn=100);



// bottom layer
difference(){
	translate([-1*WallThicknessInMM,-1*WallThicknessInMM,0]) 
		cube(size = [InnerLength + WallThicknessInMM * 2,
						InnerWidth + WallThicknessInMM * 2,
						WallHeight], center = false);
	translate([0,0,0]) 
		cube(size = [InnerLength,
						InnerWidth,
						WallHeight], center = false);
	// notches
//	for ( c = [NotchDistance/2 : NotchDistance : InnerLength - NotchDistance/2] )
//	{
//		translate([c,
//						-1*WallThicknessInMM,
//						0]) 
//		cube(size = [NotchDistance/2,
//						WallThicknessInMM+2,
//						WallHeight], center = false);
//
//	}

	for ( c = [NotchSize : NotchDistance : InnerLength-NotchSize] )
	{
		translate([c,
						-1*WallThicknessInMM,
						WallHeight-NotchSize]) 
		cube(size = [NotchSize,
						 InnerWidth+3*WallThicknessInMM,
						 NotchSize], center = false);

	}

	for ( c = [NotchSize : NotchDistance : InnerWidth-NotchSize] )
	{
		translate([-1*WallThicknessInMM,
						c,
						WallHeight-NotchSize]) 
		cube(size = [InnerLength+3*WallThicknessInMM,
							NotchSize,
						 	NotchSize], center = false);

	}
// cut cylinder
	translate([ObjectiveCenterX, ObjectiveCenterY, -1*BottomThicknessInLayersInMM])
		cylinder(h = BottomThicknessInLayersInMM + WallHeight, r=ObjectiveDiameter/2, $fn=10);

}

// skirts
//BottomThicknessInLayersInMM  InnerSkirtWidth OuterSkirtWidth
difference(){
	translate([-1*WallThicknessInMM-OuterSkirtWidth,
					-1*WallThicknessInMM-OuterSkirtWidth,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [InnerLength + (WallThicknessInMM+OuterSkirtWidth) * 2,
						InnerWidth + (WallThicknessInMM+OuterSkirtWidth) * 2,
						BottomThicknessInLayersInMM], center = false);

	translate([	0,
				  	0,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [InnerLength,
						InnerWidth,
						BottomThicknessInLayersInMM], center = false);


// cut cylinder
	translate([ObjectiveCenterX, ObjectiveCenterY, -1*BottomThicknessInLayersInMM])
		cylinder(h = BottomThicknessInLayersInMM + WallHeight, r=ObjectiveDiameter/2, $fn=10);

}

// end holders
	// holders on sides (Nikon C2)

//EndholderWidth = 54; // 54 mm for Nikon Ti holder
// Endholder Lip
//EndholderLip = 10; // 3 mm

	translate([-1*WallThicknessInMM-OuterSkirtWidth + InnerLength + (WallThicknessInMM+OuterSkirtWidth) * 2,
					-1*WallThicknessInMM-OuterSkirtWidth + (InnerWidth + (WallThicknessInMM+OuterSkirtWidth) * 2)/2 - EndholderWidth/2,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [EndholderLip,
						 EndholderWidth,
						 BottomThicknessInLayersInMM], center = false);


	translate([-1*WallThicknessInMM-OuterSkirtWidth - EndholderLip,
					-1*WallThicknessInMM-OuterSkirtWidth + (InnerWidth + (WallThicknessInMM+OuterSkirtWidth) * 2)/2 - EndholderWidth/2,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [EndholderLip,
						 EndholderWidth,
						 BottomThicknessInLayersInMM], center = false);

// inner lip

difference(){
	translate([-1*WallThicknessInMM,
					-1*WallThicknessInMM,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [InnerLength + (WallThicknessInMM) * 2,
						InnerWidth + (WallThicknessInMM) * 2,
						BottomThicknessInLayersInMM], center = false);

	translate([	InnerSkirtWidth,
				  	InnerSkirtWidth,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [InnerLength-2*InnerSkirtWidth,
						InnerWidth-2*InnerSkirtWidth,
						BottomThicknessInLayersInMM], center = false);

// cut cylinder
	translate([ObjectiveCenterX, ObjectiveCenterY, -1*BottomThicknessInLayersInMM])
		cylinder(h = BottomThicknessInLayersInMM + WallHeight, r=ObjectiveDiameter/2, $fn=100);

}




// Lid
// LidXOffset LidTolerance LidHeight


difference(){
	translate([LidXOffset-2*WallThicknessInMM -LidTolerance/2 , 
				  LidYOffset -2*WallThicknessInMM -LidTolerance/2,0]) 
		cube(size = [InnerLength + WallThicknessInMM * 4 + LidTolerance,
						InnerWidth + WallThicknessInMM * 4 + LidTolerance,
						LidHeight], center = false);
	translate([LidXOffset-WallThicknessInMM -LidTolerance/2 ,
				  LidYOffset-WallThicknessInMM -LidTolerance/2,0]) 
		cube(size = [InnerLength + LidTolerance + 2*WallThicknessInMM,
						InnerWidth + LidTolerance + 2*WallThicknessInMM,
						LidHeight], center = false);

	for ( c = [NotchSize : NotchDistance : InnerLength-NotchSize] )
	{
		translate([c + LidXOffset,
						LidYOffset -2*WallThicknessInMM -LidTolerance/2,
						0])  //LidHeight-NotchSize]
		cube(size = [NotchSize,
						 InnerWidth+4*WallThicknessInMM+LidTolerance,
						 LidHeight], center = false); //NotchSize

	}

	// has to be symmetric
	for ( c = [InnerWidth- NotchSize - 2*WallThicknessInMM - LidTolerance/2  : -1*NotchDistance : NotchSize] )
	{
		translate([-2*WallThicknessInMM-LidTolerance/2 + LidXOffset,
						c + LidYOffset,
						0]) //
		cube(size = [InnerLength+4*WallThicknessInMM+LidTolerance,
							NotchSize,
						 	LidHeight], center = false);

	}


}




difference(){

	translate([LidXOffset-2*WallThicknessInMM -LidTolerance/2 ,
					LidYOffset-2*WallThicknessInMM -LidTolerance/2,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [InnerLength + WallThicknessInMM * 4 + LidTolerance,
						InnerWidth + WallThicknessInMM * 4 + LidTolerance,
						BottomThicknessInLayersInMM], center = false);


	translate([LidXOffset-2*WallThicknessInMM -LidTolerance/2 + InnerSkirtWidth ,
					LidYOffset-2*WallThicknessInMM -LidTolerance/2 + InnerSkirtWidth,
					-1*BottomThicknessInLayersInMM]) 
		cube(size = [InnerLength + WallThicknessInMM * 4 + LidTolerance - 2*InnerSkirtWidth,
						InnerWidth + WallThicknessInMM * 4 + LidTolerance - 2* InnerSkirtWidth,
						BottomThicknessInLayersInMM], center = false);
}






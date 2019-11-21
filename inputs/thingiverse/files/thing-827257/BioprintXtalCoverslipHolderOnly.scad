//design and code by bioprint (http://www.thingiverse.com/bioprint)
//This code generates a holder for coverslip holder at SBC (customizable)
// 2015-02-02:	first design



// Size of nozzle
SizeOfNozzle = 0.4; // size of nozzle
// Bottom thickness
BottomThickness = 1; // 1 mm
// Wall thickness measured in layers
WallThicknessInLayers = 3; // number of layers (originally 2)
// Inner Skirt Width
InnerSkirtWidth = 2; // 2 mm

// Chamber Height
ChamberHeight = 0.6; // 0.6 mm (2 layers); Slicer: Z-layer: 0.3mm (first layer 0.4mm)
// ChamberWidth
ChamberWidth = 23.5; // 23 mm
// ChamberLength
ChamberLength = 23.5; // 23 mm


// Lid Tolerance
LidTolerance = 0.3; // 0.2 mm


// Round Holder Diameter
RoundHolderDiameter = 7; // 6 mm

// Round Holder Length
RoundHolderLength = 4; // 8 mm


// Washer Diameter
WasherDiameter = 13; // 1/2" 
// Washer Thickness
WasherThickness = 0.75; // 1.5 mm

// Holder Opening
HolderOpening = 10; // 9 mm

// Holder Wall Thickness In Layers
HolderWallThicknessInLayers = 4; // 3 

// HolderHeight
HolderHeight = WasherDiameter/2; // 


// BuildWidth
BuildWidth = 140; // 140 mm
// BuildLength
BuildLength = 140; // 140 mm
// Enable Multiple Device Printing
EnableMultipleDevicePrinting = 1;




WallThicknessInMM = WallThicknessInLayers*SizeOfNozzle;


LidXOffset = 0;
LidYOffset = ChamberLength + 2*WallThicknessInMM + InnerSkirtWidth; 

TopXOffset = 0;
TopYOffset = ChamberLength + 2*WallThicknessInMM + InnerSkirtWidth; 

// Holder Yoffset
HolderYOffset = ChamberLength/2;
HolderWallThicknessInLayersInMM = HolderWallThicknessInLayers * SizeOfNozzle;
HolderInsideColumn = WasherDiameter/2-2*LidTolerance;


// for multiplexing
XOffset = 0;
YOffset = 0;



MaxX = 0;
MaxY = 0;




		// bottom layer
		difference(){
			translate([XOffset-2*WallThicknessInMM - LidTolerance,-1*WallThicknessInMM,0]) 
				cube(size = [ChamberWidth + WallThicknessInMM * 4 + 2*LidTolerance,
								ChamberLength + WallThicknessInMM,
								BottomThickness + ChamberHeight-LidTolerance], center = false); // snaps better
			translate([XOffset-1*WallThicknessInMM - LidTolerance,0,BottomThickness]) 
				cube(size = [ChamberWidth + 2*WallThicknessInMM + 2*LidTolerance,
								ChamberLength+WallThicknessInMM * 2,
								ChamberHeight], center = false);
		
			translate([XOffset+InnerSkirtWidth,InnerSkirtWidth,0]) 
				cube(size = [ChamberWidth-2*InnerSkirtWidth,
								ChamberLength-2*InnerSkirtWidth,
								BottomThickness], center = false);
		
		}
		
		
		
		
		// top layer
		difference(){
			translate([XOffset-3*WallThicknessInMM-2*LidTolerance,
						  TopYOffset-2*WallThicknessInMM-LidTolerance,0]) 
				cube(size = [ChamberWidth + WallThicknessInMM * 6 + LidTolerance * 4,
								ChamberLength + WallThicknessInMM * 3 + LidTolerance * 2,
								BottomThickness + ChamberHeight + BottomThickness], center = false);
		
			translate([XOffset-2*WallThicknessInMM - LidTolerance,TopYOffset - WallThicknessInMM,BottomThickness+ChamberHeight]) 
				cube(size = [ChamberWidth+4*WallThicknessInMM+2*LidTolerance,
								ChamberLength+WallThicknessInMM,
								BottomThickness], center = false);
		
			translate([XOffset,TopYOffset - WallThicknessInMM,BottomThickness]) 
				cube(size = [ChamberWidth,
								ChamberLength+4*WallThicknessInMM,
								ChamberHeight+2*BottomThickness], center = false);
		
			translate([XOffset,TopYOffset - WallThicknessInMM,BottomThickness]) 
				cube(size = [ChamberWidth,
								ChamberLength+4*WallThicknessInMM,
								ChamberHeight+2*BottomThickness], center = false);
		
			translate([XOffset-2*WallThicknessInMM - LidTolerance,TopYOffset - WallThicknessInMM,BottomThickness]) 
				cube(size = [ChamberWidth+4*WallThicknessInMM+2*LidTolerance,
								WallThicknessInMM+2*LidTolerance,
								ChamberHeight+2*BottomThickness], center = false);
		
		
			translate([XOffset-2*WallThicknessInMM - LidTolerance,TopYOffset - WallThicknessInMM,BottomThickness]) 
				cube(size = [WallThicknessInMM+2*LidTolerance,			
								ChamberLength+WallThicknessInMM+LidTolerance,
								ChamberHeight+2*BottomThickness], center = false);
		
			translate([XOffset+ChamberWidth + WallThicknessInMM - LidTolerance,TopYOffset - WallThicknessInMM,BottomThickness]) 
				cube(size = [WallThicknessInMM+2*LidTolerance,			
								ChamberLength+WallThicknessInMM+LidTolerance,
								ChamberHeight+2*BottomThickness], center = false);
		
		// top opening
			translate([XOffset+InnerSkirtWidth,InnerSkirtWidth + TopYOffset,0]) 
				cube(size = [ChamberWidth-2*InnerSkirtWidth,
								ChamberLength-2*InnerSkirtWidth,
								ChamberHeight+2*BottomThickness], center = false);
		
		
		
		
		}
		


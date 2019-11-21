//design and code by bioprint (http://www.thingiverse.com/bioprint)
//This code generates a holder for PicoSquito(TM) (customizable)
// 2014-10-12:	first design



// Number of rows
NumRows=8; //8 for 96-well plate
// Number of columns
NumCols = 1; // 12 for 96-well plate
// Wall thickness
WallThickness = 0.4; // use nozzle size
// Well inner diameter
WellDiameter = 6.86; //http://catalog2.corning.com/lifesciences/media/equipment_compatibility/MD_Microplate_Dimension_sheets.htm
// Well depth
WellDepth = 10.67;
// Well center spacing
WellCenterSpacing = 9;
// Well bottom thickness
WellBottomThickness=1.5*WallThickness;


// Size of nozzle
SizeOfNozzle = 0.4; // size of nozzle
// Bottom thickness
BottomThickness = 6; // number of layers
// Bottom layer lip
BottomLayerLip = 5; // 100 mmm
////http://catalog2.corning.com/lifesciences/media/equipment_compatibility/MD_Microplate_Dimension_sheets.htm
// Plate X
PlateX = 129; // 128 mm
// Plate Y
PlateY = 87; // 86 mm
// Plate Z
PlateZ = 16; // 16 mm
// Plate wall thickness
PlateWallThickness = 2; // 2 mm
// Plate outer skirt height
PlateOuterSkirtHeight = 4; // 4 mm
// Plate outer skirt cutout
PlateOuterSkirtCutout = 0.8; // 80 percent
// Plate elevation pad
PlateElevationPad = 5; // 3 mm

// PCR strip Z
PcrStripZ = 22; // 20 mm
// PCR strip top diameter
PcrStripTopDiameter = 6.5; // 6 mm
// PCR strip bottom diameter
PcrStripBottomDiameter = 4; // 3 mm
// PCR strip wall thickness
PcrStripWallThickness = 1; // 1 nozzle
// PCR strip max height
PcrStripMaxHeigth = 14; // 14 mm
// PCR strip offset
PcrStripOffset = 2; // 16 mm


MaxHeight = (PcrStripZ > PlateZ) ? PcrStripZ : PlateZ;
HeightDifference = (PcrStripZ > PlateZ) ? PcrStripZ -  PlateZ: PlateZ - PcrStripZ;

PcrStripYOffset = (PlateY - (NumRows-1)*WellCenterSpacing)/2 + BottomLayerLip;



// bottom layer
difference(){
	translate([0,0,0]) 
		cube(size = [	PlateX+2*BottomLayerLip,
						PlateY+2*BottomLayerLip,
						BottomThickness*SizeOfNozzle], center = false);
	translate([BottomLayerLip,BottomLayerLip,0]) 
		cube(size = [	PlateX,
						PlateY,
						BottomThickness*SizeOfNozzle], center = false);

}


// right
difference(){

	translate([PlateX+BottomLayerLip,BottomLayerLip-PlateWallThickness,BottomThickness*SizeOfNozzle])
		cube(size = [	PlateWallThickness,
						PlateY+2*PlateWallThickness,
						PlateOuterSkirtHeight+HeightDifference], center = false);

	translate([	PlateX+BottomLayerLip,
				BottomLayerLip-PlateWallThickness + (1-PlateOuterSkirtCutout)/2*PlateY,
				BottomThickness*SizeOfNozzle+HeightDifference])
		cube(size = [	PlateWallThickness,
						(PlateY+2*PlateWallThickness)*PlateOuterSkirtCutout,
						PlateOuterSkirtHeight+HeightDifference], center = false);
}

// left

difference(){

	translate([BottomLayerLip-PlateWallThickness,BottomLayerLip-PlateWallThickness,BottomThickness*SizeOfNozzle])
		cube(size = [	PlateWallThickness,
						PlateY+2*PlateWallThickness,
						PlateOuterSkirtHeight+HeightDifference], center = false);
	translate([	BottomLayerLip-PlateWallThickness,
				BottomLayerLip-PlateWallThickness+ (1-PlateOuterSkirtCutout)/2*PlateY,
				BottomThickness*SizeOfNozzle+HeightDifference])
		cube(size = [	PlateWallThickness,
						(PlateY+2*PlateWallThickness)*PlateOuterSkirtCutout,
						PlateOuterSkirtHeight+HeightDifference], center = false);

}



// bottom
difference(){
	translate([BottomLayerLip,BottomLayerLip-PlateWallThickness,BottomThickness*SizeOfNozzle])
		cube(size = [	PlateX,
						PlateWallThickness,
						PlateOuterSkirtHeight+HeightDifference], center = false);

	translate([	BottomLayerLip+(1-PlateOuterSkirtCutout)/2*PlateX,
				BottomLayerLip-PlateWallThickness,
				BottomThickness*SizeOfNozzle+HeightDifference])
		cube(size = [	PlateX*PlateOuterSkirtCutout,
						PlateWallThickness,
						PlateOuterSkirtHeight+HeightDifference], center = false);

}


// top

difference(){
	translate([BottomLayerLip,BottomLayerLip+PlateY,BottomThickness*SizeOfNozzle])
		cube(size = [	PlateX,
						PlateWallThickness,
						PlateOuterSkirtHeight+HeightDifference], center = false);

	translate([	BottomLayerLip+(1-PlateOuterSkirtCutout)/2*PlateX,
				BottomLayerLip+PlateY,
				BottomThickness*SizeOfNozzle+HeightDifference])
		cube(size = [	PlateX*PlateOuterSkirtCutout,
						PlateWallThickness,
						PlateOuterSkirtHeight+HeightDifference], center = false);
}

// elevation pads (4 corners)
	translate([BottomLayerLip,BottomLayerLip,0])
		cube(size = [	PlateElevationPad,
						PlateElevationPad,
						HeightDifference], center = false);

	translate([BottomLayerLip+PlateX-PlateElevationPad,BottomLayerLip,0])
		cube(size = [	PlateElevationPad,
						PlateElevationPad,
						HeightDifference], center = false);

	translate([BottomLayerLip,BottomLayerLip+PlateY-PlateElevationPad,0])
		cube(size = [	PlateElevationPad,
						PlateElevationPad,
						HeightDifference], center = false);

	translate([BottomLayerLip+PlateX-PlateElevationPad,BottomLayerLip+PlateY-PlateElevationPad,0])
		cube(size = [	PlateElevationPad,
						PlateElevationPad,
						HeightDifference], center = false);

// PCR strip bottom layer (with holes)

difference(){
	translate([0-PcrStripOffset-BottomLayerLip-(NumCols-1)*WellCenterSpacing,0,0]) 
		cube(size = [	PcrStripOffset+BottomLayerLip+(NumCols-1)*WellCenterSpacing,
						PlateY+2*BottomLayerLip,
						BottomThickness*SizeOfNozzle], center = false);

	for ( c = [0 : 1 : NumCols - 1] )
	{
		for ( r = [0 : 1 : NumRows - 1] )
		{
			// holes

    			translate([	0 - c*WellCenterSpacing - PcrStripOffset, 
						r*WellCenterSpacing + PcrStripYOffset, 
						0])
    				cylinder (	h = BottomThickness*SizeOfNozzle, 
							r=PcrStripBottomDiameter/2, 
							center = false, $fn=40); //

		}
	}


}


// PCR strip holders


for ( c = [0 : 1 : NumCols - 1] )
{
	for ( r = [0 : 1 : NumRows - 1] )
	{
		// wells
		difference(){
    			translate([	0 - c*WellCenterSpacing - PcrStripOffset ,
					r*WellCenterSpacing + PcrStripYOffset ,
					BottomThickness*SizeOfNozzle])
    				cylinder (	h = PcrStripMaxHeigth - BottomThickness*SizeOfNozzle, 
						r=PcrStripTopDiameter/2+WallThickness, 
						center = false, $fn=40); //

    			translate([	0 - c*WellCenterSpacing - PcrStripOffset , 
					r*WellCenterSpacing + PcrStripYOffset,
					BottomThickness*SizeOfNozzle])
    				cylinder (	h = PcrStripMaxHeigth - BottomThickness*SizeOfNozzle, 
						r=PcrStripTopDiameter/2, 
						center = false, $fn=40); //, $fn=20


		} // diff
	}
}




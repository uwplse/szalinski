//design and code by bioprint (http://www.thingiverse.com/bioprint)
//This code generates a multi-well plate without a skirt (customizable)
// 2013-11-30:	first design



// Number of rows
NumRows=2; //8 for 96-well plate
// Number of columns
NumCols = 3; // 12 for 96-well plate
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



CubeLong = WellCenterSpacing-WellDiameter;
CubeShort = WallThickness*2;
CubeHeight =  WellDepth*0.5;

for ( c = [0 : 1 : NumCols - 2] )
{
	for ( r = [0 : 1 : NumRows - 2] )
	{
		// wells
		difference() {
    			translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
    				cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=100);
			translate([c*WellCenterSpacing, r*WellCenterSpacing, WellBottomThickness])
				cylinder (h = WellDepth-WellBottomThickness, r=WellDiameter/2-WallThickness, center = true, $fn=100);
		}

		// connectors
		translate([c*WellCenterSpacing+WellCenterSpacing/2, r*WellCenterSpacing, 0-CubeHeight/2]) 
			cube(size = [CubeLong,CubeShort,CubeHeight], center = true);

		translate([c*WellCenterSpacing, r*WellCenterSpacing+WellCenterSpacing/2, 0-CubeHeight/2]) 
			cube(size = [CubeShort,CubeLong,CubeHeight], center = true);
	}
}

// top row
for ( c = [0 : 1 : NumCols - 1] )
{
	for ( r = NumRows - 1)
	{

	    if(c == 0){
			difference() {
    				translate([0-WellDiameter/2, r*WellCenterSpacing+WellDiameter/2, 0-CubeHeight/2])
    					cube(size = [WellDiameter/2,WellDiameter/2,CubeHeight], center = true);
    				translate([0-WellDiameter/2, r*WellCenterSpacing+WellDiameter/2, 0-CubeHeight/2])
    					cube(size = [WellDiameter/4,WellDiameter/4,CubeHeight], center = true);
    				translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
    					cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=100);
			}
			difference() {
    				translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
    					cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=100);
				translate([c*WellCenterSpacing, r*WellCenterSpacing, WellBottomThickness])
					cylinder (h = WellDepth-WellBottomThickness, r=WellDiameter/2-WallThickness, center = true, $fn=100);
			}
		}else{
			difference() {
    				translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
    					cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=100);
				translate([c*WellCenterSpacing, r*WellCenterSpacing, WellBottomThickness])
					cylinder (h = WellDepth-WellBottomThickness, r=WellDiameter/2-WallThickness, center = true, $fn=100);
			}
		}

		if(c < NumCols - 1){
			translate([c*WellCenterSpacing+WellCenterSpacing/2, r*WellCenterSpacing, 0-CubeHeight/2]) 
				cube(size = [CubeLong,CubeShort,CubeHeight], center = true);
		}
	}
}

// last column
for ( c = NumCols - 1 )
{
	for ( r = [0 : 1 : NumRows - 2] )
	{

		if(r == 0){
			difference() {
    				translate([c*WellCenterSpacing+WellDiameter/2, r-WellDiameter/2, 0-CubeHeight/2])
    					cube(size = [WellDiameter/2,WellDiameter/2,CubeHeight], center = true);
    				translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
    					cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=100);

			}
			difference() {
    				translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
    					cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=100);
				translate([c*WellCenterSpacing, r*WellCenterSpacing, WellBottomThickness])
					cylinder (h = WellDepth-WellBottomThickness, r=WellDiameter/2-WallThickness, center = true, $fn=100);
			}

		}else{

			difference() {
    				translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
    					cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=100);
				translate([c*WellCenterSpacing, r*WellCenterSpacing, WellBottomThickness])
					cylinder (h = WellDepth-WellBottomThickness, r=WellDiameter/2-WallThickness, center = true, $fn=100);
			}
		}

		if(r < NumRows - 1){
			translate([c*WellCenterSpacing, r*WellCenterSpacing+WellCenterSpacing/2, 0-CubeHeight/2]) 
				cube(size = [CubeShort,CubeLong,CubeHeight], center = true);
		}
	}
}




//rotate ([90,0,0]) cylinder (h = 4, r=0.9, center = true, $fn=100);

//design and code by bioprint (http://www.thingiverse.com/bioprint)
//This code generates a holder for items used for data collection (customizable)
// 2014-07-11:	first design
// 2014-11-05: formatted to slides



// Chip Thichness
ChipThichness=1.5; // 1.5mm
// Chip Width
ChipWidth=26; // 24mm
// Chip Height
ChipHeight=50; // 50mm

// Nozzle Diameter
NozzleDiameter = 0.4; // use nozzle size

// Holder Bottom Thickness
HolderBottomThickness = 2; // 2mm
// Holder Side Thickness
HolderSideThickness = 2; // 2mm

// Holder Steel Groove Width
HolderSteelGrooveWidth = 9; // 9mm

// Holder Vertical Wall Thickness
HolderVerticalWallThickness = 2; // use nozzle size

//GrooveDepth
GrooveDepth = 2; // 2mm
//Groove Clearance
GrooveClearance = 0.4; // 0.4mm


MyBottomWidth = (HolderSteelGrooveWidth > ChipThichness) ?  HolderSteelGrooveWidth + 2*GrooveClearance + 2 *  HolderSideThickness  : ChipThichness + 2 * HolderSideThickness;
MyBottomLength = ChipWidth + 2*HolderSideThickness + GrooveDepth;


difference(){
	cube(size = [MyBottomLength,MyBottomWidth,HolderBottomThickness], center = false);

   translate ([HolderSideThickness+ChipWidth+HolderSideThickness,MyBottomWidth/2-(HolderSteelGrooveWidth+2*GrooveClearance)/2,0])
		cube(size = [GrooveDepth,HolderSteelGrooveWidth+2*GrooveClearance,ChipHeight+HolderBottomThickness], center = false);
}

difference(){
	translate ([0,0,HolderBottomThickness])
		cube(size = [GrooveDepth+HolderSideThickness,MyBottomWidth,ChipHeight], center = false);
	translate ([HolderSideThickness,MyBottomWidth/2-(ChipThichness+2*GrooveClearance)/2,HolderBottomThickness])
		cube(size = [GrooveDepth+HolderSideThickness,ChipThichness+2*GrooveClearance,ChipHeight], center = false);

}


difference(){
	translate ([HolderSideThickness+ChipWidth-GrooveDepth,0,HolderBottomThickness])
		cube(size = [2*GrooveDepth+HolderSideThickness,MyBottomWidth,ChipHeight], center = false);
   translate ([HolderSideThickness+ChipWidth-GrooveDepth,MyBottomWidth/2-(ChipThichness+2*GrooveClearance)/2,HolderBottomThickness])
		cube(size = [GrooveDepth,ChipThichness+2*GrooveClearance,ChipHeight], center = false);
   translate ([HolderSideThickness+ChipWidth+HolderSideThickness,MyBottomWidth/2-(HolderSteelGrooveWidth+2*GrooveClearance)/2,0])
		cube(size = [GrooveDepth,HolderSteelGrooveWidth+2*GrooveClearance,ChipHeight+HolderBottomThickness], center = false);

}


//		translate([c*WellCenterSpacing, r*WellCenterSpacing+WellCenterSpacing/2, 0-CubeHeight/2]) 
//			cube(size = [CubeShort,CubeLong,CubeHeight], center = true);
//
//			difference() {
//    				translate([c*WellCenterSpacing, r*WellCenterSpacing, 0])
//    					cylinder (h = WellDepth, r=WellDiameter/2, center = true, $fn=20);
//				translate([c*WellCenterSpacing, r*WellCenterSpacing, WellBottomThickness])
//					cylinder (h = WellDepth-WellBottomThickness, r=WellDiameter/2-WallThickness, center = true, $fn=20);

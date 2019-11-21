//********************************************************************
// Customizable Drawer Guide Bracket 
// By James Newton
//********************************************************************


//********************************************************************
//User defined parameters
//********************************************************************
//Width of guide.
guideWidth = 22;

//Height of guide.
guideHeight = 8;

//Distance between guide and ceiling of drawer slot
guideClearance = 6;

//Width of the guide mount or space between the top "fingers" of the bracket.
guideMount = 12;

//Width of Bracket (must be wider than guide)
bracketWidth = 55; 

bracketHeight = 45;

bracketDepth = 15;

bracketThickness = 5;

screwDiameter = 4;

//********************************************************************
bracketBelowShelf=(bracketHeight-guideClearance*2-guideHeight);
intersection() {

	// Remove extra material from the "fingers" at the top.
	union() {
		cylinder(h=bracketDepth,r=bracketWidth/2,center=true);
		//but don't take anything off the bottom. 
		translate([0,-bracketHeight/2,0])
			cube([bracketWidth,bracketHeight,bracketDepth], center=true);
		}
	
	difference() {
		//base plate
		cube([bracketWidth,bracketHeight,bracketDepth], center=true);
		
		// cutout for guide
		translate([0,bracketHeight/2-guideClearance-guideHeight/2,0])
			cube([guideWidth,guideHeight,bracketDepth*2], center=true);
	
		// cutout for guide mount
		translate([0,bracketHeight/2-guideClearance/2,0])
			cube([guideMount,guideClearance+1,bracketDepth*2], center=true);
	
		// slope the attachment to the guide holder
		translate([0,-bracketHeight/2,bracketThickness]) 
		rotate([atan((bracketDepth-bracketThickness)/bracketBelowShelf),0,0])
			cube([bracketWidth+1,bracketHeight*2,bracketDepth], center=true);
	
		// Remove unneeded material from the attachment, leaving center and side buttresses
		translate([guideClearance/2,-bracketHeight/2,-bracketDepth/2+bracketThickness]) 
			cube([bracketWidth/2-guideClearance, bracketBelowShelf, bracketDepth]);
		translate([-bracketWidth/2+guideClearance/2,-bracketHeight/2,-bracketDepth/2+bracketThickness]) 
			cube([bracketWidth/2-guideClearance, bracketBelowShelf, bracketDepth]);
	
		// Screw holes
		translate([bracketWidth*2/6,-(bracketHeight/2)+(bracketBelowShelf*2/3),0]) 
			cylinder(h=bracketDepth+1,r=screwDiameter/2,center=true);
		translate([-bracketWidth*2/6,-(bracketHeight/2)+(bracketBelowShelf*2/3),0]) 
			cylinder(h=bracketDepth+1,r=screwDiameter/2,center=true);
		translate([bracketWidth*1/4,-(bracketHeight/2)+(bracketBelowShelf*1/4),0]) 
			cylinder(h=bracketDepth+1,r=screwDiameter/2,center=true);
		translate([-bracketWidth*1/4,-(bracketHeight/2)+(bracketBelowShelf*1/4),0]) 
			cylinder(h=bracketDepth+1,r=screwDiameter/2,center=true);
		}
	}

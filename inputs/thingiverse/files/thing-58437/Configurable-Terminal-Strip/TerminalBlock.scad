//
// Terminal Block
//
//

//How many terminals in the block
NoTerminals = 3; // [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
// Diameter of screw in terminal
TerminalHoleSize = 4;
//Terminal Height in mm
TerminalHeight = 8;
//Width of each terminal in mm
TerminalWidth = 12;
//Block Width in mm
BlockWidth = 14;
//Terminal Divider width in mm
TerminalDivider = 2.4;
// Nut Thickness
NutThickness = 4;
// Tabs required
ReqTabs = "Yes"; //[Yes,No]
//Mounting tab length
MountTabLength = 8;
//Mounting tab Height
MountTabHeight = 8;
//Mount tab hole diameter in mm
MountHole = 4;
//Clearence
Clearence = 0.5; 
//Are the nuts Enclosed (nuts added during build - print must be paused) or Slotted (nuts added after build) or Bolted that is Hex head bolt inserted post print.
Enclose =1; //[1:Enclosed, 0: Slotted, 2:Bolted]


//Height of the top of the nut above the base
NutHeight = Enclose > 1 ? NutThickness : TerminalHeight - 2;
//echo (NutHeight);


for (i =[ 0:NoTerminals - 1]) {
	translate ([0,(TerminalWidth + TerminalDivider) * i ,0]) 
		terminal() ;
	}

translate ([- TerminalDivider ,- TerminalDivider , 0]) 
		cube([BlockWidth + TerminalDivider * 2,
				TerminalDivider ,
				TerminalHeight + TerminalDivider]);
if (ReqTabs == "Yes") {
	translate ([0,-TerminalDivider,0]) mirror ([0,1,0]) tab() ;
	translate ([0,(TerminalWidth + TerminalDivider) * NoTerminals,0]) tab() ;
	}

module tab() {
	difference () {
		translate ([MountHole /2, 0,0]) 
			minkowski() {
				cube([BlockWidth - MountHole,
					MountTabLength ,
					MountTabHeight ]);
				cylinder ( r= (MountHole + Clearence )/2 , h =.01 , $fn=50);
			}
		translate ([BlockWidth /2, MountTabLength /2, -1]) cylinder ( r= (MountHole + Clearence )/2 , h = MountTabHeight + 2, $fn=50);
	}
}



module terminal() {
difference() {
	union() {
		cube([BlockWidth,TerminalWidth,TerminalHeight]);
		translate ([- TerminalDivider , TerminalWidth , 0]) 
				cube([BlockWidth + (TerminalDivider * 2),
					TerminalDivider + 0.01 ,
					TerminalHeight + TerminalDivider]);
	}
	translate ([BlockWidth / 2,
				TerminalWidth / 2,  
				NutHeight  + .5]) 
			cylinder ( r= (TerminalHoleSize + Clearence )/2 , 
				h = TerminalHeight, $fn=50);

	translate ([BlockWidth /2,
		TerminalWidth /2,  -1]) 
		cylinder ( r= ( TerminalHoleSize + Clearence ) / 2 , 
		h = NutHeight - (NutThickness / 2) + 1, $fn=50);

	translate ([BlockWidth /2,
				TerminalWidth /2,  
				NutHeight - NutThickness ]) 
			cylinder ( r= TerminalHoleSize + ( Clearence ) , h = NutThickness , $fn=6);
	if (Enclose == 0) {
		translate ([BlockWidth /2 + .1,
					(TerminalWidth  - (TerminalHoleSize + Clearence) * 1.8) / 2 ,  
					NutHeight - NutThickness  ]) 
			cube([ BlockWidth /2	, (TerminalHoleSize + Clearence) * 1.8, NutThickness]);
		}
	}
}
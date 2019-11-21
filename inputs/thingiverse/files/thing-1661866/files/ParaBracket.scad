// Number of Slots
slotConfig = 3;  // 0, 1, 2, 3

// Thickness of the base portion of the bracket
baseDepth = 2.5;

// Diameter of base holes
baseDiameter = 3.3; 

// Distance between holes and edge
baseAllowance = 2;

// Space between inner surface of bracket platform and side of mounting platform. 
baseDistance = 4;

// Slot instead of double holes?
baseSlot = false; // true, false

// Thickness of the slot portion of the bracket.
slotDepth = 2.5; 

// Vertical Length of Slot
vSlotLength = 8;  

// Horizontal Length of Slot
hSlotLength = 8;

// Diameter of slot holes
slotDiameter = 3.65;

// Minimum distance between slot side and any edge/obstruction
slotAllowance = 3;

// The height off of the bottom of the bracket that the hole starts. Measured from bottom of hole. 
slotHeight = 2.3;

// Width of triangular prisms that hold the base to the bracket
supportWidth = 2.5; 

// Change to true if you would like the vertical slot on the other side (Only for slotConfig = 3)
bracketMirror = false;  // true, false

//////// Do not edit any of these variables ////////

baseLength = 
[2*supportWidth+2*slotAllowance+slotDiameter, // slotConfig = 0
2*supportWidth+2*slotAllowance+slotDiameter+hSlotLength, // slotConfig = 1
2*supportWidth+2*slotAllowance+slotDiameter, // slotConfig = 2
2*supportWidth+3*slotAllowance+2*slotDiameter+hSlotLength // slotConfig = 3
];

transVal = [supportWidth+slotAllowance+slotDiameter/2, 0, supportWidth, baseLength[slotConfig]-(2*slotAllowance+slotDiameter)-supportWidth]; // Why can't I assign variable values in IF statements?

polyPoi = 
[[0, 0, slotHeight+slotDiameter+slotAllowance], 
[supportWidth, 0, slotHeight+slotDiameter+slotAllowance], 
[supportWidth, 0, 0], 
[0, 0, 0], 
[0, -(baseDistance+2*baseAllowance+baseDiameter), 0], 
[supportWidth, -(baseDistance+2*baseAllowance+baseDiameter), 0]];

polyTri = [[0,3,2], [0,2,1],  [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]; // Thank you OpenSCAD User Manual! <3

//////////////////

module bracketMount(){
	module hSlotPositive(){
		if (slotConfig == 0){
			cube([baseLength[slotConfig],slotDepth,slotHeight+slotDiameter+slotAllowance]);
		}
		if (slotConfig != 0 && slotConfig != 2){
			cube([baseLength[slotConfig],slotDepth,slotHeight+slotDiameter+slotAllowance]);
		} // Well that was boring
		if (slotConfig != 0 && slotConfig != 1){
			translate([transVal[slotConfig], 0, 0]) union(){
				cube([2*slotAllowance+slotDiameter, slotDepth, slotHeight+slotDiameter/2+vSlotLength]);
				translate([slotAllowance+slotDiameter/2,slotDepth,slotHeight+slotDiameter/2+vSlotLength])
					rotate([90,0,0])
						cylinder(r=(slotAllowance+slotDiameter/2), h=slotDepth, $fn=20);
			}
			cube([baseLength[slotConfig],slotDepth,slotHeight+slotDiameter+slotAllowance]);
		} // If I said this unit wasn't partially guessing stuff I would be lying
	}
	module hSlotNegative(){
		if (slotConfig == 0){
			translate([transVal[slotConfig],slotDepth+1,slotHeight+slotDiameter/2])
			rotate([90,0,0]) 
				cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
		}
		if (slotConfig != 0 && slotConfig != 2){
			translate([slotAllowance+supportWidth+slotDiameter/2,slotDepth+1,slotHeight+slotDiameter/2])
			rotate([90,0,0]) 
				hull(){
					cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
					translate([hSlotLength,0,0])
						cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
				} // Hooray hulls! Making my life that much easier.
		}
		if (slotConfig != 0 && slotConfig != 1){
			translate([transVal[slotConfig]+slotAllowance+slotDiameter/2,slotDepth+1,slotHeight+slotDiameter/2])
			rotate([90,0,0]) 
				hull(){
					cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
					translate([0,vSlotLength,0])
						cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
				}
		}
	}
	difference(){
		hSlotPositive();
		hSlotNegative();
	}
}

module triangularSupport(){
polyhedron (points = polyPoi, triangles = polyTri);
translate([baseLength[slotConfig]-supportWidth,0,0])
	polyhedron (points = polyPoi, triangles = polyTri);
}

module baseMount(){
	module positiveBase(){
		translate([0,-baseDistance,0]) mirror([0,1,0])
			cube([baseLength[slotConfig], 2*baseAllowance+baseDiameter, baseDepth]);
	}
	module negativeBase(){
		if (baseSlot){
			translate([baseAllowance+supportWidth+baseDiameter/2,-baseDistance-baseAllowance-baseDiameter/2,-1]) hull(){
				cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
				translate([baseLength[slotConfig]-2*baseAllowance-2*supportWidth-baseDiameter,0,0])
					cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
			}
		} else {
			translate([baseAllowance+supportWidth+baseDiameter/2,-baseDistance-baseAllowance-baseDiameter/2,-1]) union(){
				cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
				translate([baseLength[slotConfig]-2*baseAllowance-2*supportWidth-baseDiameter,0,0])
					cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
			}
		}
	}
	difference(){
		positiveBase();
		negativeBase();
	}
}

if (bracketMirror){
mirror([1,0,0]){
bracketMount();
triangularSupport();
baseMount();
}
} else {
bracketMount();
triangularSupport();
baseMount();
}
//CUSTOMIZER VARIABLES

// Outer Diameter of the large diameter side
Large_OD = 14.5;
// Outer Diameter of the small diameter side
Small_OD = 7.5;
// Wall thickness of the adapter
WallThickness = 1.5;
// Spigot length on the large diameter side
LargeDiaLength = 20;
// Spigot length on the small diameter side
SmallDiaLength = 20;
// Overall length of the adapter
OverallLength = 55;

/* [Large Diameter Groove] */
// Groove on the large diameter side? (1 = yes 0 = no)
Large_OD_Circlip=1; // [1,0]
// Width of the groove on the large diamter side
LargeDiaGrooveWidth = 10.5;
// Thickness of the groove on the large diamter side
LargeDiaGrooveThickness = 0.5;
// Distance from the large diameter end to the groove on the large diamter side
LargeDiaGrooveDistance = 4;

/* [Small Diameter Groove] */
// Groove on the small diameter side? (1 = yes 0 = no)
Small_OD_Circlip=1; // [1,0]
// Width of the groove on the small diamter side
SmallDiaGrooveWidth = 10.5;
// Thickness of the groove on the small diamter side
SmallDiaGrooveThickness = 0.5;
// Distance from the small diameter end to the groove on the small diamter side
SmallDiaGrooveDistance = 4;



//CUSTOMIZER VARIABLES END

/* [Hidden] */

LargeRad = Large_OD/2;
SmallRad = Small_OD/2;

LargeRadGroove = LargeRad+1;
SmallRadGroove = SmallRad+1;

difference() {
rotate_extrude($fn = 100) polygon( points=[[LargeRad-WallThickness,0],[LargeRad,0],[LargeRad,LargeDiaLength],[SmallRad,OverallLength-SmallDiaLength],[SmallRad,OverallLength],[SmallRad-WallThickness,OverallLength],[SmallRad-WallThickness,OverallLength-SmallDiaLength],[LargeRad-WallThickness,LargeDiaLength]]);

if (Large_OD_Circlip==1) {
rotate_extrude($fn = 100) polygon( points=[[LargeRad-LargeDiaGrooveThickness,LargeDiaGrooveDistance],[LargeRadGroove,LargeDiaGrooveDistance],[LargeRadGroove,LargeDiaGrooveDistance+LargeDiaGrooveWidth],[LargeRad-LargeDiaGrooveThickness,LargeDiaGrooveDistance+LargeDiaGrooveWidth]]);
}
if (Small_OD_Circlip==1) {
rotate_extrude($fn = 100) polygon( points=[[SmallRad-SmallDiaGrooveThickness,OverallLength-SmallDiaGrooveDistance],[SmallRadGroove,OverallLength-SmallDiaGrooveDistance],[SmallRadGroove,OverallLength-SmallDiaGrooveDistance-SmallDiaGrooveWidth],[SmallRad-SmallDiaGrooveThickness,OverallLength-SmallDiaGrooveDistance-SmallDiaGrooveWidth]]);
}
}
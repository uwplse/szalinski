// OpenSCAD model by tselling
// dimensions in mm

// Glass clips for Monoprice Select Mini 3D Printer.  Currently
// setup for BACK LEFT corner... the FRONT RIGHT corner should
// be the same.  Note the clips squeeze against the glass plate,
// they do not clip over the top.  Changing doOppositeCorners to 1
// will do the BACK RIGHT & FRONT LEFT corners.  To  make a tight 
// fit estimate the plate is slightly smaller (... you can always 
// sand to make fit if slightly too tight.  Currently setup for 
// 130mmx130mmx3mm glass plate.  
// Commented glass values should work for 140mmx140mmx3mm plate.

fn=20;

// Change this variable for opposite corners (1 vs 0)
doOppositeCorners=0;

// (mm) thickness of glass plate
glassThickness=3.0;

// (mm) distance to glass from back - neg for smaller plate
glassBack=-15.6;
// glassBack = -10.6;

// (mm) distance to glass from left side - neg for smaller plate
glassSide=-0.8;
// glassSide = -6.0;

// (mm) length (X) of the base (underneath plate)
baseBack = 20;

// (mm) depth (Y) of the base (underneath plate)
baseSide = 30;

// (mm) thickness of the base of the clip 
baseThickness=3.0;

// (mm) adjust thickness of the wall of the clip
backWall=5.0;

// (mm) adjust thickness of the wall of the clip
sideWall=3.0;

// (mm) thickness of build plate without glass
plateThickness=2.0;

// (mm) diameter of hole needed in base for leveling screw + spring
screwDiameter=9.9;

// (mm) distance from back to screw center & averaged with front
screwBack = 3.9;

// (mm) measured from left side to screw center
screwSide = 6;

// (mm) Height from bottom of plate to bottom lip
latchHeight = 16.2;

// (mm) inside catch height...depress plate to latch/unlatch
latchCatch = 3.0;

// (mm) inside catch thickness
latchInside = 2.0;

// (mm) bottom of latch thickness
latchUnder = 2.1;

// (mm) thickness of the plate lip
latchDepth = 1.7;

totalHeight = baseThickness+plateThickness+glassThickness; 
plateHeight = baseThickness+plateThickness; 

union() {    
difference() {
union() {
    
// base
translate([0,0,0]) cube([baseBack,baseSide,baseThickness]);
   
plusX = glassSide > 0 ? glassSide : 0; 
xLength = baseBack + sideWall + plusX;
x = doOppositeCorners == 0 ? -sideWall-plusX : 0;
if ( glassBack <= 0 ) {
// Wall along X Axis
translate([x,baseSide,0]) 
    cube([xLength,backWall,totalHeight]);
// Tab along X Axis
translate([x,baseSide+glassBack,plateHeight])
    cube([xLength,backWall-glassBack,glassThickness]);
} else {
    // Extend base first--high enough for glass to sit on
    translate([x,baseSide,0])
        cube([xLength,glassBack,plateHeight]);
    // Now add wall to hold glass
    translate([x,baseSide+glassBack,0])
        cube([xLength,backWall,totalHeight]);
}

// Wall along Y axis
yLength = glassBack>0 ? baseSide+wallThickness+glassBack : baseSide+backWall;
if ( glassSide <= 0 ) { // Glass shorter at side 
    x1 = doOppositeCorners == 0 ? -sideWall : baseBack;
    x2 = doOppositeCorners == 0 ? -sideWall : baseBack+glassSide; 
    // Wall along Y Axis
    translate([x1,0,0])
        cube([sideWall,yLength,totalHeight]);
    // Tab along Y Axis    
    translate([x2,0,plateHeight])
        cube([sideWall-glassSide,yLength,glassThickness]);   
} else {  // Glass bigger at side
    x1 = doOppositeCorners == 0 ? -glassSide-sideWall : baseBack;
    x2 = doOppositeCorners == 0 ? -glassSide-sideWall : baseBack+glassSide;
    // Extend base first-- high enough for glass to sit on
    translate([x1,0,0])
        cube([backWall+glassSide,yLength,plateHeight]);
    // Now add wall to hold glass
    translate([x2,0,0])
        cube([backWall,yLength,totalHeight]);
} //else

} // union

// add slot for leveling screw & spring
x1 = doOppositeCorners == 0 ? screwSide : baseBack-screwSide;
x2 = doOppositeCorners == 0 ? baseBack*6 : -baseBack*5;
    hull() {
        translate([x1,baseSide-screwBack,0])
            cylinder(h=totalHeight,d=screwDiameter);
        translate([x2,-baseSide,0])
            cylinder(h=totalHeight,d=screwDiameter);

} // hull

} // difference

// Add latch 
ll = baseSide + backWall;
lh = latchHeight - baseThickness;
ly = 0;
x1 = doOppositeCorners == 0 ? -sideWall : baseBack;
x2 = doOppositeCorners == 0 ? -sideWall : baseBack-latchDepth;
x3 = doOppositeCorners == 0 ? latchDepth : baseBack-latchDepth-latchInside;

translate([x1,ly,-lh-latchUnder])
    cube([sideWall, ll, lh+latchUnder]);
translate([x2,ly,-lh-latchUnder])
    cube([sideWall+latchDepth, ll, latchUnder]);
translate([x3,ly,-lh-latchUnder])
    cube([latchInside, ll, latchCatch+latchUnder]);

} // union

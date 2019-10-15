// OpenSCAD model by tselling
// based on OpenSCAD thing:726983 by markwal
// dimensions in mm

// Allows you to modify almost everything on the clip
// In general the Back Right corner and the Front Left 
// corner use the same clip so just duplicate it unless 
// you need something different.  I wanted my side 
// walls to be shorter than the back/front walls to avoid 
// hitting my custom filament spool holder on the inside 
// of my Dreamer.  You can just make the back & right lengths
// the same for a square piece if you don't need a shorter
// side.

// Just change this variable for opposite corners (1 vs 0)
doOppositeCorners=0;

// (mm) thickness of the base of the clip 
//   (too thick may require longer screw)
baseThickness=5;

// (mm) adjust thickness of the wall of the clip
wallThickness=4;

// (mm) thickness of build plate without glass (round up)
// This will be the wall height.
plateThickness=10;

// (mm) thickness of the glass plate (round down)
// This will be the tab height.
glassThickness=5;

// (mm) how long at the back (X-Axis)
baseBack=27;

// (mm) how long on the side (Y-Axis)
baseRight=20;

// (mm) length of back wall (shorten if you want open corner)
wallBack=27;

// (mm) length of right wall (shorten if you want open corner)
wallRight=20;

// Back tab length
tabBackLength=12;

// Right tab length
tabRightLength=9;

// (mm) space in back/front of glass plate (when centered)
tabBackThickness=1.8;

// (mm) space on the left/right side of glass plate (when centered)
tabRightThickness=2.6;

// (mm) slotLength for bolt
slotLength=12;

// (mm) width of the bolt slot
boltDiameter=3.2;

// (mm) allows you to leave  original nut attached to build
// plate and add wingnut to the bottom.
nutDiameter=7;
nutHeight=2.5;

difference() {
union() {
    
total_height = baseThickness+plateThickness+glassThickness; 

baseX = doOppositeCorners ? baseRight : baseBack;
baseY = doOppositeCorners ? baseBack : baseRight;
wallX = doOppositeCorners ? wallRight : wallBack;
wallY = doOppositeCorners ? wallBack : wallRight;
tabX = doOppositeCorners ? tabRightLength : tabBackLength;
tabY = doOppositeCorners ? tabBackLength : tabRightLength;
tabX_thickness = doOppositeCorners ? tabRightThickness : tabBackThickness;
tabY_thickness = doOppositeCorners ? tabBackThickness : tabRightThickness;
    
// base
cube([baseX,baseY,baseThickness]);
 
// Wall on X Axis
translate([baseX-wallX,0,0]) 
    cube([wallX,wallThickness, total_height]);

// Tab on X Axis
translate([baseX-tabX,0,baseThickness+plateThickness])
	cube([tabX,wallThickness+tabX_thickness,glassThickness]);
    
// Wall on Y Axis
translate([0,baseY-wallY,0])
	cube([wallThickness,wallY,total_height]);
    
// Tab on Y Axis
translate([0,baseY-tabY,baseThickness+plateThickness])
	cube([wallThickness+tabY_thickness,tabY,glassThickness]);
}

    //remove the slots 
    rotate([0,0,-45]) {
        translate([0,wallThickness+boltDiameter,0]){
    
            // bolt slot
            hull() {
                cylinder(h=baseThickness,d=boltDiameter);
                translate([0, slotLength,0])
                    cylinder(h=baseThickness,d=boltDiameter);
            }
            
            // nut slot       
            translate([0,0, baseThickness-nutHeight]) hull() {
                cylinder(h=nutHeight,d=nutDiameter);
                translate([0, slotLength, 0]) 
                    cylinder(h=nutHeight,d=nutDiameter); 
            }
        }
    }
}

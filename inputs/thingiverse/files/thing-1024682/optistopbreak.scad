// How wide is your printer nozzle, for hole size correction
nozzleWidth=0.4; //[0.1,0.2,0.3,0.4,0.5,0.6]
halfNozzleWidth=nozzleWidth/2;
// How wide is your carraige
carraigeWidth=25; //[20:40]
// How deep is the carraige from front to back
carraigeDepth=12; // [4:30]
// How deep is the section where the belt goes through 0 for no belt
carraigeBeltPathDepth=5.5; 
// How wide is the cutout for the belt
carraigeBeltPathWidth=15; //[5:30]
// Where is the bolt located divide in half for the middle
carraigeMountBolt=12.5; 
// The offset for the sensor location
opticalBreakOffset=3; // [0:10]
// How thick should the break be
opticalBreakThickess=.6; //[0.1:0.9]
// How tall should the optical break be
opticalBreakHeight=7; //[4:10]
// How thick should the mounting bracket be
opticalBreakMountThickness=1; //[1:3]
// How many points the screw holes should have
circleRadiusPoints=6; //[3:30]
// The radius of the screw hole
screwHoleRadius=1.475;

module OpticalBreak(){
    beltDepthOffset = carraigeDepth - carraigeBeltPathDepth;
    halfBeltDepthOffset = beltDepthOffset / 2;
    halfOpticalBreakHeight=opticalBreakHeight/2;
    halfOpticalBreakMountThickness=opticalBreakMountThickness/2;
    holeRadius=screwHoleRadius+halfNozzleWidth;
    union() {
        
        difference() {
            cube([carraigeWidth, carraigeDepth, opticalBreakMountThickness], center=true);
            translate([0, halfBeltDepthOffset,0]) 
            cube([carraigeBeltPathWidth + 0.002, carraigeBeltPathDepth + 0.002, opticalBreakMountThickness + 0.02], center=true);
            translate([0, -halfBeltDepthOffset,0]) 
    cylinder(h = opticalBreakMountThickness + 0.002, r1 = holeRadius, r2= holeRadius * 1.6, center = true, $fn = circleRadiusPoints);
        }
        difference() {
        translate([-opticalBreakOffset + (opticalBreakThickess / 2) , -halfBeltDepthOffset + (0.5) , halfOpticalBreakHeight - (halfOpticalBreakMountThickness) ]) 
        cube([opticalBreakThickess, beltDepthOffset, opticalBreakHeight], center=true);
           translate([0, halfBeltDepthOffset,0]) 
            cube([carraigeBeltPathWidth + 0.002, carraigeBeltPathDepth + 0.002, opticalBreakMountThickness + 0.02], center=true); 
            
        }

    }
}


OpticalBreak();
//mirror([0,1,0]) 
//OpticalBreak();
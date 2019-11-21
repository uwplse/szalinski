// nice (and horribly long) variable names for Thingiverse Customizer

// Height of the coupler, half for the motor shaft and half for the rod
couplerHeight = 35;
// External diameter of the coupler
couplerExternalDiameter = 20;
// Diameter of the motor shaft
motorShaftDiameter = 5;
// Diameter of the rod
threadedRodDiameter = 8;
// Diameter of the screw thread
screwDiameter = 3.4;
screwHeadDiameter = 7;
screwThreadLength = 10;
// Width across flats of the nut (wrench size)
nutWidth = 6;
nutThickness = 3;
// Gap between the two halves
halvesDistance = couplerExternalDiameter; // 0.5;

/* [Hidden] */
// end of Customizer variables
// Portion of the shaft inside the coupler
shaftLen = couplerHeight/2;
// Portion of the rod inside the coupler
rodLen = couplerHeight/2;
shaftScrewsDistance = motorShaftDiameter+screwDiameter+1;
rodScrewsDistance = threadedRodDiameter+screwDiameter+1;

$fa = 0.02;
$fs = 0.25;
little = 0.01; // just a little number
big = 100; // just a big number

module coupler()
{
    difference()
    {
        // main body
        cylinder(d=couplerExternalDiameter, h=shaftLen + rodLen);
        // shaft
        translate([0,0,-little])
            cylinder(d=motorShaftDiameter, h=shaftLen+2*little);
        // rod
        translate([0,0,shaftLen])
            cylinder(d=threadedRodDiameter, h=rodLen+little);
        // screws
        translate([0,shaftScrewsDistance/2,shaftLen/2])
            rotate([90,0,90])
                screw();
        translate([0,-shaftScrewsDistance/2,shaftLen/2])
            rotate([90,0,270])
                screw();
        translate([0,rodScrewsDistance/2,shaftLen+rodLen/2])
            rotate([90,0,90])
                screw();
        translate([0,-rodScrewsDistance/2,shaftLen+rodLen/2])
            rotate([90,0,270])
                screw();
        // cut between the two halves
        translate([-10,0,0])  
        cube([halvesDistance,big,big], center=true);
    }
    
}

module screw()
{
    // thread
    cylinder(d=screwDiameter, h=big, center=true);
    // head
    translate([0,0,(screwThreadLength-nutThickness)/2])
        cylinder(d=screwHeadDiameter, h=big);
    // nut
    translate([0,0,-(screwThreadLength-nutThickness)/2])
        rotate([180,0,30])
            cylinder(d=nutWidth*2*tan(30), h=big, $fn=6);
}

rotate([0,-90,0])
coupler();
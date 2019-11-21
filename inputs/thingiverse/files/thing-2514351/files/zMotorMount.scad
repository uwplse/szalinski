// -------------------------------
// ---------- variables ----------
// -------------------------------

globalFn = 128;                 // default: 128

partWidth = 70;                 // default: 80
partHeight = 24;                // default: 24
partThickness = 12;             // default: 12

cornerRadius = 5;               // default: 5
slotThickness = 2;              // default: 2

motorSideWidth = 35.4;          // default: 35.4
motorMountWallThickness = 2.5;  // default: 2.5

rodDiameter = 8.2;              // default: 8.2

screwDiameter = 3.2;            // default: 3.2
screwHeadDiameter = 6.2;        // default: 6.2

boltPatternWidth = 28.5;        // default: 28.5

module m3Hex(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[9.794687,5.654965],[0.000000,11.309930],[-9.794687,5.654965],[-9.794687,-5.654965],[-0.000000,-11.309930],[9.794687,-5.654965]]);
  }
}
m3HexMultiplier = 1.15;         // default: 1.15

// -----------------------------------------------
// ---------- let's create some modules ----------
// -----------------------------------------------

//     the basic shape
// -------------------
module bodyPart () {
    cube([partWidth, partThickness, partHeight-cornerRadius]);

    translate([cornerRadius,0,0])
        cube([partWidth-cornerRadius*2, partThickness, partHeight]);

    //     right corner
    // ----------------
    module rightCorner () {
        translate([partWidth-cornerRadius, partThickness, partHeight-cornerRadius])
        rotate([90,0,0])
            cylinder(h=partThickness, r=cornerRadius, $fn=globalFn);
    }

    rightCorner();

    //     left corner
    // ---------------
    translate([partWidth,0,0]) mirror([1,0,0]) rightCorner();
    
    //     motor mount
    // ---------------
    translate([partWidth/2-motorSideWidth/2-motorMountWallThickness, partThickness/2-motorSideWidth/2-motorMountWallThickness, 0])
        cube([motorSideWidth+motorMountWallThickness*2, motorSideWidth+motorMountWallThickness*2, (partThickness-rodDiameter)/2+rodDiameter+7.5]);
}

//     the frame rod
// -----------------
module frameRod() {
    translate([-10, rodDiameter/2+(partThickness-rodDiameter)/2, rodDiameter/2+(partThickness-rodDiameter)/2])
    rotate([0, 90, 0])
        cylinder(h=partWidth+20, d=rodDiameter, $fn=globalFn);
};

//     cut outs in z direction
// ---------------------------
module zTopCutOuts() {
    //     z rods
    // ----------
    module rightZRod () {
        translate([partWidth-rodDiameter/2-(partThickness-rodDiameter)/2, partThickness-rodDiameter/2-(partThickness-rodDiameter)/2, (partThickness-rodDiameter)/2+rodDiameter/2])
            cylinder(h=partWidth+20, d=rodDiameter, $fn=globalFn);
    };
    
    rightZRod();
    
    translate([partWidth,0,0]) mirror([1,0,0]) rightZRod();
    
    // >>> slot
    translate([cornerRadius, partThickness/2-slotThickness/2, (partThickness-rodDiameter)/2+rodDiameter/2])
        cube([partWidth-cornerRadius*2, slotThickness, partHeight]);
};

//     m3 hex assembly (screw + nut)
// ---------------------------------
module m3HexAssembly() {
    module m3ScrewAndNut() {
        translate([0, 0, -partThickness/2+(partThickness-slotThickness)/4])
            scale([m3HexMultiplier, m3HexMultiplier, 1]) m3Hex(partThickness/2);

        translate([0, 0, partThickness-(partThickness-slotThickness)/4])
            cylinder(h=partThickness*2, d=screwHeadDiameter, $fn=globalFn);

        cylinder(h=partThickness, d=screwDiameter, $fn=globalFn);
    };

    //     right screw
    // ---------------
    translate([partWidth-(partThickness-rodDiameter)/2-rodDiameter-(((partWidth-motorSideWidth-motorMountWallThickness*2)/2)-(partThickness-rodDiameter)/2-rodDiameter)/2, 0, partHeight-((partThickness-rodDiameter)/2+rodDiameter)/2])
    rotate([-90, 0, 0])
        m3ScrewAndNut();

    //     left screw
    // --------------
    translate([(partThickness-rodDiameter)/2+rodDiameter+(((partWidth-motorSideWidth-motorMountWallThickness*2)/2-((partThickness-rodDiameter)/2+rodDiameter))/2), 0, partHeight-((partThickness-rodDiameter)/2+rodDiameter)/2])
    rotate([-90, 0, 0])
        m3ScrewAndNut();
};

//     bore
// --------
module motorMountBore() {
    translate([partWidth/2-(boltPatternWidth-2.5)/2, partThickness/2-(boltPatternWidth-2.5)/2, 0]) cylinder(h=partHeight, d=3.5, $fn=globalFn);
    translate([partWidth/2-(boltPatternWidth-2.5)/2, partThickness/2-(boltPatternWidth-2.5)/2, -0.02]) cylinder(h=4, d=6, $fn=globalFn);
    
    translate([partWidth/2+(boltPatternWidth-2.5)/2, partThickness/2-(boltPatternWidth-2.5)/2, 0]) cylinder(h=partHeight, d=3.5, $fn=globalFn);
    translate([partWidth/2+(boltPatternWidth-2.5)/2, partThickness/2-(boltPatternWidth-2.5)/2, -0.02]) cylinder(h=4, d=6, $fn=globalFn);
    
    translate([partWidth/2-(boltPatternWidth-2.5)/2, partThickness/2+(boltPatternWidth-2.5)/2, 0]) cylinder(h=partHeight, d=3.5, $fn=globalFn);
    translate([partWidth/2-(boltPatternWidth-2.5)/2, partThickness/2+(boltPatternWidth-2.5)/2, -0.02]) cylinder(h=4, d=6, $fn=globalFn);
    
    translate([partWidth/2+(boltPatternWidth-2.5)/2, partThickness/2+(boltPatternWidth-2.5)/2, 0]) cylinder(h=partHeight, d=3.5, $fn=globalFn);
    translate([partWidth/2+(boltPatternWidth-2.5)/2, partThickness/2+(boltPatternWidth-2.5)/2, -0.02]) cylinder(h=4, d=6, $fn=globalFn);
};

// ----------------------------------
// ---------- le assembly! ----------
// ----------------------------------

difference() {
    bodyPart();
    
    translate([partWidth/2-motorSideWidth/2, partThickness/2-motorSideWidth/2, (partThickness-rodDiameter)/2+rodDiameter])
        cube([motorSideWidth, motorSideWidth, partHeight]);
    
    translate([partWidth/2-5, -partThickness-motorMountWallThickness*2, (partThickness-rodDiameter)/2+rodDiameter]) cube([10, motorSideWidth, partHeight]);

    frameRod();
    
    zTopCutOuts();
    
    m3HexAssembly();
    
    motorMountBore();
    
    // translate([-5, -partWidth/2, -0.1]) cube([partWidth+10, partWidth+10, partHeight/3]);
    // translate([-5, -partWidth/2, 13]) cube([partWidth+10, partWidth+10, partHeight/2]);
};


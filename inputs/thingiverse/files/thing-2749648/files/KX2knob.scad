// preview view:south, tilt:top diagonal
//
//  Knobs
//
//  Author:  sir_jon - Jonathan Poland, N0WL
//  Date:  01 January, 2017
//  License:  Creative Commons - Attribution - Non-Commercial
//
//  note:  knobs may be for sale on my eBay store:  https://stores.ebay.com/N0WL-Radio


/* [Global] */

// Which part to build?  the knob or the shaft test
Knob_or_Test = "Knob"; // [Knob, Shaft]
// Diameter of the shaft to get a tight fit
ShaftDiameter = 6.3;
// Radius of the finger divot - keep this value reasonable small or you might need to add supports when printing
DetentRadius = 6;

/* [Hidden] */

// Height of the finished knob
KnobHeight = 13;
// Diameter of the finished product
KnobDiameter = 30;
// Angle of the tilt of the side of the knob
KnobTilt = 3;
// How wide should the lip of the finger hole be? (should be multiple of printer nozzle width
DetentPlinthX = 0.8;
// How high should the lip of the finger hole be? (should be a multiple of intentended layer height)
DetentPlinthZ = 0.4; 
// Height and width of the cap of the knob
Chamfer = 1;
// Height and width of the base lib of the knob
BaseHeight = 1;

// height of the inside shaft hole
ShaftHeight = 10.6;
// this variable is not used anymore but if you want a flat side on your shaft hole, set a value
ShaftFlatThickness = 0;
// Diameter for clearance of the shaft nut
NutDiameter = 10;
// Height for clearance of the shaft nut
NutHeight = 3;

PrintPart();

module PrintPart(){
    if(Knob_or_Test != "Shaft"){
        Knob();
    }
    else {
        ShaftTest();
    }
}

module ShaftTest() {
    $fn=36;
    difference(){
        cylinder(d=14, h=5);
        translate([0,0,-0.01])cylinder(d=ShaftDiameter, h=5.02);
    }
}

module Knob(){
    KnobTop = KnobDiameter - tan(KnobTilt) * (KnobHeight - Chamfer - BaseHeight) * 2;
    DetentOffsetX = KnobDiameter / 2;
    $fn = 180;
    
    difference(){
        // everything that can be added in a first pass
        union(){
            // main body with flutes removed
            difference(){
                // main body
                color("yellow")cylinder(d1 = KnobDiameter, d2 = KnobTop, h = KnobHeight - Chamfer);
                // flutes (there are 20 of them...)
                color("cyan") for(z = [9: 18: 359]) rotate(z) translate([0, KnobDiameter / 2 + KnobDiameter * PI / 50, 1]) rotate([KnobTilt, 0, 0]) cylinder(d = KnobDiameter * PI / 20, h = KnobHeight); 
            }
            // top cylinder (I call it chamfer from a previous design)
            color("red")translate([0, 0, KnobHeight - Chamfer]) cylinder( d = KnobTop - 2 * Chamfer, h = Chamfer);
            // the base lip
            color("blue") cylinder(d = KnobDiameter + 1, h = 1 );
            // the extension for the finger divot that prevents the need for supports
            color("green") translate([DetentOffsetX, 0, 1]) cylinder(r1 = 0, r2 = DetentRadius + DetentPlinthX, h = KnobHeight - 1);
        }
        // stuff to remove from the main build... shaft & divot
        union(){
            // shaft well
            color("white") translate([0, 0, -0.01]) Shaft();
            // finger divot
            color("white") translate([DetentOffsetX, 0, KnobHeight + DetentRadius]) sphere(DetentRadius * sqrt(2));
        }
    }
    
    // add the plinth to the finger divot
    difference(){
        // the plinth
        color("blue") translate([DetentOffsetX, 0, KnobHeight]) cylinder(r = DetentRadius + DetentPlinthX, h = DetentPlinthZ);
        // remove the divot hole
        color("black") translate([DetentOffsetX, 0, KnobHeight - 0.01]) cylinder(r = DetentRadius, h = DetentPlinthZ + 0.02);
    }
}

module Shaft(){
    SFT = ShaftFlatThickness == 0 ? ShaftDiameter : ShaftFlatThickness > ShaftDiameter ? ShaftDiameter : ShaftFlatThickness;
    $fn = 36;
    
    difference() {
        union(){
            cylinder(d = ShaftDiameter, h = ShaftHeight);
            translate([0, 0, ShaftHeight]) cylinder(d1 = ShaftDiameter, d2 = 0, h = ShaftDiameter / sqrt(3) / 2);
            translate([0, 0, 0])cylinder(d = NutDiameter, h = NutHeight);
        }
        union(){
            translate([-ShaftDiameter / 2, SFT - ShaftDiameter / 2, NutHeight + 0.01]) cube([ShaftDiameter + 0.02, ShaftDiameter + 0.02, ShaftHeight + ShaftDiameter / 2 + 0.02]);
        }
    }
        translate([0, 0, NutHeight]) cylinder(r1 = NutDiameter / 2, r2 = SFT - ShaftDiameter / 2, h = (NutDiameter - SFT + ShaftDiameter) / 4 / sqrt(3));
}
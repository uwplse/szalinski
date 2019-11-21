/* [Panel_Retainer_Clip] */
//Diameter of center pin in mm
PinDiameterInMm = 8;// [6:15]
//Length of center pin in mm.
PinLengthInMm = 12;//[7:50]
//Diamenter of the large washer
WasherDiameterInMm = 30;//[20:50]
/* [Print_Layout] */
// 0 to render as assembled, 1 to render for printing
$PrintLayout = 0;//[0:Assembled,1:Printable]

/* [Hidden] */
$fs=.8;


if ($PrintLayout == 0)
    PanelRetainerClip(PinDiameterInMm,WasherDiameterInMm,PinLengthInMm, true);
else 
    PrintLayout(PinDiameterInMm,WasherDiameterInMm,PinLengthInMm);

module PrintLayout(shaftDiameter, topDiameter, depth){
    angle = atan(.95/(depth+4));
    translate([-topDiameter/2,(shaftDiameter-topDiameter)/2+2,1.5])
        TopWasher(shaftDiameter, topDiameter);
    translate([depth+3.5,-1,0.1])
        rotate([0,-90+angle,0])
            translate([-shaftDiameter/6,0,0])
                RightWing(shaftDiameter, depth);
    translate([-depth-4,shaftDiameter+3,0.1])
        rotate([0,90-angle,0])
            translate([shaftDiameter/6,0,0])
                LeftWing(shaftDiameter,depth);
    translate([8, shaftDiameter+3,0])
        rotate([0,90,0])
            translate([-shaftDiameter/6,0,0])
                Pin(shaftDiameter,depth);
}

module PanelRetainerClip(shaftDiameter=6, topDiameter=25, depth=15, open=false){
    angle = atan(.95/(depth+4));
    color("gray")
        TopWasher(shaftDiameter, topDiameter);
    color("darkgray")
    rotate([0,open?angle:0,0])
        RightWing(shaftDiameter, depth);
    color("steelblue")
    rotate([0,open?-angle:0,0])
        LeftWing(shaftDiameter, depth);
    color("navy")
    translate([0,0,open==true?0:-depth-4])
        Pin(shaftDiameter, depth);
}

module TopWasher(shaftDiameter, topDiameter){
    translate([0,0,-.75])
    difference(){
        cylinder(d=topDiameter, h = 1.5, center=true);
        cube([shaftDiameter, shaftDiameter, 2], center=true);
    }
}
module CenterSlot(shaftDiameter, depth){
    cube([shaftDiameter/3-.01,2*shaftDiameter, 4*depth], center = true);
}
module IdealPin(shaftDiameter, depth){
    intersection(){
        union(){
            translate([0,0,depth/2-.75])
                cylinder(d=shaftDiameter, h = depth+3, center=true);
            translate([0,0,depth])
                minkowski(){
                    cylinder(r1=shaftDiameter*.66, r2 = shaftDiameter/6, h=2);
                    cube([.1,.1,1]);
                }
                
            translate([0,0,-2.75])
                cube([shaftDiameter+4,shaftDiameter, 2], center=true);
        }
        cube([2*shaftDiameter, shaftDiameter, depth*3], center=true);
    }
}
module Half(shaftDiameter, depth){
    translate([-shaftDiameter, -shaftDiameter,-depth])
        cube([shaftDiameter, 2*shaftDiameter, 3*depth]);
}
module RightWing(shaftDiameter, depth){
    angle = atan(.95/(depth+4));
    translate([.2,0,0])
    difference(){
        IdealPin(shaftDiameter, depth);
        translate([.1,0,-depth/2-3])
            rotate([0,-angle,0])
                translate([0,0,depth/2])
                    scale([1.1,1,1]){
                        CenterSlot(shaftDiameter, depth);
                        Half(shaftDiameter, depth);
                    }
        translate([shaftDiameter/2,0,-.6])
            cube([1,shaftDiameter,2], center=true);
    }
}
module LeftWing(shaftDiameter, depth){
    mirror([1,0,0])
        RightWing(shaftDiameter, depth);
}
module Pin(shaftDiameter, depth){
    difference(){
        union(){
            intersection(){
                IdealPin(shaftDiameter, depth);
                CenterSlot(shaftDiameter, depth);
            }
            translate([0,0,-3.75])
                cube([shaftDiameter/3,shaftDiameter+5, 7], center=true);
        }
        translate([-2.25,0, depth+1])
            rotate([0,105,0])
                cube([shaftDiameter, shaftDiameter+2, 4], center=true);
    }
}

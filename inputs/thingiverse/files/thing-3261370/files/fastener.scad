// tzt-A-fastener.scad
// library for parametric fastener, snap, rivet, grommet, anchor, insert
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: December 2018


// Distance between fastener head and retainer (in mm)
Fastener_Height = 10;

// Fastener shaft diameter (in mm)
Fastener_Diameter = 9.5;

/* [Hidden] */

$fn=100;
TZT_SR=Fastener_Diameter/2;
TZT_SL=Fastener_Height;

translate ([TZT_SR*1.8,0,0]) TZT_FastB();
translate ([-TZT_SR*1.8,0,0]) TZT_FastA();

module TZT_FastB () {
    difference () {
        cylinder (TZT_SR,TZT_SR*1.7,TZT_SR*1.7,$fn=10);
        cylinder (TZT_SR*3,TZT_SR*1.05,TZT_SR*1.05,true);
        translate ([0,0,TZT_SR*.6]) cylinder (TZT_SR*.21,TZT_SR*1.25,TZT_SR*1.05);
        translate ([0,0,TZT_SR*.4]) cylinder (TZT_SR*.21,TZT_SR*1.25,TZT_SR*1.25);
        translate ([0,0,TZT_SR*.2]) cylinder (TZT_SR*.21,TZT_SR*1.05,TZT_SR*1.25);
    }   
}
module TZT_FastA () {
    difference () {
        union () {
            intersection () {
                difference () {
                    union () {
                        cylinder (TZT_SL+TZT_SR*2,TZT_SR,TZT_SR);
                        translate ([0,0,TZT_SL+TZT_SR*1.6]) cylinder (TZT_SR*.2,TZT_SR*1.2,TZT_SR);
                        translate ([0,0,TZT_SL+TZT_SR*1.4]) cylinder (TZT_SR*.2,TZT_SR*1.2,TZT_SR*1.2);
                        translate ([0,0,TZT_SL+TZT_SR*1.2]) cylinder (TZT_SR*.2,TZT_SR,TZT_SR*1.2);
                    }
                    translate ([0,0,TZT_SL/2+TZT_SR*2.3]) cube ([TZT_SR*.6,TZT_SR*4,TZT_SL+TZT_SR*2],true);
                    translate ([0,0,TZT_SR*1.3]) rotate ([90,0,0]) cylinder (TZT_SR*4,TZT_SR*.3,TZT_SR*.3,true);
                }
                translate ([0,0,(TZT_SL+TZT_SR*2)/2]) cube ([TZT_SR*2.4,TZT_SR*1.9,TZT_SL+TZT_SR*2.1],true);
            }
            cylinder (TZT_SR,TZT_SR*1.7,TZT_SR*1.7,$fn=10);
        }
        cylinder ((TZT_SL+TZT_SR)*3,TZT_SR*.6,TZT_SR*.6,true);
    }
}

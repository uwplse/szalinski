// dc-guage-spacer
// Configurable spacer for more comfort with large gauge earings
// Copyright 2014-2017 Nicholas Brookins and Danger Creations, LLC
// http://dangercreations.com/
// https://github.com/nbrookins/danger-gadgets.git
// http://www.thingiverse.com/knick

//distance between the two holes
distance = 4;
//thickness of spacer
thickness = 1.5;

//diameter of gauge hole #1
hole1 = 16;
//additional flare.  Set to zero for a unflared hole
flare1 = 1.25;
//width of material around the hole.  
width1 = 2.5;

//diameter of gauge hole #2
hole2 = 8;
//additional flare.  Set to zero for a unflared hole
flare2 = 1.0;
//width of material around the hole.  
width2 = 2;

$fn=128;
apart = hole1/2 + hole2/2 + distance;

difference(){
    hull(){
        cylinder(d=hole1 + width1, h = thickness);
        translate([apart,0,0]){
            cylinder(d=hole2 + width2, h = thickness);
        }
    }
    translate([0,0,-0.1]){
        cylinder(d1=hole1, d2=hole1+flare1, h = thickness+.2);
        translate([apart,0,0]){
            cylinder(d=hole2, d2=hole2+flare2, h = thickness+.2);
        }
    }
 }
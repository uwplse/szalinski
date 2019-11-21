//Misengineered Light switch case
//Ari M. Diacou
//Feb 3, 2019

////////////////////// Libraries //////////////////////////
use <MCAD/metric_fastners.scad>
///////////////////// Parameters //////////////////////////
//of the wallplate (Parallel to gravity)
height=113;
//of the wallplate
width=70;
//of the wallplate (towards the wall)
depth=20;
//of the front face
thickness=3;
ep=0.05+0;
//the bolt hole diameter is US6 for elctrical bolts
US6=3.5;
//from the middle of the switch (this should not be changed for USA)
hole_offset=48.5;
//for the light switch (default is for a US rocker switch)
hole_dimensions=[34,68];

/* [Hidden] */
///////////////// Derived Parameters//////////////////////
cutout_dimensions=[hole_dimensions[0],hole_dimensions[1],2.1*depth];

/////////////////////// Main() ////////////////////////////
translate([0,0,depth]) mirror([0,0,1])
difference(){
    shell();
    cutout();
    holes();
    }
////////////////////// Modules ////////////////////////////
module cutout(){
    cube(cutout_dimensions,center=true);
    }

module shell(){
    translate(.5*[-width,-height])
    difference(){
        cube([width,height,depth]);
        translate([thickness,thickness,-ep])
        cube([width,height,depth]-thickness*[2,2,1]);
        }
    }

module holes(){
    translate([0,-hole_offset,depth+ep]) rotate([180,0,0]) csk_bolt(US6,depth);
    translate([0,hole_offset,depth+ep]) rotate([180,0,0]) csk_bolt(US6,depth);
    }
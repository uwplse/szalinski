// extruder_temp_tower.scad
// Parametric Extruder Temp Tower
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: February 2019

// Base Temperature - Celsius
Base_Temperature = 200; //

// Number of Steps (5 Deg. increments above base)
Number_of_Steps = 5; //

// Material Identification (4 char. MAX)
Material = "PLA";

// Ascending/Descending
Temperature_Order = 0; //[0:Descending - Base temp on bottom, 1:Ascending - Base temp on top]

/* [Hidden] */

TZT_B=Base_Temperature;
TZT_S=Number_of_Steps;
TZT_M=Material;
TZT_H=Temperature_Order;

$fn=60;

for (i=[1:TZT_S])
    translate ([0,0,10*i-10])
        if (TZT_H==0) {
            TZT_step ([25,TZT_B-5+5*i]);
        } else {
            TZT_step ([25,TZT_B+5*TZT_S-5*i]);
        }

module TZT_step (TZT) {
    difference () {
        hull () {
            for (i=[-1:2:1])
                translate ([i*TZT[0],0,1]) {
                cylinder (9,5,5);
                cylinder (2,4,4,true);
            }
        }
        translate ([-TZT[0]/4,0,5])
            cube ([TZT[0],12,8],true);
        translate ([-TZT[0]-7,0,.5])
            rotate ([90,0,0])
            cylinder (11,9,9,true);
        rotate ([30,0,0])
            translate ([TZT[0]*0.65,9,.3])
            cube ([TZT[0]*0.7,8,10],true);
    }
    cylinder (8,2,.2);
    translate ([-TZT[0]/2,0,0]) cylinder (8,2,.2);
    translate ([TZT[0]-2,3,1])
        rotate ([-120,180,0])
        linear_extrude (2.5)
        text (str (TZT[1]), size=5.5);
    translate ([TZT[0]*.3,-3,2.5])
        rotate ([90,0,0])
        linear_extrude (2.4)
        text (TZT_M, size=5.5);
}
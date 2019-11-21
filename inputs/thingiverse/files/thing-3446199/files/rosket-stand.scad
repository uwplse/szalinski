// rocket_stand.scad
// Parametric Model Rocket Display Stand
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: February 2019

// (in mm)
Step_Diameter = 120;

//
Foot_Count = 3;

// 1/2A=13mm, ABC=18mm, D=24mm (in mm)
Engine_Diameter = 18;

// 1/2A=45mm, ABC=70mm, D=70mm (in mm)
Engine_Depth = 70;

/* [Hidden] */

$fn=100;

//13, 18, 24
TZT_stand ([Step_Diameter/2,Foot_Count,Engine_Diameter,Engine_Depth]);


module TZT_stand (TZT) {
    difference () {
        union () {
            for (i=[0:360/TZT[1]:359])
                rotate ([0,0,i])
                translate ([-TZT[0], 0, 0]) {
                    difference () {
                        union () {
                            translate ([0, .5, 0]) {
                                minkowski() {
                                    cylinder(1,2,0);
                                    rotate([90,0,0]){
                                        linear_extrude(1) {
                                            polygon(points=[[0,0],[TZT[0],0],[TZT[0],15],[5,5]]);
                                        }
                                    }
                                }
                            }
                            translate ([3, 0, 0]) {
                                cylinder(2,6,5);
                            }
                        }
                    }
                }
            cylinder (16,5,TZT[2]/1.8);
            translate ([0,0,16]) cylinder (TZT[3],TZT[2]/2-.1,TZT[2]/2-.2);
        }
        cylinder (16,3,TZT[2]/2-2);
        translate ([0,0,16]) cylinder (TZT[3],TZT[2]/2-2,TZT[2]/2-2);
    }
}

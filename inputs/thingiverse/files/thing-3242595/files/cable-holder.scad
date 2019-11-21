// cable_holder.scad
// library for parametric Cable Holder, Clip, Hook, Hanger, Loop
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: November 2018


// (in mm)
Clip_Diameter = 30;

// (in mm)
Clip_Thickness = 10;

// #4-3mm, #6-3.5mm, #8-4mm, #9-4.5mm, #10-5mm (in mm)
Screw_Gauge = 4;

// (Front or Side)
Clip_Split = 0; // [0:Front,1:Side]


/* [Hidden] */

$fn=100;
TZT_Rad=Clip_Diameter/2;
TZT_Thk=Clip_Thickness;
TZT_Scr=Screw_Gauge;
TZT_Slt=Clip_Split;

difference () {
    TZT_CLIP();
    if ((TZT_Thk/8)<TZT_Scr) {
        TZT_SCREW();
    } else {
        translate ([0,0,TZT_Thk/4]) {
            TZT_SCREW();
        }
        translate ([0,0,-TZT_Thk/4]) {
            TZT_SCREW();
        }
       
    }
}

module TZT_SCREW () {
    translate ([-TZT_Rad*.98,0,0]) {
        rotate ([0,-90,0]) {
            cylinder (TZT_Scr*1.1,TZT_Scr,0);
            cylinder (TZT_Rad*.6,TZT_Scr/2,TZT_Scr/2);
            translate ([0,0,-TZT_Scr]) {
                cylinder (TZT_Scr*1.1,TZT_Scr,TZT_Scr);
            }
            if ((TZT_Slt==1)&&((TZT_Thk/3)>TZT_Scr)) {
                translate ([0,0,-TZT_Rad*3]) {
                    cylinder (TZT_Rad*3,TZT_Scr*.7,TZT_Scr*.7);
                }
            }
        }
    }
}

module TZT_CLIP () {
    difference () {
        union () {
            translate ([-TZT_Rad*1.1,0,0]) {
                difference () {
                    cube ([TZT_Rad*.6,TZT_Rad*2.2,TZT_Thk],true) ;
                    translate ([TZT_Rad*.2,TZT_Rad*1.07,0]) {
                        cylinder (TZT_Thk*1.1,TZT_Rad*.2,TZT_Rad*.2,true);
                    }
                    translate ([TZT_Rad*.2,-TZT_Rad*1.07,0]) {
                        cylinder (TZT_Thk*1.1,TZT_Rad*.2,TZT_Rad*.2,true);
                    }

                }
            }
            cylinder (TZT_Thk,TZT_Rad*1.2,TZT_Rad*1.2,true);
        }
        cylinder (TZT_Thk*4,TZT_Rad,TZT_Rad,true);
        
        if (TZT_Slt==1) {
            rotate ([0,0,90]) TZT_SPLIT();
        } else {
            TZT_SPLIT();
        }       
    }
    module TZT_SPLIT () {
        translate ([TZT_Rad*1.1,0,0]) {
            for (TZT_i=[-30:30:30]) {
                rotate ([-TZT_Rad*10/TZT_Thk,0,TZT_i]) {
                    cube ([TZT_Rad,TZT_Rad*.1,TZT_Thk*2],true);
                }
            }
        }
    }
}
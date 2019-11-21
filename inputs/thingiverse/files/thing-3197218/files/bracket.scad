// bracket.scad
// library for parametric Holder, Clip, Grip, Hook, Hanger, Bracket
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: October 2018


// (in mm)
Clip_Diameter = 30;

// (in mm)
Clip_Thickness = 15;

// #4-3mm, #6-3.5mm, #8-4mm, #9-4.5mm, #10-5mm (in mm)
Screw_Gauge = 4;


/* [Hidden] */

$fn=100;
TZT_Rad=Clip_Diameter/2;
TZT_Thk=Clip_Thickness;
TZT_Scr=Screw_Gauge;

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
        translate ([TZT_Rad*1.3,0,0]) {
            cylinder (TZT_Thk+1,TZT_Rad,TZT_Rad,true);
        }
    }
    for (TZT_i=[-50:100:50]) {
        rotate ([0,0,TZT_i]) {
            translate ([TZT_Rad*1.1,0,0]) {
                cylinder (TZT_Thk,TZT_Rad*.2,TZT_Rad*.2,true);
            }
        }
    }
}
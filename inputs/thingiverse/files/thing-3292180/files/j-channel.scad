// j-channel.scad
// library for parametric J-Channel Cable Holder, Management, Organizer, Hanger
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: December 2018


// 10 or highter for best results (in mm)
Holder_Width = 20;

// 10 or highter for best results (in mm)
Holder_Height = 20;

// 10 or highter for best results (in mm)
Holder_Length = 60;

// <== THIN : THICK ==>
Holder_Thickness = 3; // [1:5]

/* [Hidden] */

$fn=100;
TZT_W = Holder_Width;
TZT_H = Holder_Height;
TZT_L = Holder_Length;
TZT_T = (TZT_W+TZT_H)*(0.05+Holder_Thickness/100);

difference () {
    intersection () {
        union () {
            difference () {
                TZT_J (TZT_W+TZT_T*2, TZT_H, TZT_L, TZT_T);
                TZT_J (TZT_W, TZT_H, TZT_L*1.1, TZT_T);
            }
            translate ([-TZT_H/2,-TZT_W/2+TZT_T*.7,0]) cylinder (TZT_L, TZT_T/2, TZT_T/2, true);
            translate ([-(TZT_H+TZT_W/2)/2-8,-(TZT_W+TZT_T)/2,0]) cube ([TZT_W/2+16, TZT_T, TZT_L], true);
            translate ([-(TZT_H+TZT_W)/2-16,-TZT_W/2-TZT_T,0]) cylinder (TZT_L, TZT_T, TZT_T, true);
        }
        cube ([(TZT_H+TZT_W)*3, TZT_W+TZT_T*2, TZT_L], true);
    }
    if (TZT_L<41) {
        TZT_SCREW (20,4);
    } else {
        for (i=[-1:2:1]) translate ([0,0,i*TZT_L/3]) TZT_SCREW (20,4);
    }    
}

module TZT_J (TZT_W, TZT_H, TZT_L, TZT_T) {
    cube ([TZT_H, TZT_W, TZT_L], true);
    difference () {
        translate ([TZT_H/2,0,0]) cylinder (TZT_L, TZT_W/2, TZT_W/2, true);
        translate ([-TZT_W/2,0,0]) cube ([TZT_W, TZT_W, TZT_L*1.1], true);
    }
    translate ([-TZT_H/2,TZT_T*.6,0]) cylinder (TZT_L, (TZT_W-TZT_T*1.2)/2, (TZT_W-TZT_T*1.2)/2, true);
}

module TZT_SCREW () {
    translate ([-(TZT_H+TZT_W)/2-8,-TZT_W/2,0]) {
        rotate ([90,0,0]) {
            cylinder (4.4,4,0);
            cylinder (TZT_T*1.5,2,2);
            translate ([0,0,-4]) {
                cylinder (4.4,4,4);
            }
        }
    }
}
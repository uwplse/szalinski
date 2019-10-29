// shelf_bracket.scad
// library for parametric wall shelf brackets
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: November 2018



// (in mm)
Bracket_Width = 100;

// (in mm)
Bracket_Height = 20; //[15:50]

// (in mm)
Bracket_Thickness = 5; //[5:10]

Bracket_Style = 1; //[1:Support Style 1, 2:Support Style 2, 3:Support Style 3, 4:Support Style 4]

/* [Hidden] */

$fn=50;
TZT_W=Bracket_Width;
TZT_H=Bracket_Height;
TZT_S=Bracket_Style;
TZT_T=Bracket_Thickness;

//-----------------------

TZT_Bracket ();

//-----------------------

module TZT_Bracket () {
    difference () {
        intersection () {
            union () {
                TZT_BBeam ();
                rotate ([0,0,-90]) mirror ([0,1,0]) TZT_BBeam ();
                difference () {
                    translate ([0,-TZT_T*2,0]) cube ([TZT_T*2,TZT_T*2,TZT_H]);
                    translate ([TZT_T*2,-TZT_T*2,-1]) cylinder (TZT_H+2,TZT_T*1.5,TZT_T*1.5); 
                }
                if (TZT_S==2) {
                    TZT_B2 ();
                } else if (TZT_S==3) {
                    TZT_B3 ();
                } else if (TZT_S==4) {
                    TZT_B4 ();
                } else {
                    TZT_B1 ();
                }
            }
            TZT_BTrim ();
        }
        TZT_BMount ();
    }
    
    module TZT_B1 () {
        TZT_BSupport ([TZT_W-TZT_T*3,TZT_W-TZT_T*3]);
    }
    module TZT_B2 () {
        for (TZT_i=[1:(TZT_W-TZT_T*3)/3:TZT_W-TZT_T*3+1])
            TZT_BSupport ([TZT_i,TZT_i]);       
    }
    module TZT_B3 () {
        for (TZT_i=[(TZT_W-TZT_T*3)/3:(TZT_W-TZT_T*3)/3:TZT_W-TZT_T*3+1])
            TZT_BSupport ([TZT_i,TZT_W-TZT_T*3]);       
    }
    module TZT_B4 () {
        for (TZT_i=[(TZT_W-TZT_T*3)/3:(TZT_W-TZT_T*3)/3:TZT_W-TZT_T*3-1]) {
            TZT_BSupport ([TZT_i,TZT_W-TZT_T*3]);
            rotate ([0,0,-90]) mirror ([0,1,0]) TZT_BSupport ([TZT_i,TZT_W-TZT_T*3]);
        }
    }   
    module TZT_BBeam () {
        translate ([-TZT_T/2,-TZT_T/2,0]) {
            intersection () {
                translate ([TZT_W-TZT_T,TZT_T,0]) cylinder (TZT_H,TZT_T,TZT_T);
                cube ([TZT_W,TZT_T,TZT_H]);
            }
            cube ([TZT_W-TZT_T,TZT_T,TZT_H]);
        }
    }
    module TZT_BSupport (TZT) {
        hull () {
            translate ([TZT[0],0,0]) cylinder (TZT_H, TZT_T/2, TZT_T/2);
            translate ([0,-TZT[1],0]) cylinder (TZT_H, TZT_T/2, TZT_T/2);
        }
    }
    module TZT_BTrim () {
        translate ([-TZT_T/2,-TZT_W+TZT_T/2,0]) cube ([TZT_W, TZT_W, TZT_H]);
    }
    module TZT_BMount () {
        for (TZT_i=[0:1]) rotate (90*TZT_i,0,0) mirror ([TZT_i,0,0]) {
            translate ([TZT_T/3,-TZT_W*.1,TZT_H/2]) TZT_BMHole ();
            translate ([TZT_T/3,-TZT_W*.9,TZT_H/2]) TZT_BMHole ();
        }
        module TZT_BMHole () {
            rotate ([0,90,0]) { 
                cylinder (TZT_W, 4, 4);
                translate ([0,0,-TZT_T*2]) cylinder (TZT_W, 1.5, 1.5);
            }
        }
    }
}
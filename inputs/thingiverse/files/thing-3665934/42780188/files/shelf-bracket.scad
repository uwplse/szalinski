// shelf_bracket.scad
// library for parametric wall shelf brackets
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: November 2018



// (in mm)
Bracket_Width = 100; // [50:200]

// (in mm)
Bracket_Height = 20; //[15:50]

// (in mm)
Bracket_Thickness = 5; //[5:10]

// (in mm)
Side_A_Screw_Diameter = 4.0; //[3.0:0.1:6.0]

// (in mm)
Side_A_Screw_Head_Diameter = 8.0; //[6.0:0.1:10.0]

Side_A_Countersunk = 0; // [0:false, 1:true]

// (in mm)
Side_B_Screw_Diameter = 4.0; //[3.0:0.1:6.0]

// (in mm)
Side_B_Screw_Head_Diameter = 8.0; //[6.0:0.1:10.0]

Side_B_Countersunk = 1; // [0:false, 1:true]

Fit_Tolerance = 0.2;

/* [Hidden] */

TZT_W=Bracket_Width;
TZT_H=Bracket_Height;
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
                $fn=32;
                difference () {
                    translate ([0,-TZT_T*2,0]) cube ([TZT_T*2,TZT_T*2,TZT_H]);
                    translate ([TZT_T*2,-TZT_T*2,-1]) cylinder (TZT_H+2,TZT_T*1.5,TZT_T*1.5); 
                }
                TZT_B1 ();
            }
            TZT_BTrim ();
        }
        TZT_BMount ();
    }
    
    module TZT_B1 () {
        TZT_BSupport ([TZT_W-TZT_T*3-Side_A_Screw_Head_Diameter,TZT_W-TZT_T*3-Side_B_Screw_Head_Diameter]);
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
        $fn=32;
        translate ([TZT_T/3,-TZT_W*.1-Side_A_Screw_Head_Diameter/2,TZT_H/2]) TZT_BMHole (Side_A_Screw_Diameter, Side_A_Screw_Head_Diameter, Side_A_Countersunk);
        translate ([TZT_T/3,-TZT_W*.9+Side_A_Screw_Head_Diameter/2,TZT_H/2]) TZT_BMHole (Side_A_Screw_Diameter, Side_A_Screw_Head_Diameter, Side_A_Countersunk);
        rotate (90,0,0) mirror ([1,0,0]) {
            translate ([TZT_T/3,-TZT_W*.1-Side_B_Screw_Head_Diameter/2,TZT_H/2]) TZT_BMHole (Side_B_Screw_Diameter, Side_B_Screw_Head_Diameter, Side_B_Countersunk);
            translate ([TZT_T/3,-TZT_W*.9+Side_B_Screw_Head_Diameter/2,TZT_H/2]) TZT_BMHole (Side_B_Screw_Diameter, Side_B_Screw_Head_Diameter, Side_B_Countersunk);
        }
        module TZT_BMHole (Screw_Diameter, Screw_Head_Diameter, Countersunk) {
            rotate ([0,90,0]) { 
                cylinder (TZT_W, d=Screw_Head_Diameter + Fit_Tolerance * 2);
                translate ([0,0,-TZT_T*2]) cylinder (TZT_W, d=Screw_Diameter + Fit_Tolerance * 2);
                if (Countersunk) {
                    hull() {
                        delta = Screw_Head_Diameter - Screw_Diameter;
                        cylinder (1, d=Screw_Head_Diameter + Fit_Tolerance * 2);
                        translate ([0,0,-delta]) cylinder (1e-6, d=Screw_Diameter + Fit_Tolerance * 2);
                    }
                }
            }
        }
    }
}
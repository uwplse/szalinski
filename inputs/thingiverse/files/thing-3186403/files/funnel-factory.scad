// funnel_factory.scad
// library for parametric funnel
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: October 2018

/* [Options] */

// Add Rim to top of funnel
Top_Rim = "yes"; //[yes,no]

// Add Loop to funnel rim
Rim_Loop = "yes"; //[yes,no]

// Add Hook to funnel rim
Rim_Hook = "yes"; //[yes,no]

// Add Vent Ridges to sides of funnel
Vent_Ridges = "yes"; //[yes,no]

// Add Strainer to throat of funnel
Throat_Strainer = "yes"; //[yes,no]

/* [Dimentions] */

// (in mm)
Funnel_Mouth_Diameter = 100;

// (in mm)
Funnel_Depth = 60;

// (in mm)
Stem_Throat_Diameter = 25;

// (in mm)
Stem_Tip_Diameter = 10;

// (in mm)
Stem_Depth = 60;

// (in mm)
Wall_Thickness = 1;

/* [Hidden] */

$fn=100;
TZT_FTRad = Funnel_Mouth_Diameter/2;
TZT_STRad = Stem_Throat_Diameter/2;
TZT_SBRad = Stem_Tip_Diameter/2;
TZT_FHgt = Funnel_Depth;
TZT_SHgt = Stem_Depth;
TZT_WThk = Wall_Thickness;

difference () {
    union () {
        if (Vent_Ridges=="yes") {
            TZT_VNT ();
        }
        if (Throat_Strainer=="yes") {
            TZT_STR ();
        }
        TZT_FUN (TZT_FTRad, TZT_STRad,TZT_FHgt,TZT_WThk);
        translate ([0,0,TZT_FHgt]) {
            TZT_FUN (TZT_STRad,TZT_SBRad,TZT_SHgt,TZT_WThk);
        }
        if (Top_Rim=="yes") {
            TZT_RIM ();
        }
    }
    translate ([0,0,TZT_FHgt+TZT_SHgt]) {
        rotate ([0,25,0]) {
            cylinder (TZT_SBRad*2,TZT_SBRad*3,TZT_SBRad*3);
        }
    }
}

module TZT_VNT () {
    translate ([0,0,0]) {
        difference () {
            intersection () {
                translate ([0,0,(TZT_FHgt+TZT_SHgt)/2]) {
                    for (TZT_i=[0:60:180]) {
                        rotate ([0,0,TZT_i]) {
                            cube ([TZT_FTRad*2+TZT_WThk*2,1.2,TZT_FHgt+TZT_SHgt], true);
                        }
                    }
                }
                union () {
                    cylinder (TZT_FHgt,TZT_FTRad+1,TZT_STRad+1);
                    translate ([0,0,TZT_FHgt]) {
                        cylinder (TZT_SHgt,TZT_STRad+1,TZT_SBRad+1);
                    }
                }
            }
            union () {
                cylinder (TZT_FHgt,TZT_FTRad-TZT_WThk,TZT_STRad-TZT_WThk);
                translate ([0,0,TZT_FHgt]) {
                    cylinder (TZT_SHgt,TZT_STRad-TZT_WThk,TZT_SBRad-TZT_WThk);
                }
            }
        }
    }
}

module TZT_STR () {
    translate ([0,0,TZT_FHgt-TZT_WThk]) {
        difference () {
            intersection () {
                translate ([0,0,TZT_STRad]) {
                    for (TZT_i=[0:60:180]) {
                        rotate ([0,0,TZT_i]) {
                            cube ([TZT_STRad*2,1.2,TZT_STRad*2], true);
                        }
                    }
                }
                cylinder (TZT_SHgt,TZT_STRad,TZT_SBRad);
            }
            cylinder (TZT_STRad,TZT_STRad, 0);
        }
    }
}

module TZT_FUN (TZT_FUN_RA,TZT_FUN_RB,TZT_FUN_HT,TZT_FUN_TH) {
    translate ([0,0,TZT_FUN_HT/2]) {
        difference () {
            cylinder (TZT_FUN_HT,TZT_FUN_RA,TZT_FUN_RB,true);
            cylinder (TZT_FUN_HT,TZT_FUN_RA-TZT_FUN_TH,TZT_FUN_RB-TZT_FUN_TH,true);
        }
    }
}

module TZT_RIM () {
    difference () {
        union () {
            cylinder (2,TZT_FTRad+1,TZT_FTRad+1);
            if (Rim_Loop=="yes") {
                translate ([TZT_FTRad+3,0,0]) {
                    difference () {
                        cylinder (2,6,6);
                        cylinder (2,3,3);
                    }
                }
            }
            if (Rim_Hook=="yes") {
                translate ([-TZT_FTRad-12,-6,0]) {
                    cube ([12,12,2]);
                    cube ([2,12,TZT_FHgt/3]);
                    translate ([0,6,TZT_FHgt/3]) {
                        rotate ([0,90,0]) {
                            cylinder (2,6,6);
                        }
                    }
                }
            }
        }
        cylinder (2,TZT_FTRad-TZT_WThk-1,TZT_FTRad-TZT_WThk-1);
    }
} 
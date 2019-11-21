// furniture_foot.scad
// library for parametric furniture foot, leg, pad, protector, standoff
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: November 2018


// Crossection, number of sides (100 = round)
Crossection_Sides = 100; //[3,4,5,6,8,12,100]

// Size/Diameter (in mm)
Base_Diameter = 40; //[10:160]

// Size/Diameter (in mm)
Tip_Diameter = 35; //[10:160]

// (in mm)
Base_Height = 10; //[5:30]

// (in mm)
Stem_Height = 20; //[5:160]

// (in mm)
Screw_Head_Diameter = 10; //[5:30]

// (in mm)
Screw_Shaft_Diameter = 5; //[2:10]


/* [Hidden] */

TZT_BD = Base_Diameter/2;
TZT_TD = Tip_Diameter/2;
TZT_BH = Base_Height;
TZT_SH = Stem_Height;
TZT_HH = Screw_Head_Diameter/2;
TZT_HS = Screw_Shaft_Diameter/2;

$fn=Crossection_Sides;

TZT_FOOT ();

module TZT_FOOT () {
    difference () {
        cylinder (TZT_BH, TZT_BD, TZT_BD);
        cylinder (TZT_BH, TZT_HS, TZT_HS, $fn=100);
    }
    translate ([0,0,TZT_BH]) {
        difference () {
            union () {
                cylinder (TZT_SH-1, TZT_BD, TZT_TD);
                translate ([0,0,TZT_SH-1]) {
                    cylinder (1, TZT_TD, TZT_TD-1);
                }
            }
            cylinder (TZT_SH+1, TZT_HH, TZT_HH, $fn=100);
        }
    }
}











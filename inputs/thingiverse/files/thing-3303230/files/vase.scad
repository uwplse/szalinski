// vase.scad
// library for parametric Vase, Vessel, Dish, Cup, Bowl, Container
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: December 2018


// (in mm)
Base_Diameter = 80;

// (in mm)
Top_Diameter = 160;

// (in mm)
Height = 100;

// Crossection polygon number of sides
Crossection = 5; //[3:Triangle (3-sided),4:Quadrilateral (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octagon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided)]

// (in degrees)
Twist = 180; //[0:360]

/* [Hidden] */

$fn=100;
TZT_BR=Base_Diameter/2;
TZT_TR=Top_Diameter/Base_Diameter;
TZT_HT=Height;
TZT_TW=Twist;
TZT_CS=Crossection;

TZT_vase ();


module TZT_vase () {
    hull () {
        cylinder (1,TZT_BR,TZT_BR);
        translate ([0,0,3]) cylinder (1,TZT_BR*0.95,TZT_BR*0.95,$fn=TZT_CS);
    }
    translate ([0,0,4]) difference () {
        linear_extrude (height=TZT_HT, twist=TZT_TW, scale=TZT_TR, convexity=10, slices=TZT_HT) circle (TZT_BR*0.95,$fn=TZT_CS);
        linear_extrude (height=TZT_HT+.1, twist=TZT_TW, scale=TZT_TR, convexity=10, slices=TZT_HT) circle (TZT_BR*0.95-2,$fn=TZT_CS);
    }
    translate ([0,0,4+TZT_HT]) scale (TZT_TR,TZT_BR,0) rotate ([0,0,-TZT_TW]) {
        translate ([0,0,1]) minkowski () {
            difference () {
                cylinder (1, TZT_BR*0.95-1,TZT_BR*0.95-1,$fn=TZT_CS,true);
                cylinder (1.1, TZT_BR*0.95-1.2,TZT_BR*0.95-1,$fn=TZT_CS,true);
            }
            sphere (1, $fn=10);
        }
    }
}
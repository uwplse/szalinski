// finish_washer.scad
// library for parametric finishing washer, button, ring, pad, accent
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: November 2018

// Washer diameter (in mm): 3x or larger than Screw Gauge.
Washer_Diameter = 20;

// General washer shape
Washer_Type = 1; //[1:CYLINDER, 2:CONE, 3:CHAMFER, 4:DOME]

// Screw shaft diameter (in mm): #4-3mm, #6-3.5mm, #8-4mm, #9-4.5mm, #10-5mm
Screw_Gauge = 4;

// General screw head type
Screw_Head_Type = 1; //[1:FLUSH, 2:RECESSED]

/* [Hidden] */

$fn=50;
TZT_Rad = Washer_Diameter/2;
TZT_Sad = Screw_Gauge/2;
TZT_Thk = Screw_Gauge;
TZT_Wty = Washer_Type;
TZT_Sty = Screw_Head_Type;

difference () {
    TZT_Washer ();
    TZT_Hole ();
}

//-----------------

module TZT_Washer () {
    translate ([0,0,-0.5]) cylinder (0.5, TZT_Rad, TZT_Rad);
    if (TZT_Wty==2) {
        cylinder (TZT_Thk, TZT_Rad, TZT_Sad*2);
    } else if (TZT_Wty==3) {
        cylinder (TZT_Thk*0.7, TZT_Rad, TZT_Rad);
        translate ([0,0,TZT_Thk*0.7]) cylinder (TZT_Thk*0.3, TZT_Rad, TZT_Rad-TZT_Thk*0.3);
    } else if (TZT_Wty==4) {
        difference () {
            scale ([1,1,TZT_Thk/TZT_Rad]) sphere (TZT_Rad);
            translate ([0,0,-TZT_Thk]) cylinder (TZT_Thk, TZT_Rad, TZT_Rad);
        }
    } else {
        cylinder (TZT_Thk, TZT_Rad, TZT_Rad);
    }
}

module TZT_Hole () {
    translate ([0,0,-1]) cylinder (TZT_Thk*9, TZT_Sad, TZT_Sad);
    if (TZT_Sty==2) {
        translate  ([0,0,TZT_Sad+0.1]) cylinder (TZT_Sad, TZT_Sad, TZT_Sad*2);
    } else {
        translate  ([0,0,TZT_Sad+0.1]) cylinder (TZT_Sad, TZT_Sad*2.2, TZT_Sad*2.2);
    }
}
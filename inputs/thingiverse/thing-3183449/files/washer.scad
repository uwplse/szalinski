// washer.scad
// library for parametric washer, bushing, spacer, ring or gasket
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: October 2018


// (in mm)
Outside_Diameter = 30;

// (in mm)
Inside_Diameter = 15;

// (in mm)
Thickness = 5;

/* [Hidden] */

$fn=100;
TZT_WASHER (Thickness, Outside_Diameter/2, Inside_Diameter/2);

module TZT_WASHER (TZT_Thk, TZT_RadA, TZT_RadB) {
    difference () {
        cylinder (TZT_Thk, TZT_RadA, TZT_RadA, true);
        cylinder (TZT_Thk+1, TZT_RadB, TZT_RadB, true);
    }
} 
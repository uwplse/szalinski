// nut_driver.scad
// library for parametric nut drivers, knobs, handles or tools
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: October 2018

// Nut driver or knob (in mm)
Type = 1; //[0:NUT DRIVER (OPEN),1:NUT DRIVER (CLOSED), 2:NUT KNOB, 3:NUT KNOB (REVERSED)]

// Knob diameter (in mm)
Wheel_Diameter = 40;

// Knob thickness (in mm)
Wheel_Width = 10;

// Nut size, width across flats (in mm)
Nut_Size = 9;

// Shaft/Bolt/Rod size (in mm)
Shaft_Size = 6;

// Nut size tolerance (in mm/10)
Nut_Tolerance = 6; //[0:9]

// Nut thickness (in mm)
Nut_Thickness = 6;

/* [Hidden] */

$fn=100;
difference () {
    TZT_Wheel (Wheel_Diameter/2, Wheel_Width, Nut_Size);
    TZT_Hole (Wheel_Width, Nut_Size+(.1*Nut_Tolerance), Nut_Thickness, Type, Shaft_Size/2);
}

module TZT_Hole (TZT_Wid, TZT_Drv, TZT_Thk, TZT_Typ, TZT_Sht) {
    union () {
        TZT_hex = (TZT_Drv / sqrt(3));
        if (TZT_Typ==0) {
            cylinder (TZT_Wid*2, TZT_hex, TZT_hex, true, $fn=6);
        }
        else if (TZT_Typ==1) {
            translate ([0,0,3]) {
                cylinder (TZT_Wid, TZT_hex, TZT_hex, true, $fn=6);
            }
        }
        else if (TZT_Typ==2) {
            cylinder (TZT_Wid+5, TZT_Drv/2.4, TZT_Drv/2.4, true);
            translate ([0,0,TZT_Wid/2-TZT_Thk+2]) {
                cylinder (TZT_Thk+1, TZT_hex, TZT_hex, $fn=6);
            }           
        }
        else {
            cylinder (TZT_Wid+5, TZT_Sht, TZT_Sht, true);
            rotate ([0,180,0]) {
                translate ([0,0,TZT_Wid/2-TZT_Thk]) {
                    cylinder (TZT_Thk+1, TZT_hex, TZT_hex, $fn=6);
                }
            }
        }
    }
}
module TZT_Wheel (TZT_Rad, TZT_Wid, TZT_Drv) {
    difference () {
        union () {
            cylinder (TZT_Wid-2, TZT_Rad, TZT_Rad, true);
            for (TZT_i=[0:180:180]) {
                rotate ([0,TZT_i,0]) {
                    translate ([0,0,TZT_Wid/2-1]) {
                        cylinder (1, TZT_Rad, TZT_Rad-1);
                    }
                }
            }
            translate ([0,0,TZT_Wid/2]) {
                cylinder (2, TZT_Drv, TZT_Drv*.8);
            }
        }       
        for (TZT_i = [0:30:330]) {
            rotate ([0, 0, TZT_i]) {
                translate ([TZT_Rad*1.15, 0, 0]) {
                    cylinder (TZT_Wid+1, TZT_Rad/4, TZT_Rad/4, true);
                }
            }
        }
    }
}
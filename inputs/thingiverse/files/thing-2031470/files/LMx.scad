/*[Standard settings]*/
//Specify the height of the bearing
// use 14mm for FFCP Bearings 
// use 24mm for LM8UU and 45mm for LM8UUL
Height = 24 ; // [10:1:100]
//Specify the outside diameter of the bearing
Outside_Diameter = 15 ; // [15:1:50]
//Specify the inner diameter of the bearing
Inner_Diameter = 8 ; // [6:2:12]
// Specify the shell thickness
Thickness = 2 ; // [1.5:0.25:3]
// Specify inner tolerance needed for specific printers
Tolerance = 0.00 ; // [0:0.05:2]

/*[Design]*/
// Close bearing on bottom and top ?
ClosedDesign = "No" ; // [Yes,No]

/*[Securing]*/
// Thickness for inserting secure rings ?
SecureRing_Thickness = 0; // [0:0.50:1.5]
// Space between bottom and top for inserting rings ?
SecureRing_Height = 2.75; // [2.5:0.25:10]

difference () {
    union () {
        translate ([0,0,0]) rotate ([0,0,22.5]) LMXUU();
        translate ([0,0,0]) rotate ([0,0,67.5]) LMXUU();
    }
    translate ([0,0,0]) rotate ([0,0,0]) LMXUU_Dif();

}

module LMXUU () {
    color ("blue") 
    difference () {
        union () {
            difference () {
                cylinder (d=Outside_Diameter,h=Height);
                translate ([0,0,Thickness/2]) cylinder (d=Outside_Diameter-Thickness+Tolerance,h=Height-Thickness);
                translate ([0,0,-0.5]) cylinder (d=Inner_Diameter+Tolerance,h=Height+1);

                if (ClosedDesign == "No") {
                    translate ([0,0,-Thickness/2]) cylinder (d=Outside_Diameter-Thickness+Tolerance,h=Height+Thickness);
                }

            }
            difference () {
                cylinder (d=Inner_Diameter+Thickness+Tolerance,h=Height);
                translate ([0,0,-0.5]) cylinder (d=Inner_Diameter+Tolerance,h=Height+1);

            }
            translate ([0,-Thickness/4,0]) cube ([Outside_Diameter/2-Thickness/4,Thickness/2,Height]);
            translate ([0,-Thickness/4,0]) mirror ([1,0,0]) cube ([Outside_Diameter/2-Thickness/4,Thickness/2,Height]);
            translate ([-Thickness/4,0,0]) cube ([Thickness/2,Outside_Diameter/2-Thickness/4,Height]);
            translate ([-Thickness/4,0,0]) mirror ([0,1,0]) cube ([Thickness/2,Outside_Diameter/2-Thickness/4,Height]);
        }
    
        translate ([0,0,-0.5]) cylinder (d=Inner_Diameter+Tolerance,h=Height+1);
            difference () {
                translate ([0,0,SecureRing_Height]) cylinder (d=Outside_Diameter+1,h=SecureRing_Thickness);
                translate ([0,0,SecureRing_Height]) cylinder (d=Outside_Diameter-0.75,h=SecureRing_Thickness);
            }
            difference () {
                translate ([0,0,Height-SecureRing_Height-SecureRing_Thickness]) cylinder (d=Outside_Diameter+1,h=SecureRing_Thickness);
                translate ([0,0,Height-SecureRing_Height-SecureRing_Thickness]) cylinder (d=Outside_Diameter-0.65,h=SecureRing_Thickness);
        }
    }
}

module LMXUU_Dif () {
    color ("Blue") 
    union () {
        translate ([0,-Thickness/2,-0.5]) cube ([Outside_Diameter/2-Thickness/2-0.25,Thickness,Height+1]);
        translate ([0,-Thickness/2,-0.5]) mirror ([1,0,0]) cube ([Outside_Diameter/2-Thickness/2-0.25,Thickness,Height+1]);
        translate ([-Thickness/2,0,-0.5]) cube ([Thickness,Outside_Diameter/2-Thickness/2-0.25,Height+1]);
        translate ([-Thickness/2,0,-0.5]) mirror ([0,1,0]) cube ([Thickness,Outside_Diameter/2-Thickness/2-0.25,Height+1]);
    }
}
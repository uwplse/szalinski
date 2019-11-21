// photo_frame.scad
// library for parametric Photo Frame
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: February 2019

// (in mm)
Frame_Width = 130;

// (in mm)
Frame_Height = 78;

// VALUE/100 + 0.5 (effective range 0.5mm - 1.5mm)
Frame_Slot = 50; //[1:100]

/* [Hidden] */

TZT_H=Frame_Height;
TZT_W=Frame_Width;
TZT_S=Frame_Slot/100+0.5;
$fn=50;

difference () {
    TZT_Frame ([TZT_W,TZT_H,TZT_S]);
    translate ([0,0,-20]) cube ([TZT_W*2,TZT_H,40],true);
}

module TZT_Frame (TZT) {
    rotate ([-5,0,0]) 
        translate ([0,0,+TZT[1]/2+3]) {
            difference () {
                union () {
                    minkowski () {
                        translate ([0,0,-1])
                            cube ([TZT[0],1,TZT[1]+2],true);
                        sphere (3);
                    }
                    hull () {
                        sphere (3);
                        translate ([0,3,-TZT[1]/2]) cube (6,true);
                        translate ([0,TZT[1]/3,-TZT[1]/1.9]) sphere (3);
                    }
                }
                translate ([0,0,+3])
                    cube ([TZT[0],TZT[2],TZT[1]+6],true);
                translate ([0,-5,0]) hull () {
                    cube ([TZT[0],1,TZT[1]],true);
                    translate ([0,3,0])
                        cube ([TZT[0]-8,1,TZT[1]-8],true);
                }
                translate ([0,-1,0])
                    cube ([TZT[0]-8,2.5,TZT[1]-8],true);
            }
            for (i=[6:2:TZT[0]-6])
                translate ([-TZT[0]/2+i,-1.5,TZT[1]/2-4])
                rotate ([-50,0,0])
                cube ([.4,5,.8]);
    }
}


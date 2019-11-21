// bracket_mount.scad
// library for parametric bracket, mount, clamp, holder, clip, grip, strap, hanger
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: November 2018



// (in mm)
Bracket_Width = 10;

// (in mm)
Bracket_Height = 10;

// (in mm)
Bracket_Span = 10;

// (in mm)
Bracket_Thickness = 3;


/* [Hidden] */

$fn=50;
TZT_BR=min(Bracket_Span,Bracket_Height)/2;
TZT_BW=max(10,Bracket_Width);
TZT_BH=max(Bracket_Height,Bracket_Thickness)+Bracket_Thickness;
TZT_BS=Bracket_Span+2*Bracket_Thickness;
TZT_BT=Bracket_Thickness;

rotate ([90,0,0]) difference () {
    union () {
        difference () {
            union () {
                rotate ([90,0,0]) TZT_Pipe (TZT_BH*2,TZT_BS,TZT_BW,TZT_BR,TZT_BT);
                TZT_Rod (TZT_BW,TZT_BS+20,min(TZT_BT,10)*2,1);
            }
            translate ([0,0,-TZT_BH/2]) cube ([TZT_BS+20,TZT_BW+.01,TZT_BH],true);
            cube ([TZT_BS-TZT_BT*2,TZT_BW+.01,TZT_BT*2.01],true);
        }
        TZT_a=min(TZT_BT,5,TZT_BR);
        for (TZT_i=[0:180:180]) {
            rotate ([0,0,TZT_i]) translate ([TZT_BS/2+TZT_a/2,0,TZT_BT+TZT_a/2]) rotate ([90,0,0]) TZT_InRad (TZT_a, TZT_BW);
        }
    }
    for (TZT_i=[0:180:180]) {
        if (TZT_BW<40) {
            rotate ([0,0,TZT_i]) translate ([-TZT_BS/2-5,0,-3]) TZT_ScrHole ();
        } else {
            for (TZT_a=[-1:2:1]) {
                rotate ([0,0,TZT_i]) translate ([-TZT_BS/2-5,TZT_a*TZT_BW/4,-3]) TZT_ScrHole ();
            }
        }
    }
}

// 3mm screw hole - recessed at 3mm+
// TZT_ScrHole ()
module TZT_ScrHole () {
    cylinder (TZT_BT+1,1.5,1.5);
    translate ([0,0,+TZT_BT+.01]) if (TZT_BT<3) {
        cylinder (3.1,1.5,1.5);
    } else {    
        cylinder (3,1.5,4.5);
    }
    translate ([0,0,+TZT_BT+3]) cylinder (3,4.5,4.5);
}

// Rounded corner rectangular pipe
// TZT_Pipe (Width, Height, Length, Corner_Radius, Wall_Thickness)
module TZT_Pipe (TZT_w,TZT_h,TZT_l,TZT_r,TZT_t) {
    difference () {
        TZT_Rod (TZT_w,TZT_h,TZT_l,TZT_r);
        TZT_Rod (TZT_w-2*TZT_t,TZT_h-2*TZT_t,TZT_l+.01,TZT_r-TZT_t);
    }
}

// Rounded inside corner
// TZT_InRad (Width, Length)
module TZT_InRad (TZT_w, TZT_l) {
    difference () {
        cube ([TZT_w,TZT_w,TZT_l],true);
        translate ([TZT_w/2,TZT_w/2,0]) cylinder (TZT_l+.01,TZT_w,TZT_w,true);
    }
}

// Rounded corner rectangular rod
// TZT_Rod (Width, Height, Length, Corner_Radius)
module TZT_Rod (TZT_w,TZT_h,TZT_l,TZT_r) {
    iTZT_RH ();
    mirror ([1,0,0]) iTZT_RH ();
    module iTZT_RH () {
        iTZT_RQ (); 
        mirror ([0,1,0]) iTZT_RQ ();
    }
    module iTZT_RQ () {
        translate ([-TZT_h/4+.01,-TZT_w/4+.01,0]) {
            difference () {
                cube ([TZT_h/2,TZT_w/2,TZT_l],true);
                translate ([-TZT_h/4+TZT_r/2,-TZT_w/4+TZT_r/2,0]) TZT_InRad (TZT_r+.01, TZT_l+.01);
            }
        }
    }    
}

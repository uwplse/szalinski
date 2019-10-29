// cable_management_polybox.scad
// Parametric Desktop Cable Organizer, Container, Enclosure, Storage
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: February 2019

// PolyBox Number of Sides
PolyBox_Sides = 3; //[3:3-SIDED, 4:4-SIDED, 5:5-SIDED, 6:6-SIDED, 7:7-SIDED, 8:8-SIDED]

// Polybox Diameter (in mm)
PolyBox_Diameter = 100;

// Polybox Depth (in mm)
PolyBox_Depth = 50;

// Box corner radius (in mm)
PolyBox_Corner_Radius = 8; //[4:50]

// Box Thickness
PolyBox_Thickness = 2; //[1:5]

// Cable Center Post
Center_Post = 1; //[1:YES, 0:NO]

// Group
Build_Group = 1; //[1:BOTH, 2:BOX, 3:LID]

/* [Hidden] */

TZT_S = PolyBox_Sides;
TZT_R = PolyBox_Diameter/2;
TZT_D = PolyBox_Depth;
TZT_C = PolyBox_Corner_Radius;
TZT_T = PolyBox_Thickness;
TZT_P = Center_Post;
$fn=50;


//TZT_Box ([sides, radius, depth, corner_radius])

if (Build_Group!=3) translate ([0,TZT_R*1.1,0]) TZT_Box ();
if (Build_Group!=2) translate ([0,-TZT_R*1.1,0]) TZT_Lid ();

module TZT_Lid () {
    translate ([0,0,7]) {
        difference () {
            hull () {
                TZT_Vol ([TZT_S,TZT_R+TZT_T+.5,10,TZT_C+TZT_T+.5]);
                translate ([0,0,-6]) TZT_Vol ([TZT_S,TZT_R+TZT_T-.5,1,TZT_C+TZT_T-.5]);
            }
            translate ([0,0,TZT_T]) TZT_Vol ([TZT_S,TZT_R+.5,11,TZT_C+.5]);
        }
        if (TZT_P==1) {
            difference () {
                cylinder (10,TZT_R/6+TZT_T,TZT_R/6+TZT_T,true);
                cylinder (11,TZT_R/6+0.1,TZT_R/6+0.1,true);
            }
        }
    }
}

module TZT_Box () {
    translate ([0,0,TZT_D/2]) {
        difference () {
            TZT_Vol ([TZT_S,TZT_R,TZT_D,TZT_C]);
            translate ([0,0,TZT_T]) TZT_Vol ([TZT_S,TZT_R-TZT_T,TZT_D,TZT_C-TZT_T]);
            TZT_Cslot ();
        }
        if (TZT_P==1) cylinder (TZT_D,TZT_R/6,TZT_R/6,true);
    }    
}

module TZT_Vol (TZT) {
    hull ()
        for (i=[0:360/TZT[0]:359])
        rotate ([0,0,i])
        translate ([TZT[1]-TZT[3], 0, 0]) 
        cylinder (TZT[2], TZT[3], TZT[3], true);
}

module TZT_Cslot () {
    for (i=[0:360/TZT_S:359]) {
        rotate ([180,-90,360/TZT_S/2+i])
            translate ([-TZT_D/2+10,0,TZT_R/2])
            union () {
                cylinder (TZT_R,5,5);
                translate ([0,-5,0]) cube ([TZT_D,10,TZT_R]);
            }
    }
}
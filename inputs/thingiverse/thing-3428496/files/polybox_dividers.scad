// trinket_box.scad
// library for parametric Trinket Box, Container, Enclosure, Organizer, Storage
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

// Group
Build_Group = 1; //[1:BOTH, 2:BOX, 3:LID]

/* [Hidden] */

TZT_S = PolyBox_Sides;
TZT_R = PolyBox_Diameter/2;
TZT_D = PolyBox_Depth;
TZT_C = PolyBox_Corner_Radius;
TZT_T = PolyBox_Thickness;
$fn=100;


//TZT_Box ([sides, radius, depth, corner_radius])

if (Build_Group!=3) translate ([0,TZT_R*1.1,0]) TZT_Box ();
if (Build_Group!=2) translate ([0,-TZT_R*1.1,0]) TZT_Lid ();

module TZT_Lid () {
    translate ([0,0,7])
    difference () {
        hull () {
            TZT_Vol ([TZT_S,TZT_R+TZT_T+.5,10,TZT_C+TZT_T+.5]);
            translate ([0,0,-6]) TZT_Vol ([TZT_S,TZT_R+TZT_T-.5,1,TZT_C+TZT_T-.5]);
        }
        translate ([0,0,TZT_T]) TZT_Vol ([TZT_S,TZT_R+.5,11,TZT_C+.5]);
    }
}

module TZT_Box () {
    translate ([0,0,TZT_D/2])
        difference () {
            TZT_Vol ([TZT_S,TZT_R,TZT_D,TZT_C]);
            translate ([0,0,TZT_T]) TZT_Vol ([TZT_S,TZT_R-TZT_T,TZT_D,TZT_C-TZT_T]);
        }
        translate ([0,0,TZT_T]) TZT_Div ([TZT_S,TZT_R-TZT_T,TZT_D,TZT_C-TZT_T]);
}

module TZT_Vol (TZT) {
    hull ()
        for (i=[0:360/TZT[0]:359])
        rotate ([0,0,i])
        translate ([TZT[1]-TZT[3], 0, 0]) 
        cylinder (TZT[2], TZT[3], TZT[3], true);
}

module TZT_Div (TZT) {
    for (i=[0:360/TZT[0]:359])
        rotate ([0,0,i])
        translate ([TZT[1]/2, 0, TZT_D/2-TZT_T*1.5]) 
        cube ([TZT[1],TZT_T,TZT[2]-TZT_T],true);
}

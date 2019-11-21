// trinket_box_inlay.scad
// library for parametric Trinket Box, Container, Enclosure, Organizer, Storage
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: January 2019

// Length of box exterior (in mm)
Box_Length = 110; //[110:200]

// Width of box exterior (in mm)
Box_Width = 110; //[110:200]

// Depth of box exterior (in mm)
Box_Depth = 50;

// Box style/structure tune
Box_Style = 2; //[2:10]

// Group
Build_Group = 1; //[1:BOTH, 2:BOX, 3:LID]


/* [Hidden] */

TZT_X=Box_Length-8;
TZT_Y=Box_Width-8;
TZT_Z=Box_Depth;
TZT_R=4;
TZT_W=TZT_R/Box_Style+1;
$fn=40;

//---------------

if (Build_Group!=3) translate ([0,Box_Width*0.55,0]) TZT_Container ();
if (Build_Group!=2) translate ([0,-Box_Width*0.55,TZT_W+TZT_R/2]) rotate ([0,180,0]) TZT_Lid ();

module TZT_Lid () {
    difference () {
        union () {
            translate ([0,0,TZT_W]) TZT_Box ([TZT_X,TZT_Y,TZT_R/2,TZT_R,TZT_R/2]);
            TZT_Box ([TZT_X,TZT_Y,TZT_W,TZT_R,TZT_R]);
            translate ([0,0,-TZT_W]) TZT_Box ([TZT_X-2*TZT_W-1,TZT_Y-2*TZT_W-1,TZT_W,TZT_R-TZT_W-0.5,TZT_R-TZT_W-0.5]);
        }
        translate([0,0,4]) cylinder (8,46,49,true, $fn=100);
        translate([0,0,1]) cylinder (3,47.2,47,true, $fn=100);
        translate([0,0,-0]) cylinder (10,45,45,true, $fn=100);
    }
}

module TZT_Container () {
    difference () {
        TZT_Box ([TZT_X,TZT_Y,TZT_Z,TZT_R,TZT_R]);
        translate ([0,0,TZT_W]) TZT_Box ([TZT_X-2*TZT_W,TZT_Y-2*TZT_W,TZT_Z,TZT_R-TZT_W,TZT_R-TZT_W]);
        TZT_Thmb=TZT_W/10;
        for (x=[-1:2:1]) {
            translate ([0,(TZT_Y/2+TZT_R)*x,TZT_Z]) scale ([1,TZT_Thmb,1]) sphere (10);
            translate ([(TZT_X/2+TZT_R)*x,0,TZT_Z]) scale ([TZT_Thmb,1,1]) sphere (10);
        }
    }   
}

module TZT_Box (TZT_Sz) {
    hull () {
        for (x=[-1:2:1]) for (y=[-1:2:1]) {
            translate ([TZT_Sz[0]/2*x,TZT_Sz[1]/2*y,0]) cylinder (TZT_Sz[2],TZT_Sz[3],TZT_Sz[4]);
        }
    }
}
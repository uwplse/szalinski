// game_die.scad
// library for parametric gaming dice
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: January 2019

Game_Die_Size = 20;
Game_Die_Type = 1; //[0:GENERIC CUBE,1:ROUND CORNER,2:ROUND EDGE]
Roundness = 5; //[1:10]

/* [Hidden] */

$fn=40;

TZT_Size = Game_Die_Size;
TZT_Rnd = Roundness;
TZT_Typ = Game_Die_Type;

difference () {
    if (TZT_Typ==1) {
        TZT_DieB ();
    } else if (TZT_Typ==2) {
        TZT_DieC ();
    } else {
        TZT_DieA ();
    }
    TZT_Dots ();
}

module TZT_DieA () {
    cube (TZT_Size,true);
}

module TZT_DieB () {
    TZT_Rnd = TZT_Size/TZT_Rnd;
    intersection () {
        TZT_DieA ();
        sphere (TZT_Size/2+(TZT_Size+TZT_Rnd)/7);
    }
}

module TZT_DieC () {
    TZT_Rnd = TZT_Rnd/3;
    TZT_Offset=(TZT_Size/2-TZT_Rnd);
    hull () {
        for (ix=[-1:2:1]) for (iy=[-1:2:1]) for (iz=[-1:2:1]) {
            translate ([ix*TZT_Offset,iy*TZT_Offset,iz*TZT_Offset])
                sphere (TZT_Rnd);
        }
    }
}

module TZT_Dots () {
    TZT_Dsz=TZT_Size/10;
    TZT_Dfs=TZT_Size/2;
    TZT_Dos=TZT_Size/4.5;
    //bottom
    rotate ([180,0,0]) TZT_Dot ();
    //top
    TZT_2Dot ();
    translate ([0,-TZT_Dos,0]) TZT_2Dot ();
    rotate ([0,0,180]) TZT_2Dot ();
    //front
    rotate ([90,0,0]) {
        TZT_Dot ();
        TZT_2Dot ();
        rotate ([0,0,180]) TZT_2Dot ();
    }
    //left
    rotate ([0,-90,0]) {
        TZT_Dot ();
        for (i=[-1:2:1])
            translate ([i*TZT_Dos,i*TZT_Dos,0]) TZT_Dot ();
    }
    //back
    rotate ([-90,0,0]) {
        for (i=[-1:2:1])
            translate ([i*TZT_Dos,i*TZT_Dos,0]) TZT_Dot ();
    }
    //right
    rotate ([0,90,0]) {
        TZT_2Dot ();
        rotate ([0,0,180]) TZT_2Dot ();
    }
    module TZT_2Dot () {
        for (i=[-1:2:1]) translate ([i*TZT_Dos,TZT_Dos,0]) TZT_Dot ();
    }
    module TZT_Dot () {
        translate ([0,0,TZT_Dfs]) sphere (TZT_Dsz);
    }
}
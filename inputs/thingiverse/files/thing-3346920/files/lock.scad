// lock.scad
// library for parametric door lock, latch, bolt, detent
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: Jaqnuary 2019


// (in mm)
Length = 100;

// (in mm)
Width = 50;

/* [Hidden] */

//$fn=100;
TZT_Bolt ([Length,Width/2]);

module TZT_Bolt (TZT_Size) {
    difference () {
        rotate ([90,90,0]) difference () {
            TZT_Pill (TZT_Size);
            translate ([TZT_Size[1]/2,0,0])
                cube ([TZT_Size[1],TZT_Size[1]*2,TZT_Size[1]*2+TZT_Size[0]],true);
            TZT_Pill ([TZT_Size[0], TZT_Size[1]/2]);
        }
        for (i=[-1:2:1]) for (j=[-1:1:1]) {
            translate ([i*(TZT_Size[1]/2+5),j*TZT_Size[0]*0.40+TZT_Size[0]*0.05,0])
                cylinder (TZT_Size[1]*2,5,5,true);
        }
        translate ([0,+TZT_Size[0]*0.25,0])
            cube ([TZT_Size[1]*2,1,TZT_Size[1]*2],true);
        
        hull ()
            for (i=[0.1,0.5])
                translate ([0,-i*TZT_Size[0],0])
                cylinder (TZT_Size[1],TZT_Size[1]/3,TZT_Size[1]/3);
    }
    for (i=[-1:2:1]) for (j=[-1:1:1]) {
        translate ([i*(TZT_Size[1]/2+5),j*TZT_Size[0]*0.40+TZT_Size[0]*0.05,0]) TZT_Mount ();
    }
    rotate ([90,90,0]) difference () {
        translate ([0,0,TZT_Size[0]*0.15+TZT_Size[1]/4])
            union () {
                TZT_Pill ([TZT_Size[0]*0.7-TZT_Size[1]/2, TZT_Size[1]/2-1]);
                rotate ([0,90,0])
                    translate ([-TZT_Size[0]/2+TZT_Size[0]*0.15+TZT_Size[1]/4,0,-TZT_Size[1]/2])
                    TZT_Pill ([TZT_Size[1], TZT_Size[1]/3-1]);
            }
        translate ([TZT_Size[1]/2,0,0])
            cube ([TZT_Size[1],TZT_Size[1]*2,TZT_Size[1]*2+TZT_Size[0]],true);
    }
}
module TZT_Mount () {
    translate ([0,0,5]) difference () {
        cylinder (10,5,5,true);
        cylinder (11,2,2,true);
        translate ([0,0,4]) cylinder (3,2,5,true);
    }
}
module TZT_Pill (TZT_Size) {
    cylinder (TZT_Size[0],TZT_Size[1],TZT_Size[1],true);
    for (i=[-1:2:1]) translate ([0,0,i*TZT_Size[0]/2]) sphere (TZT_Size[1]);
}
// transition_factory.scad
// library for parametric model rocket body tube transitions with clustering
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: December 2018

/* [Parameters] */

// Front Body tube OUTSIDE diameter (in mm)
Front_Tube_Outside_Diameter = 19; //

// Front Body tube INSIDE diameter (in mm)
Front_Tube_Inside_Diameter = 18; //

// Transition height (in mm)
Transition_Height = 40; //

// Rear Body tube OUTSIDE diameter (in mm)
Rear_Tube_Outside_Diameter = 19; //

// Rear Body tube INSIDE diameter (in mm)
Rear_Tube_Inside_Diameter = 18; //

Rear_Cluster_Configuration = 3; //[1:Single,2:Double,3:Triple,6:Triple Flat,4:Quadruple,5:Quintuple]

/* [Hidden] */

TZT_FOR=Front_Tube_Outside_Diameter/2;
TZT_FIR=Front_Tube_Inside_Diameter/2;
TZT_ROR=Rear_Tube_Outside_Diameter/2;
TZT_RIR=Rear_Tube_Inside_Diameter/2;
TZT_HGT=Transition_Height;
TZT_CTR=Rear_Cluster_Configuration;
$fn=100;


union () {   
    if (TZT_CTR==1) {
        translate ([0,0,TZT_HGT]) mirror ([0,0,1]) TZT_Sleave (TZT_FOR,TZT_FIR,0);
        difference () {
            cylinder (TZT_HGT,TZT_ROR,TZT_FOR);
            translate ([0,0,-TZT_HGT*.01]) cylinder (TZT_HGT*1.02,TZT_RIR*.9,TZT_FIR*.9);
        }
        TZT_Sleave (TZT_ROR,TZT_RIR,1);
    } else if (TZT_CTR==2) {
        TZT_Cluster (0,180,180,TZT_ROR);
    } else if (TZT_CTR==3) {
        TZT_Cluster (0,120,240,TZT_ROR*1.15);
    } else if (TZT_CTR==4) {
        TZT_Cluster (0,90,270,TZT_ROR*1.4);
    } else if (TZT_CTR==5) {
        TZT_Cluster (0,72,288,TZT_ROR*1.7);
    } else if (TZT_CTR==6) {
        translate ([0,0,TZT_HGT]) mirror ([0,0,1]) TZT_Sleave (TZT_FOR,TZT_FIR,0);
        difference () {
            for (TZT_i=[-1:1:1]) {
                hull () {
                    translate ([0,0,TZT_HGT]) cylinder (.1,TZT_FOR,TZT_FOR);
                    translate ([0,TZT_i*TZT_ROR*2,0]) cylinder (.1,TZT_ROR,TZT_ROR);
                }
                translate ([0,TZT_i*TZT_ROR*2,0]) TZT_Sleave (TZT_ROR,TZT_RIR,1);
            }
            for (TZT_i=[-1:1:1]) {
                hull () {
                    translate ([0,0,TZT_HGT]) cylinder (.3,TZT_FIR*.9,TZT_FIR*.9,true);
                    translate ([0,TZT_i*TZT_ROR*2,0]) cylinder (.3,TZT_RIR*.9,TZT_RIR*.9,true);
                }
            }
        }
    }
}
module TZT_Sleave (TZT_TOR,TZT_TIR,TZT_MNT) {
    difference () {
        union () {
            translate ([0,0,-TZT_TOR+TZT_TIR]) cylinder (TZT_TOR-TZT_TIR,TZT_TIR,TZT_TOR);
            translate ([0,0,-TZT_TIR*2]) cylinder (TZT_TIR*2,TZT_TIR,TZT_TIR);
        }
        translate ([0,0,-TZT_TIR*2.01]) cylinder (TZT_TIR*2.02,TZT_TIR*.9,TZT_TIR*.9);
    }
    if (TZT_MNT==1) {
        translate ([0,0,-TZT_TIR*1.8]) {
            for (TZT_i=[0:90:90]) {
                rotate ([0,90,TZT_i]) cylinder (TZT_TIR*1.9,TZT_TIR*.1,TZT_TIR*.1,true);
                rotate ([0,90,TZT_i]) translate ([TZT_TIR*.1,0,0]) cube ([TZT_TIR*.2,TZT_TIR*.2,TZT_TIR*1.9],true);
            }
        }
    }
}
module TZT_Cluster (TZT_ia,TZT_ib,TZT_ic,TZT_OFST) {
    translate ([0,0,TZT_HGT]) mirror ([0,0,1]) TZT_Sleave (TZT_FOR,TZT_FIR,0);
    difference () {
        for (TZT_i=[TZT_ia:TZT_ib:TZT_ic]) {
            hull () {
                translate ([0,0,TZT_HGT]) cylinder (.1,TZT_FOR,TZT_FOR);
                rotate (TZT_i,0,0) translate ([0,TZT_OFST,0]) cylinder (.1,TZT_ROR,TZT_ROR);
            }
            rotate (TZT_i,0,0) translate ([0,TZT_OFST,0]) TZT_Sleave (TZT_ROR,TZT_RIR,1);
        }
        for (TZT_i=[TZT_ia:TZT_ib:TZT_ic]) {
            hull () {
                translate ([0,0,TZT_HGT]) cylinder (.3,TZT_FIR*.9,TZT_FIR*.9,true);
                rotate (TZT_i,0,0) translate ([0,TZT_OFST,0]) cylinder (.3,TZT_RIR*.9,TZT_RIR*.9,true);
            }
        }
    }

}



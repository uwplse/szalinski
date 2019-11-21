//************************************************************************************
//*
//*  This creates a car set cupholder
//*
//* The global variables can be edited as required for better resolution, a tighter
//*  or looser fit or a different fillet size.
//*
//* Keith Welker 2/2/18
//************************************************************************************
//dimensions (all in mm) (unless stated otherwise)

//
// MISC variables
//
//$fn for cylinders
FN = 360;// [60:Low Detail,120:Medium Detail,360:High Detail]

//a small offset to clear up any cutouts.
DELTA = .005; // [.001,.005,.01,.1]

//
// cupholder configuration variables
//
//recomended 3 cup holder setup
// LH cup holder: foot = "yes", mating_RH = "yes", and mating_LH = "no"
// middle cup holder: foot = "no", mating_RH = "yes", and mating_LH = "yes"
// RH cup holder: foot = "yes", mating_RH = "no", and mating_LH = "yes"
//front foot for cupholder stability?
foot = "no"; // [yes,no]
//left hand "external" mating features?
mating_LH = "yes"; // [yes,no]
//right hand "internal" mating features?
mating_RH = "yes"; // [yes,no]


//
// cupholder variables
//
//cupholder length
ch_L = 95;
//cupholder width
ch_W = 82;
//cup depth (I.E. how far the cup is in tye cupholder)
cup_H = 60;
//cup diameter 
cup_D = 78;
// cupholder height is cup depth + bottom thickness
ch_BT = 5;

//
// cupholder foot variables
//

//cupholder foot length
foot_L = 50;
//cupholder foot width
foot_W = 15;
//cupholder foot height 
foot_H = 5;

//
// cupholder mating variables
//

//mating "cylinder" diameter
mating_D = 12;
//mating "cylinder" height
mating_H = 20;
//mating wall thickness (I.E. remaining in cup holder)
mating_WT = 5;
//mating foot height 
mating_FH = 5;

//
// cupholder mating variables
//

//mating clearance
mating_CL = .75; // [.2,.5, .75,1,2]
/* [Hidden] */
// don't show these variable in customizer...
//mating "cylinder" diameter
mating_D_LH = mating_D - 2*mating_CL ;
//mating "cylinder" height
mating_H_LH = mating_H - mating_CL ;
//mating foot height 
mating_FH_LH = mating_FH - mating_CL ;

cupholder(foot_yesno = foot, mating_RH_yesno = mating_RH, mating_LH_yesno = mating_LH);


//difference()
//{
//    union()
//    {
//        translate([-ch_L-.2,0,0])
//        cupholder(foot_yesno = "yes", mating_RH_yesno = "yes", mating_LH_yesno = "no");
//        cupholder(foot_yesno = "no", mating_RH_yesno = "yes", mating_LH_yesno = "yes");
//        translate([ch_L+.2,0,0])
//        cupholder(foot_yesno = "yes", mating_RH_yesno = "no", mating_LH_yesno = "yes");
//    }
//    // uncomment to test the build/fit of the three cupholder system...
//    translate([-ch_L-.2-DELTA,-4*DELTA-ch_W+mating_WT+mating_D/2, -DELTA])
//    cube([ch_L, ch_W+8*DELTA,cup_H+ch_BT+2*DELTA]);
//}

//************************************************************************************
//* this module creates the cupholder
//************************************************************************************
module cupholder()
{
    union()
    {
        difference()
        {
            cube([ch_L, ch_W,cup_H+ch_BT]);
            translate([ch_L/2,ch_W/2,ch_BT])
            cylinder(cup_H+DELTA, r=cup_D/2, $fn = FN);
            if (mating_RH_yesno == "yes")
            {
                //front mating cylinder
                translate([ch_L-mating_D/2-mating_WT,mating_D/2+mating_WT,-DELTA/2])
                cylinder(mating_H+DELTA, r=mating_D/2, $fn = FN);
                //front mating foot
                translate([ch_L-mating_WT-mating_D/2,mating_WT,-DELTA/2])
                cube([mating_D/2+mating_WT+DELTA, mating_D,mating_FH+DELTA]);
                //rear mating cylinder
                translate([ch_L-mating_D/2-mating_WT,ch_W-mating_D/2-mating_WT,-DELTA/2])
                cylinder(mating_H+DELTA, r=mating_D/2, $fn = FN);
                //rear mating foot
                translate([ch_L-mating_WT-mating_D/2,ch_W-mating_WT-mating_D,-DELTA/2])
                cube([mating_D/2+mating_WT+DELTA, mating_D,mating_FH+DELTA]);
            }        
        }
        if (foot_yesno == "yes")
        {
            translate([ch_L/2-foot_W/2,-foot_L,0])
            cube([foot_W, foot_L+DELTA,foot_H]);
        }
        if (mating_LH_yesno == "yes")
        {
            //front mating cylinder
            translate([-mating_D/2-mating_WT,mating_D/2+mating_WT,0])
            cylinder(mating_H_LH, r=mating_D_LH/2, $fn = FN);
            //front mating foot
            translate([-mating_WT-mating_D/2,mating_WT+(mating_D-mating_D_LH)/2,0])
            cube([mating_D/2+mating_WT+DELTA, mating_D_LH,mating_FH_LH]);
            //rear mating cylinder
            translate([-mating_D/2-mating_WT,ch_W-mating_D/2-mating_WT,0])
            cylinder(mating_H_LH, r=mating_D_LH/2, $fn = FN);
            //rear mating foot
            offset1 = ch_W-mating_WT-mating_D+(mating_D-mating_D_LH)/2;
            translate([-mating_WT-mating_D/2,offset1,0])
            cube([mating_D/2+mating_WT+DELTA, mating_D_LH,mating_FH_LH]);

        }
    }
    
}
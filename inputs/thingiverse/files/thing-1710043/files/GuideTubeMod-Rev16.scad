//Remix of Guide Tube to convert to openscad and make some dimensions Parametric
//Remixed from: http://www.thingiverse.com/thing:508896
//8/5/2016  By: David Bunch
//
//This remix allows you to:
//1. Adjust the Length of the Guide Tube
//2. Adjust the Height of the Guide Tube Stem
//3. Adjust the Z Angle of the Guide Tube
//4. Filament opening option for either 1.75mm, 3mm or Both with variable Filament_Type
//5. Option for slotted Filament opening with variable Filament_Slot
//6. You can also adjust the hole diameters used and a few other odd variables

//These 3 variables used to show the complete part in the View Area (Comment out if you do not want this)
//$vpt=[19,-66,18];
//$vpr =[53.6,0,237.3];
//$vpd =580;

//CUSTOMIZER VARIABLES

//1. Length of Arm (136 original)
Len = 136;                  //Length from End to center of Vertical Guide Tube (136mm original)
                            //Original shorter Guide Tube arm is 109mm
                            //I used 116mm for my Foger Tech Kossel
//2. Height of the Guide Tube Stem
Ht = 70;                    //Height from Base to Center Line of Filament Horizontal Guide

//3. Filament Type (1 = 1.75mm, 3 = 3mm or 0 = both)
Filament_Type = 0;          //1 = 1.75mm filament, 3 = 3mm filament, 0 = 1.75 & 3mm

//4. Filament Slotted opening in top (1 = Yes, 0 = No)
Filament_Slot = 0;          //1 = Yes, 0 = No

//5. Rotation Angle of Guide Tube (negative is clockwise)
Guide_ZRot = 0;             //I used -30 for my Folger Tech Kossel

//6. Guide Tube X offset (Not usually needed)
Guide_X_Offset = 0;         //May need this if you rotate the guide tube

//7. Diameter of hole for 1.75mm Filament
Fil1_OD = 3;

//8. Diamenter of hole for 3mm Filament
Fil3_OD = 4;

/* [Hidden] */

Tran_Len = Len - 7.13;     //Original is 128.87mm
TR_Top = Ht-19-45.39;       //Need this variable to be able to change transition height at top of Stem
SpongeDepth = 16;           //Originally 21.44mm
SpongeHt = SpongeDepth - 10.44;
TranArm_1st = 36.75;        //1st Transition distance at Arm Connection
SS_X_Offset = 1.75;         //Set Screw X Offset (I think this is used for a set screw)
SS_Z_Offset = .3;           //Set Screw Z Offset
SS_Ang = -20;               //Set Screw X rotation (-10 was close to original)
OD = 20;                    //Diameter of Base of the Vertical Stem
OD18 = 18.0;                //Outside Diameter of Main Part of Guide Tube

//These 4 diameters are used at the bottom of Stem (Not sure what they are used for,but left them in)
OD23 = 2.3;
OD3 = 3.0;
OD35 = 3.5;
OD43 = 4.3;

Fil1_Tap_OD = 5.88;             //Taper opening for 1.75mm Filament
Fil1_Tube_OD = 4.47;            //Bowden Tube Diameter for 1.75mm Filament
Fil1_Slot_OD = Fil1_OD + 2;     //Diameter to use for top of Slotted Opening for 1.75mm Filament
Fil1_OD_Res = (round(((Fil1_Tube_OD * 3.14)/4)/.7)*4);


Fil3_Tap_OD = 7.88;             //Taper opening for 3mm Filament
Fil3_Tube_OD = 6.48;            //Bowden Tube Diameter for 3mm Filament
Fil3_Slot_OD = Fil3_OD + 2;     //Diameter to use for top of Slotted Opening for 3mm Filament
Fil3_OD_Res = (round(((Fil3_Tube_OD * 3.14)/4)/.7)*4);

OD_Res = (round(((OD * 3.14)/4)/.7)*4);         //Resolution of Outside Diameter
OD18_Res = (round(((OD18 * 3.14)/4)/.7)*4);

echo(TR_Top = TR_Top);
echo(Tran_Len = Tran_Len);
echo(OD18_Res = OD18_Res);

module BotGuideHull()
{
    difference()
    {
        rotate([0,90,0])
        cylinder(d=OD18,h=27,$fn=OD18_Res,center=true);
        translate([-15,-15,-5.27])
        cube([30,30,30]);
    }
}
//Used to reference original to check how close it matches
//module GuideTube()
//{
//    translate([0,6,0])
//    color("red",.5)
//    import("Guide-tube_holder_and_filament_filter.stl", convexity = 5);
//}
//GuideTube();
module Guide()
{
    union()
    {
        translate([0,-Len,Ht])
        rotate([0,90,0])
        translate([0,0,-15])
        {
            cylinder(d1=OD18-3,d2=OD18,h=1.5,$fn=OD18_Res);
            translate([0,0,1.5])
            cylinder(d=OD18,h=27,$fn=OD18_Res);
            translate([0,0,28.5])
            cylinder(d1=OD18,d2=OD18-3,h=1.5,$fn=OD18_Res);
        }
        HullMidTop();
    }
}
module GuideTubeRotate()
{
    translate([Guide_X_Offset,-Len,Ht])
    rotate([0,0,Guide_ZRot])
    translate([0,Len,-Ht])      //Translate back to origin before rotating
    Guide();
}
module TopCube()
{
    hull()
    {
        translate([-4.5,-(Len + 7.5),Ht])
        RndBox(9,15,10,2);
        translate([-3.5,-(Len + 6.5),Ht+10])
        RndBox(7,13,1,1);
    }
}
module InsertSponge()
{
    translate([0,-Len,Ht-SpongeHt])
    {
        hull()
        {
            translate([-.825,-3.825,0])
            cube([1.65,7.65,.1]);
            translate([-2.71,-5.71,SpongeDepth])
            cube([5.42,11.42,.1]);
        }
        hull()
        {
            translate([-2.71,-5.71,SpongeDepth])
            cube([5.42,11.42,.1]);
            translate([-3.21,-6.21,SpongeDepth+.5])
            cube([6.42,12.42,.1]);
        }
        translate([-3.21,-6.21,SpongeDepth+.5])
        cube([6.42,12.42,1]);
    }
}
module HullMidTop()
{
    hull()
    {
        translate([0,-Len,Ht])
        rotate([0,90,0])
        color("tan")
        cylinder(d=OD18,h=11.6,$fn=OD18_Res,center=true);
        TopCube();
    }
}
//This module is called by Rounded Box
module RndTop(Rnd_OD = 9,Rnd_Ht = 5,Rnd_Res)
{
    Rnd_Rad = Rnd_OD / 2;
    translate([-Rnd_Rad,Rnd_Rad,0])
    difference()
    {
        cylinder(d=Rnd_OD*2,h=Rnd_Ht+2,$fn=Rnd_Res);
        translate([0,0,-1])
        cylinder(d=Rnd_OD,h=Rnd_Ht+4,$fn=Rnd_Res);
        translate([-Rnd_OD,0,-1])
        cube([Rnd_OD*2,Rnd_OD,Rnd_Ht+4]);
        translate([-Rnd_OD,-Rnd_OD,-1])
        cube([Rnd_OD,Rnd_OD+1,Rnd_Ht+4]);
    }
}
//Rounded Box Module
module RndBox(R_Len=9,R_Wid=15,R_Ht=10,R_OD=2)
{
    R_Rad = R_OD / 2;
    difference()
    {
        cube([R_Len,R_Wid,R_Ht]);
        translate([0,0,-1])
        rotate([0,0,-90])
        RndTop(R_OD,R_Ht,12);
        translate([R_Len,0,-1])
        RndTop(R_OD,R_Ht,12);

        translate([0,R_Wid,-1])
        rotate([0,0,180])
        RndTop(R_OD,R_Ht,12);
        translate([R_Len,R_Wid,-1])
        rotate([0,0,90])
        RndTop(R_OD,R_Ht,12);
    }
}
module Filament_175()
{
    translate([-5,-Len,Ht])
    rotate([0,-90,0])
    cylinder(d=Fil1_Tube_OD,h=11,$fn=Fil1_OD_Res);      //1.75 Filament Bigger Opening
    translate([5,-Len,Ht])
    rotate([0,90,0])
    cylinder(d=Fil1_Tube_OD,h=11,$fn=Fil1_OD_Res);      //1.75mm Filament Bigger Opening

    translate([-14.51,-Len,Ht])
    rotate([0,-90,0])
    cylinder(d1=Fil1_Tube_OD,d2=Fil1_Tap_OD,h=.51,$fn=Fil1_OD_Res);      //1.75mm Filament Taper Opening
    translate([14.5,-Len,Ht])
    rotate([0,90,0])
    cylinder(d1=Fil1_Tube_OD,d2=Fil1_Tap_OD,h=.51,$fn=Fil1_OD_Res);      //1.75mm Filament Taper Opening

    translate([0,-Len,Ht])
    rotate([0,90,0])
    cylinder(d=Fil1_OD,h=40,$fn=Fil1_OD_Res,center=true);      //1.75mm Filament drill thru
}
module Filament_3()
{
    translate([0,-Len,Ht])
    rotate([0,90,0])
    cylinder(d=Fil3_OD,h=40,$fn=Fil3_OD_Res,center=true);      //3mm Filament drill thru
    translate([-5,-Len,Ht])
    rotate([0,-90,0])
    cylinder(d=Fil3_Tube_OD,h=11,$fn=Fil3_OD_Res);      //3mm Filament Bigger Opening
    translate([5,-Len,Ht])
    rotate([0,90,0])
    cylinder(d=Fil3_Tube_OD,h=11,$fn=Fil3_OD_Res);      //3mm Filament Bigger Opening

    translate([-14.51,-Len,Ht])
    rotate([0,-90,0])
    cylinder(d1=Fil3_Tube_OD,d2=Fil3_Tap_OD,h=.51,$fn=Fil3_OD_Res);      //3mm Filament Taper Opening
    translate([14.5,-Len,Ht])
    rotate([0,90,0])
    cylinder(d1=Fil3_Tube_OD,d2=Fil3_Tap_OD,h=.51,$fn=Fil3_OD_Res);      //3mm Filament Taper Opening
}

module CutTopGuideTube()
{
    InsertSponge();
    if (Filament_Type != 0)
    {
        if (Filament_Slot == 1)
        {
    
            if (Filament_Type == 1)
            {
                hull()
                {
                    translate([0,-Len,Ht])
                    rotate([0,90,0])
                    cylinder(d=Fil1_OD,h=40,$fn=Fil1_OD_Res,center=true);      //1.75mm Filament drill thru
                    translate([0,-Len,Ht+10])
                    rotate([0,90,0])
//Make it a tapered slot 10mm up
                    cylinder(d=Fil1_Slot_OD,h=40,$fn=Fil1_OD_Res,center=true);    
                }
            } else
            {
                hull()
                {
                    translate([0,-Len,Ht])
                    rotate([0,90,0])
                    cylinder(d=Fil3_OD,h=40,$fn=Fil1_OD_Res,center=true);      //3mm Filament drill thru
                    translate([0,-Len,Ht+10])
                    rotate([0,90,0])
//Make it a tapered slot 10mm up
                    cylinder(d=Fil3_Slot_OD,h=40,$fn=Fil1_OD_Res,center=true);
                }
            }
        }
    }
    if (Filament_Type == 1)
    {
        Filament_175();
    } else if (Filament_Type == 3)
    {
        Filament_3();
    } else
    {
        translate([0,0,3])          //Add 3mm to drill thru for 3mm filament
        Filament_3();
        translate([0,0,-4])         //Subtrace 4mm to drill thru for 1.75mm filament
        Filament_175();
    }
//Not sure what this hole is, but probably for set screw to keep Guide tube in place
    translate([9.5,-Len+SS_X_Offset,Ht-SS_Z_Offset])
    rotate([SS_Ang,0,0])
    cylinder(d=2.7,h=50,$fn=16,center=true);
    translate([-9.5,-Len+SS_X_Offset,Ht-SS_Z_Offset])
    rotate([SS_Ang,0,0])
    cylinder(d=2.7,h=50,$fn=16,center=true);
//Taper the opening of the set screw holes a little
    translate([9.5,-Len+SS_X_Offset-1,Ht-SS_Z_Offset+.2])
    rotate([SS_Ang-8,0,0])
    translate([0,0,8])
    cylinder(d1=2.7,d2=3.7,h=1,$fn=16);
    translate([-9.5,-Len+SS_X_Offset-1,Ht-SS_Z_Offset+.2])
    rotate([SS_Ang-8,0,0])
    translate([0,0,8])
    cylinder(d1=2.7,d2=3.7,h=1,$fn=16);
    translate([0,-Len,Ht-18.97])
    scale([1,1,1])
    ChamBotGuide();
}
//These profiles are used for the Arm transitions
module BotProfile1()
{
    linear_extrude(height = .1, center = false, convexity = 10)polygon(points = 
    [[6.42,1.8],[9.59,4.38],[4.98,10.05],[4.59,10.49],[4.15,10.9],
    [3.68,11.26],[3.18,11.58],[2.65,11.85],[2.49,11.92],[-2.49,11.92],
    [-2.65,11.85],[-3.18,11.58],[-3.68,11.26],[-4.15,10.9],[-4.59,10.49],
    [-4.98,10.05],[-9.59,4.38],[-6.42,1.8]]);
}
module BotProfile2()
{
    linear_extrude(height = .1, center = false, convexity = 10)polygon(points = 
    [[-12.63,4.06],[-8.59,0.78],[8.58,0.77],[12.63,4.06],[6.66,11.41],
    [6.19,11.94],[6.13,12],[6.12,12.01],[6.06,12.06],[5.55,12.54],
    [5.54,12.55],[5.47,12.6],[4.92,13.03],[4.9,13.04],[4.83,13.08],
    [4.25,13.45],[4.22,13.46],[4.15,13.5],[3.54,13.81],[3.42,13.86],
    [3.39,13.88],[2.89,14.08],[-1.33,14.08],[-2.89,14.08],[-3.39,13.88],
    [-3.42,13.86],[-3.54,13.81],[-4.15,13.5],[-4.17,13.49],[-4.25,13.45],
    [-4.83,13.08],[-4.85,13.07],[-4.92,13.03],[-5.47,12.6],[-5.48,12.59],
    [-5.55,12.54],[-6.06,12.06],[-6.07,12.06],[-6.13,12],[-6.6,11.47],
    [-6.66,11.41]]);
}
module BotProfile3()
{
    linear_extrude(height = .1, center = false, convexity = 10)polygon(points = 
    [[-5.14,1],[-4.14,0],[4.14,0],[5.14,1]]);
}
module BotProfile3A()
{
    linear_extrude(height = .1, center = false, convexity = 10)polygon(points = 
    [[-5.14,1],[-5.15,1.47],[-5.18,1.82],[-5.27,2.15],[-5.42,2.47],
    [-5.62,2.76],[-5.88,3],[-6.25,3.3],[-6.39,3.43],[-6.5,3.55],
    [-6.57,3.63],[-6.62,3.7],[-6.67,3.77],[-6.71,3.84],[-6.75,3.91],
    [-6.78,3.98],[-6.82,4.05],[-6.85,4.12],[-6.87,4.19],[-6.9,4.27],
    [-6.92,4.34],[-6.94,4.44],[-6.95,4.5],[-6.96,4.57],[-6.97,4.64],
    [-6.98,4.72],[-6.98,4.85],[-6.98,4.99],[-6.96,5.14],[-6.94,5.27],
    [-6.91,5.41],[-6.88,5.49],[-6.82,5.64],[-6.79,5.71],[-6.75,5.79],
    [-6.71,5.87],[-6.66,5.94],[-6.61,6.01],[-6.54,6.11],[-3.99,9.24],
    [-3.86,9.4],[-3.73,9.54],[-3.59,9.69],[-3.45,9.81],[-3.31,9.94],
    [-3.16,10.06],[-3.01,10.18],[-2.84,10.29],[-2.68,10.39],[-2.52,10.48],
    [-2.37,10.57],[-2.21,10.65],[-2.04,10.72],[-1.88,10.79],[-1.71,10.85],
    [-1.54,10.91],[-1.37,10.96],[-1.19,11],[-1.02,11.04],[-0.85,11.07],
    [-0.67,11.1],[-0.5,11.12],[-0.33,11.13],[-0.15,11.14],[0,11.14],
    [0.15,11.14],[0.33,11.13],[0.5,11.12],[0.67,11.1],[0.85,11.07],
    [1.02,11.04],[1.19,11],[1.37,10.96],[1.54,10.91],[1.71,10.85],
    [1.88,10.79],[2.04,10.72],[2.21,10.65],[2.37,10.57],[2.52,10.48],
    [2.68,10.39],[2.84,10.29],[3.01,10.18],[3.16,10.06],[3.31,9.94],
    [3.45,9.81],[3.59,9.69],[3.73,9.54],[3.86,9.4],[3.99,9.24],
    [6.54,6.11],[6.61,6.01],[6.66,5.94],[6.71,5.87],[6.75,5.79],
    [6.79,5.71],[6.82,5.64],[6.88,5.49],[6.91,5.41],[6.94,5.27],
    [6.96,5.14],[6.98,4.99],[6.98,4.85],[6.98,4.72],[6.97,4.64],
    [6.96,4.57],[6.95,4.5],[6.94,4.44],[6.92,4.34],[6.9,4.27],
    [6.87,4.19],[6.85,4.12],[6.82,4.05],[6.78,3.98],[6.75,3.91],
    [6.71,3.84],[6.67,3.77],[6.62,3.7],[6.57,3.63],[6.5,3.55],
    [6.39,3.43],[6.25,3.3],[5.88,3],[5.62,2.76],[5.42,2.47],
    [5.27,2.15],[5.18,1.82],[5.15,1.47],[5.14,1]]);
}
module TransAtColumn()
{
    translate([0,-Len+12,0])
    rotate([90,0,0])
    linear_extrude(height = .1, center = false, convexity = 10)polygon(points = 
    [[0.29,11.29],[-0.29,11.29],[-0.62,11.27],[-0.78,11.25],[-1.11,11.19],
    [-1.45,11.12],[-1.61,11.07],[-1.93,10.96],[-1.96,10.95],[-2.27,10.81],
    [-2.28,10.81],[-2.43,10.73],[-2.47,10.72],[-2.76,10.55],[-2.91,10.45],
    [-2.95,10.43],[-3.11,10.32],[-3.14,10.3],[-3.42,10.07],[-3.69,9.83],
    [-3.72,9.81],[-3.72,9.81],[-3.97,9.53],[-4,9.5],[-6.55,6.38],
    [-6.85,6.01],[-7.01,5.78],[-7.09,5.63],[-7.11,5.56],[-7.17,5.42],
    [-7.2,5.34],[-7.23,5.21],[-7.25,5.09],[-7.27,4.94],[-7.27,4.69],
    [-7.24,4.48],[-7.23,4.42],[-7.21,4.33],[-7.19,4.26],[-7.14,4.12],
    [-7.11,4.05],[-7.05,3.92],[-5.52,1.15],[-5.31,0.99],[-5.14,0.99],
    [-5.31,0.99],[-5.31,0.99],[-5.31,0.95],[-4.36,0],[4.37,0],
    [5.32,0.95],[5.32,0.99],[5.31,0.99],[5.52,1.15],[7.05,3.92],
    [7.11,4.05],[7.14,4.12],[7.19,4.26],[7.21,4.33],[7.23,4.42],
    [7.26,4.61],[7.27,4.69],[7.27,4.94],[7.25,5.09],[7.23,5.21],
    [7.2,5.34],[7.17,5.42],[7.11,5.56],[7.09,5.63],[7.01,5.78],
    [6.85,6.01],[6.55,6.38],[4,9.5],[3.98,9.53],[3.72,9.8],
    [3.72,9.81],[3.69,9.83],[3.42,10.07],[3.14,10.3],[3.11,10.32],
    [2.95,10.43],[2.91,10.45],[2.76,10.55],[2.47,10.72],[2.43,10.73],
    [2.28,10.81],[2.27,10.81],[1.96,10.95],[1.93,10.96],[1.61,11.07],
    [1.45,11.12],[1.11,11.19],[0.78,11.25],[0.62,11.27]]);
}
//This module transitions from the Arm the Vertical Stem
module ColumnTransition()
{
    hull()
    {
        TransAtColumn();        //Profile of Arm at 12mm from center of Vertical Stem
        translate([0,-Len,0])
        cylinder(d=OD,h=14.74,$fn=OD_Res);      //Transition to Bottom section of Vertical Stem
    }
}
//Torus to cut around the top of the stem below the Guide tube
module ChamBotGuide()
{
    rotate_extrude(convexity = 10, $fn = 72)
    translate([14.8, 0, 0])
    circle(r = 10, $fn = OD18_Res);
}

module Arm()
{
    translate([0,0,0])
    rotate([90,0,0])
    union()
    {
//Bottom of Guide Tube Base had to be hulled seperately to get the correct transition
        hull()
        {
            translate([-6.4196,0,0])
            cube([12.8391,1.8003,.1]);
            translate([-8.538,0,TranArm_1st])
            cube([17.1536,.7734,.1]);
        }
    
//Where guide slides into Spool Holder Base
        hull()
        {
            BotProfile1();
            translate([0,0,TranArm_1st])
            BotProfile2();
        }
//This is the top of the base Guide tube transition to the Guide Tube Column
        hull()
        {
            translate([0,0,TranArm_1st])
            BotProfile2();
            translate([0,0,Tran_Len])
            BotProfile3A();
        }
//Bottom of Guide to the Guide Tube Column
        hull()
        {
            translate([-8.538,0,TranArm_1st])
            cube([17.1536,.7734,.1]);
            translate([0,0,Tran_Len])
            BotProfile3();
        }
    }
}
module Stem()
{
    translate([0,-Len,0])
    rotate([0,0,Guide_ZRot]) 
    union()
    {
        difference()
        {
            cylinder(d=OD,h=14.74,$fn=OD_Res);
            translate([0,0,-1])
            cylinder(d=OD35,h=8,$fn=Fil1_OD_Res);
            translate([0,-5.5,-.01])
            cylinder(d1=OD43,d2=OD23,h=1.01,$fn=Fil1_OD_Res);
            translate([0,-5.5,0])
            cylinder(d=OD23,h=7,$fn=Fil1_OD_Res);
        }
        translate([0,0,14.74])
        cylinder(d1=20,d2=19.48,h=2.49,$fn=OD_Res);
        translate([0,0,17.23])
        cylinder(d1=19.48,d2=13.02,h=13.02,$fn=OD_Res);
        translate([0,0,30.25])
        cylinder(d1=13.02,d2=11.27,h=5.01,$fn=OD_Res);         //3 transitions up
        translate([0,0,35.26])
        cylinder(d1=11.27,d2=10.42,h=3.36,$fn=OD_Res);         //1st 2 transitions up
        translate([0,0,38.62])
        cylinder(d1=10.42,d2=9.87,h=3.38,$fn=OD_Res);         //2nd 2 transitions up
        color("cyan")
        translate([0,0,42])
        cylinder(d1=9.87,d2=9.6,h=3.39,$fn=OD_Res);         //3rd 2 transitions up
        translate([0,0,42])
        cylinder(d1=9.87,d2=9.6,h=3.39,$fn=OD_Res);

        translate([0,0,45.39])
        cylinder(d=9.6,h=TR_Top,$fn=OD_Res);
        hull()
        {
            translate([0,0,45.39+TR_Top])
            cylinder(d=9.6,h=.1,$fn=OD_Res);
            translate([0,0,Ht-7.5])
            scale([1,.3,1])
            cylinder(d=29.61,h=.1,$fn=OD_Res);
        }
    }
}
//Add all the Parts together
module DrawUnion()
{
    union()
    {
        Arm();                  //Horizontal Arm
        Stem();                 //Add the Vertical Stem
        GuideTubeRotate();      //Add the Guide Tube to top of Stem
        ColumnTransition();     //Add the transition between the Arm & Stem
    }
}
module DrawFinal()
{
    difference()
    {
        DrawUnion();
        translate([Guide_X_Offset,-Len,Ht])
        rotate([0,0,Guide_ZRot])     //Rotate Top of Guide Tube cutting holes
        translate([0,Len,-Ht])      //Translate back to origin before rotating
        CutTopGuideTube();          //Cut all the openings in Guide Tube
    }
}
DrawFinal();
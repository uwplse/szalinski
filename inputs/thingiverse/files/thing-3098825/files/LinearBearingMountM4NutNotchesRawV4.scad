// LinearBearingMountM4NutNotchesRawV4

// CUSTOMIZER VARIABLES

// (DIN 934 wrench size: M3=5.5mm, M4=7mm, M5=8mm)
LBM_NutNotchSize = 7.1; //[5:0.1:9]

// (DIN 934 nut height: M3=2.4mm, M4=3.2mm, M5=4mm)
LBM_NutNotchDepth = 3.2; //[0.1:0.1:6]

// (above NutNotch)
LBM_NutInsertBevelBottom = 0; //[0:0.1:19]

// (above NutNotch)
LBM_NutInsertBevelTop = 3.2; //[0:0.1:20]

// (appr. 0.5mm wider than the threads diameter)
LBM_ThroughDiameter = 4.5; //[3:0.1:6]

LBM(LBM_NutNotchSize,LBM_NutNotchDepth,LBM_NutInsertBevelBottom,LBM_NutInsertBevelTop,LBM_ThroughDiameter);

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

// Main geometry of the LinearBearingMount (LBM)

module LBM(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
{
    difference()
    {
        intersection()
        {
            Body();
            Intersector();
        }
        HolesCutouts(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
    }
}
module Body()
union()
{
    bottom();
    middle();
    top();
    Ribs();
    M4Frames();
}
module Intersector()
union()
{
    
}

module HolesCutouts(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
union()
{
    Floor();
    CutCorners();
    LinearBearingHole();
    TopGap();
    SetHole();
    SlideBevel();
    M4Holes(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
}

module bottom()
translate([0,0,5/2])
    cube ([34.2, 30.2, 5], center = true);
module middle()
translate([-19.5/2,-30.2/2,0])
    cube ([19.5, 30.2, 14.8/2+3.3], center = false);
module top()
translate([0,0,14.8/2+3.3])
    rotate([90,0,0])
        cylinder (h=30.2,d=19.5, center = true);
module M4Frames()
union()
{
    M4FrameA();
    M4FrameB();
}
module M4FrameA()
translate([0,9,5])
    M4Frame();
module M4FrameB()
translate([0,-9,5])
    M4Frame();
module M4Frame()
union()
{
    M4FrameSquare();
    M4FrameRoundings();
}
module M4FrameSquare()
cube ([24,10,4], center = true);
module M4FrameRoundings()
union()
{
    M4FrameRoundingLeft();
    M4FrameRoundingRight();
}
module M4FrameRoundingLeft()
translate([-12,0,0])
    M4FrameRounding();
module M4FrameRoundingRight()
translate([12,0,0])
    M4FrameRounding();
module M4FrameRounding()
cylinder (h=4, d=10, center = true);
module Ribs()
union()
{
    RibA();
    RibB();
    RibC();
}
module RibA()
translate([0,13.5,0])
    RibB();
module RibC()
translate([0,-13.5,0])
    RibB();
module RibB()
union()
{
    RibBottom();
    RibTop();
}
module RibBottom()
union()
{
    RibBottomBody();
    RibBottomRoundings();
}
module RibBottomBody()
translate([-20.4/2,-2/2,0])
    cube([20.4,2,14.8/2+1.55],center=false);
module RibBottomRoundings()
union()
{
    RibBottomRoundingLeft();
    RibBottomRoundingRight();
}
module RibBottomRoundingLeft()
translate([-20.4/2,0,0])
    RibBottomRounding();
module RibBottomRoundingRight()
translate([20.4/2,0,0])
    RibBottomRounding();
module RibBottomRounding()
cylinder(h=14.8/2+1.55, d=2, center=false);
module RibTop()
translate([0,0,14.8/2+1.55])
    rotate([90,0,0])
        union()
        {
            RibTopBody();
            RibTopRounding();
        }
module RibTopBody()
cylinder (h=2,d=20.4, center = true);
module RibTopRounding()
rotate_extrude(convexity = 10, $fn = 100)
    translate([10.2, 0, 0])
        circle(r = 1, $fn = 100);


module Floor()
translate([0,0,-50])
    cube([100,100,100], center = true);
module CutCorners()
union()
{
    CutCornerA();
    CutCornerB();
    CutCornerC();
    CutCornerD();
}
module CutCornerA()
    translate([30.2/2,26.2/2,-2.5])
    rotate([0,0,0])
    CutCorner();
module CutCornerB()
    translate([-30.2/2,26.2/2,-2.5])
    rotate([0,0,90])
    CutCorner();
module CutCornerC()
    translate([-30.2/2,-26.2/2,-2.5])
    rotate([0,0,180])
    CutCorner();
module CutCornerD()
    translate([30.2/2,-26.2/2,-2.5])
    rotate([0,0,270])
    CutCorner();
module CutCorner()
difference()
{
    cube([4,4,10], center=false);
    cylinder(h=20,d=4, center=true);
}
module LinearBearingHole()
translate([0,0,14.8/2+3.3])
    rotate([90,0,0])
        cylinder (h=32.2,d=14.8, center = true);
module TopGap()
translate([0,0,20.53])
    cube ([1.5, 32.2, 10], center = true);
module SetHole()
translate([0,0.5-30.2/2,14.8/2+3.3])
    rotate([90,0,0])
        cylinder (h=1,d=16.5, center = false);
module SlideBevel()
translate([0,16.5/2+0.5-30.2/2,14.8/2+3.3])
    rotate([90,0,0])
        cylinder (h=16.5/2,d1=0, d2=16.5, center = false);
module M4Holes(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
union()
{
    M4HoleA(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
    M4HoleB(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
    M4HoleC(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
    M4HoleD(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
}
module M4HoleA(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
translate([12,9,0])
    rotate([0,0,180])
        M4Hole(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
module M4HoleB(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
translate([-12,9,0])
    M4Hole(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
module M4HoleC(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
translate([12,-9,0])
    rotate([0,0,180])
        M4Hole(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
module M4HoleD(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
translate([-12,-9,0])
    M4Hole(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
module M4Hole(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
translate([0,0,-1])
    union()
    {
        M4ThroughHole(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
        M4ThroughBevelBottom(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
        M4NutNotchTop(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
    }
module M4ThroughHole(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
cylinder (h=9,d=ThroughDiameter, center = false);
module M4ThroughBevelBottom(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
cylinder (h=2,d1=ThroughDiameter+1.5,d2=ThroughDiameter-0.5, center = false);
module M4NutNotchTop(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
difference()
{
    union()
    {
        rotate([0,0,0])
            M4NutNotchThird(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
        rotate([0,0,60])
            M4NutNotchThird(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
        rotate([0,0,120])
            M4NutNotchThird(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
    }
    M4NutNotchTopBevel(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter);
}
module M4NutNotchThird(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
translate([-NutNotchSize/2,-(NutNotchSize*tan(30))/2,7-NutNotchDepth+1])
    cube([NutNotchSize,NutNotchSize*tan(30),NutNotchDepth+NutInsertBevelTop], center = false);
module M4NutNotchTopBevel(NutNotchSize,NutNotchDepth,NutInsertBevelBottom,NutInsertBevelTop,ThroughDiameter)
translate([24/2-19.5/2,0,7+NutInsertBevelTop+1])
    rotate([0,-atan((19.5/2-(24/2-NutNotchSize/2))/(NutInsertBevelTop-NutInsertBevelBottom)),0])
        translate([0, -NutNotchSize/2, -(NutNotchDepth+NutInsertBevelTop)])
            cube([1.3, NutNotchSize, NutNotchDepth+NutInsertBevelTop], center = false);
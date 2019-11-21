//Customizable Gimbal Mount to put a Spinning Shape in
//7/21/2015     By: David Bunch
//
//Initially made to spin this shape: http://www.thingiverse.com/thing:543083
//
//CUSTOMIZER VARIABLES

//1. Length Between Gimbal Points
GimbalDistance = 60;

//2. Inside Width Clearance Distance
PivotThroat = 33;

//3. Diameter of Pivot Point
PivotDia = 6;

//4. Thickness of Part
Thickness = 6;

//5. Height of Part
Ht = 12;

//6. Resolution of Pivot Points
iresPiv = 12;

//7. Resolution of Larger Curves
iresBig = 188;

//8. Resolution of Smaller Curves
iresSmall = 64;

//9. Resolution of Round Corners
iresRnd = 24;

//CUSTOMIZER VARIABLES END

PivRad = PivotDia / 2;
Thk2 = Thickness / 2;
G2 = GimbalDistance / 2;
Piv_Y = G2 - Thk2 - .01;
//Initial Cube to cut from
Len = GimbalDistance + Thickness;
Wid = PivRad + PivotThroat + Thickness + 9 + Thickness;
Cube_Y = G2 + Thk2;
Cube_X =  PivRad + Thk2;
//Cube portion at Gimbal Throat full length
Cut1Len = Len - (Thickness * 2);
Cut1Wid = (PivotThroat - 24) + PivRad + Thickness;
Cut1_X = PivRad + Thickness;
Cut1_Y = G2 - Thk2;
//Cut largest Cylinder inside cut at top Right
CutCyl1_X = PivotThroat - 24;
CutCyl1_Y = G2 - Thk2 - 24;
//Cut Smallest Cylinder inside cut at bottom right
CutCyl2_X = PivotThroat - 10;
CutCyl2_Y = Cut1_Y - 10;
//Inside Bottom Cube Cut from Center of pivot to edge of bottom cylinder cut
Cube2Len=11;
Cube2Wid=PivotThroat;
Cut2_X = -10;
//Inside Bottom Cube Cut 
Cube3Len = CutCyl1_Y + CutCyl2_Y;
Cube3Wid = PivotThroat;
Cut3_X = 0;
Cut3_Y = CutCyl2_Y;
//Outside Top Cube
Cube4Wid = 9 + Thickness;
Cube4Len = Len;
Cut4_X = PivotThroat + Thickness;
//Outisde Bottom Cylinder Cut
CutCyl3_X = PivotThroat + Thickness + 5;
CutCyl3_Y = G2 - Thk2 - 5;
//Outside Bottom cut of Cylinder
Cube5Wid = 20;
Cube5Len = 20;
Cut5_X = PivotThroat + Thickness+5;
Cut5_Y = G2 - Thk2;
//Outside Top cut of Cylinder
Cube6Wid = 10;
Cube6Len = 20;
Cut6_X = PivotThroat + Thickness;
Cut6_Y = G2 - Thk2 - 5;
//Outside Top Cube for Cutting
Cube7Wid = 24 + Thickness + 5;
Cube7Len = 24 + Thickness + 5;
//Round Corners variables
RndCornLen = Thickness * 2;
RndCornWid = Thickness * 2;
RndCorn_X = RndCornLen;
RndCorn_Y = RndCornWid / 2;
XLoc1 = PivRad;
YLoc1 = Cube_Y - Thk2;
XLoc2 = PivotThroat + Thickness + 9;
module CutOutTopCyl()
{
    difference()
    {
        translate([CutCyl1_X,CutCyl1_Y,-1])
        cube([Cube7Wid,Cube7Len,Ht+2]);
        translate([CutCyl1_X,CutCyl1_Y,-2])
        cylinder(d=48 + (Thickness * 2),h=Ht+4,$fn=iresBig);
    }
}
module RoundCorners()
{
    difference()
    {
        translate([-RndCorn_X,-RndCorn_Y,-1])
        cube([RndCornWid,RndCornLen,Ht+2]);
        translate([0,0,-2])
        cylinder(d=Thickness,h=Ht+4,$fn=iresRnd);
    }
}
module Indent()
{
    translate([0,0,-.01])
    cylinder(d1=PivotDia,d2=0,h=(PivotDia / 2) + .01,$fn=iresPiv);
    translate([0,0,-2])
    cylinder(d=PivotDia,h=2,$fn=iresPiv);
}
module Gimbal()
{
    difference()
    {
//Initial Cube to cut from
        translate([-Cube_X,-Cube_Y,0])
        cube([Wid,Len,Ht]);
//Cube portion at Gimbal Throat full length
        translate([-Cut1_X,-Cut1_Y,-1])
        cube([Cut1Wid,Cut1Len,Ht+2]);
//Cut largest Cylinder inside cut at top Right
        translate([CutCyl1_X,CutCyl1_Y,-1])
        cylinder(d=48,h=Ht+2,$fn=iresBig);
//Cut Smallest Cylinder inside cut at bottom right
        translate([CutCyl2_X,-CutCyl2_Y,-1])
        cylinder(d=20,h=Ht+2,$fn=iresSmall);
//Inside Bottom Cube Cut from Center of pivot to edge of bottom cylinder cut
        translate([Cut2_X,-Cut1_Y,-1])
        cube([Cube2Wid,Cube2Len,Ht+2]);
//Inside Bottom Cube Cut 
        translate([Cut3_X,-Cut3_Y,-1])
        cube([Cube3Wid,Cube3Len,Ht+2]);
//Outside Top Cube Cut 
        translate([Cut4_X,-Cut3_Y,-1])
        cube([Cube4Wid,Cube4Len,Ht+2]);
//Outside Bottom Cylinder Cut 
        translate([CutCyl3_X,-CutCyl3_Y,-1])
        cylinder(d=10,h=Ht+2,$fn=iresSmall);
//Outside Bottom Cube Cut 
        translate([Cut5_X,-Cut5_Y,-1])
        cube([Cube5Wid,Cube5Len,Ht+2]);
//Outside Bottom Cube Cut 
        translate([Cut6_X,-Cut6_Y,-1])
        cube([Cube6Wid,Cube6Len,Ht+2]);
//Cut the Outside Top Curve
        CutOutTopCyl();
//Round the 3 end Points of Gimbal
        translate([-XLoc1,YLoc1,0])
        RoundCorners();
        translate([-XLoc1,-YLoc1,0])
        RoundCorners();
        translate([XLoc2,-YLoc1,0])
        rotate([0,0,180])
        RoundCorners();
//Cut out the Gimbal pivot points
        translate([0,Piv_Y,Ht/2])
        rotate([-90,0,0])
        Indent();
        translate([0,-Piv_Y,Ht/2])
        rotate([90,0,0])
        Indent();
    }
}
//Draw the Final Part
Gimbal();

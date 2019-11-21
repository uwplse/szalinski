//Bracket at Outer Edge of the three wings for a Delta Printer Build Plate Support
//12/15/2015    By: David Bunch
//
//.37oz for 6 of these at 40% infill & print time of 0:45:28
//
OutOval_OD = 34;        //Major Diameter of Outer Oval Bracket
Brac_OD = 3.5;          //I used M4x16mm socket head bolts
OO_X_Offset = 10.5;     //Offset from Center line of Mounting Holes (From Parametric Wings)
OO_Y_Offset = 9.5;      //Distance between holes if using 4 hole bracket
OO_Ht = 4;              //Height of Outer Oval Bracket
L_OD = 6;               //This is the value you used on the build plate wings 
OO_Qty_Holes = 2;       //2 or 4 Hole Bracket
OO_Qty_Parts = 6;       //Draw 1, 2, 3 or 6 Parts
OO_iRes = 64;
L_Adjust = L_OD - 6;    //Adjustment of holes if Ledge is not 6mm
Y_Half = OO_Y_Offset / 2;
$fn=OO_iRes;
//translate([-10.5,0,0])
//%cylinder(d=3.5,h=10);
//translate([10.5,0,0])
//%cylinder(d=3.5,h=10);
module DrawOuterOval2Hole()
{
    difference()
    {
        scale([1,.5,1])
        cylinder(d=OutOval_OD,h=OO_Ht,$fn=OO_iRes);
        OO_Holes2();
        scale([1,.8,1])
        translate([0,0,-1])
        cylinder(d=10,h=OO_Ht+2,$fn=36);
    }
}
module DrawOuterOval()
{
    if (OO_Qty_Holes == 2)
    {
        DrawOuterOval2Hole();
    } else {
        DrawOuterOval4Hole();
    }
}
module DbleOval()
{
    hull()
    {
        translate([0,Y_Half,0])
        scale([1,.5,1])
        cylinder(d=OutOval_OD,h=OO_Ht);

        translate([0,-Y_Half,0])
        scale([1,.5,1])
        cylinder(d=OutOval_OD,h=OO_Ht);
    }
}
module OO_Holes2()
{
    translate([-(OO_X_Offset+L_Adjust),0,-1])
    cylinder(d=Brac_OD,h=OO_Ht+2,$fn=24);
    translate([OO_X_Offset+L_Adjust,0,-1])
    cylinder(d=Brac_OD,h=OO_Ht+2,$fn=24);
}
module OO_Holes2_x2()
{
    translate([OutOval_OD-16,0,0])
    DrawOuterOval();
    translate([-(OutOval_OD-16),0,0])
    DrawOuterOval();
}
module DrawOuterOval4Hole()
{
    difference()
    {
        DbleOval();
        translate([0,Y_Half,0])
        OO_Holes2();
        translate([0,-Y_Half,0])
        OO_Holes2();

        scale([1,.8,1])
        translate([0,0,-1])
        cylinder(d=10,h=OO_Ht+2,$fn=36);
    }
}
if (OO_Qty_Parts == 1)
{
    DrawOuterOval();            //Always draw at least one part
}
if (OO_Qty_Parts == 2)
{
    OO_Holes2_x2();
}
if (OO_Qty_Parts == 3)
{
    DrawOuterOval();            //Always draw at least one part
    translate([0,OutOval_OD-18,0])
    OO_Holes2_x2();
}
if (OO_Qty_Parts == 4)
{
    echo("**4");
    OO_Holes2_x2();
    translate([0,OutOval_OD-14,0])
    OO_Holes2_x2();
}
if (OO_Qty_Parts == 6)
{
    echo("**4");
    OO_Holes2_x2();
    translate([0,OutOval_OD-14,0])
    OO_Holes2_x2();
    translate([0,-(OutOval_OD-14),0])
    OO_Holes2_x2();
}

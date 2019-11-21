//Parametric Corner bracket to hold 2 3/16" thick foam core sheets together
//
//By changing the Gap variable,
//You should be able to use with other material:
//like Acrylic, Glass, Plywood, etc.
//
//As well as 90 corners,
//this can do 7 other angles for 3, 5, 6, 8, 9, 10 & 12 sided structures
//11/21/2015    By: David Bunch

//CUSTOMIZER VARIABLES

//1. Length of Corner Backet
CornerLen = 20;

//2. Width of Corner Bracket
CornerWid = 20;         //For Corner_Ang other than 90, CornerLen is used for both sides

//3. Height of Corner Bracket
CornerHt = 9;

//4. Thickness of Face of Connector
BaseThk = 2.0;

//5. Thickness of Side Walls
Thk = 3;

//6. Gap that Foam core board fits in between
Gap = 4.5;

//7. Angle At Corner (Only 90 when Connect_Qty = 3)
Corner_Ang = 90;        //90 = 4 Sided Structure
                        //120 = 3 Sided
                        //72 = 5 Sided
                        //60 = 6 Sided
                        //Not bothering with 7 sided
                        //45 = 8 Sided
                        //40 = 9 Sided
                        //36 = 10 Sided
                        //Not bothering with 11 Sided
                        //30 = 12 Sided
//8. Length of Foam Core (For Assembly Display)
FC_Len = 100;

//9. Width of Foam Core (For Assembly Display)
FC_Wid = 60;

//10. Height of Foam Core (For Assembly Display)
FC_Ht = 40;

//11. Foam Core Thickness (For Assembly Display)
FC_Thk = Gap;

//12. How many corners to Draw (1,2,4 or 8)
Qty = 2;            //Only used if Assembly = 0

//13. Number of Connections (2 or 3)
Connect_Qty = 2;        //Can only use 3 when Corner Angle is 90

//14. Draw Assembled (1 = Yes, 0 = No)
Assembly = 0;           //1 = Show Assembled, 0 = No

//CUSTOMIZER VARIABLES END

TopMul = (Connect_Qty - 2);         //0 if connecting 2 sides at corner
                                    //1 if connecting 3 sides at corner
echo("TopMul = ",TopMul);
TopThk = (BaseThk * TopMul);
echo("TopThk = ",TopThk);
TopGap = (Gap * TopMul);
echo("TopGap = ",TopGap);
TopTotThk = TopThk + TopGap + (Thk * TopMul);
echo("TopTotThk = ",TopTotThk);

TotHt = BaseThk + TopGap + TopThk + CornerHt;   //Total Height of Corner Bracket
echo("TotHt = ", TotHt);
TotThk = Thk + Gap + Thk;
CutCubeHt = TotHt - TopTotThk + 1;

//Calculate Corner support when printing a Connect 3
Ang45_Wid = sqrt((Thk * Thk) + (Thk * Thk));
Ang45_Len = Ang45_Wid * 2;
Y_Offset = cos(45) * TotHt;

//Calculations for Corner_Ang other than 90
Y_Center = tan(60) * CornerLen;

echo("Y_Center = ",Y_Center);
Corner_Rad = CornerLen / cos(60);
echo("Corner_Rad = ",Corner_Rad);
Corner_Dia = Corner_Rad * 2;
echo("Thk = ", Thk);
Corner_Dia_x2 = Corner_Dia * 2;
Thk_DiagLen = Thk / sin(60);
echo("Thk_DiagLen = ",Thk_DiagLen);
Gap_DiagLen = Gap / sin(60);
echo("Gap_DiagLen = ",Gap_DiagLen);
Sides = 360 / Corner_Ang;
echo("Sides = ", Sides);
In_Rad = Corner_Rad - (Thk_DiagLen * 2) - Gap_DiagLen;
In_Dia = In_Rad * 2;
echo("In_Rad = ",In_Rad);

module Corner()
{
    if (Corner_Ang == 90)
    {
    difference()
    {
        cube([CornerLen,CornerWid,TotHt]);      //Draw the Basic corner to start

        translate([Thk,Thk,BaseThk])        
        cube([CornerLen,Gap,TotHt]);            //Cut out where the length side connects
    
        translate([Thk,Thk,BaseThk])
        cube([Gap,CornerWid,TotHt]);            //Cut out where the Width side connects
        if (Connect_Qty == 2)
        {
            translate([TotThk,TotThk,-1])
            cube([CornerLen,CornerWid,CutCubeHt+1]);  //Cut off the inside corner
        } else {
            translate([TotThk,TotThk,BaseThk+Gap+Thk])
            cube([CornerLen,CornerWid,CutCubeHt]);    //Cut off the inside corner
            translate([TotThk,TotThk,BaseThk])
            cube([CornerLen,CornerWid,Gap]);
        }
    }
    } else {
        difference()
        {
            CylRot(Corner_Rad,TotHt);

            translate([0,0,-1])
            CylRot(In_Dia/2,TotHt+2);

            translate([0,0,BaseThk])
            GapAngCut();
            if (Corner_Ang == 120)
            {
                rotate([0,0,-36])
                translate([0,-Corner_Dia,-1])
                cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);

                rotate([0,0,-84])
                translate([-Corner_Dia_x2,-Corner_Dia,-1])
                cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);
            }
            else if (Corner_Ang == 45)
            {
                rotate([0,0,0])
                translate([0,-Corner_Dia,-1])
                cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);

                rotate([0,0,-45])
                translate([-Corner_Dia_x2,-Corner_Dia,-1])
                cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);
            }
            else
            {
                translate([0,-Corner_Dia,-1])
                cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);

                translate([-Corner_Dia,0,-1])
                cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);

                rotate([0,0,-Corner_Ang])
                translate([-Corner_Dia_x2,-Corner_Dia_x2,-1])
                cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);
            }
    }
}
}

module CylRot(CR_Rad=Corner_Rad,CR_HT=TotHt)
{
    // 90, 60, 36 are correct rotation
    if (Corner_Ang == 72)
    {
        rotate([0,0,18])
        cylinder(r=CR_Rad,h=CR_HT,$fn=Sides);
    }
    else if (Corner_Ang == 45)
    {
        rotate([0,0,22.5])
        cylinder(r=CR_Rad,h=CR_HT,$fn=Sides);
    }
    else if (Corner_Ang == 40)
    {
        rotate([0,0,10])
        cylinder(r=CR_Rad,h=CR_HT,$fn=Sides);
    }
    else if (Corner_Ang == 30)
    {
        rotate([0,0,15])
        cylinder(r=CR_Rad,h=CR_HT,$fn=Sides);
    }
    else if (Corner_Ang == 120)
    {
        rotate([0,0,-30])
        cylinder(r=CR_Rad,h=CR_HT,$fn=Sides);
    }
    else
    {
        rotate([0,0,0])
        cylinder(r=CR_Rad,h=CR_HT,$fn=Sides);
    }
}
module GapAngCut()
{
    if (Corner_Ang == 90)
    {
        echo("Not Doing Anything Here");
    } else {
        difference()
        {
            CylRot(Corner_Rad-Thk_DiagLen,TotHt);

            translate([0,0,-1])
            CylRot(Corner_Rad-Thk_DiagLen-Gap_DiagLen,TotHt+2);

            translate([1,-Corner_Dia,-1])           //go 1mm beyond bracket
            cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);

            translate([-Corner_Dia,0,-1])
            cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);

            rotate([0,0,-Corner_Ang-1])             //go 1 deg beyond bracket
            translate([-Corner_Dia_x2,-Corner_Dia_x2,-1])
            cube([Corner_Dia_x2,Corner_Dia_x2,TotHt+2]);
        }        
    }
}
module Corner_3Connect()
{
    translate([0,0,-Ang45_Wid])
    rotate([45,0,0])
    difference()
    {
        rotate([-45,0,0])       //Easier to calculate cut by rotating back 1st
        difference()
        {
            rotate([45,0,0])
            rotate([0,0,45])
            union()
            {
                Corner();
                rotate([0,0,-45])
                translate([-Ang45_Wid,-TotHt,0])
                cube([Ang45_Len,Ang45_Wid + TotHt,TotHt]);
            }
            translate([0,0,-50 + Ang45_Wid])
            cylinder(d=50,h=50);
            translate([-25,-Y_Offset-50,-1])
            cube([50,50,50]);
        }
        translate([-25,-50,-1])
        cube([50,50,50]);
    }
}
module Corner_3Connect_x2()
{
    Corner_3Connect();
    translate([0,CornerWid+8,0])
    Corner_3Connect();
}
module Corner_3Connect_x4()
{
    Corner_3Connect_x2();
    translate([CornerLen+10,0,0])
    Corner_3Connect_x2();
}
module Corner_x2()
{
    Corner();
    if (Corner_Ang == 90)
    {
        translate([CornerLen+6,0,0])
        Corner();
    } else {
        translate([CornerLen+12,0,0])
        Corner();
    }
}
module Corner_x4()
{
    Corner_x2();
    if (Corner_Ang == 90)
    {
        translate([0,CornerWid+6,0])
        Corner_x2();
    } else {
        translate([0,CornerWid+8,0])
        Corner_x2();
    }
}
module Corners4()
{
    Corner();                                   //Draw Left Corner Bracket
    translate([Thk+FC_Len+Thk,0,0])
    rotate([0,0,90])
    Corner();                                   //Draw Right Corner Bracket
    translate([0,Thk+Gap+FC_Wid+Gap+Thk,0])
    rotate([0,0,-90])
    Corner();                                   //Draw Upper Left Corner Bracket
    translate([Thk+FC_Len+Thk,Thk+Gap+FC_Wid+Gap+Thk,0])
    rotate([0,0,180])
    Corner();                                   //Draw Upper Right Corner Bracket    
}
if (Corner_Ang == 90)
{
if (Assembly == 1)
{
    Corners4();
    translate([0,0,FC_Ht+BaseThk+BaseThk])
    mirror([0,0,1])
    Corners4();

    translate([Thk,Thk,BaseThk])
    %cube([FC_Len,FC_Thk,FC_Ht]);              //Draw Bottom Side Foam Core
    #translate([Thk,Thk+Gap,BaseThk])
    cube([FC_Thk,FC_Wid,FC_Ht]);              //Draw Left side Foam Core
    translate([Thk,Thk+Gap+FC_Wid,BaseThk])
    %cube([FC_Len,FC_Thk,FC_Ht]);              //Draw Top Side Foam Core
    #translate([Thk+FC_Len-Gap,Thk+Gap,BaseThk])
    cube([FC_Thk,FC_Wid,FC_Ht]);              //Draw Right side Foam Core
//Only draw Top & Bottom Foam core if using a 3 connector
    if (Connect_Qty == 3)
    {
        #translate([TotThk,TotThk,BaseThk])
        cube([FC_Len-TotThk-Gap,FC_Wid-Thk-Thk,FC_Thk]);    //Draw Bottom Foam Core
        #translate([TotThk,TotThk,FC_Ht-BaseThk])
        cube([FC_Len-TotThk-Gap,FC_Wid-Thk-Thk,FC_Thk]);    //Draw Top Foam Core
    }
} else {
    if (Connect_Qty == 2)
    {

        if (Qty == 1)
        {
            Corner();
        }
        if (Qty == 2)
        {
            Corner_x2();
        }
        if (Qty == 4)
        {
            Corner_x4();
        }
        if (Qty == 8)
        {
            Corner_x4();
            translate([CornerLen+6+CornerLen+6,0])
            Corner_x4();
        }
    } else {
        if (Corner_Ang == 90)
        {
            if (Qty == 1)
            {
                Corner_3Connect();
            }
            if (Qty == 2)
            {
                Corner_3Connect_x2();
            }
            if (Qty == 4)
            {
                Corner_3Connect_x4();
            }
            if (Qty == 8)
            {
                Corner_3Connect_x4();
                translate([CornerLen+10+CornerLen+10,0,0])
                Corner_3Connect_x4();
            }
        } else {
            echo("********************************************");
            echo("***Corner_Ang MUST be 90 for Connect_Qty = 3");
            echo("********************************************");
        }
    }
}
} else {
    echo("***Calculating other than 90");
            %CylRot(Corner_Rad,TotHt);
        if (Qty == 1)
        {
            Corner();
        }
        if (Qty == 2)
        {
            Corner_x2();
        }
        if (Qty == 4)
        {
            Corner_x4();
        }
        if (Qty == 8)
        {
            Corner_x4();
            translate([CornerLen+10+CornerLen+10,,00])
            Corner_x4();
        }
}
//Parametric Carriage Base for V-Slot Printers
//This was designed to be used on my Emmett-Delta
//I made this parametric to make it easy to adjust for different situations
//1/10/2016  By: David Bunch
//
include <Delta_Traxxas_Carriage.scad>;

//CUSTOMIZER VARIABLES

//1. Wheel Center X Offset (default for 2060 V-Slot)
W_X_Offset = 39.9;          //39.85165 measured, but I used 39.9mm
                //2020 measures 39.7082 between holes 19.8541 to centerline
                //2040 measures 59.7033 between holes  29.85165 to centerline
                //2060 measures 79.7033 between holes  39.85165 to centerline
                //2080 measueres 99.7033 between holes  49.85165 to centerline

//2. Wheel Center Y Offset (default 16)
W_Y_Offset =16; 

//3. Offset to Top Ledge
L_Offset_Top = 11.3;     //Not used on Top if FlushTop = 1
                        //will draw incorrectly if
                        //Y_Offset + (UpChamfer_OD / 2) > W_Y_Offset

//4. Offset to Bottom Ledge
L_Offset_Bot = 11.3;    //Not used on Bottom if FlushBottom = 1

//5. Height of Carriage Base Plate
Ht = 6;

//6. Diameter of Bolt holes for Wheels
M5 = 5.5;

//7. Diameter of Eccentric Spacers hole
M5_ECC = 7.5;

//8. Bolt Hole Resolution
M5_Res = 24;

//9. Eccentric bolts on (1=Right, 0 = Left) Side
ECC_Right = 1;

//10. Base Plate Flush across the top (1 = Yes)
FlushTop = 0;   //0 = curved at the Top

//11. Base Plate Flush across the Bottom (1 = Yes)
FlushBottom = 0;   //0 = curved at the Bottom

//12. Base Plate Flush on both sides
FlushSides = 0;     //0 = curved on both sides

//13. Diameter of  Plate around each hole
Corner_OD = 30;

//14. Diameter of Chamfer cut on top inside cut of Wheel Corners
UpChamfer_OD = 10;

//15. Diameter of Chamfer cut on outside of wheel Corners
SideChamfer_OD = 12;

//16. Draw the Ledge around perimeter
Ledge_On = 1;

//17. Draw Carriage (1= Yes, 0 = Draw only Base Plate)
Carriage_On = 1;

//CUSTOMIZER VARIABLES END

Corner_Rad = Corner_OD / 2;
UpChamfer_Rad = UpChamfer_OD / 2;
SideChamfer_Rad = SideChamfer_OD / 2;
Sin45 = sin(45);

SideCh_Offset = Sin45 * (Corner_Rad + SideChamfer_Rad);
SideChamfer_X_Offset = SideCh_Offset + W_X_Offset;

SideChamfer_Y_Offset = W_Y_Offset - SideCh_Offset;
echo("SideChamfer_Y_Offset = ",SideChamfer_Y_Offset);
SideCube_Len = Sin45 * Corner_Rad;
echo("SideCube_Len = ",SideCube_Len);
TopCube_Len = Corner_Rad + UpChamfer_Rad;
echo("TopCube_Len = ",TopCube_Len);
TopCube_Wid = L_Offset_Top + UpChamfer_Rad;
echo("TopCube_Wid = ",TopCube_Wid);
BotCube_Wid = L_Offset_Bot + UpChamfer_Rad;

SideCube_Wid = Corner_Rad+SideChamfer_Rad;
SB_OD = SideChamfer_OD+12;               //Side Bump Diameter
SB_Cyl_X_Offset = SideChamfer_X_Offset - (SideChamfer_Rad + 3);
UB_OD = UpChamfer_OD + 12;              //Upper Bump Diameter
UB_Cyl_X_Offset = W_X_Offset - (Corner_Rad-3);
echo("UB_Cyl_X_Offset = ",UB_Cyl_X_Offset);

UB_Cyl_Ht = W_Y_Offset - TopCube_Wid;
echo("UB_Cyl_Ht = ",UB_Cyl_Ht);
LB_Cyl_Ht = W_Y_Offset - BotCube_Wid;
UpChamfer_X_Offset = W_X_Offset - TopCube_Len;
Ledge_Ht = UpChamfer_X_Offset * 2;
echo("(W_X_Offset - TopCube_Len) = ",(W_X_Offset - TopCube_Len));
Wheel_Len = W_X_Offset * 2;
Wheel_Wid = W_Y_Offset * 2;
Wheel_UpFlushLedge_Y = W_Y_Offset + (Corner_Rad - 3);
echo("Wheel_UpFlushLedge_Y = ",Wheel_UpFlushLedge_Y);
Wheel_SideFlushLege_X = W_X_Offset + (Corner_Rad - 3);
echo("Wheel_SideFlushLege_X = ",Wheel_SideFlushLege_X);

//Makes each segment about 1mm and even number of segments
Corner_Res = (round((Corner_OD * 3.14)/4)*4);       //Resolution of Corner Cylinders
echo("Corner_Res = ",Corner_Res);
UpCh_Res = (round((UpChamfer_OD * 3.14)/4)*4);      //Resolution of Upper/Lower Cylinders
echo("UpCh_Res = ",UpCh_Res);
SidCh_Res = (round((SideChamfer_OD * 3.14)/4)*4);   //Resolution of Side Cylinders
echo("SidCh_Res = ",SidCh_Res);
module CornerTop()
{
    union()
    {
        cylinder(d=Corner_OD,h=Ht,$fn=Corner_Res);
        if (Ledge_On == 1)
        {
            translate([0,0,Ht])
            BumpLedge();
        }
        translate([0,-W_Y_Offset,0])
        cube([Corner_Rad,W_Y_Offset,Ht]);       //Fill in to Right of Corner

        translate([-SideCube_Len,-W_Y_Offset,0])
        cube([SideCube_Len,W_Y_Offset,Ht]);     //Left most cube

        translate([0,-W_Y_Offset,0])
        cube([W_X_Offset+.01,L_Offset_Top,Ht]); //Connect Corner to Center

        translate([0,-W_Y_Offset,0])
        cube([TopCube_Len,TopCube_Wid,Ht]);     //Upper Right Cube
    }
}
module CornerBot()
{
    union()
    {
        cylinder(d=Corner_OD,h=Ht,$fn=Corner_Res);
        if (Ledge_On == 1)
        {
            translate([0,0,Ht])
            BumpLedge();
        }
        translate([0,-W_Y_Offset,0])
        cube([Corner_Rad,W_Y_Offset,Ht]);       //Fill in to Right of Corner

        translate([-SideCube_Len,-W_Y_Offset,0])
        cube([SideCube_Len,W_Y_Offset,Ht]);     //Left most cube

        translate([0,-W_Y_Offset,0])
        cube([W_X_Offset+.01,L_Offset_Bot,Ht]); //Connect Corner to Center

        translate([0,-W_Y_Offset,0])
        cube([TopCube_Len,BotCube_Wid,Ht]);     //Upper Right Cube
    }
}
module CornerSideFlush()
{
    difference()
    {
        CornerTop();
        translate([-Corner_OD,-Corner_OD,Ht])
        cube([Corner_OD,Corner_OD,Ht+2]);       //Cut for Side Flush Ledge
    }
}
module CornerTopAndSideFlush()
{
    difference()
    {
        CornerTop();
        translate([0,-W_Y_Offset,Ht])
        cube([Corner_OD,W_Y_Offset*2,Ht+2]);    //Cut for Top Flush Ledge
        translate([-Corner_OD,-Corner_OD,Ht])
        cube([Corner_OD,Corner_OD,Ht+2]);       //Cut for Side Flush Ledge
    }
}
module DrawTopCorner()
{
    union()
    {
        difference()
        {
            translate([-W_X_Offset,W_Y_Offset,0])
            CornerTop();
            CutForCurves();
        }
        if (Ledge_On == 1)
        {
            SideBump();
            SideLedge();
            UpBump();
            if (UB_Cyl_Ht > 0)
            {
                UpLedge();
            }
        }
    }
}
module DrawBotCorner()
{
    union()
    {
        difference()
        {
            translate([-W_X_Offset,W_Y_Offset,0])
            CornerBot();
            CutForCurvesBot();
        }
        if (Ledge_On == 1)
        {
            SideBump();
            SideLedge();
            UpBumpBot();
            if (LB_Cyl_Ht > 0)
            {
                DownLedge();
            }
        }
    }
}
module CutForCurves()
{
    translate([-SideChamfer_X_Offset,SideChamfer_Y_Offset,-1])
    cylinder(d=SideChamfer_OD,h=Ht+2,$fn=SidCh_Res);       //Cut Side Curve
    translate([-UpChamfer_X_Offset,TopCube_Wid,-1])
    cylinder(d=UpChamfer_OD,h=Ht+2,$fn=UpCh_Res);         //Cut Top Right Curve
    if (SideChamfer_Y_Offset > 0)
    {
        translate([-SideChamfer_X_Offset,-.1,-1])
        cube([SideChamfer_Rad,SideChamfer_Y_Offset+.1,Ht+2]);
    }
    translate([-SideChamfer_X_Offset,SideChamfer_Y_Offset,Ht])
    rotate([0,0,-45])
    cube([SideCube_Wid,SideCube_Wid,Ht]);  //Cut off Bottom & Left of Bump
    translate([-W_X_Offset,0,Ht])
    cube([Corner_OD,W_Y_Offset,Ht]);  //Cut off rest of Right Bottom corner
}
module CutForCurvesBot()
{
    translate([-SideChamfer_X_Offset,SideChamfer_Y_Offset,-1])
    cylinder(d=SideChamfer_OD,h=Ht+2,$fn=SidCh_Res);       //Cut Side Curve
    translate([-UpChamfer_X_Offset,BotCube_Wid,-1])
    cylinder(d=UpChamfer_OD,h=Ht+2,$fn=UpCh_Res);         //Cut Top Right Curve
    if (SideChamfer_Y_Offset > 0)
    {
        translate([-SideChamfer_X_Offset,-.1,-1])
        cube([SideChamfer_Rad,SideChamfer_Y_Offset+.1,Ht+2]);
    }
    translate([-SideChamfer_X_Offset,SideChamfer_Y_Offset,Ht])
    rotate([0,0,-45])
    cube([SideCube_Wid,SideCube_Wid,Ht]);  //Cut off Bottom & Left of Bump
    translate([-W_X_Offset,0,Ht])
    cube([Corner_OD,W_Y_Offset,Ht]);  //Cut off rest of Right Bottom corner
}
module CutForSideCurves()
{
    translate([-SideChamfer_X_Offset,SideChamfer_Y_Offset,-1])
    cylinder(d=SideChamfer_OD,h=Ht+2,$fn=SidCh_Res);       //Cut Side Curve
    translate([-UpChamfer_X_Offset,TopCube_Wid,-1])
    cylinder(d=UpChamfer_OD,h=Ht+2,$fn=UpCh_Res);         //Cut Top Right Curve
    if (SideChamfer_Y_Offset > 0)
    {
        translate([-SideChamfer_X_Offset,-.1,-1])
        cube([SideChamfer_Rad,SideChamfer_Y_Offset+.1,Ht+2]);
    }
    translate([-SideChamfer_X_Offset,SideChamfer_Y_Offset,Ht])
    rotate([0,0,-45])
    cube([SideCube_Wid,SideCube_Wid,Ht]);  //Cut off Bottom & Left of Bump
    translate([-W_X_Offset,0,Ht])
    cube([Corner_OD,W_Y_Offset,Ht]);  //Cut off rest of Right Bottom corner
}
module DrawCornerSideFlush()
{
    union()
    {
        difference()
        {
            translate([-W_X_Offset,W_Y_Offset,0])
            CornerSideFlush();
            CutForSideCurves();
        }
        translate([-(W_X_Offset+Corner_Rad),0,0])
        cube([Corner_Rad,W_Y_Offset,Ht]);           //Fill Side Curve
        if (Ledge_On == 1)
        {
            UpBump();
            if (UB_Cyl_Ht > 0)
            {
                UpLedge();
            }
        }
    }
}
module DrawCornerTopAndSideFlush()
{
    union()
    {
        difference()
        {
            translate([-W_X_Offset,W_Y_Offset,0])
            CornerTopAndSideFlush();
            CutForSideCurves();
            translate([-W_X_Offset,0,Ht])
            cube([Wheel_Len,W_Y_Offset+Corner_OD,Ht+2]);
        }
        translate([-W_X_Offset,0,0])
        cube([Wheel_Len/2,W_Y_Offset+Corner_Rad,Ht]);
        translate([-(W_X_Offset+Corner_Rad),0,0])
        cube([Corner_Rad,W_Y_Offset,Ht]);           //Fill Side Curve
        if (Ledge_On == 1)
        {
            TopLedgeFlush();
        }
    }
}
module DrawCornerTopFlush()
{
    union()
    {
        difference()
        {
            translate([-W_X_Offset,W_Y_Offset,0])
            CornerTop();
            CutForSideCurves();
            translate([-W_X_Offset,0,Ht])
            cube([Wheel_Len,W_Y_Offset+Corner_OD,Ht+2]);
        }
        translate([-W_X_Offset,0,0])
        cube([Wheel_Len/2,W_Y_Offset+Corner_Rad,Ht]);
        if (Ledge_On == 1)
        {
            SideBump();
            SideLedge();
            TopLedgeFlush();
        }
    }
}
module BumpLedge(B_OD = Corner_OD,I_R = 108)
{
    CB_D2 = B_OD - 3;              //Corner Bump Diameters
    CB_D3 = B_OD - 12;
    CB_D4 = B_OD - 9 + .0577;
    difference()
    {
        cylinder(d1=B_OD,d2=CB_D2,h=2.6,$fn=I_R);
        translate([0,0,-1])
        cylinder(d=CB_D3,h=6,$fn=I_R);
        cylinder(d1=CB_D3,d2=CB_D4,h=2.7,$fn=I_R);
    }
}
module SideBump()
{
    translate([-SideChamfer_X_Offset,SideChamfer_Y_Offset,Ht])
    difference()
    {
        BumpLedge(SB_OD);
        translate([-SB_OD,-SB_OD,-1])
        cube([SB_OD*2,SB_OD,Ht+2]);        //Cut off Bottom half of Side Bump
        
        rotate([0,0,-45])
        translate([-SB_OD,-(SB_OD/2-1),-1])
        cube([SB_OD,SB_OD,Ht+2]);           //Cut off Left & 45degs to Match Wheel bump
    }
}
module UpBump()
{
    translate([-UpChamfer_X_Offset,TopCube_Wid,Ht])
    difference()
    {
        BumpLedge(UB_OD);
        translate([-UB_OD,0,-1])
        cube([UB_OD*2,UB_OD,Ht+2]);        //Cut off Top half of Upper Right Bump

        translate([0,-UB_OD,-1])
        cube([UB_OD*2,UB_OD+1,Ht+2]);        //Cut off Bottom half of Side Bump
    }
}
module UpBumpBot()
{
    translate([-UpChamfer_X_Offset,BotCube_Wid,Ht])
    difference()
    {
        BumpLedge(UB_OD);
        translate([-UB_OD,0,-1])
        cube([UB_OD*2,UB_OD,Ht+2]);        //Cut off Top half of Upper Right Bump

        translate([0,-UB_OD,-1])
        cube([UB_OD*2,UB_OD+1,Ht+2]);        //Cut off Bottom half of Side Bump
    }
}
module TopLedge()
{
    translate([0,L_Offset_Top-3,Ht])
    rotate([0,90,0])
    rotate([0,0,90])
    cylinder(d=6,h=Ledge_Ht,$fn=6,center=true);
}
module BotLedge()
{
    translate([0,L_Offset_Bot-3,Ht])
    rotate([0,90,0])
    rotate([0,0,90])
    cylinder(d=6,h=Ledge_Ht,$fn=6,center=true);
}
module TopLedgeFlush()
{
    translate([0,Wheel_UpFlushLedge_Y,Ht])
    rotate([0,90,0])
    rotate([0,0,90])
    cylinder(d=6,h=Wheel_Len,$fn=6,center=true);
}
module SideLedgeFlush()
{
    translate([-Wheel_SideFlushLege_X,0,Ht])
    rotate([90,0,0])
    cylinder(d=6,h=Wheel_Wid,$fn=6,center=true);
}
module UpLedge()
{
    translate([-UB_Cyl_X_Offset,W_Y_Offset,Ht])
    rotate([90,0,0])
    cylinder(d=6,h=UB_Cyl_Ht,$fn=6);
}
module DownLedge()
{
    translate([-UB_Cyl_X_Offset,W_Y_Offset,Ht])
    rotate([90,0,0])
    cylinder(d=6,h=LB_Cyl_Ht,$fn=6);
}
module SideLedge()
{
    translate([-SB_Cyl_X_Offset,0,Ht])
    rotate([90,0,0])
    cylinder(d=6,h=SideChamfer_Y_Offset*2,$fn=6,center=true);
}
module DrawTopSide()
{
    if (FlushTop == 0)
    {
        if (FlushSides == 0)
        {
            DrawTopCorner();
            mirror([1,0,0])
            DrawTopCorner();
        } else {
            DrawCornerSideFlush();
            mirror([1,0,0])
            DrawCornerSideFlush();
        }
        if (Ledge_On == 1)
        {
            TopLedge();
        }
    } else {
        if (FlushSides == 0)
        {
                DrawCornerTopFlush();
                mirror([1,0,0])
                DrawCornerTopFlush();
        } else {
            DrawCornerTopAndSideFlush();
            mirror([1,0,0])
            DrawCornerTopAndSideFlush();
        }
    }
}
module DrawBottomSide()
{
    mirror([0,1,0])
    {
        if (FlushBottom == 0)
        {
            if (FlushSides == 0)
            {
                DrawBotCorner();
                mirror([1,0,0])
                DrawBotCorner();
            } else {
                DrawCornerSideFlush();
                mirror([1,0,0])
                DrawCornerSideFlush();
            }
            if (Ledge_On == 1)
            {
                BotLedge();
            }
        } else {
            if (FlushSides == 0)
            {
                DrawCornerTopFlush();
                mirror([1,0,0])
                DrawCornerTopFlush();
            } else {
                DrawCornerTopAndSideFlush();
                mirror([1,0,0])
                DrawCornerTopAndSideFlush();
            }
        }
    }
}
module DrawUnion()
{
    union()
    {
        DrawTopSide();
        DrawBottomSide();
        if (Carriage_On == 1)
        {
            translate([0,0,Ht])
            DrawCarriage();             //Carriage from Included file
        }
        if (FlushSides == 1)
        {
            if (Ledge_On == 1)
            {
                SideLedgeFlush();
                mirror([1,0,0])
                SideLedgeFlush();
            }
        }
    }
}
module DrawFinal()
{
    difference()
    {
        DrawUnion();
        if (ECC_Right == 1)
        {
            translate([-W_X_Offset,W_Y_Offset,-1])
            cylinder(d=M5,h=Ht+2,$fn=M5_Res);           //Drill Upper left M5 Hole
            translate([-W_X_Offset,-W_Y_Offset,-1])
            cylinder(d=M5,h=Ht+2,$fn=M5_Res);           //Drill Lower left M5 Hole
            translate([W_X_Offset,W_Y_Offset,-1])
            cylinder(d=M5_ECC,h=Ht+2,$fn=M5_Res);       //Drill Upper Right M5 Eccentric Hole
            translate([W_X_Offset,-W_Y_Offset,-1])
            cylinder(d=M5_ECC,h=Ht+2,$fn=M5_Res);       //Drill Lower Right M5 Eccentric Hole
        } else {
            translate([W_X_Offset,W_Y_Offset,-1])
            cylinder(d=M5,h=Ht+2,$fn=M5_Res);           //Drill Upper left M5 Hole
            translate([W_X_Offset,-W_Y_Offset,-1])
            cylinder(d=M5,h=Ht+2,$fn=M5_Res);           //Drill Lower left M5 Hole
            translate([-W_X_Offset,W_Y_Offset,-1])
            cylinder(d=M5_ECC,h=Ht+2,$fn=M5_Res);       //Drill Upper Right M5 Eccentric Hole
            translate([-W_X_Offset,-W_Y_Offset,-1])
            cylinder(d=M5_ECC,h=Ht+2,$fn=M5_Res);       //Drill Lower Right M5 Eccentric Hole
        }
//If you are using a different type of carriage, you might be able to comment out
//the next 5 lines of code
        if (Carriage_On == 1)
        {
            translate([-12,-L_Offset_Bot*4,Ht])
            cube([10,W_Y_Offset*6,10]);             //Cut ledges for Belt clearance
        }
    }
}
DrawFinal();
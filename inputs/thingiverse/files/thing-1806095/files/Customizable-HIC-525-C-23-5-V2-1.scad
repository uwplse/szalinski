//Customizable 525 MPCNC "C-23.5mm OD" Remix of HicWic Universal Mount
//10/1/2016     By: David Bunch
//Source of Remix: http://www.thingiverse.com/thing:1234989
//
//This is the US version for 23.5 OD EMT
//
//Original EMT Mount Hole Recess measures 2.57mm
//Original Nut Trap Recess is 2.5mm

// CODE FOR THINGIVERSE CUSTOMIZER

////////////////////////////////////////////////////////////////////////////

/* [Main Options] */

//1. Height of Tool Holder or EMT Mount (100)
Ht = 100;                       //[40:1:100]

//2. Height of Bottom EMT Bolt Holes (10.0)
EMT_Hole_Z1 = 10.0;      //[6:0.2:20]

//3. Height of Top EMT Bolt Holes (86.2)
EMT_Hole_Z2 = 86.2;      //[40:0.2:90]

//4. 1st or only Z Height of Tool Mount Holes (25.3)
Tool_Mnt_Z1 = 25.3;      //[10:0.1:40]

//5. 2nd Z Height of Tool Mount Holes (75.3)
Tool_Mnt_Z2 = 75.3;      //[40:0.1:100]

////////////////////////////////////////////////////////////////////////////

/* [Additional Options] */

//6. Base Height (4)

Base_Ht = 4;                    //[1:0.1:6]

//7. 3rd Z Height of Tool Mount Holes (0 if not used)
Tool_Mnt_Z3 = 0;         //[0:2:100]

//8. EMT Mount Bolt Hole Diameter (4.4)
EMT_Hole_OD = 4.4;              //[3:0.1:6]

//9. EMT Mount Bolt Head Diameter (7.6)
EMT_Mnt_Hole_OD = 7.6;          //[6:0.1:8]

//10. EMT Mount Bolt Head Recess (2.6)
EMT_Mnt_Recess = 2.6;           //[1:0.1:6]

//11. Bolt Hole diameter to mount Tool Holder (3.0)
Tool_Mnt_Hole_OD = 3.0;         //[3:0.1:6]

//12. Diameter of inserted Nut for Tool Holder (6.6)
Tool_Mnt_Nut_OD = 6.6;         //[4:0.1:10]

//13. Nut Trap Depth (2.5)
Nut_Trap_Depth = 2.5;           //[1:0.1:2.5]

//14. Section Cut for Verification (yes, or no)
Draw_Section = "no";    //[yes,no]        

/* [Hidden] */

Tool_Mnt_Y_Offset = 6.81;       //Offset for origin of Tool Mount holes
EMT_Hole_Y_Offset = 32.85;      //Offset for origin of EMT Mounts holes

//From where I am starting the EMT Bolt Head cut, 36.13mm will give 0.0 Recess
EMT_Mnt_Hole_Len = 36.13 - EMT_Mnt_Recess;  //Calculate length of Bolt Head Drill Length

//From where I am starting the Nut Trap cut, 14.62mm will give 0.0 deptth Cut
NutTrap_Len = 14.62 + Nut_Trap_Depth;

EMT_Hole_Res = (round(((EMT_Hole_OD * 3.14)/4) / .5)*4);
EMT_Mnt_Hole_Res = (round(((EMT_Mnt_Hole_OD * 3.14)/4) / .7)*4);
Tool_Mnt_Hole_Res = (round(((Tool_Mnt_Hole_OD * 3.14)/4) / .4)*4);

echo(EMT_Hole_Res = EMT_Hole_Res);
echo(EMT_Mnt_Hole_Res = EMT_Mnt_Hole_Res);
echo(Tool_Mnt_Hole_Res = Tool_Mnt_Hole_Res);
echo(EMT_Mnt_Hole_Len = EMT_Mnt_Hole_Len);
echo(NutTrap_Len = NutTrap_Len);

//Used to verify that this customized version matches original
//module HicWicMount_C_V2()
//{
//    difference()
//    {
//        color("red")
//        rotate([0,0,45])
//        translate([-92.06,-92.06,0])
//        import("UniversalMount_525_-_C_-_23.5_v2.stl", convexity=3);
//        if (Draw_Section == "yes")
//        {
//            translate([-100,0,EMT_Hole_Z1])
//            cube([100,100,100]);
//            translate([0,0,Tool_Mnt_Z1])
//            cube([100,100,100]);
//        }
//    }
//}
//%HicWicMount_C_V2();
module OutLine()
{
//This is the profile copied from Original Design
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
    [[-14.95,27.81],[-30.79,11.04],[-29.77,10.61],[-28.79,10.09],[-27.87,9.48],
    [-27,8.78],[-26.21,8],[-25.49,7.16],[-24.86,6.25],[-24.32,5.28],
    [-23.87,4.27],[-23.51,3.22],[-7.84,19.81],[7.84,19.81],[23.51,3.22],
    [23.87,4.27],[24.32,5.28],[24.86,6.25],[25.49,7.16],[26.21,8],
    [27,8.78],[27.87,9.48],[28.79,10.09],[29.77,10.61],[30.79,11.04],
    [14.95,27.81],[7.5,27.81],[-7.5,27.81]]);
}
module VertCut()
{
//This is the Cutout profile copied from Original Design
    translate([0,0,Base_Ht])
    linear_extrude(height = Ht+2, center = false, convexity = 10)polygon(points = 
    [[-12.5,25.31],[-20.59,16.74],[-18.11,14.03],[-10.29,22.31],[10.29,22.31],
    [18.11,14.03],[20.59,16.74],[12.5,25.31],[7.5,25.31],[7.5,28.81],
    [-7.5,28.81],[-7.5,25.31]]);
}
module EMT_Holes()
{
    for (a =[0:1])
    {
        mirror([a,0,0])
        translate([0,EMT_Hole_Y_Offset,0])
        rotate([0,0,-47.5])
        rotate([90,0,0])
        {
            cylinder(d=EMT_Mnt_Hole_OD,h=EMT_Mnt_Hole_Len,$fn=EMT_Mnt_Hole_Res);
            cylinder(d=EMT_Hole_OD,h=48.63,$fn=EMT_Hole_Res);
        }
    }
}
module Tool_Mnt_Holes()
{
    for (a =[0:1])
    {
        mirror([a,0,0])
        translate([0,Tool_Mnt_Y_Offset,0])
        rotate([0,0,46.62])     //Line up holes at correct angle
        rotate([-90,0,0])       //Rotate holes horizontal
        {
            rotate([0,0,30])    //Rotate Nut Trap hole for no overhang printing
            cylinder(d=Tool_Mnt_Nut_OD,h=NutTrap_Len,$fn=6);      //Nut Trap Hole
            cylinder(d=Tool_Mnt_Hole_OD,h=28,$fn=Tool_Mnt_Hole_Res);    //Drill hole all the way thru
        }
    }
}
module DrawFinal()
{
    difference()
    {
        OutLine();
        VertCut();
        translate([0,0,EMT_Hole_Z1])
        EMT_Holes();
        translate([0,0,EMT_Hole_Z2])
        EMT_Holes();
        translate([0,0,Tool_Mnt_Z1])
        Tool_Mnt_Holes();
        if (Tool_Mnt_Z2 > 0)
        {
            translate([0,0,Tool_Mnt_Z2])
            Tool_Mnt_Holes();
        }
        if (Tool_Mnt_Z3 > 0)
        {
            translate([0,0,Tool_Mnt_Z3])
            Tool_Mnt_Holes();
        }
        if (Draw_Section == "yes")
        {
            translate([-100,0,EMT_Hole_Z1])
            cube([100,100,100]);
            translate([0,0,Tool_Mnt_Z1])
            cube([100,100,100]);
        }
    }
}
DrawFinal();
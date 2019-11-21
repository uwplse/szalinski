//Drill guide for Mostly Printed CNC Z Pipe
//7/3/2015  By: David Bunch
//Revised center cuts for larger Diameter holes to work better
//
//Revised 10/4/2015
//Designed for Bosch Toolholder with Dust cover using 2 parts
//76.25mm 1st & 3rd hole
//28.01mm 1st & 2nd hole
//48.24mm 2nd & 3rd hole

//Revised 8/5/2017 to make Wall thickness & Base Thickness separate variables & fixed one bug

//CUSTOMIZER VARIABLES

//1. Spacing between Nuts (Standard is 76.2mm)
NutSpacing = 76.2;      //(I used 53mm for the rotary tool I am using)

//2. Spacing between 1st & 2nd Nut
NutSpacing2 = 28;    //Use 0 if only using 2 nuts

//3. Dia of Drill Hole (9/64" Drill bit, Added .2mm for slip fit)
//M3 = 3.8;
DrSize = 3.8;

//4. Pipe Dia. to Use (Added 0.8 for slight tight fit)
OD = 23.8;              //23.7mm was a little tight & 24.0 was a little loose for me

//5. Thickness at bottom of Pipe
Thickness = 5;

//6. Thickness of Walls on each side of pipe
Wall_Thk = 5;

//7. Resolution of Pipe (108 gives .688mm length segments)
Pipe_res = 108;

//8. Resolution of holes (24 gives .497mm length segments)
Hole_res = 24;

//9. Offset from Left for 1st Nut Trap
LtNutOffset = 19.05;      //Original Design is 19.05mm

//10. Offset from Right of 2nd Nut Trap (Original is 6.35mm)
RtNutOffset = 8.35;       //(I decided to add 2mm to this gap)

//11. Center Clamp Width
Cl_Wid = 6;

//12. Number of Holes (1, 2 or 3)
Num_Holes=2;        //I needed 3 for the Bosch quick disconnect mount

//13. Print 1 or 2 Nut Traps
Qty = 2;

//CUSTOMIZER VARIABLES END
//----------------------------------------
//Begin calculations based on input variables
MidNutOffset = LtNutOffset + NutSpacing2;
echo("MidNutOffset = ", MidNutOffset);
TotCenGap=NutSpacing - DrSize - 12;         //I use 6mm plastic around holes
echo("TotCenGap = ",TotCenGap);

DrRad = DrSize / 2;
echo("DrRad = ", DrRad);
THK = OD /2 + Thickness;

DrLen = OD + Thickness + Thickness+2;

echo("THK = ",THK);

Width = OD + Wall_Thk + Wall_Thk;
echo("Width = ",Width);

WidSlice = Width + 2;
Rad = OD / 2;
echo("Rad = ", Rad);

Ht = LtNutOffset + NutSpacing + RtNutOffset;
echo("Ht = ", Ht);

CenCub_Z2 = LtNutOffset + DrRad + 3;         //6mm of plastic each side of hole

CenCub_Z1 = MidNutOffset + DrRad + 3;

CenCubLen1 = NutSpacing - NutSpacing2 - (6 + DrSize);                     //Use this if Cl_Wid = 0;
//CenCubLen2 = (TotCenGap - Cl_Wid) / 2;
CenCubLen2 = NutSpacing2 - (6 + DrSize);

echo("CenCubLen1 = ", CenCubLen1);
echo("CenCubLen2 = ", CenCubLen2);
//translate([LtNutOffset,0,0])
//%cube([DrRad + 3,4,10]);
module Base()
{
    translate([0,0,THK])
    rotate([0,90,0])
    difference()
    {
        translate([0,-Width/2,0])
        cube([THK,Width,Ht]);                   //Basic starting cube
        translate([0,0,-1])
        cylinder(d=OD,h=Ht+2,$fn=Pipe_res);     //Cut for where pipe is laid
        if (Cl_Wid > 0)
        {
            translate([-1,-Rad,CenCub_Z2])
            cube([THK+2,OD,CenCubLen2]);           //cube cut out of 1st part of center
            translate([-1,-Rad,CenCub_Z1])
            cube([THK+2,OD,CenCubLen1]);           //cube cut out of 2nd part of center
        } else {
            translate([-1,-Rad,CenCub_Z])
            cube([OD,OD,CenCubLen1]);          //cube cut out of center
        }
        translate([-1,-Rad,-1])
        cube([THK+2,OD,(LtNutOffset - DrRad - 6) + 1]);         //Slice a cube cut at left side
        translate([-(Thickness+2),-(WidSlice/2),LtNutOffset])
        cube([THK,WidSlice,NutSpacing]);        //Slice across Top for less plastic

        translate([0,0,LtNutOffset])
        rotate([0,90,0])
        cylinder(d=DrSize,h=DrLen,center=true,$fn=Hole_res);       //Drill Bottom Hole
        if (Num_Holes == 3)
        {
            translate([0,0,LtNutOffset+NutSpacing2])
            rotate([0,90,0])
            cylinder(d=DrSize,h=DrLen,center=true,$fn=Hole_res);       //Drill Middle Hole
        }
        if (Num_Holes > 1)
        {
                translate([0,0,LtNutOffset+NutSpacing])
                rotate([0,90,0])
                cylinder(d=DrSize,h=DrLen,center=true,$fn=Hole_res);    //Drill Top Hole
        }
    }
}
            //translate([-1,-Rad,CenCub_Z])
            //cube([OD,OD,CenCubLen2]);           //cube cut out of 1st part of center
Base();
if (Qty == 2)
{
    translate([0,Width+6,0])
    Base();
}
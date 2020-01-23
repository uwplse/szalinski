//Parametric Nut trap for Mostly Printed CNC Router
//July 7,2015 By: David Bunch
//
//I needed to make a length that would fit with my customized tool holder for
//a Mastergrip rotary tool I bought at Costco years ago, so I decided to make it parametric.
//Spacing for my tool holder is 53mm distance between holes

//Even though this is for the U.S. Standard Version, I use mm for dimensions

//CUSTOMIZER VARIABLES

//1. Spacing between Nuts
NutSpacing=76.2;     //mm spacing between Nuts (original design seems to be 76.2mm)

//2. Diameter of Nut Holder (21mm is U.S. Version Size)
THNT_Dia=21;      //Dia Tool Holder Nut Trap

//3. Resolution of Nut Holder (96 gives you about .7mm length segments in curve)
ires=96;    //Number of  segments for Tool Holder
                    //Circumference of 21mm Dia circle is 65.97
                    //Making each segment about .7mm will give you 96 for the number of sides

//4. Diameter of Bolt Threading
M3Dia=3.6;             //Dia. of Hole

//5. Resolution of Bolt Threads (24 gives .47mm length segments in curve)
M3_ires=24;         //Number of segments for M3 holes (.47mm segments)
                    //original design was 180 sides (.06mm segments)
//6. Diameter of Nut
M3NutDia=9.18;

//7. Height of Nut trap
M3Nut_Ht=4.7;

//8. Offset from Left for 1st Nut Trap
LtNutOffset=19.05;      //Original Design is 19.05mm

//9. Offset from Right of 2nd Nut Trap (Original is 6.35mm)
RtNutOffset=8.35;       //(I decided to add 2mm to this gap)

//10. Rotation of Nut Trap (0 = Original or 30 = Nut face parallel with End)
RotNut=0;	//	[0:Original, 30:parallel with End]

//11. Print 1 or 2 Nut Traps
Qty=1;

//12. Change this number to make it thicker or thinner
Z_Origin=-2;      //Z origin of Nut trap profile cylinder to extrude
//CUSTOMIZER VARIABLES END
//----------------------------------------
//	This creates a drop down box of numbered options

Len=LtNutOffset+RtNutOffset+NutSpacing;     //Total Length of Nut Trap
echo("Len = ",Len);
RtNut_X=Len-RtNutOffset;



//Len=101.6;   //Original Tool Holder Nut Trap length was 101.6
Cube_z=(Z_Origin + 30)* (-1);
module Base()
{
    difference()
    {
        translate([0,0,Z_Origin])
        rotate([0,90,0])
        cylinder(d=THNT_Dia,h=Len,$fn=ires);
        translate([-1,-15,-30])
        cube([Len+2,30,30]);
    }
}
module DrawFinal()
{
    difference()
    {
        Base();
//Drill the Left Bolt Hole
        translate([LtNutOffset,0,-1])
        cylinder(d=M3Dia,h=12,$fn=M3_ires);
//Cut Left Nut Trap
        translate([LtNutOffset,0,-1])
        rotate([0,0,RotNut])            //Rotate Nut either 0 or 30
                                        //rotating 30 gives more plastic between Nut and end
        cylinder(d=M3NutDia,h=M3Nut_Ht+1,$fn=6);        //6 sided Nut trap hole
        translate([LtNutOffset,0,M3Nut_Ht-.01])
        rotate([0,0,RotNut])            //Rotate Nut either 0 or 30
        cylinder(d1=M3NutDia,d2=M3NutDia-2,h=1,$fn=6);  //Add slight taper for nut hole
//Drill the Right Bolt Hole
        translate([RtNut_X,0,-1])
        cylinder(d=M3Dia,h=12,$fn=M3_ires);
//Cut Right Nut Trap
        translate([RtNut_X,0,-1])
        rotate([0,0,RotNut])            //Rotate Nut either 0 or 30
        cylinder(d=M3NutDia,h=M3Nut_Ht+1,$fn=6);        //6 sided Nut trap hole
        translate([RtNut_X,0,M3Nut_Ht-.01])
        rotate([0,0,RotNut])            //Rotate Nut either 0 or 30
        cylinder(d1=M3NutDia,d2=M3NutDia-2,h=1,$fn=6);  //Add slight taper for nut hole
    }
}
DrawFinal();
if (Qty == 2)
{
    translate([0,25,0])
    DrawFinal();
}
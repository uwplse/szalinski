//Parametric Coupler
//By David Bunch 8/9/2015
//
//This design is based on the Rigid Coupler for the
//Mostly printed CNC machine http://www.thingiverse.com/thing:724999
//To couple different or same size Shafts together,
//usually a nema 17 motor to a threaded rod
//The little bolts used to tighten this design are M3 x 14mm or 16mm length
//CUSTOMIZER VARIABLES

//1. Outside Diameter of Coupler (try 20 for 5mm to 5mm)
OD = 22;

//2. Total Height of Coupler
Ht = 25.4;

//3. Small Coupler Connection (5mm default)
ShaftSmall = 5.25;              //Add 5% to make more of a slip fit
                                //Tightening bolts will snug this up
                               //6.66 = 1/4"(6.35mm)

//4. Large Coupler Connection (8mm default)
ShaftLarge = 8.4;              //Add 5% to make more of a slip fit
                               //8.4 = 8mm, 6.3 = 6mm, 5.25 = 5mm


//5. Gap Cut size for Tightening Coupler
GapDist = 2.2;

//6. Coupling Bolt Diameter used for Tightening (M3 default)
M3 = 3.4;              //Use 3.65 for #6 bolts

//7. Coupling Bolt Diameter used for Tightening
M3Nut = 6.5;           //if using #6 Nuts use 9.25mm
                        //4mm nuts 8.08mm (
                        //3mm nuts 6.5mm (This size worked good for me)

//8. Bolt Length (14mm long bolt is default)
BoltLen = 14;         //This should still be a good length for
                        //14mm or 16mm length bolts will just
                        //        stick out a little beyond locknut

//9. X Offset for Bolt Tightening Holes (try 6 for 5mm to 5mm)
M3_DX=7;

//10. 1st Z Offset for Bolt Tightening Holes
M3_DZ1 = 6;

//11. 2nd Z Offset for Bolt Tightening Holes
M3_DZ2 = 19.4;

//12. Resolution large Circles
IresBig = 88;

//13. Resolution of Small Circles
IresSmall = 34;

//14. Chamfer Radius at Top & bottom
ChamferSize = 1.5;        //Set width of chamfer at top & bottom

//15. 1 part or 2 Halves
PartType = 1;   //2 Halves are useful if your 2 shafts are already in place

//CUSTOMIZER VARIABLES END

M3_Thk = (BoltLen - GapDist - 5.2) / 2;
echo("M3_Thk = ", M3_Thk);

GapHalf = GapDist / 2;
M3Nut_DY = M3_Thk + GapHalf;

Rad = OD / 2;

//This is the Chamfer used at the bottom & top of coupling
module ChamferCyl()
{
    if (ChamferSize > 0)
    {
        rotate_extrude(convexity = 10, $fn = IresBig)
        translate([Rad, 0, 0])
        circle(r = ChamferSize, $fn = 4);
    }
}
//These are the holes for the tightening bolts & nuts
module BoltAndNutCut()
{
//Drill hole all the way through
    translate([-M3_DX,Rad,0])
    rotate([90,0,0])
    cylinder(d=M3,h=OD,$fn=IresSmall);
//Cut for hex nut on one end
    translate([-M3_DX,-M3Nut_DY,0])
    rotate([90,0,0])
    rotate([0,0,30])
    cylinder(d=M3Nut,h=Rad,$fn=6); 
//Cut for hex nut on the other end
    translate([-M3_DX,M3Nut_DY,0])
    rotate([-90,0,0])
    rotate([0,0,30])
    cylinder(d=M3Nut,h=Rad,$fn=6);
}
module HorizontalHoles()
{
    translate([0,0,M3_DZ1])
    BoltAndNutCut();            //Lower Horizontal Hole
    translate([0,0,M3_DZ2])
    BoltAndNutCut();            //Upper Horizontal Hole
}
//Cut out the holes, gap & draw final part
module DrawFinal()
{
    difference()
    {
        cylinder(d=OD,h=Ht,$fn=IresBig);        //Draw the main cylinder
        translate([0,0,-1])
        cylinder(d=ShaftSmall,h=Ht+2,$fn=IresSmall);    //Cut small shaft hole from bottom
        translate([0,0,Ht / 2])                         //Start 2nd hole half way up
        cylinder(d=ShaftLarge,h=Ht,$fn=IresSmall);      //Cut large or same size shaft hole
        translate([-(Rad+.01),-GapHalf,-1])
        cube([Rad,GapDist,Ht+2]);       //Cut gap for tightening
//Cut bottom bolt tightening hole
        HorizontalHoles();  //Cut horizontal holes for tightening bolts
//See if user wants to draw this as 2 halves instead of just 1 gap cut
        if (PartType == 2)
        {
            rotate([0,0,180])
            {
                HorizontalHoles();  //Cut horizontal holes for tightening bolts
                translate([-(Rad+.01),-GapHalf,-1])
                cube([Rad,GapDist,Ht+2]);       //Cut gap for tightening
            }
        }
        if (ChamferSize > 0)
        {
            ChamferCyl();                   //Chamfer the top
            translate([0,0,Ht])
            ChamferCyl();                   //Chamfer the bottom
        }
    }
}


DrawFinal();
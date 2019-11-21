//Parametric Rigid Coupler
//By David Bunch 8/9/2015
//
//This design is based on the Rigid Coupler for the
//Mostly printed CNC machine http://www.thingiverse.com/thing:724999
//To couple a Nema 17 Motor shaft to a 5/16" threaded rod
//I only changed the connection diameter of the 5/16" threaded rod
//The little bolts used to tighten this design are #6 x 1/2" bolts
//If using metric, M4 x 14mm is closest
//CUSTOMIZER VARIABLES

//1. Outside Diameter of Coupler
OD = 19.6;

//2. Taper Height for Coupler
H2 = 1.16;

//3. Taper Outside Diameter of Coupler
ODT = 12.2;

//4. Total Height of Coupler
Ht = 28.0;

//5. Small Coupler Connection
M5 = 5.0;

//6. Large Coupler Connection
M8 = 7.94;                   //Originally 7.6mm (5/16" = 7.9375mm)

//7. Gap Cut size for Tightening Coupler
GapDist = 2.2;

//8. Coupling Bolt Diameter used for Tightening (#6 screw used here)
M4 = 3.65;              //Use 4.0 if using M4 bolts

//9. Coupling Bolt Diameter used for Tightening (#6 Nut default)
M4Nut = 9.25;           //if using M4 nuts, use 8.08mm

//10. Bolt Length (1/2" long bolt is default)
BoltLen = 12.7;         //This should still be a good length for
                        //14mm or 16mm length bolts,
                        //they will just stick out a little beyond locknut

//11. X Offset for Bolt Tightening Holes
M4_DX = 6.75;

//12. 1st Z Offset for Bolt Tightening Holes
M4_DZ1 = 7.0;

//13. 2nd Z Offset for Bolt Tightening Holes
M4_DZ2 = 21.0;

//14. Resolution large Circles
IresBig = 88;

//15. Resolution of Small Circles
IresSmall = 34;

//16. 1 part or 2 Halves
PartType = 1;   //2 Halves are useful if your 2 shafts are already in place
                //This maybe useful if you need to replace a broken coupling
                //without removing Z tower

//CUSTOMIZER VARIABLES END

M4_Thk = (BoltLen - GapDist - 5.2) / 2;
echo("M4_Thk = ", M4_Thk);

echo("H2 = ",H2);
H1 = Ht - H2;
echo("H1 = ",H1);

GapHalf = GapDist / 2;
M4Nut_DY = M4_Thk + GapHalf;

Rad = OD / 2;
//Draw the Main Coupler
module DrawUnion()
{
    union()
    {
        cylinder(d=OD,h=H1,$fn=IresBig);
        translate([0,0,H1])
        cylinder(d1=OD,d2=ODT,h=H2,$fn=IresBig);
    }
}
module HorizontalHoles()
{
    translate([0,0,M4_DZ1])
    BoltAndNutCut();            //Lower Horizontal Hole
    translate([0,0,M4_DZ2])
    BoltAndNutCut();            //Upper Horizontal Hole
}
//Cut out the holes, gap & draw final part
module DrawFinal()
{
    difference()
    {
        DrawUnion();
        translate([0,0,-1])
        cylinder(d=M5,h=Ht+2,$fn=IresSmall);
        translate([0,0,Ht / 2])
        cylinder(d=M8,h=Ht,$fn=IresSmall);
        translate([-(Rad+.01),-GapHalf,-1])
        cube([Rad,GapDist,Ht+2]);       //Cut gap for tightening
//Cut bottom bolt tightening hole
        HorizontalHoles(); 
        if (PartType == 2)
        {
            rotate([0,0,180])
            {
                HorizontalHoles();  //Cut horizontal holes for tightening bolts
                translate([-(Rad+.01),-GapHalf,-1])
                cube([Rad,GapDist,Ht+2]);       //Cut gap for tightening
            }
        }
    }
}
//These are the holes for the tightening bolts & nuts
module BoltAndNutCut()
{
//Drill hole all the way through
    translate([-M4_DX,Rad,0])
    rotate([90,0,0])
    cylinder(d=M4,h=OD,$fn=IresSmall);
//Cut for hex nut on one end
    translate([-M4_DX,-M4Nut_DY,0])
    rotate([90,0,0])
    rotate([0,0,30])
    cylinder(d=M4Nut,h=Rad,$fn=6); 
//Cut for hex nut on the other end
    translate([-M4_DX,M4Nut_DY,0])
    rotate([-90,0,0])
    rotate([0,0,30])
    cylinder(d=M4Nut,h=Rad,$fn=6);
}
DrawFinal();
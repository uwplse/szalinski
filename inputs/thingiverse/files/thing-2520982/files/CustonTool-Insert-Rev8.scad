//Customizable insert for Bosch Quck Disconnect Mount
//9/6/2017  By: David Bunch

//CUSTOMIZER VARIABLES

//1. Outside Diameter of Insert (70.7mm Default)
OD = 70.7;              //Outside Diameter matches Quick Disconnect size

//2. Inside Diameter of Insert (48.4mm Default)
ID = 48.4;              //Size of Master Grip rotary tool or size you need

//3. Height of Insert
Ht = 33;                //[4:1:60]

//4. Width of Lip
Lip_Wid = 2.5;          //[0:.5:10]

//5. Height of Lip
Lip_Ht = 1.5;           //[.5:.5:6]

//6. Thickness of Walls (Used for cutting out excess plastic)
Thk = 4;                //[3:.5:6]

//7. Width of Tightening Slot
Slot_Wid = 4;           //[1:.5:8]

//8. Diameter of Chamfer relief cuts
Cham_OD = 4;            //[1:.5:8]

//9. Angle between each Chamfer
Cham_Ang = 30;          //[0:5:60]

//10. Cutout Support Width (4mm Default)
CS_Wid = 4;             //[0:.5:8]

//11. Cutout Support Angle
CS_Ang = 60;            //[0:5:60]

/* [Hidden] */

Lip_Wid2x = Lip_Wid * 2;        //OD + this = Diameter of Lip
Wid = (OD - ID) / 2;            //Thickness of Plastic from ID to OD
Slant_Wid = Wid - Thk;          //Width & Height of Slant Height
OD1 = OD - (Slant_Wid * 2);
Cut_Thk = Wid - Thk - Thk;

Short_Ht = (Ht - (Slant_Wid * 2)) / 3;  //Height of Short Height & Mid Outside Height
A1 =  Thk * sin(22.5);
C_Ht1 = Short_Ht - A1;          //Solid Cut Height

OD_Res = (round(((OD  * 3.14) / 4) / 2) *  4);
ID_Res = (round(((ID  * 3.14) / 4) / 1) *  4);

echo(Wid = Wid);
echo(Slant_Wid = Slant_Wid);
echo(C_Ht1 = C_Ht1);
echo(A1 = A1);
echo(Cut_Thk = Cut_Thk);        //How much we can cut out of Cylinder Wall
echo(Short_Ht = Short_Ht);
echo(OD1 = OD1);
echo(OD_Res = OD_Res);
echo(ID_Res = ID_Res);

module Cutout()
{
    OD2 = OD - Thk - Thk;
    ID1 = ID + Thk + Thk;
//Do not bother cutting if not worth the bother
    if (Cut_Thk > 2)
    {
        difference()
        {
            union()
            {
                difference()
                {
                    translate([0,0,-.01])
                    cylinder(d=OD2,h=C_Ht1 + .02,$fn=OD_Res);
                    translate([0,0,-1])
                    cylinder(d=ID1,h=C_Ht1 + 2,$fn=OD_Res);
                }
                difference()
                {
                    translate([0,0,C_Ht1])
                    cylinder(d1=OD2,d2=ID1,h=Cut_Thk,$fn=OD_Res);
                    translate([0,0,C_Ht1 - 1])
                    cylinder(d=ID1,h=Cut_Thk + 2,$fn=OD_Res);
                }
            }
            if (CS_Wid > 0)
            {
                if (CS_Ang > 0)
                {
                    for (a = [0:(360 / CS_Ang)- 1])
                    {
                        rotate([0,0,a * CS_Ang])
                        rotate([0,0,CS_Ang / 2])
                        translate([0,-CS_Wid / 2,-1])
                        cube([OD,CS_Wid,Ht + 2]);
                    }
                }
            }
//Close off the end of the Cutout for more strength
            translate([0,-((Slot_Wid * 3)/ 2),-1])
            cube([OD,Slot_Wid * 3,Ht + 2]);
        }
    }
}
module CylCham(C_OD = Cham_OD, X1 = 0)
{
    hull()
    {
        cylinder(d=C_OD,h=Ht + 2,$fn=20);
        for (m = [0,1])
        {
            mirror([0,m,0])
            translate([X1,C_OD / 2,0])
            cylinder(d=C_OD / 2,h=Ht+2,$fn=4);
        }
    }
}
module DrawUnion()
{
    if (Slant_Wid > 1.0)
    {
        union()
        {
            if (Lip_Wid > 0)
            {
                cylinder(d=OD + Lip_Wid2x,h=Lip_Ht,$fn=OD_Res);
            }
            cylinder(d=OD,h=Short_Ht,$fn=OD_Res);
            translate([0,0,Short_Ht])
            cylinder(d1=OD,d2=OD1,h=Slant_Wid,$fn=OD_Res);
            translate([0,0,Short_Ht + Slant_Wid])
            cylinder(d=OD1,h=Short_Ht,$fn=OD_Res);
            translate([0,0,Short_Ht + Slant_Wid + Short_Ht])
            cylinder(d1=OD1,d2=OD,h=Slant_Wid,$fn=OD_Res);
            translate([0,0,Short_Ht + Slant_Wid + Short_Ht + Slant_Wid])
            cylinder(d=OD,h=Short_Ht,$fn=OD_Res);
        }
    } else
    {
//Don't bother making slant heights if diameter difference is too small
        if (Lip_Wid > 0)
        {
            union()
            {
                cylinder(d=OD + Lip_Wid2x,h=Lip_Ht,$fn=OD_Res);
                cylinder(d=OD,h=Ht,$fn=OD_Res);
            }
        } else
        {
            cylinder(d=OD,h=Ht,$fn=OD_Res);
        }
    }
}
module DrawFinal()
{
    difference()
    {
        DrawUnion();
        Cutout();
        translate([0,0,Ht])
        mirror([0,0,1])
        Cutout();
        translate([0,0,-1])
        cylinder(d=ID,h=Ht + 2,$fn=ID_Res);
        translate([0,-Slot_Wid / 2,-1])
        cube([OD,Slot_Wid,Ht + 2]);
//Add some relief cuts on inside & outside Diameter every 30 degrees
//Do not cut out around Slot opening
        if (Cham_Ang > 0)
        {
            //Cham_IDX = 360 / Cham_Ang;
            for (a = [0:(360 / Cham_Ang) - 2])
            {
                rotate([0,0,Cham_Ang + (a * Cham_Ang)])
                translate([ID / 2,0,-1])
                CylCham(4,-.4);
                rotate([0,0,Cham_Ang + (a * Cham_Ang)])
//We Hull this in case somone made a really wide Lip
                hull()
                {
                    translate([(OD / 2) + 2.5,0,-1])
                    CylCham(7,0);
                    translate([(OD / 2) + Lip_Wid,0,-1])
                    CylCham(4+Lip_Wid,0);
                }
            }
        }
        for (m = [0,1])
        {
            mirror([0,m,0])
            {
                translate([(ID / 2) - .4,Slot_Wid / 2,-1])
                cylinder(d=4,h=Ht + 2,$fn=4);
                translate([(OD / 2) + Lip_Wid,Slot_Wid / 2,-1])
                cylinder(d=4 + (Lip_Wid * 2),h=Ht+2,$fn=4);
            }
        }
//In case of small Inside Diameter, this is needed to get rid of extra plastic top & bottom
        translate([0,0,Ht])
        cylinder(d=OD * 3,h=Ht);
        translate([0,0,-Ht])
        cylinder(d=OD * 3,h=Ht);
    }
}
DrawFinal();
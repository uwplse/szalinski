//Parametric Adapter Tool Holder
//I made this to fit a sharpie in my Master Grip tool holder
//8/24/2015 By: David Bunch
//
//CUSTOMIZER VARIABLES

//1. Diameter of Inserted Adapter
OD = 49.0;

//2. Diameter of opening for smaller tool
ID = 11.2;          //This was a nice somewhat loose fit of a Sharpie Fine Point
                    //10.0 is about the diameter of a Sharpie Ultra Fine Point

//3. Diameter of Lip
LipThk = 3;

//4. Height of Lip
LipHt = 3;

//5. Height of Adapter Portion
Ht = 12.7;

//6. Resolution of Cylinder
I_Res = 64;

//CUSTOMIZER VARIABLES END

TotHt = Ht + LipHt;

LipOD = OD + LipThk + LipThk;
$fn = I_Res;

LipRad = LipOD / 2;

Rad = OD / 2;

RadID = ID / 2;
module DrawUnion()
{
    union()
    {
        cylinder(d=OD,h=TotHt);
        cylinder(d=LipOD,h=LipHt);
    }
}
difference()
{
    DrawUnion();
    translate([0,0,-1])
    cylinder(d=ID,h=TotHt+2);
    translate([-1,-32,-1])
    cube([2,32,TotHt+2]);
//Chamfer the outer bottom lip
    translate([0,0,0])
    rotate_extrude(convexity = 10, $fn = I_Res)
    translate([LipRad, 0, 0])
    circle(r = 1, $fn = 4);
//Chamfer the outer bottom lip
    translate([0,0,3])
    rotate_extrude(convexity = 10, $fn = I_Res)
    translate([LipRad, 0, 0])
    circle(r = 1, $fn = 4);
//Chamfer the outer top edge
    translate([0,0,TotHt])
    rotate_extrude(convexity = 10, $fn = I_Res)
    translate([Rad, 0, 0])
    circle(r = 1.5, $fn = 4);
//Chamfer the top of Tool Adapter
    translate([0,0,TotHt])
    rotate_extrude(convexity = 10, $fn = I_Res)
    translate([RadID, 0, 0])
    circle(r = 1.5, $fn = 4);
//Chamfer the bottom of Tool Adapter
    translate([0,0,0])
    rotate_extrude(convexity = 10, $fn = I_Res)
    translate([RadID, 0, 0])
    circle(r = 1.5, $fn = 4);
}
//Adapter for Sharpie fine point in Master Grip 49mm Dia. Tool holder
//8/24/2015 By: David Bunch

//1. Diameter of Inserted Adapter
OD = 49.0;

//2. Diameter of opening for smaller tool
ID = 11.2;          //This is the diameter of a Sharpie Fine Point
                    //10.0 is the diameter of a Sharpie Ultra Fine Point

//3. Diameter of Opening above Adapter Hole
ID_Above = 43;

//4. Height of Above Opening
Ht_Above = 8.38;

//3. Diameter of Lip
LipOD = 55;

//4. Total Height of Adapter
Ht = 28;

echo("Ht = ", Ht);

//5. Resolution of Cylinder
I_Res = 64;

$fn = I_Res;

LipRad = LipOD / 2;
Rad = OD / 2;
RadID = ID / 2;
module ChamOuter()
{
    translate([0,0,3])
    difference()
    {
        cylinder(d=55,h=28);
        translate([0,0,-1])
        cylinder(d=48.1175,h=5.8557);
        translate([0,0,4.85])
        cylinder(d1=48.1175,d2=19.126,h=14.2);
        translate([0,0,-1])
        cylinder(d=19.126,h=35);
    }
}
module DrawUnion()
{
    union()
    {
        cylinder(d=LipOD,h=3);
        cylinder(d=OD,h=4.4228);
        translate([0,0,4.4228])
        cylinder(d1=OD,d2=28.2238,h=10.189);
        translate([0,0,14.6119])
        cylinder(d1=28.2238,d2=OD,h=10.3881);
        translate([0,0,25])
        cylinder(d=OD,h=3);
    }
}
module DrawFinal()
{
    difference()
    {
        DrawUnion();
        translate([0,0,-1])
        cylinder(d=ID,h=Ht+2);
//Cut for space above Tool Holder
        translate([0,0,-1])
        cylinder(d=ID_Above,h=2.55);

        translate([0,0,1.55])
        cylinder(d1=ID_Above,d2=ID,h=16.15);
//Cut 3mm opening for tightening in tool holder
        translate([-1.5,-32,-1])
        cube([3,32,Ht+2]);
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
//Chamfer the top of Sharpie holder
        translate([0,0,Ht])
        rotate_extrude(convexity = 10, $fn = I_Res)
        translate([RadID, 0, 0])
        circle(r = 1.5, $fn = 4);
//Chamfer the bottom of Sharpie holder
        translate([0,0,16.2])
        cylinder(d1=ID+3,d2=ID,h=2.134);
    //cube([60,60,60]);             //Cut a quarter section of part
    }
}
DrawFinal();
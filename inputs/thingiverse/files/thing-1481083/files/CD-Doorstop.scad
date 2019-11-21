//**************************************************************************
//*   
//*   Configurable CD/DVD Doorstop
//*   dimensions (all in mm)
//*   Created by Keith Welker
//*   10 April 2016
//**************************************************************************

FN = 120;//$fn for cylinders (resolution)
ID = 15; //CD inner diameter - 15 recommended
OD = 120; // CD outer diameter - 120 recommended
Hmin = 5; // minimum height of doorstop
Hmax = 30; // maximum height of doorstop
 
CD_DoorStop();

module CD_DoorStop()
{
    delta = .015; // small delta size for cutouts
    os = Hmin + (Hmax-Hmin)/2;
    difference()
    {
        cylinder(Hmax, d=OD, $fn = FN);
        //remove the inner hole
        translate([0,0,-delta])
        cylinder(Hmax+2*delta, d=ID, $fn = FN);
        //remove the top to form a wedge...
        translate([-OD*1.25/2, -OD/2, Hmin])
        rotate(a = asin((Hmax-Hmin)/OD)*.95, v=[1,0,0])
        cube([OD*1.25, OD*1.25, Hmax]);
    }
}



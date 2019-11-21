//********************************************
//Motor mount tilt for quadcopter.
//
// Each mount consists of an upper piece that
//goes above the fram arm and another piece that
//goes below the frame arm.
//This will keep mounting screw lengths the same
//mounting screws will have no angle force on them.
//********************************************





//Motor tilt required
motorTilt=13;

//Minimum thickness of smallest edge of mount. Increase for a taller mount
minThickness=1;



//Mounting hole 1 centers. Looking at base of motor, with motor wires sticking out top, hole 1 is first hole to the counter clockwise direction. Default suits baby beast motors
motorMountHole1Centers = 19;

//Looking at base of motor, with motor wires sticking out top, hole 2 is first hole to the clockwise direction. Default suits baby beast motors
motorMountHole2Centers = 16;

//Mounting screw diameter
motorMountHoleDiameter=3;

//This will be the diameter of the mount
motorDiameter=27.8;

//clearance required for motor shaft at base
shaftClearanceDiameter = 8;

//Frame/arm 

//Angle of arm in deg.
armAngle = 110;

//Motor mount will be minimum height required to get 
//desired angle with minimum thickness as previously
//set in variable.
heightOfCylinder=tan(motorTilt)*motorDiameter+2*minThickness;
echo(heightOfCylinder);


//Hidden from thingiverse customizer
/*[Hidden]*/

//How high mounting orientation tab will be
tabThickness = 1.5;

$fn=100;
tolerance=.1;

//create cylinder of Motor diameter and height determined by
//tilt angle and motor diameter and minimum thickness
module Mount()
{

difference()
{

//create cylinder 
union()
{
cylinder(heightOfCylinder,motorDiameter/2,motorDiameter/2,true);
//back locating tab
translate([0,motorDiameter/2,-heightOfCylinder/2+minThickness/2])
cylinder(minThickness,tabThickness,tabThickness,true);

//front locating tab
translate([0,-motorDiameter/2,-heightOfCylinder/2+minThickness/2])
cylinder(minThickness,tabThickness,tabThickness,true);

}
//translate([0,0,-heightOfCylinder/2-tolerance])

//subtract cylinder for shaft/circlip clearance at base of motor.
cylinder(heightOfCylinder+tolerance,shaftClearanceDiameter/2,shaftClearanceDiameter/2,true);
}

}



module MountHoles()
{
//MountHole
module MountHole()
{
cylinder(heightOfCylinder+tolerance,motorMountHoleDiameter/2,motorMountHoleDiameter/2,true);
}


{
translate([-motorMountHole1Centers/2,0,0])
MountHole();

translate([motorMountHole1Centers/2,0,0])
MountHole();

translate([0,-motorMountHole2Centers/2,0])
MountHole();

translate([0,motorMountHole2Centers/2,0])
MountHole();
}
}//end MountHoles()


//Rotate requred angle and slice at required tilt angle
//Mirror object of left (or right amrs).
module Motor1and3()
{
//Top half with shaft clearance cutout
difference()
{
difference()
{
Mount();
rotate([0,0,45-(armAngle-90)])
MountHoles();
}
//create a cube,tilt it,position it to slice at angle.
translate([-(motorDiameter+tolerance)/2,-motorDiameter/2,-heightOfCylinder/2+minThickness])
rotate([motorTilt,0,0])
cube([motorDiameter+tolerance,motorDiameter*2,heightOfCylinder],false);
}

}


module Motor2and4()
{
difference()
{

difference()
{

Mount();
rotate([0,0,45+(armAngle-90)])
MountHoles();
}


translate([-(motorDiameter+tolerance)/2,-motorDiameter/2,-heightOfCylinder/2+minThickness])
rotate([motorTilt,0,0])
cube([motorDiameter+tolerance,motorDiameter*2,heightOfCylinder],false);
}
}



//dinner time
//red=pair 1
//green=pair 2
//print 2x these plates for a quad.

translate([motorDiameter/2+2,0,0])
color([1,0,0])
//RED motor 2 top
Motor1and3();

mirror([1,0,0]){
translate([motorDiameter/2+2,0,0])
color([0,1,0])
//GREEN Motor 2 bottom
Motor1and3();
}

translate([motorDiameter/2+2,motorDiameter+tabThickness*2+2,0])
color([0,0,1])
//BLUE motor 3 top
Motor2and4();

mirror([1,0,0]){
translate([motorDiameter/2+2,motorDiameter+tabThickness*2+2,0])
color([1,1,0])
//YELLOW motor 3 bottom
Motor2and4();
}


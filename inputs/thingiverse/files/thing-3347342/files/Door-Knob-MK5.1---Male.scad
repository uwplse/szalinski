//Variables
//Width of the door knob at it's widest point
DoorKnobDiameter = 51;
//Additional width for door knob to allow easy rotation
DoorKnobAllowance = 1;
//How thick do you want the cover to be?
CoverThickness = 3.5;
//Ignore this variable
OuterDiameter = DoorKnobDiameter + (CoverThickness*2) + DoorKnobAllowance;
//Ignore this variable
InnerDiameter = DoorKnobDiameter + DoorKnobAllowance;
//Ignore this variable
InnerRadius = (InnerDiameter/2);
//Ignore this variable
Resolution = 100;
//Ignore this variable
OuterRadius = (OuterDiameter/2);
//Depth to be cut in to sphere to make room for gripping the door knob
FingerGripSize = 5;
//Distance from the thickest part of the knob to the front
DistanceToFront = 1000;
//Distance from the thickest part of the knob to the back
DistanceToBack = 20;
//Total length of the snap fit arms
ArmLength = 4;
//Width of the base of the snap fit arms
ArmWidth = 1;

//Build
//MainBody
difference(){
//OuterShell - Bottom
    translate([OuterDiameter/2,0,0])
    sphere(d=OuterDiameter,$fn=Resolution);
//Remove top half of female sphere
    translate([OuterDiameter/2,0,0])
    linear_extrude(OuterDiameter/2 + 1)
    square([OuterDiameter,OuterDiameter], center = true);
//Remove space for door knob - Bottom
    translate([OuterDiameter/2,0,0])
    sphere(d=DoorKnobDiameter + DoorKnobAllowance,$fn=Resolution);
//Remove bottom section of sphere for Finger Grip
    translate([OuterRadius,0,-OuterRadius-1])
    linear_extrude(FingerGripSize+1)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
//Remove front of the sphere for lock
    translate([OuterRadius,-DistanceToFront,-OuterRadius])
    rotate(a=[90,0,0])
    linear_extrude(OuterRadius)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
//Remove rear of the sphere for handle's arm
    translate([OuterRadius,DistanceToBack,-OuterRadius])
    rotate(a=[-90,0,0])
    linear_extrude(OuterRadius)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
}

//Arms
difference(){
    //Arm and fittings
    union(){
//Create arms
        //Added .5 to keep objects manifold
    translate([OuterRadius,0,-.5])
    rotate(a=[0,0,0])
    cylinder(h = ArmLength + .5, r1 = InnerRadius + ArmWidth, r2 = InnerRadius + ArmWidth, $fn=Resolution, center = false);
        //Creating Retraction Side of Snap Joint
     translate([OuterRadius,0,ArmLength*.4])
    rotate(a=[0,0,0])
    cylinder(h = ArmLength * .1, r1 = InnerRadius + ArmWidth, r2 = InnerRadius + ArmWidth + 1, $fn=Resolution, center = false);
          //Creating Entrance Side of Snap Joint
     translate([OuterRadius,0,ArmLength * .8])
    rotate(a=[0,0,0])
    cylinder(h = ArmLength * .2, r1 = InnerRadius + ArmWidth + 1, r2 = InnerRadius + ArmWidth, $fn=Resolution, center = false);
           //Creating Perpendicular Face
     translate([OuterRadius,0,ArmLength * .5])
    rotate(a=[0,0,0])
    cylinder(h = ArmLength * .3, r1 = InnerRadius + ArmWidth + 1, r2 = InnerRadius + ArmWidth + 1, $fn=Resolution, center = false);
    }
//Remove sections of the snapjoint from sphere
    //Remove front of the sphere for lock and make room for snap fitting guide on other sphere
    translate([OuterRadius,-20+5,0])
    rotate(a=[90,0,0])
    linear_extrude(OuterRadius)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
    //Remove rear of the sphere for handle's arm and make room for snap fitting guide on other sphere
    translate([OuterRadius,20-5,0])
    rotate(a=[-90,0,0])
    linear_extrude(OuterRadius)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
    //Remove space for door knob - Bottom
    translate([OuterDiameter/2,0,0])
    sphere(d=DoorKnobDiameter + DoorKnobAllowance,$fn=Resolution);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,20*.5,0])
    rotate(a=[-90,0,0])
    linear_extrude(1)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,20*.25,0])
    rotate(a=[-90,0,0])
    linear_extrude(1)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,0,0])
    rotate(a=[-90,0,0])
    linear_extrude(.5)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,-20*.5,0])
    rotate(a=[90,0,0])
    linear_extrude(1)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,-20*.25,0])
    rotate(a=[90,0,0])
    linear_extrude(1)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,0,0])
    rotate(a=[90,0,0])
    linear_extrude(.5)
    square([OuterDiameter,OuterDiameter], center = true);
    
}

  


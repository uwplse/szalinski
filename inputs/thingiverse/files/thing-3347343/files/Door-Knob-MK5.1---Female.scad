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
DistanceToFront = 70;
//Distance from the thickest part of the knob to the back
DistanceToBack = 20;
//Total length of the snap fit arms
ArmLength = 4;
//Width of the base of the snap fit arms
ArmWidth = 1;
//Added width to face of joint
SnapJointAllowance = .4;
//Added space for snap joint dividers
SnapJointWidthAllowance = .1;
//Added Vertical spacing in female snapjoint
SnapJointHeightAllowance = .1;


//Build
//MainBody
difference(){
//OuterShell
    translate([OuterDiameter/2,0,0])
    sphere(d=OuterDiameter,$fn=Resolution);
//Remove bottom half of female sphere
    rotate(a=[180,0,0])
    translate([OuterDiameter/2,0,0])
    linear_extrude(OuterDiameter/2 + 1)
    square([OuterDiameter,OuterDiameter], center = true);
//Remove space for door knob
    translate([OuterDiameter/2,0,0])
    sphere(d=DoorKnobDiameter + DoorKnobAllowance,$fn=Resolution);
//Remove bottom section of sphere for Finger Grip
    translate([OuterRadius,0,OuterRadius-FingerGripSize])
    linear_extrude(FingerGripSize+1)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
//Remove front of the sphere for lock
    translate([OuterRadius,-DistanceToFront,OuterRadius])
    rotate(a=[90,0,0])
    linear_extrude(OuterRadius)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
//Remove rear of the sphere for handle's arm
    translate([OuterRadius,DistanceToBack,OuterRadius])
    rotate(a=[-90,0,0])
    linear_extrude(OuterRadius)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
//Create slot for snap arms
        //Added .5 to keep objects manifold
    translate([OuterRadius,0,-.5])
    rotate(a=[0,0,0])
    cylinder(h = ArmLength + .5, r1 = InnerRadius + ArmWidth + SnapJointAllowance, r2 = InnerRadius + ArmWidth + SnapJointAllowance, $fn=Resolution, center = false);
        //Creating Retraction Side of Snap Joint
     translate([OuterRadius,0,ArmLength*.2 + .1])
    rotate(a=[0,0,0])
    cylinder(h = ArmLength * .1, r1 = InnerRadius + ArmWidth + SnapJointAllowance, r2 = InnerRadius + ArmWidth + SnapJointAllowance + 1, $fn=Resolution, center = false);
          //Creating Entrance Side of Snap Joint
     translate([OuterRadius,0,ArmLength])
    rotate(a=[0,0,0])
    cylinder(h = (ArmLength * .1) + 1, r1 = InnerRadius + ArmWidth + SnapJointAllowance + 1, r2 = InnerRadius + ArmWidth + SnapJointAllowance, $fn=Resolution, center = false);
           //Creating Perpendicular Face
     translate([OuterRadius,0,ArmLength * .3])
    rotate(a=[0,0,0])
    cylinder(h = ArmLength * .7, r1 = InnerRadius + ArmWidth + SnapJointAllowance + 1, r2 = InnerRadius + ArmWidth + SnapJointAllowance + 1, $fn=Resolution, center = false);
}

//Create slots for each snap arm
//SnapJoint Dividers
 difference(){
 intersection(){
union(){
 difference(){
//OuterShell
    translate([OuterDiameter/2,0,0])
    sphere(d=OuterDiameter,$fn=Resolution);
//Remove space for door knob
    translate([OuterDiameter/2,0,0])
    sphere(d=DoorKnobDiameter + DoorKnobAllowance,$fn=Resolution);
 }
 }
 union(){
 //Back end-cap
 translate([OuterRadius,-DistanceToBack+2.5-(SnapJointWidthAllowance/4),0])
 rotate(a=[0,0,0])
    linear_extrude(ArmLength + 2.1)
    square([OuterDiameter,5-(SnapJointWidthAllowance/2)], center = true);
 //Front end-cap
  translate([OuterRadius,20-2.5+(SnapJointWidthAllowance/4),0])
 rotate(a=[0,0,0])
    linear_extrude(ArmLength + 2.1)
    square([OuterDiameter,5-(SnapJointWidthAllowance/2)], center = true);
//Seperate Snap Joint in to multiple sections
    translate([OuterRadius,DistanceToBack*.5 + (SnapJointWidthAllowance/2),0])
    rotate(a=[-90,0,0])
    linear_extrude(1 - SnapJointWidthAllowance)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,DistanceToBack*.25 + (SnapJointWidthAllowance/2),0])
    rotate(a=[-90,0,0])
    linear_extrude(1 - SnapJointWidthAllowance)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,0,0])
    rotate(a=[-90,0,0])
    linear_extrude(.5 - (SnapJointWidthAllowance/2))
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,-20*.5 - (SnapJointWidthAllowance/2),0])
    rotate(a=[90,0,0])
    linear_extrude(1 - SnapJointWidthAllowance)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,-20*.25 - (SnapJointWidthAllowance/2),0])
    rotate(a=[90,0,0])
    linear_extrude(1 - SnapJointWidthAllowance)
    square([OuterDiameter,OuterDiameter], center = true);
    //Seperate Snap Joint in to multiple sections
    translate([OuterRadius,0,0])
    rotate(a=[90,0,0])
    linear_extrude(.5 - (SnapJointWidthAllowance/2))
    square([OuterDiameter,OuterDiameter], center = true);
 }
}
//Remove bottom half of female sphere
    rotate(a=[180,0,0])
    translate([OuterDiameter/2,0,0])
    linear_extrude(OuterDiameter/2 + 1)
    square([OuterDiameter,OuterDiameter], center = true);
//Remove bottom section of sphere for Finger Grip
    translate([OuterRadius,0,OuterRadius-FingerGripSize])
    linear_extrude(FingerGripSize+1)
    square([OuterDiameter+2,OuterDiameter+2], center = true);
}


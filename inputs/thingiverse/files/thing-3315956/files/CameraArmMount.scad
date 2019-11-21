//Variables to define
//How much wiggle room does the screw need? (0-1mm)
ScrewAllowance = .1;
//How much wiggle room does the nut need? (0-1mm)
NutAllowance = .15;
//Added depth to the female parts of the arm (0-1mm)
FemaleSlotDepthAllowance = .5;
//Increases the width of the slot to more easily allow adjoining arm to slide in. This is doubled, once on each side. (0-1mm)
FemaleSlotWidthAllowance = .05;
ScrewSize = 3; //[3:M3,4:M4,5:M5,6:M6]
NutSize = 6; //[6:M3,7.66:M4,8.79:M5,11.05:M6]
//Width of just the screw's head
ScrewHeadWidth = 5.6;
//Length of the screw's head from end to beginning of threads
ScrewHeadDepth = 5;
MountOrientation = 2; //[1:Vertical,2:Horizontal]

if(MountOrientation==1){
difference() {
union() {
//TopBracket
    translate([0,0,23])
    rotate(a=[-90,0,0])
    linear_extrude(height = 23)
    square([15,3]);
//SideBracket
    translate([0,20,0])
    rotate(a=[0,0,0])
    linear_extrude(height = 20)
    square([15,3]);
//Left Arm
    translate([0,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,10])
    rotate(a=[0,90,0])
    linear_extrude(height = 5 - FemaleSlotWidthAllowance)
    circle(d=15,$fn=360, center = true);
//Right Arm
    translate([10 + FemaleSlotWidthAllowance,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,10])
    rotate(a=[0,90,0])
    linear_extrude(height = 5 -FemaleSlotWidthAllowance)
    circle(d=15,$fn=360, center = true);
//Left Arm Support
    translate([0,23,11.5])
    rotate(a=[90,45,90])
    linear_extrude(height = 15)
    square(([16.265,16.265]), center = true);
//SideBracket (solid)
    translate([0,15.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,2.5])
    rotate(a=[0,0,0])
    linear_extrude(height = 15)
    square([15,10 + ScrewHeadDepth + FemaleSlotDepthAllowance]);  
}
//Female Slot (remove)
    translate([5 - FemaleSlotWidthAllowance,22.5 + ScrewHeadDepth,0])
    rotate(a=[0,0,0])
    linear_extrude(height = 20)
    square([5 + (FemaleSlotWidthAllowance*2),15 + FemaleSlotDepthAllowance]);
//RemoveRail
    translate([-.5,0,0])
    rotate(a=[0,0,0])
    linear_extrude(height = 20)
    square([21,20]);
//Reduce angle at top
    translate([-.5,30,17.5])
    rotate(a=[90,0,0])
    linear_extrude(height = 5)
    square([21,20]);
//Screw Hole (Top - Left)
 translate([4,10,19])
 rotate(a=[0,0,0])
 linear_extrude(height = 5)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Hole (Top - Right)
 translate([11,10,19])
 rotate(a=[0,0,0])
 linear_extrude(height = 5)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Hole (Side - Center)
 translate([7.5,19,10])
 rotate(a=[-90,0,0])
 linear_extrude(height = 20)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Head Slot (Rotate)
 translate([7.5,42.5 + ScrewHeadDepth +FemaleSlotDepthAllowance,10])
 rotate(a=[90,0,0])
 linear_extrude(height = 20 + ScrewHeadDepth + FemaleSlotDepthAllowance)
 circle(d=ScrewHeadWidth + ScrewAllowance,$fn=360, center = true);  
 //Angle for printing
    translate([-1,-3,22])
    rotate(a=[-45,0,0])
    linear_extrude(height = 3)
    square([50,50]);
//Screw Hole (Arm)
 translate([-1,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,10])
 rotate(a=[0,90,0])
 linear_extrude(height = 20)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
//Nut Capture (Right)
 translate([-1,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,10])
 rotate(a=[0,90,0])
 linear_extrude(height = 3.5)
 circle(d=NutSize + NutAllowance,$fn=6, center = true);
}
}

if(MountOrientation==2){
difference() {
union() {
//TopBracket
    translate([0,0,23])
    rotate(a=[-90,0,0])
    linear_extrude(height = 23)
    square([15,3]);
//SideBracket
    translate([0,20,0])
    rotate(a=[0,0,0])
    linear_extrude(height = 20)
    square([15,3]);
//Top Arm
    translate([7.5,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,12.5 + FemaleSlotWidthAllowance])
    rotate(a=[0,0,0])
    linear_extrude(height = 5 - FemaleSlotWidthAllowance)
    circle(d=15,$fn=360);
//Bottom Arm
    translate([7.5,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,2.5])
    rotate(a=[0,0,0])
    linear_extrude(height = 5 - FemaleSlotWidthAllowance)
    circle(d=15,$fn=360, center = true);
//Left Arm Support
    translate([0,23,11.5])
    rotate(a=[90,45,90])
    linear_extrude(height = 15)
    square(([16.265,16.265]), center = true);
//SideBracket (solid)
    translate([0,23,2.5])
    rotate(a=[0,0,0])
    linear_extrude(height = 15)
    square([15,7.5 + ScrewHeadDepth + FemaleSlotDepthAllowance]);  
}
//Female Slot (remove)
    translate([-1,23 + ScrewHeadDepth,12.5 + FemaleSlotWidthAllowance])
    rotate(a=[0,90,0])
    linear_extrude(height = 17)
    square([5 + (FemaleSlotWidthAllowance*2),15 + FemaleSlotDepthAllowance]);
//RemoveRail
    translate([-.5,0,0])
    rotate(a=[0,0,0])
    linear_extrude(height = 20)
    square([21,20]);
//Screw Hole (Top - Left)
 translate([4,10,19])
 rotate(a=[0,0,0])
 linear_extrude(height = 5)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Hole (Top - Right)
 translate([11,10,19])
 rotate(a=[0,0,0])
 linear_extrude(height = 5)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Hole (Side - Center)
 translate([7.5,19,10])
 rotate(a=[-90,0,0])
 linear_extrude(height = 20)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Head Slot (Rotate)
 translate([7.5,42.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,10])
 rotate(a=[90,0,0])
linear_extrude(height = 20 + ScrewHeadDepth + FemaleSlotDepthAllowance)
 circle(d=ScrewHeadWidth + ScrewAllowance,$fn=360, center = true);  
//Screw Hole (Arm)
 translate([7.5,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,0])
 rotate(a=[0,0,0])
 linear_extrude(height = 20)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
//Nut Capture (Right)
translate([7.5,30.5 + ScrewHeadDepth + FemaleSlotDepthAllowance,2])
 rotate(a=[0,0,0])
 linear_extrude(height = 3)
 circle(d=NutSize + NutAllowance,$fn=6, center = true);
}
}
//Variables to define
//How long should the arm be? (31mm+)
ArmLength = 75;
//How much wiggle room does the screw need? (0-1mm)
ScrewAllowance = .1;
//Added depth to space on each side of male arm (0-1mm)
FemaleSlotDepthAllowance = .5;
//Reduces size of male arm to more easily slide in to adjoining arm. This is doubled (once on each side)
MaleWidthAllowance = .05;
//Ignore these variables
MainBodyLength = ArmLength - 15; //From center of screwhole on each end

ScrewSize = 3; //[3:M3,4:M4,5:M5,6:M6]

//Build
//arm one
 difference() {
 translate([5 + (MaleWidthAllowance/2),7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - MaleWidthAllowance)
 circle(d=15,$fn=360, center = true);
//Screw Hole
 translate([5 + (MaleWidthAllowance/2),7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - MaleWidthAllowance)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
 }

//arm two
 //LEFT
  difference() {
 translate([5 + (MaleWidthAllowance/2),MainBodyLength + 7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - MaleWidthAllowance)
 circle(d=15,$fn=360, center = true);
 //Screw Hole (Left)
 translate([5 + (MaleWidthAllowance/2),MainBodyLength + 7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - MaleWidthAllowance)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
  }
 
  //Main Body
 difference() {
//Shaft
    translate([0,7.5,15])
    rotate(a=[-90,0,0])
    linear_extrude(height = MainBodyLength)
    square([15,15]);
//Slot for Female arms (arm 1)
    translate([-1,15 + FemaleSlotDepthAllowance,16])
    rotate(a=[-90,0,-90])
    linear_extrude(height = 6 + (MaleWidthAllowance/2))
    square([15,17]);
    translate([10 - (MaleWidthAllowance/2),15 + FemaleSlotDepthAllowance,16])
    rotate(a=[-90,0,-90])
    linear_extrude(height = 6 + (FemaleSlotWidthAllowance * 2))
    square([15,17]); 
//Slot for Male arm 2
    translate([-1,MainBodyLength + 15 - FemaleSlotDepthAllowance,16])
    rotate(a=[-90,0,-90])
    linear_extrude(height = 6 + (MaleWidthAllowance/2))
    square([15,17]);
    translate([10 - (MaleWidthAllowance/2),MainBodyLength + 15 - FemaleSlotDepthAllowance,16])
    rotate(a=[-90,0,-90])
    linear_extrude(height = 6 + (FemaleSlotWidthAllowance * 2))
    square([15,17]); 
//Screw hole (arm 1)
    translate([5 + (MaleWidthAllowance/2),7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 5 - MaleWidthAllowance)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw hole for arm 1 (Right)
    translate([5 + (MaleWidthAllowance/2),MainBodyLength + 7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 5 - MaleWidthAllowance)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
  } 
//Variables to define
//How long should the arm be? (31mm+)
ArmLength = 31;
//Ignore these variables
MainBodyLength = ArmLength - 7.5; //From center of screwhole on each end
//How much wiggle room does the screw need? (0-1mm)
ScrewAllowance = .1;
//How much wiggle room does the nut need? (0-1mm)
NutAllowance = .5;
//Added depth to space on each side of male arm (0-1mm)
FemaleSlotDepthAllowance = .5;
//Reduces size of male arm to more easily slide in to adjoining arm. This is doubled, once on each side. (0-1mm)
MaleWidthAllowance = .05;

NutThickness = 2.4;//[2.4:M3,3.2:M4,4.7:M5,5.2:M6]
//Space behind the nut to give room for extra length of the screw. End of arm to the nut is ~3-4mm depending on nut thickness. Can increase this 1:1 with extra length added to the arm.
PegSlotDepth = 15;
ScrewSize = 3; //[3:M3,4:M4,5:M5,6:M6]
//Measured from flat sides of the nut
NutSize = 5.5; //[5.5:M3,7:M4,8:M5,10:M6]


//Build
//arm one
 difference() {
 translate([5 + (MaleWidthAllowance/2),7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - MaleWidthAllowance)
 circle(d=15,$fn=360, center = true);
//Screw Hole
 translate([4,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 7)
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
    linear_extrude(height = 6)
    square([15,17]); 
//Screw hole (arm 1)
    translate([4,7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 7)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Slot
    translate([7.5,ArmLength - PegSlotDepth + 1,7.5])
    rotate(a=[0,90,90])
    linear_extrude(height = PegSlotDepth + 1)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Nut Slot
    translate([16,ArmLength - 6 ,7.5])
    rotate(a=[-90,0,90])
    linear_extrude(height = 17)
    square([NutThickness + NutAllowance,NutSize + NutAllowance], center = true);
  }  
  
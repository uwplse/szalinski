//Variables to define
//How long should the arm be? (Minimum length is 15 + FemaleSlotDepthAllowance + ScrewHeadDepth) (~29 with default settings)
ArmLength = 29;
//Ignorew this variable
MainBodyLength = ArmLength - 7.5; //From center of screwhole on each end
//How much wiggle room does the screw need? (0-1mm)
ScrewAllowance = .1;
//How much wiggle room does the nut need? (0-1mm)
NutAllowance = .25;
//Added depth to space on each side of male arm (0-1mm)
FemaleSlotDepthAllowance = .5;
//Increases spacing of female arms to allow male arm to more easily slide in. This is doubled, once on each side. (0-1mm)
FemaleSlotWidthAllowance = .05;
//Length of the screw's head from end to beginning of threads
ScrewHeadDepth = 5.6;
ScrewSize = 3; //[3:M3,4:M4,5:M5,6:M6]
NutSize = 6; //[6:M3,7.66:M4,8.79:M5,11.05:M6]

//Build
//arm one
 //LEFT
 difference() {
 translate([0,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - FemaleSlotWidthAllowance)
 circle(d=15,$fn=360, center = true);
//Screw Hole (Left)
 translate([-1,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 7)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw Head Slot (Rotate)
 translate([7.5,15 + FemaleSlotDepthAllowance,7.5])
 rotate(a=[90,0,0])
 linear_extrude(height = 15 + FemaleSlotDepthAllowance)
 circle(d=ScrewHeadDepth + ScrewAllowance,$fn=360, center = true);     
 }
  //RIGHT
 difference() {
 translate([10 + FemaleSlotWidthAllowance,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - FemaleSlotWidthAllowance)
 circle(d=15,$fn=360, center = true); 
//Screw Hole (Right)
 translate([9,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 7)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
//Nut Capture (Right)
 translate([12.5,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 3.5)
 circle(d=NutSize + NutAllowance,$fn=6, center = true);
//Screw Head Slot (Rotate)
 translate([7.5,15 + FemaleSlotDepthAllowance,7.5])
 rotate(a=[90,0,0])
 linear_extrude(height = 15 + FemaleSlotDepthAllowance)
 circle(d=ScrewHeadDepth + ScrewAllowance,$fn=360, center = true);  
 }

 
  //Main Body
 difference() {
//Shaft
    translate([0,7.5,15])
    rotate(a=[-90,0,0])
    linear_extrude(height = MainBodyLength)
    square([15,15]);
//Slot for Male arm 1
    translate([5 - FemaleSlotWidthAllowance,15 + FemaleSlotDepthAllowance,16])
    rotate(a=[-90,0,-90])
    linear_extrude(height = 5 + (FemaleSlotWidthAllowance * 2))
    square([15,17]);
//Screw hole for arm 1 (LEFT)
    translate([-1,7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 7)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw hole for arm 1 (Right)
    translate([9,7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 7)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
//Nut Capture for arm 1 (Right)
    translate([12.5,7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 3.5)
    circle(d=NutSize + NutAllowance,$fn=6, center = true);
 //Screw Slot (Rotate)
 translate([7.5,ArmLength + 1,7.5])
 rotate(a=[90,0,0])
 linear_extrude(height = ArmLength + 1)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
 //Screw Head Slot (Rotate)
 translate([7.5,ArmLength - 5,7.5])
 rotate(a=[90,0,0])
 linear_extrude(height = ArmLength)
 circle(d=ScrewHeadDepth + ScrewAllowance,$fn=360, center = true);  
  } 
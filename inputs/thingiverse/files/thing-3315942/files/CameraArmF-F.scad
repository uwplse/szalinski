//Variables to define
//How long should the arm be? (31mm+)
ArmLength = 75;
//Ignore these variables
MainBodyLength = ArmLength - 15; //From center of screwhole on each end
//How much wiggle room does the screw need? (0-1mm)
ScrewAllowance = .1;
//How much wiggle room does the nut need? (0-1mm)
NutAllowance = .25;
//Added depth between the two male arms (0-1mm)
FemaleSlotDepthAllowance = .5;
//Increases the width of the slot to more easily allow adjoining arm to slide in. This is doubled, once on each side. (0-1mm)
FemaleSlotWidthAllowance = .05;
//M3 (screw=3,Nut=6)
//M4 (screw=4,Nut=7.66)
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
 linear_extrude(height = 6 - FemaleSlotWidthAllowance)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
 }
  //RIGHT
 difference() {
 translate([10 + FemaleSlotWidthAllowance,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - FemaleSlotWidthAllowance)
 circle(d=15,$fn=360, center = true); 
//Screw Hole (Right)
 translate([10,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 6)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
//Nut Capture (Right)
 translate([12.5,7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 3.5)
 circle(d=NutSize + NutAllowance,$fn=6, center = true);
 }


//arm two
 //LEFT
  difference() {
 translate([0,MainBodyLength + 7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - FemaleSlotWidthAllowance)
 circle(d=15,$fn=360, center = true);
 //Screw Hole (Left)
 translate([-1,MainBodyLength + 7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 6)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
  }
 //RIGHT
  difference() {
 translate([10 + FemaleSlotWidthAllowance,MainBodyLength + 7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 5 - FemaleSlotWidthAllowance)
 circle(d=15,$fn=360, center = true);
 //Screw Hole (Right)
 translate([9,MainBodyLength + 7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 7)
 circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
 //Nut Capture (Right)
 translate([12.5,MainBodyLength + 7.5,7.5])
 rotate(a=[0,90,0])
 linear_extrude(height = 3.5)
 circle(d=NutSize + NutAllowance,$fn=6, center = true);
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
//Slot for Male arm 2
    translate([5 - FemaleSlotWidthAllowance,MainBodyLength - FemaleSlotDepthAllowance,16])
    rotate(a=[0,90,0])
    linear_extrude(height = 5 + (FemaleSlotWidthAllowance * 2))
    square([17,15]);    
//Screw hole for arm 1 (LEFT)
    translate([-1,7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 6)
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
//Screw hole for arm 2 (LEFT)
    translate([-1,MainBodyLength + 7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 7)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true); 
//Screw hole for arm 2 (Right)
    translate([9,MainBodyLength + 7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 7)
    circle(d=ScrewSize + ScrewAllowance,$fn=360, center = true);
//Nut Capture (Right)
    translate([12.5,MainBodyLength + 7.5,7.5])
    rotate(a=[0,90,0])
    linear_extrude(height = 3.5)
    circle(d=NutSize + NutAllowance,$fn=6, center = true);
  } 
//Variables to define
//How much wiggle room does the ARM screw need? (0-1mm)
ScrewAllowance = .1;
//Added depth to space on each side of male arm (0-1mm)
FemaleSlotDepthAllowance = .5;
//Reduces size of male arm to more easily slide in to adjoining arm. This is doubled, once on each side. (0-1mm)
MaleWidthAllowance = .05;
//Arm Screw Size
ScrewSize = 3; //[3:M3,4:M4,5:M5,6:M6]
//Size/type of Camera Screw?
CameraScrewSize = 6.35; //[6.35:1/4"-20,7.94:3/8"-16]
//How much wiggle room does the CAMERA screw need? (0-1mm)
CameraScrewAllowance = .1;

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
 union(){
//Shaft
    translate([0,7.5,15])
    rotate(a=[-90,0,0])
    linear_extrude(height = 10.5 + FemaleSlotDepthAllowance)
    square([15,15]);
//Platform
    translate([0,15 + FemaleSlotDepthAllowance,30])
    rotate(a=[-90,0,0])
    linear_extrude(height = 3)
    square([15,15]);
 }    
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
//CameraScrewHole
    translate([7.5,14,22.5])
    rotate(a=[-90,0,0])
    linear_extrude(height = 7)
    circle(d=CameraScrewSize + CameraScrewAllowance,$fn=360, center = true); 
  } 
// Diameter of the cord to be wrangled, set to zero to remove the cord wrangler entirely (mm)
CordDiameter=2.75;
// Adjust the cut angle of the cord gripping portion, 30 degrees seems to be good but go nuts if you like
CordGripAngle=40; //[0:90]
// How far along on the gripper should the cord wrangler be placed?
CordGripLoc=80; //[0:100]
// Maybe you're using this as something other than just a cord gripper (as I sometimes do)
CordGripStyle=1; //[0:Closed,1:Open]

//How long should the fabric (or other substance) gripper be? (mm)
GripperLength=20;
//And how tall? (mm)
GripperHeight=10;
//And how far apart (mm)
GripperGap=2.5;

//Interior gripping knobbles, how many?
Knobbles = 2;
//Opposing knobbles on the top?
CounterKnobbles=true;//[true:Yes,false:No]

//And how thick would you like the walls of the gripper to be? (mm)
WallThickness=3;

/* [Hidden] */
CordGripLocation=CordGripLoc/100.0;
$fs=.5;

difference(){
 union(){
  translate([GripperLength,0,0])
   difference(){
    cylinder(r=GripperGap/2+WallThickness, h=GripperHeight);
    translate([-GripperGap-2*WallThickness,-GripperGap/2-WallThickness*1.5,-0.5]) cube([GripperGap+2*WallThickness,GripperGap+3*WallThickness, GripperHeight+1]);
    translate([0,0,-0.5]) cylinder(r=GripperGap/2, h=GripperHeight+1);
   }

  translate([0,GripperGap/2,0]) cube([GripperLength,WallThickness,GripperHeight]);
  translate([0,-GripperGap/2-WallThickness,0]) cube([GripperLength,WallThickness,GripperHeight]);

  translate([0,GripperGap/2+WallThickness/2,0]) cylinder(r=WallThickness/2, h=GripperHeight);
  translate([0,-GripperGap/2-WallThickness/2,0]) cylinder(r=WallThickness/2, h=GripperHeight);

  for ( i = [0:Knobbles-1] ){
   translate([(i+0.5)*GripperLength/Knobbles,-GripperGap/2,0]) cylinder(r=WallThickness/2, h=GripperHeight);
  }
  if (CounterKnobbles) 
   for ( i = [1:Knobbles-1] ){
    translate([(i)*GripperLength/Knobbles,GripperGap/2,0]) cylinder(r=WallThickness/2, h=GripperHeight);
   }

  if (CordDiameter > 0) {
   translate([GripperLength*CordGripLocation,GripperGap/2+(WallThickness+CordDiameter)/2+WallThickness/2,0]) {
   difference(){
    cylinder(r=CordDiameter/2+WallThickness, h=GripperHeight);
    translate([0,0,-0.5]) cylinder(r=CordDiameter/2, h=GripperHeight+1);
    if (CordGripStyle == 1){
     rotate([0,0,-1*abs(CordGripAngle)]) translate([0,0,-0.5]) cube([CordDiameter*2,CordDiameter*2,GripperHeight+1]);
     rotate([0,0,-90]) translate([0,0,-0.5]) cube([CordDiameter*2,CordDiameter*2,GripperHeight+1]);
    }
   }
   if (CordGripStyle == 1) rotate([0,0,-1*abs(CordGripAngle)]) translate([0,(WallThickness+CordDiameter)/2,0]) cylinder(r=WallThickness/2, h=GripperHeight);
  }
 }
}
//Put a bevel on the bottom edge of the cord grip because I don't like the "bottom layer squish" cutting into my cables.
if (CordDiameter > 0){
  translate([GripperLength*CordGripLocation,GripperGap/2+(WallThickness+CordDiameter)/2+WallThickness/2,0]) {
  translate([0,0,-CordDiameter*0.4]) cylinder(r1=CordDiameter,r2=0,h=CordDiameter);
 }
}
}

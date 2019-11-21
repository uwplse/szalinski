// The_Real_Ento
LoopLowerRadius=3.5;
LoopUpperRadius=5;
LoopRadius=10;
LoopThickness=5.5;
ArmThickness=5.5;
ArmWidth=15;
ArmOverhang=50;
LipWidth=3.5;
LipAmount=5;
LipHeight=ArmThickness+LipAmount;
ArmLength=ArmOverhang+LipWidth;
FilamentGap=1.7;

$fn=50;
//Long Arm
cube([ArmWidth,ArmOverhang+LipWidth,ArmThickness], false);
//Back lip
cube([ArmWidth,LipWidth,ArmThickness+LipAmount], false); 
//Mid Arm
//20.4 is the internal allowance for 2020 extrusion
translate([0,20.4+LipWidth,0])
cube([ArmWidth,LipWidth,ArmThickness+20.4+LipWidth], false);
//Mid lip
//20.4 is the internal allowance for 2020 extrusion
translate([0,20.4+LipWidth-LipAmount,20.4+ArmThickness])
cube([ArmWidth,LipAmount,LipWidth], false);



$fa=1;
$fs=0.2;
$fn=150;
//Create gap for filament
difference() {
  translate([ArmWidth/2,ArmLength+LoopRadius-1,0])
  rotate_extrude(convexity = 10) translate([LoopRadius, 0, ArmLength+LoopRadius])
       hull() {
        circle(d = LoopUpperRadius);
        translate([0,LoopThickness])
         circle(d = LoopLowerRadius);
       }
  //Remove section for filament entry
 translate([ArmWidth/2,ArmLength+1.5*LoopRadius,-5])
  cube([LoopRadius+2,FilamentGap,LoopThickness+10], false);
}

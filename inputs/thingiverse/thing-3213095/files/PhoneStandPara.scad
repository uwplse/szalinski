mainLongArm= 126;
mainLowerLeg= 35;
mainCentreBar= 25;

ArmWidth = 16;
StandWidth= 66; 

supportLongArm= 90;
supportCentreBar= ArmWidth;
supportForPhone= 25;

Z= 4.5;

//Advanced
play = .2; // slack allowance to push fit the 2 pats
$fn=10; // Puts a flat on the bottom of main stand, use higher numbers for a smoother radius

difference(){
  union(){
     hull(){
       cylinder(d=ArmWidth, Z);
       translate([0, mainLongArm-ArmWidth, 0]) cylinder(d=ArmWidth, Z);
    }
    translate([StandWidth-ArmWidth, 0, 0]) hull(){
       cylinder(d=ArmWidth, Z);
       translate([0, mainLongArm-ArmWidth, 0]) cylinder(d=ArmWidth, Z);
    }
    translate([ArmWidth/2, mainLowerLeg, 0]) cube([StandWidth-ArmWidth-ArmWidth, mainCentreBar, Z]); 
  }
  translate([-ArmWidth/2, mainLowerLeg+(mainCentreBar-Z-play)/2, -.01]) cube([ArmWidth+.01, Z+play, Z+.02]);
  translate([StandWidth-ArmWidth-ArmWidth/2, mainLowerLeg+(mainCentreBar-Z-play)/2, -.01]) cube([ArmWidth+.01, Z+play, Z+.02]);
}

translate([StandWidth-ArmWidth+3/2*ArmWidth, 0, 0])
  union(){
     hull(){
       cylinder(d=ArmWidth, Z);
       translate([0, supportLongArm-ArmWidth, 0]) cylinder(d=ArmWidth, Z);
    }
    translate([StandWidth-ArmWidth, 0, 0]) hull(){
       cylinder(d=ArmWidth, Z);
       translate([0, supportLongArm-ArmWidth, 0]) cylinder(d=ArmWidth, Z);
    }
    translate([ArmWidth/2, supportCentreBar, 0]) cube([StandWidth-ArmWidth-ArmWidth, supportCentreBar, Z]); 
  }

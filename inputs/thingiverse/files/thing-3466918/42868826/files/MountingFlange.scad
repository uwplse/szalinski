/* [Resolution] */
$fn = 80;

/* [Hole Pattern] */
//Flange hole pattern: (0)=circular, (1)=rectangular
Mode=1; //[0,1]  
//(0) Number of holes for circular pattern
Holes=4;
//(0) Angle between each hole in degrees
AngleIncrement=90;
//(0) Diameter for circular pattern
PatternD=84; 
//(1) Width for rectangular pattern
PatternW=60;  
//(1) Height for rectangular pattern
PatternH=60;  

/* [Part Size] */
//Tool diameter
ToolD=52.6; 
//Part height
PartH=60; 
//Outer diameter of the bottom disk
FlangeD=100;
//Wall thickness
WallT=10;  
//Slice thickness
SliceT=5;  

/* [Screw dimensions] */
//Screw diameter
ScrewD=5;
//Diameter of the screws head
ScrewHeadD=9; 
//Height of the screws head; 0 disables countersinking
ScrewHeadH=5.5; 
//Number of clamping holes
ClampingHoles=3;
//Additional distance for the clamping coles
AddClampingHoleDist=7.5;  

if(PatternD<(ToolD+WallT*2+ScrewHeadD)){
    PatternD=ToolD+WallT*2+ScrewHeadD;
}

module Hole(){  //Circular pattern module
  translate([0,0,-5])
    cylinder(PartH*3,d=ScrewD,d=ScrewD,center=true);
  translate([0,0,WallT-ScrewHeadH])
    cylinder(ScrewHeadH+PartH,d=ScrewHeadD,d=ScrewHeadD);
}

difference(){
    
  union(){
    cylinder(PartH,d=ToolD+2*WallT,d=ToolD+2*WallT);
    cylinder(WallT,d=FlangeD,d=FlangeD);
    translate([-(2*WallT+SliceT)/2,-FlangeD/2,0])
      cube([2*WallT+SliceT,FlangeD/2,PartH], center=false);
  }
 
  if(Mode<1){  //Circular pattern 
    for(Angle = [0:AngleIncrement:AngleIncrement*Holes-AngleIncrement]){ 
      rotate(a=[0,0,Angle])
        translate([sin(45)*PatternD/2,-sin(45)*PatternD/2,0])
          Hole();
    }
  }
   
  if(Mode>=1){  //Rectangular pattern
    translate([PatternW/2,-PatternH/2,0])
      Hole();
    translate([PatternW/2,PatternH/2,0])
      Hole();
    translate([-PatternW/2,-PatternH/2,0])
      Hole();
    translate([-PatternW/2,PatternH/2,0])
      Hole();
    }
  
  translate([0,0,-5])
    cylinder(PartH+5*2,d=ToolD,d=ToolD); 
  translate([-(SliceT)/2,-FlangeD/2-1,-1])
    cube([SliceT,FlangeD/2+2,PartH+2], center=false);
  
  for(NumHoles=[1:ClampingHoles]){ 
    translate([-((WallT+SliceT)/2)-ScrewHeadH,-ToolD/2-WallT-ScrewHeadD/2,WallT+ScrewHeadD/2+(NumHoles-1)*(ScrewHeadD+AddClampingHoleDist)+4])  
    rotate([0,-90,0])
      Hole();
  }
}

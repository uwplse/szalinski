$fn=120;
Part_Type = "Cylinders"; //[Cylinders,Base]
//Diameter of the smallest cylinder
Start_D = 10; 
//Incrementing size of cylinders
Step = 10;
//Diameter the largest cylinder
End_D = 50;
Cylinder_Height = 10.0;
Cylinder_Wall_Thickness = 2.0;
Base_Height = 4.0;
Base_Slot_Depth = 2.0;
Base_Slot_Gap = 0.8;

if (Part_Type == "Cylinders"){
  Cylinders(Start_D,Step,End_D,0);
}else if (Part_Type == "Base"){
  difference(){
    Base();
    translate([0,0,Base_Height-Base_Slot_Depth]){
      Cylinders(Start_D+Base_Slot_Gap/2, Step, End_D+Base_Slot_Gap/2, Base_Slot_Gap);
    }
  }
}

module Cylinders(Start,Step,End,gap){
  linear_extrude(Cylinder_Height){
    for (i = [Start:Step:End]){
      difference(){
        circle(d=i);
        circle(d=i-Cylinder_Wall_Thickness-gap);
      }
      x = i;
    }
  }
}

module Base(){
  linear_extrude(Base_Height){
    circle(d=End_D+10);
  }
}


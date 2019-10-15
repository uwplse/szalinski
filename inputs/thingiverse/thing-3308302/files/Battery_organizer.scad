$fn=36;
SlotsH=5;// Array X
SlotsV=1; //Array Y
Slot_height=15;
Battery_diameter=10.5;  //AA=14.5    AAA=10.5    18650=18.5


module Slot()
  {
  difference()
    {
      hull()
        {
          cube([Battery_diameter+3,Battery_diameter+3,1],center=true);
          translate([(Battery_diameter+3)/2-0.5,(Battery_diameter+3)/2-0.5,Slot_height])
            sphere(1);
          translate([-(Battery_diameter+3)/2+0.5,(Battery_diameter+3)/2-0.5,Slot_height])
            sphere(1);
          translate([(Battery_diameter+3)/2-0.5,-(Battery_diameter+3)/2+0.5,Slot_height])
            sphere(1);
          translate([-(Battery_diameter+3)/2+0.5,-(Battery_diameter+3)/2+0.5,Slot_height])
            sphere(1);
        }
      translate([0,0,Slot_height/2+2])
      cylinder(d=Battery_diameter+1,h=Slot_height+2,center=true);
    }
    
  }


difference()
  {
  union()
    {
    for(a=[0:1:SlotsH-1])
      {
      for(b=[0:1:SlotsV-1])
      translate([a*(Battery_diameter+2.5),b*(Battery_diameter+2.5),0])
        Slot();
      }  
    }

    
*translate([0,-250,0])
  cube([500,500,500],center=true);

  }
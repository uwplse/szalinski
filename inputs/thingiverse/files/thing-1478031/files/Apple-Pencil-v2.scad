// Customizer Foot Designer
// Copyright (c) 2016 www.DIY3DTech.com
//

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

// Diameter of Apple Pencil(mm) Adjust for Plastic
Pencil_Dia = 8.9; //[7.9:0.1:9.9]

// Diameter of Barrel(mm)
Barrel_Dia = 15; //[12:1:20]

// Length of Barrel(mm)
Barrel_Length = 20; //[10:1:40]

// Number of Barrel sides (4-square to 100-round)
Barrel_Sides = 100; //[4:1:100]

// Clip thickness (mm)
Clip_Thickness = 5; //[3:1:8]

// Clip length (mm)
Clip_Length = 40; //[20:1:80]

// 3=Triangle 100=Round
Clip_Shape = 60; //[3:1:100]

// Slot width(mm)
Slot_Width = 2; //[1:1:10]

/*---------------------Execute---------------------*/

 Clip();


/*---------------------Modules---------------------*/
module Clip(){
  difference() { 
        Body();
    // Create pencil opening
      translate([0,0,-1]){cylinder((Clip_Length+Barrel_Dia+5),(Pencil_Dia/2),(Pencil_Dia/2),$fn=60,false);
        }
    // Create Clip w/Cube
        color("red");
        translate([0,Clip_Thickness,((Clip_Length+Barrel_Length)/2)+Barrel_Length-2]){rotate ([0,0,-270])cube([Barrel_Dia+Clip_Thickness,Barrel_Dia,Clip_Length+Barrel_Length], true);
        }
    // Create Slot w/Cube
        translate([-Slot_Width/2,0,-1]){cube([Slot_Width,Barrel_Dia,Barrel_Length]);
        }
    }
}


module Body(){
    union() {
    // Create base barrel for clip
        cylinder(Barrel_Length+Clip_Length,(Barrel_Dia/2),(Barrel_Dia/2),$fn=Barrel_Sides,false);
    // Create Triangular Support   
        translate([0,(-Barrel_Dia/2)+0.5,0]) rotate ([0,0,90]){cylinder(Barrel_Length+Clip_Length+(Barrel_Dia/2),Barrel_Dia/2,Barrel_Dia/2,$fn=Clip_Shape,fase);
        }
   }
   }
   
   
   
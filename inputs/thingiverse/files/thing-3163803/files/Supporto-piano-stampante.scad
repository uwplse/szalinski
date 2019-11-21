//I've been thinking for a while how I can fit a larger borosilicate glass to my 200x200mm heatbed. I mostly print PLA so it is not critical if some parts of the print are not heated. I modified my printer to have a larger print area but I still cannot print things larger than my standard Geeetech glass.
//So, I decided it is time to upgrade the print bed and this is what I came up with...
//First problem are the screws heads that adjust the levelling of the bed...I decided to countersink the PCB of the bed so they are flush with everything else.
//The second and most important, was how to fix the glass (the original one is held in place by 4 paper clips as many others), with the possibility of easily remove it.
//As the glass is flat, without holes or screws that can catch on and it greatly exceed the PCB size, I first didn't know how to aspproach that but I got this idea and here it is...
//As PLA do not require high bed temperature this should not cause issues, but the pushing bit that touch the PCB could be made of high temperature filament, aluminum, wood, fiberglass or other materials, it is a simple part that would not take too long to be shaped even by hand from a square piece of metal.
//Silicone sealant should be more than enough for glueing the part to the glass, plus it is easily removable, but if you prefer you can use epoxy or any other glue you consider more appropriate (Please share the info if you know of specialty glues that may be more appropriate).
//The bonding part shuld be thinner or the same thickness of the PCB
//I added an example of how can be made the extra piece in a different material (Part_3)


$fn=36;
//The part that is going to be glued to the glass
Bonding_area_X_size=10;
Bonding_area_Y_size=30;
//Thinner than PCB thickness
Bonding_area_thickness=1.5;
//The part that will overlap the PCB to hold it
Locking_area=20;

Screw_holder_radius=6;
Screw_hole_radius=1.35;

//Thickness of the PCB heatbed
PCB_thickness=2;
//To make the sliding work, you may need to adjust this for your printer tolerances
Tolerance=0.2;

//Render or not    0=no   1=yes
//Bonding partt
Part_1=1;
//Slider
Part_2=1;
//Extra bit in different material
Part_3=0;

//If you want to make the part that touch the PCB in different material put this to 1
End_part_fixing_points=0;
Extra_bit_screw_hole_radius=1.35;


if(Part_1==1)
difference()
   {
   union()
      {
      translate([-Bonding_area_X_size/2,-Bonding_area_Y_size/2,0])
         rotate([0,0,0])
            cube([Bonding_area_X_size,Bonding_area_Y_size,Bonding_area_thickness]);

      translate([-Bonding_area_X_size/2,0,Screw_holder_radius])
         rotate([0,90,0])
            cylinder(r=Screw_holder_radius,h=Bonding_area_X_size,$fn=4);
      }
      translate([-Bonding_area_X_size/2-1,0,Screw_holder_radius])
         rotate([0,90,0])
            cylinder(r=Screw_hole_radius,h=Bonding_area_X_size+2);
   }

if(Part_2==1)
rotate([0,0,0])
difference()
   {
   union()
      {
      translate([-Bonding_area_X_size/2-Locking_area,-Bonding_area_Y_size/2,0])
         rotate([0,0,0])
            cube([Bonding_area_X_size+Locking_area+3,Bonding_area_Y_size,Screw_holder_radius*2+4]);
      }

      translate([-Bonding_area_X_size/2-Tolerance/2-Locking_area,-Bonding_area_Y_size/2-Tolerance/2,-Tolerance])
         rotate([0,0,0])
            cube([Bonding_area_X_size+Tolerance+Locking_area,Bonding_area_Y_size+Tolerance,Bonding_area_thickness+Tolerance*2]);

      translate([-Bonding_area_X_size/2-Locking_area-1.9,0,Screw_holder_radius])
         rotate([0,90,0])
            cylinder(r=Screw_holder_radius+Tolerance,h=Bonding_area_X_size+2+Locking_area,$fn=4);


      translate([-Bonding_area_X_size/2-1,0,Screw_holder_radius])
         rotate([0,90,0])
            cylinder(r=Screw_hole_radius+0.5,h=Bonding_area_X_size*2);

      translate([-55-Bonding_area_X_size/2-4,-25,0])
         rotate([0,0,0])
            cube([50,50,PCB_thickness]);

      translate([-Bonding_area_X_size/2-Locking_area-1,0,0])
         rotate([90,0,0])
            cylinder(r=5,h=Bonding_area_Y_size*3,$fn=4,center=true);


      if(Part_3==1)
         {
         translate([-50-Bonding_area_X_size,-25,-10])
            cube([50,50,50]);
         translate([-Bonding_area_X_size-1,Bonding_area_Y_size/3,Screw_holder_radius+Bonding_area_thickness])
            rotate([0,90,0])
               cylinder(r=Extra_bit_screw_hole_radius,h=Bonding_area_X_size*3);
         translate([-Bonding_area_X_size-1,-Bonding_area_Y_size/3,Screw_holder_radius+Bonding_area_thickness])
            rotate([0,90,0])
               cylinder(r=Extra_bit_screw_hole_radius,h=Bonding_area_X_size*3);

         }
   }


//Extra part made of heat resistant material
//This is just an example that can be made easily from other material
if(Part_3==1)
difference()
   {
   union()
      {
      translate([-25,-15,PCB_thickness])
         cube([15,9,14]);
      translate([-25,-7,12])
         cube([15,15,4]);
      translate([-25,6,PCB_thickness])
         cube([15,9,14]);

      translate([-25,-15,Bonding_area_thickness+Tolerance])
         cube([15,9,14]);
      translate([-25,6,Bonding_area_thickness+Tolerance])
         cube([15,9,14]);
      }

      translate([-Bonding_area_X_size-Locking_area,Bonding_area_Y_size/3,Screw_holder_radius+Bonding_area_thickness])
         rotate([0,90,0])
            cylinder(r=Extra_bit_screw_hole_radius+0.5,h=Bonding_area_X_size*5);

      translate([-Bonding_area_X_size-16,-Bonding_area_Y_size/3,Screw_holder_radius+Bonding_area_thickness])
         rotate([0,90,0])
            cylinder(r=Extra_bit_screw_hole_radius+0.5,h=Bonding_area_X_size*5);

      translate([-55-Bonding_area_X_size/2-4,-25,0])
         rotate([0,0,0])
            cube([50,50,PCB_thickness]);

      translate([-Bonding_area_X_size/2-Locking_area-1,0,0])
         rotate([90,0,0])
            cylinder(r=5,h=Bonding_area_Y_size*3,$fn=4,center=true);

      translate([-Bonding_area_X_size/2-Locking_area-1.9,0,Screw_holder_radius])
         rotate([0,90,0])
            cylinder(r=Screw_holder_radius+Tolerance,h=Bonding_area_X_size+2+Locking_area,$fn=4);
   }

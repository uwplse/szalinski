$fn=36;
Pins_pitch=2.54;
Board_thickness=2;
Pins_enabled=1;
Pins_up=0;            

use<PCB.scad>

module Board(Board_size_X,Board_size_Y,Board_size_Z)
{
translate([0,0,0])
cube([Board_size_X,Board_size_Y,Board_size_Z],center=true);
}

module Pins(Pins_number,Pins_pitch)
   {
   translate([0,0,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([0,Pins_pitch*a,-3])
               cube([0.5,0.5,10],center=true);
        color("Silver")
        hull()
          {
           color("Silver")
              translate([0,Pins_pitch*a,-Board_thickness/2-0.3])
                 cylinder(r1=0,r2=0.75,h=0.5,center=true);
           color("Silver")
              translate([0,Pins_pitch*a,Board_thickness/2+0.3])
                 cylinder(r1=0.75,r2=0,h=0.5,center=true);
          }
         }
   }

module Pins_holes(Pins_number,Pins_pitch,Diameter)
   {
   translate([0,0,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,Pins_pitch*a,0])
            cylinder(r=Diameter,h=Board_thickness*2,center=true);
         }
   }

module Pins_copper_rings(Pins_number,Pins_pitch,Diameter)
   {
   translate([0,0,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,Pins_pitch*a,0])
            cylinder(r=Diameter,h=Board_thickness+0.1,center=true);
         }
   }

module Component(X,Y,Z)
   {
   hull()
      {
      translate([X/2,Y/2,0])
         sphere(r=0.25,$fn=18);
      translate([-X/2,Y/2,0])
         sphere(r=0.25,$fn=18);
      translate([X/2,-Y/2,0])
         sphere(r=0.25,$fn=18);
      translate([-X/2,-Y/2,0])
         sphere(r=0.25,$fn=18);

      translate([X/2,Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      translate([-X/2,Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      translate([X/2,-Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      translate([-X/2,-Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      }
   }

//--------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

module HTU21D(Pins_enabled,Pins_up)
translate([1.27,1.27,2])
  {

  X1=2.54*1.5;
  Y1=-2.54*2.5;


  difference()
     {
     union()
        {  
        color("OrangeRed")
        translate([0,0,0])
          Board(15,15,Board_thickness);

        translate([X1,Y1,0])
          rotate([0,0,90])
            Pins_copper_rings(4,Pins_pitch,1);

    color("Black")
      translate([0,3,0.5])
        rotate([0,0,0])
          Component(3,3,1.5);
        }

    color("Silver")
      translate([0,2.5,2])
        rotate([0,0,0])
          Component(0.5,0.5,1);

     translate([X1,Y1,0])
        rotate([0,0,90])
           Pins_holes(4,Pins_pitch,0.55);

    color("Silver")
     translate([5.1,4.5,0])
        rotate([0,0,90])
           Pins_holes(2,Pins_pitch*4,2);
      
      color("Black")
        translate([-5,-1.5,0.99])
          rotate([0,0,0])
            linear_extrude(1)
              text("HTU21D",size=2);
     }

    if(Pins_enabled==1 && Pins_up==0)
    {
    translate([X1,Y1,0])
      rotate([0,0,90])
        Pins(4,Pins_pitch);
    }
    if(Pins_enabled==1 && Pins_up==1)
    {
    translate([X1-2.54*3,Y1,0])
      rotate([180,0,90])
        Pins(4,Pins_pitch);
    }
}

HTU21D(Pins_enabled,Pins_up);
PCB(35,35,1,2.54,1);
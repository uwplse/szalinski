$fn=36;
Pitch=2.54;
Pins_enabled=0;
Pins_up=0;

module Pins(Pins_number,Pitch)
   {
   translate([0,-Pitch*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([0,Pitch*a,-3])
               cube([0.6,0.6,10],center=true);
         color("Silver")
            translate([0,Pitch*a,-1.5])
               cylinder(r1=0,r2=1,h=1);
         color("Silver")
            translate([0,Pitch*a,0.5])
               cylinder(r1=1,r2=0,h=1);
         color("Black")
            translate([0,Pitch*a,-2])
               Component(2,2,1.25);
         }
   }

module Pins_holes(Pins_number,Pitch,Diameter)
   {
   translate([0,-Pitch*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,Pitch*a,-3])
            cylinder(r=Diameter,h=10,center=true);
         }
   }

module Pins_copper_rings(Pins_number,Pitch,Diameter)
   {
   translate([0,-Pitch*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,Pitch*a,-3])
            cylinder(r=Diameter,h=1.6,center=true);
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

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

module OLED_13_128_64_I2C(Pins_enabled,Pins_up)
  {
  translate([0,-1.252,0])
  difference()
     {
     union()
        {  
        color("Royalblue")
        translate([1.252,0.5,0])
        cube([34,35,1.5]);

        translate([Pitch,Pitch*7.5,-2.25])
           rotate([0,180,0])
              Pins_copper_rings(4,Pitch,0.75);

          color("silver")
      translate([4,3,-0.05])
        rotate([0,0,0])
          cylinder(d=3.5,h=1.6);
      color("silver")
        translate([4,33,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
      color("silver")
        translate([32,3,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
      color("silver")
        translate([32,33,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);

    color("Black")
      translate([18,18,2.5])
        rotate([0,180,90])
          Component(35,22,1);
        }

     translate([Pitch,Pitch*7.5,0.5])
        rotate([0,180,0])
           Pins_holes(4,Pitch,0.55);

    color("white")
     translate([18,8,2])
        rotate([0,0,90])
           linear_extrude(1)
              text("OLED 1.3",size=3);
    color("white")
    translate([23,11,2])
        rotate([0,0,90])
           linear_extrude(1)
              text("128x64",size=3);

    color("silver")
      translate([4,3,-1])
        rotate([0,0,0])
          cylinder(d=2.75,h=10);
      color("silver")
        translate([4,33,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
      color("silver")
        translate([32,3,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
      color("silver")
        translate([32,33,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
     }

  if(Pins_enabled==1 && Pins_up==0)
    translate([Pitch,Pitch*7,1])
      rotate([0,0,0])
        Pins(4,Pitch);
  if(Pins_enabled==1 && Pins_up==1)
    translate([Pitch,Pitch*7,0.8])
      rotate([0,180,0])
        Pins(4,Pitch);

}


OLED_13_128_64_I2C(Pins_enabled,Pins_up);
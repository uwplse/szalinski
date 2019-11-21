
$fn=36;
//0=false 1=true
Connection_pins_enabled=1;
Connection_pins_up=0;
I2C_pins_enabled=1;
I2C_pins_up=3;
Led_pins_enabled=1;
Led_pins_up=0;

module Pins_holes(Pins_number)
   {
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,2.54*a,0])
            cylinder(r=0.55,h=10,center=true);
         }
   }

module Pins_copper_rings(Pins_number)
   {
   
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,2.54*a,0])
            cylinder(r=1,h=1.05,center=true);
         }
   }

module Pins(Pins_number,Pitch,Solder)
   {
   translate([0,-(Pitch*round(Pins_number/2))+Pitch,0])
      for(a=[0:1:Pins_number-1])
         {
          translate([0,0,-10/6])
         {
         color("Goldenrod")
            translate([0,Pitch*a,-2])
               cube([0.6,0.6,10],center=true);
        color("Goldenrod")
            translate([0,Pitch*a,-7.6])
              rotate([0,0,45])
               cylinder(r1=0,r2=0.425,h=0.6,$fn=4);
        color("Goldenrod")
            translate([0,Pitch*a,3])
              rotate([0,0,45])
               cylinder(r2=0,r1=0.425,h=0.6,$fn=4);
        }
         color("Black")
            translate([0,Pitch*a,-2])
               Component(2,2,1.25);
        if(a<Pins_number-1)
         color("Black")
            translate([0,Pitch*a+Pitch/2,-2])
               Component(1.6,1,1.25);

        if(Solder==1)
          translate([0,Pitch*a-Pitch,0])
            rotate([0,0,90])
              {
              color("Silver")
                  translate([Pitch,0,0])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }
         }
   }


module Pins_90(Pins_number,Pitch,Solder)
   {
   translate([0,-(Pitch*round(Pins_number/2))+Pitch,0])
      for(a=[0:1:Pins_number-1])
         {
          translate([0,0,-10/6])
         {
         color("Goldenrod")
            translate([0,Pitch*a,1])
               cube([0.6,0.6,10-6],center=true);
        color("Goldenrod")
            translate([4.7,Pitch*a,-1.25])
               rotate([0,90,0])
               cube([0.6,0.6,10],center=true);
        color("Goldenrod")
            translate([10.3,Pitch*a,-1.25])
              rotate([0,-90,0])
              rotate([0,0,45])
               cylinder(r1=0,r2=0.425,h=0.6,$fn=4);
        color("Goldenrod")
            translate([0,Pitch*a,10/2-2])
              rotate([0,0,45])
               cylinder(r2=0,r1=0.425,h=0.6,$fn=4);
        }
         color("Black")
            translate([0,Pitch*a,-2])
               Component(2,2,1.25);
        if(a<Pins_number-1)
         color("Black")
            translate([0,Pitch*a+Pitch/2,-2])
               Component(1.6,1,1.25);

        if(Solder==1)
          translate([0,Pitch*a-Pitch,0])
            rotate([0,0,90])
              {
              color("Silver")
                  translate([Pitch,0,0])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }
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


//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------

module I2C_interface_LCD1602(Connection_pins_enabled,Connection_pins_up,I2C_pins_enabled,I2C_pins_up,Led_pins_enabled,Led_pins_up)
translate([0,1.27,0])
   {
   translate([0,1.257,4])
      union()
         {
         difference()
            {
            union()
               {
               color("MidnightBlue")
                  translate([0,-1.252,0])
                     cube([19,41.5,1],center=true);

              translate([2.54*3,-2.54*8,0])
               rotate([0,180,0])
                  Pins_copper_rings(16);

              translate([2.54*1,-2.54*8,0])
               rotate([0,180,90])
                  Pins_copper_rings(4);

              translate([2.54*0,2.54*7,0])
               rotate([0,180,90])
                  Pins_copper_rings(2);
               }



            translate([2.54*3,-2.54*8,0])
               rotate([0,180,0])
                  Pins_holes(16);

              translate([2.54*1,-2.54*8,0])
               rotate([0,180,90])
                  Pins_holes(4);

              translate([2.54*0,2.54*7,0])
               rotate([0,180,90])
                  Pins_holes(2);

            }



         color("Black")
            translate([0,0,0])
               rotate([0,0,90])
                  Component(8,10.5,1.5);
         color("Silver")
            translate([0,0,0])
               rotate([0,0,90])
                  Component(10,9,1);

difference()
  {
    union()
      {
         color("RoyalBlue")
            translate([1,-11,0])
               rotate([0,0,90])
                  Component(7,7,5);
         color("Grey")
            translate([1,-11,2])
               rotate([0,0,90])
                  cylinder(r=2,h=3);
      }
        color("DimGrey")
            translate([1,-11,5])
               rotate([0,0,90])
                  cube([0.75,4,2],center=true);
        color("DimGrey")
            translate([1,-11,5])
               rotate([0,0,0])
                  cube([0.75,4,2],center=true);
      
   }         
            if(Connection_pins_enabled==1 && Connection_pins_up==0)
              translate([2.54*3,-2.54*1,0])
               rotate([0,0,0])
                  Pins(16,2.54,1);
            if(Connection_pins_enabled==1 && Connection_pins_up==1)
              translate([2.54*3,-2.54*1,0])
               rotate([0,180,0])
                  Pins(16,2.54,1);
            if(Connection_pins_enabled==1 && Connection_pins_up==3)
              translate([2.54*3,0,0])
               rotate([0,180,180])
                  Pins_90(16,2.54,1);
            if(Connection_pins_enabled==1 && Connection_pins_up==2)
              translate([2.54*3,-2.54*1,0])
               rotate([0,0,0])
                  Pins_90(16,2.54,1);
            if(I2C_pins_enabled==1 && I2C_pins_up==1)
              translate([0,-2.54*8,0])
               rotate([0,180,90])
                  Pins(4,2.54,1);
            if(I2C_pins_enabled==1 && I2C_pins_up==0)
              translate([0,-2.54*8,0])
               rotate([0,0,90])
                  Pins(4,2.54,1);
            if(I2C_pins_enabled==1 && I2C_pins_up==2)
              translate([-2.54,-2.54*8,0])
               rotate([0,0,-90])
                  Pins_90(4,2.54,1);
            if(I2C_pins_enabled==1 && I2C_pins_up==3)
              translate([0,-2.54*8,0])
               rotate([0,180,90])
                  Pins_90(4,2.54,1);
            if(Led_pins_enabled==1 && Led_pins_up==1)
              translate([2.54*0,2.54*7,0])
               rotate([0,180,90])
                  Pins(2,2.54,1);
            if(Led_pins_enabled==1 && Led_pins_up==0)
              translate([2.54*0,2.54*7,0])
               rotate([0,0,90])
                  Pins(2,2.54,1);
            if(Led_pins_enabled==1 && Led_pins_up==2)
              translate([2.54*0,2.54*7,0])
               rotate([0,0,90])
                  Pins_90(2,2.54,1);
            if(Led_pins_enabled==1 && Led_pins_up==3)
              translate([-2.54,2.54*7,0])
               rotate([0,180,-90])
                  Pins_90(2,2.54,1);
         }
   }


I2C_interface_LCD1602(Connection_pins_enabled,Connection_pins_up,I2C_pins_enabled,I2C_pins_up,Led_pins_enabled,Led_pins_up);
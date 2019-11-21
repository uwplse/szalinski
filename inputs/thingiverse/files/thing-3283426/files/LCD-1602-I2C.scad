use<I2C_interface_LCD1602.scad>;
use<Solder.scad>;

$fn=36;
Pitch=2.54;
PinsDown=1;
Text1="ABCDEFG";
Text2="HIJKLMNOPQ";



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

module LCD_1602_I2C(PinsDown,Text1,Text2)
translate([-2.54*16,-2.54*7-1.27,0])
  {
  translate([0,-1.252,0])
  difference()
     {
     union()
        {
        color("Royalblue")
        translate([0,1.5,0])
        cube([81,36,1.5]);

        translate([Pitch*11,Pitch*14,-2.25])
           rotate([0,180,90])
              Pins_copper_rings(16,Pitch,1);

          color("silver")
      translate([2.5,4,-0.05])
        rotate([0,0,0])
          cylinder(d=3.5,h=1.6);
      color("silver")
        translate([2.5,35,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
      color("silver")
        translate([78.5,4,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
      color("silver")
        translate([78.5,35,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);

    color("Black")
      translate([40.5,19.5,9.5])
        rotate([0,180,0])
          Component(71.5,27,8);
        }

     translate([Pitch*11,Pitch*14,0.5])
        rotate([0,180,90])
           Pins_holes(16,Pitch,0.55);

    color("OliveDrab")
      translate([40.5,19.5,12.5])
        rotate([0,180,0])
          Component(64,16,3);

    color("Black")
     translate([10,20.5,9.5])
        rotate([0,0,0])
           linear_extrude(1)
              text(Text1,size=4.25);
    color("Black")
    translate([10,14.5,9.5])
        rotate([0,0,0])
           linear_extrude(1)
              text(Text2,size=4.25);

    color("silver")
      translate([2.5,4,-1])
        rotate([0,0,0])
          cylinder(d=2.75,h=10);
      color("silver")
        translate([2.5,35,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
      color("silver")
        translate([78.5,4,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
      color("silver")
        translate([78.5,35,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
     }


  
  difference()
    {
//I2C_interface_LCD1602(Connection_pins_enabled,Connection_pins_up,I2C_pin_enabled,I2C_pins_up,Led_pins_enabled,Led_pins_up);
    translate([2.54*11,2.54*10+1.27,0])
      rotate([0,180,-90])
        I2C_interface_LCD1602(1,0,1,PinsDown,1,PinsDown,1,3);
    translate([0,0,52.5])
      cube([100,100,100],center=true);
  }

  translate([2.54*4,2.54*13.5,0.75])
    scale([1,1,1.2])
      Solder(16,1);



}


LCD_1602_I2C(PinsDown,Text1,Text2);

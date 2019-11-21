//I have two version of this display, one from an original Arduino kit and one from Aliexpress, and the display case (the black part) differ in size so I placed an option to select wich one to visualize. The original one size 26.5x71.5x8.5mm while non original one size 24x71x7mm.The board and pin positions are identical.


$fn=36;
Pitch=2.54;
Pins_enabled=0;
Pins_up=0;
Version=0;    //0=Original display from Arduino kit, LCM1602C  1=Generic eBay or Aliexpress
Text1="ABCDEFGHIJKLMNOP";
Text2="QRSTUVWXYZ123456";


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

module LCD_1602_Serial(Pins_enabled,Pins_up,Version,Text1,Text2)
translate([-Pitch*15-Pitch/2,-Pitch*7-Pitch/2,2.5])
  {
  translate([0,-1.252,0])
  difference()
     {
     union()
        {
        color("Royalblue")
        translate([0,1.5,0])
        cube([80,36,1.5]);

        translate([Pitch*10.5,Pitch*14,-2.25])
           rotate([0,180,90])
              Pins_copper_rings(16,Pitch,0.75);

          color("silver")
      translate([2.5,4,-0.05])
        rotate([0,0,0])
          cylinder(d=3.5,h=1.6);
      color("silver")
        translate([2.5,35,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
      color("silver")
        translate([77.5,4,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
      color("silver")
        translate([77.5,35,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);

    if(Version==0)
      color("Black")
        translate([40,19,9.5])
          rotate([0,180,0])
            Component(71.5,27,8);
    if(Version==1)
      color("Black")
        translate([40,19,8.5])
          rotate([0,180,0])
            Component(71,24,7);
        }

     translate([Pitch*10.5,Pitch*14,0.5])
        rotate([0,180,90])
           Pins_holes(16,Pitch,0.55);

    color("OliveDrab")
      translate([40,19,11.5])
        rotate([0,180,0])
          Component(64,16,3);

    color("Black")
     translate([10,20,8.45])
        rotate([0,0,0])
           linear_extrude(1)
              text(Text1,size=4.25);
    color("Black")
    translate([10,14,8.45])
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
        translate([77.5,4,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
      color("silver")
        translate([77.5,35,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
     }

  if(Pins_enabled==1 && Pins_up==0)
    translate([Pitch*10.5,Pitch*14-1.257,1])
      rotate([0,0,90])
        Pins(16,Pitch);
  if(Pins_enabled==1 && Pins_up==1)
    translate([Pitch*11,Pitch*14-1.257,0.8])
      rotate([0,180,90])
        Pins(16,Pitch);

}


LCD_1602_Serial(Pins_enabled,Pins_up,Version,Text1,Text2);
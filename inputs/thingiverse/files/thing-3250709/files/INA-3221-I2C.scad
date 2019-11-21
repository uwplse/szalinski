$fn=36;
Pitch=2.54;
Data_pins_enabled=1;
Data_pins_up=1;
Power_pins_enabled=0;
Power_pins_up=0;
Load_pins_enabled=0;
Load_pins_up=0;

module Pins(Pins_number,Pitch)
   {
   translate([0,-Pitch*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([0,Pitch*a,-3])
               cube([0.6,0.6,10],center=true);
         color("Silver")
            translate([0,Pitch*a,-2])
               cylinder(r1=0,r2=1,h=1);
         color("Silver")
            translate([0,Pitch*a,0.5])
               cylinder(r1=1,r2=0,h=1);
         color("Black")
            translate([0,Pitch*a,-2.25])
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

module INA_3221(Data_pins_enabled,Data_pins_up,Power_pins_enabled,Power_pins_up,Load_pins_enabled,Load_pins_up)
translate([-2.54*7,-2.54*7,0])
  {
  difference()
     {
     union()
        {  
        color("Royalblue")
        translate([2.54,0.5,0])
        cube([31,38,1.5]);

        translate([Pitch*2,Pitch*8,-2.25])
           rotate([0,180,0])
              Pins_copper_rings(8,Pitch,0.75);

        translate([Pitch*12,Pitch*4,-2.25])
           rotate([0,180,0])
              Pins_copper_rings(2,Pitch*2,1.5);
        translate([Pitch*12,Pitch*9,-2.25])
           rotate([0,180,0])
              Pins_copper_rings(2,Pitch*2,1.5);
           translate([Pitch*12,Pitch*14,-2.25])
           rotate([0,180,0])
              Pins_copper_rings(2,Pitch*2,1.5);

        translate([Pitch*4,Pitch*14,-2.25])
           rotate([0,180,90])
              Pins_copper_rings(3,Pitch*2,1.5);

          color("silver")
      translate([6,3,-0.05])
        rotate([0,0,0])
          cylinder(d=3.5,h=1.6);
      color("silver")
        translate([24.5,3,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
      color("silver")
        translate([24.5,36,-0.05])
          rotate([0,0,0])
            cylinder(d=3.5,h=1.6);
        }

     translate([Pitch*2,Pitch*8,0.5])
        rotate([0,180,0])
           Pins_holes(8,Pitch,0.55);

     translate([Pitch*12,Pitch*4,0.5])
        rotate([0,180,0])
           Pins_holes(2,Pitch*2,1);
     translate([Pitch*12,Pitch*9,0.5])
        rotate([0,180,0])
           Pins_holes(2,Pitch*2,1);
        translate([Pitch*12,Pitch*14,0.5])
        rotate([0,180,0])
           Pins_holes(2,Pitch*2,1);

     translate([Pitch*4,Pitch*14,0.5])
        rotate([0,180,90])
           Pins_holes(3,Pitch*2,1);

     translate([19,3,1.4])
        rotate([0,0,90])
           linear_extrude(1)
              text("INA 3221",size=5);

     translate([28.5,5,1])
        rotate([0,0,90])
           linear_extrude(1)
              text("CH3",size=2);
     translate([28.5,17.5,1])
        rotate([0,0,90])
           linear_extrude(1)
              text("CH2",size=2);
     translate([28.5,30,1])
        rotate([0,0,90])
           linear_extrude(1)
              text("CH1",size=2);

     translate([7,2.54*3.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("TC",size=1);
      translate([7,2.54*4.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("WAR",size=1);
      translate([7,2.54*5.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("CRI",size=1);
      translate([7,2.54*6.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("PV",size=1);
      translate([7,2.54*7.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("SDA",size=1);
      translate([7,2.54*8.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("SCL",size=1);
      translate([7,2.54*9.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("GND",size=1);
      translate([7,2.54*10.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("VS",size=1);

      translate([6,2.54*12.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("VPU",size=1);
      translate([6+2.54*2,2.54*12.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("POW",size=1);
      translate([6+2.54*4,2.54*12.85,1])
        rotate([0,0,0])
           linear_extrude(1)
              text("GND",size=1);


    color("silver")
      translate([6,3,-1])
        rotate([0,0,0])
          cylinder(d=2.75,h=10);
      color("silver")
        translate([24.5,3,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);
      color("silver")
        translate([24.5,36,-1])
          rotate([0,0,0])
            cylinder(d=2.75,h=10);

     }

  translate([0,0,0])
    {
    if(Data_pins_enabled==1 && Data_pins_up==0)
    translate([Pitch*2,Pitch*8,1])
      rotate([0,0,0])
        Pins(8,Pitch);
    if(Data_pins_enabled==1 && Data_pins_up==1)
    translate([Pitch*2,Pitch*8,0.5])
      rotate([0,180,0])
        Pins(8,Pitch);

if(Load_pins_enabled==1 && Load_pins_up==1)
  {
    translate([Pitch*12,Pitch*4,0.5])
      rotate([0,180,0])
        Pins(2,Pitch*2);
    translate([Pitch*12,Pitch*9,0.5])
      rotate([0,180,0])
        Pins(2,Pitch*2);
    translate([Pitch*12,Pitch*14,0.5])
      rotate([0,180,0])
        Pins(2,Pitch*2);
}
if(Load_pins_enabled==1 && Load_pins_up==0)
  {
    translate([Pitch*12,Pitch*4,1])
      rotate([0,0,0])
        Pins(2,Pitch*2);
    translate([Pitch*12,Pitch*9,1])
      rotate([0,0,0])
        Pins(2,Pitch*2);
    translate([Pitch*12,Pitch*14,1])
      rotate([0,0,0])
        Pins(2,Pitch*2);
}

    if(Power_pins_enabled==1 && Power_pins_up==1)
      {
    translate([Pitch*4,Pitch*14,0.5])
      rotate([0,180,90])
        Pins(3,Pitch*2);
    }

if(Power_pins_enabled==1 && Power_pins_up==0)
    {
    translate([Pitch*4,Pitch*14,1])
      rotate([0,0,90])
        Pins(3,Pitch*2);
  }

    color("Black")
      translate([24,9,2])
        rotate([0,180,90])
          Component(6,3,1);
    color("Black")
      translate([24,19,2])
        rotate([0,180,90])
          Component(6,3,1);
    color("Black")
      translate([24,29,2])
        rotate([0,180,90])
          Component(6,3,1);
  }
}


INA_3221(Data_pins_enabled,Data_pins_up,Power_pins_enabled,Power_pins_up,Load_pins_enabled,Load_pins_up);
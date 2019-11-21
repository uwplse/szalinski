use<Pin_header.scad>;
use<Screw_terminal.scad>;


$fn=36;
Pitch=2.54;
Data_pins_enabled=1;
Data_pins_up=0;
Load_pins_enabled=0;
Load_pins_up=2;


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

module Hole(Diameter,Height)
  {
  cylinder(d=Diameter,h=Height);
  }

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

module INA_219(Data_pins_enabled,Data_pins_up,Load_pins_enabled,Load_pins_up)
translate([-2.54*4+0.5,-2.54*4+0.4,3])
  {
  difference()
     {
     union()
        {  
        color("Royalblue")
        translate([0,0,0])
        cube([20,22,1.5]);

        translate([Pitch*1-0.5,Pitch*5-0.4,-2.25])
           rotate([0,180,0])
              Pins_copper_rings(6,Pitch,0.9);

        translate([Pitch*7-0.5,Pitch*4.5+1.27,-2.25])
           rotate([0,180,0])
              Pins_copper_rings(2,Pitch*1.5,1.5);


          color("silver")
      translate([2,2,-0.05])
        rotate([0,0,0])
          cylinder(d=2.75,h=1.6);
      color("silver")
        translate([18,2,-0.05])
          rotate([0,0,0])
            cylinder(d=2.75,h=1.6);
      color("silver")
        translate([18,20,-0.05])
          rotate([0,0,0])
            cylinder(d=2.75,h=1.6);
      color("silver")
        translate([2,20,-0.05])
          rotate([0,0,0])
            cylinder(d=2.75,h=1.6);
        }

     translate([Pitch*1-0.5,Pitch*5-0.4,0.5])
        rotate([0,180,0])
           Pins_holes(6,Pitch,0.55);

     translate([Pitch*7-0.5,Pitch*4.5+1.27,1])
        rotate([0,0,0])
           Pins_holes(2,Pitch*1.5,0.75);
     
     translate([9.25,4.5,1.4])
        rotate([0,0,90])
           linear_extrude(1)
              text("INA 219",size=2.5);

      translate([4,2.54*6.65,1.45])
        rotate([0,0,0])
           linear_extrude(1)
              text("Vin+",size=1);
      translate([4,2.54*5.65,1.45])
        rotate([0,0,0])
           linear_extrude(1)
              text("Vin-",size=1);
      translate([4,2.54*4.65,1.45])
        rotate([0,0,0])
           linear_extrude(1)
              text("SDA",size=1);
      translate([4,2.54*3.65,1.45])
        rotate([0,0,0])
           linear_extrude(1)
              text("SCL",size=1);
      translate([4,2.54*2.65,1.45])
        rotate([0,0,0])
           linear_extrude(1)
              text("Gnd",size=1);
      translate([4,2.54*1.65,1.45])
        rotate([0,0,0])
           linear_extrude(1)
              text("Vcc",size=1);

      translate([4,2.7*6.65,0.05])
        rotate([180,0,0])
           linear_extrude(1)
              text("Vin+",size=1);
      translate([4,2.7*5.65,0.05])
        rotate([180,0,0])
           linear_extrude(1)
              text("Vin-",size=1);
      translate([4,2.7*4.7,0.05])
        rotate([180,0,0])
           linear_extrude(1)
              text("SDA",size=1);
      translate([4,2.7*3.8,0.05])
        rotate([180,0,0])
           linear_extrude(1)
              text("SCL",size=1);
      translate([4,2.7*2.85,0.05])
        rotate([180,0,0])
           linear_extrude(1)
              text("Gnd",size=1);
      translate([4,2.7*1.9,0.05])
        rotate([180,0,0])
           linear_extrude(1)
              text("Vcc",size=1);

      translate([17,2.7*1.6,1.45])
        rotate([180,0,90])
           linear_extrude(1)
              text("Vin+",size=1);
      translate([17,2.7*5.4,1.45])
        rotate([180,0,90])
           linear_extrude(1)
              text("Vin-",size=1);
      translate([18,2.7*1.6,1.45])
        rotate([0,0,90])
           linear_extrude(1)
              text("Vin+",size=1);
      translate([18,2.7*5.4,1.45])
        rotate([0,0,90])
           linear_extrude(1)
              text("Vin-",size=1);

    color("silver")
      translate([2,2,-1])
        rotate([0,0,0])
          Hole(2.5,5);
      color("silver")
        translate([18,2,-1])
          rotate([0,0,0])
            Hole(2.5,5);
      color("silver")
        translate([18,20,-1])
          rotate([0,0,0])
            Hole(2.5,5);
      color("silver")
        translate([2,20,-1])
          rotate([0,0,0])
            Hole(2.5,5);

     }

  translate([0,0,0])
    {
    if(Data_pins_enabled==1 && Data_pins_up==0)
    translate([Pitch*1-0.5,Pitch*5-0.4,1.1])
      rotate([180,0,90])
        Pin_header(6,1,0,1);
    if(Data_pins_enabled==1 && Data_pins_up==1)
    translate([Pitch*1-0.5,Pitch*5-0.4,0.4])
      rotate([0,0,90])
        Pin_header(6,1,0,1);

if(Load_pins_enabled==1 && Load_pins_up==1)
  {
    translate([Pitch*7-0.5,Pitch*4.5-2.54,0.5])
      rotate([0,0,0])
        Pin_header(1,1,0,1);
    translate([Pitch*7-0.5,Pitch*4.5+1.27,0.5])
      rotate([0,0,0])
        Pin_header(1,1,0,1);
}
if(Load_pins_enabled==1 && Load_pins_up==0)
  {
    translate([Pitch*7-0.5,Pitch*4.5-2.54,1])
      rotate([180,0,0])
        Pin_header(1,1,0,1);
    translate([Pitch*7-0.5,Pitch*4.5+1.27,1])
      rotate([180,0,0])
        Pin_header(1,1,0,1);

}

if(Load_pins_enabled==1 && Load_pins_up==2)
  {
    translate([Pitch*7-0.5,Pitch*4.5-2.54,1])
      rotate([0,0,0])
        Screw_terminal(2.54*1.5,2);
}

    color("Black")
      translate([11.25,10.5,2])
        rotate([0,180,90])
          Component(6,3,1);

  }
}


INA_219(Data_pins_enabled,Data_pins_up,Load_pins_enabled,Load_pins_up);
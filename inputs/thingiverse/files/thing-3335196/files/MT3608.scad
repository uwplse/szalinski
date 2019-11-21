$fn=36;
use<Pin_header.scad>;
use<PCB.scad>;

Pins_enabled=1;
Pins_up=0;

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

module MT3608(Pins_enabled,Pins_up)
translate([1.27,0,2.5])
  {
  difference()
    {
    union()
      {
      color("RoyalBlue")
      cube([17,37,1],center=true);

  translate([1.27,-1.27,0])
    {
      color("Silver")
        translate([2.54*1,2.54*6.5,0])
          cube([3,5,1.05],center=true);
      color("Silver")
        translate([2.54*1,-2.54*5.5,0])
          cube([3,5,1.05],center=true);
      color("Silver")
        translate([-2.54*2,2.54*6.5,0])
          cube([3,5,1.05],center=true);
      color("Silver")
        translate([-2.54*2,-2.54*5.5,0])
          cube([3,5,1.05],center=true);
    }

    color("SaddleBrown")
      translate([2.54*2,2.54*3.5,0.7])
        Component(3.5,1.75,1.5);
    color("SaddleBrown")
      translate([2.54*2,2.54*0.4,0.7])
        Component(3.5,1.75,1.5);
    
    color("Black")
      translate([-2.54*2.5,-2.54*2.25,0.7])
        Component(1.75,3.5,2);

    
    color("Black")
      translate([2.54*2,2.54*1.9,0.7])
        Component(1.75,0.85,0.5);

    color("Black")
      translate([-2.54*1.25,2.54*2,0.7])
        Component(10,10,3);
    
    color("Blue")
      translate([2.54*1,-2.54*2.5,0.7])
        Component(10,9.5,4);
    color("Silver")
      translate([2.54*1.75,-2.54*4,3.5])
        rotate([0,90,0])
          cylinder(d=1.5,h=4);
    
      
      }

  translate([1.27,-1.27,0])
  {
  translate([2.54*1,2.54*6.5,-1])
    cylinder(d=1,h=5);
  translate([2.54*1,-2.54*5.5,-1])
    cylinder(d=1,h=5);
  translate([-2.54*2,2.54*6.5,-1])
    cylinder(d=1,h=5);
  translate([-2.54*2,-2.54*5.5,-1])
    cylinder(d=1,h=5);
  }

    color("Black")
      translate([-5,0,-0.7])
        rotate([180,0,0])
          linear_extrude(1)
            text("TP4056",size=2);

    color("Black")
      translate([-6,14,0.45])
        rotate([0,0,90])
          linear_extrude(1)
            text("VIN+",size=1);
    color("Black")
      translate([7.5,14,0.45])
        rotate([0,0,90])
          linear_extrude(1)
            text("VIN-",size=1);
    color("Black")
      translate([-6,-16,0.45])
        rotate([0,0,90])
          linear_extrude(1)
            text("VOUT+",size=1);
    color("Black")
      translate([7.5,-16,0.45])
        rotate([0,0,90])
          linear_extrude(1)
            text("VOUT-",size=1);

    color("Black")
      translate([2,7,0.45])
        rotate([0,180,90])
          linear_extrude(1)
            text("MT3608",size=3);


    }

  if(Pins_enabled==1 && Pins_up==0)
    {
    translate([2.54*1+1.27,2.54*6.5-1.27,-1])
      Pin_header(1,0,0,1);
    translate([2.54*1+1.27,-2.54*6.5+1.27,-1])
      Pin_header(1,0,0,1);
    translate([-2.54*1-1.27,2.54*6.5-1.27,-1])
      Pin_header(1,0,0,1);
    translate([-2.54*1-1.27,-2.54*6.5+1.27,-1])
      Pin_header(1,0,0,1);
    }
  if(Pins_enabled==1 && Pins_up==1)
    {
    translate([2.54*1+1.27,2.54*6.5-1.27,0])
      Pin_header(1,1,0,1);
    translate([2.54*1+1.27,-2.54*6.5+1.27,0])
      Pin_header(1,1,0,1);
    translate([-2.54*1-1.27,2.54*6.5-1.27,0])
      Pin_header(1,1,0,1);
    translate([-2.54*1-1.27,-2.54*6.5+1.27,0])
      Pin_header(1,1,0,1);
    }
  }

MT3608(Pins_enabled,Pins_up);
*PCB(54,54,1,2.54,2);
$fn=36;
Pins_pitch=2;
Board_thickness=1;
Pins_enabled=0;
Pins_up=0;            
Pins_to_254=0;   //only for Pins_up=0

//use<PCB.scad>



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
               cube([0.4,0.4,10],center=true);
        color("Silver")
        hull()
          {
           color("Silver")
              translate([0,Pins_pitch*a,-Board_thickness/2-0.3])
                 cylinder(r1=0,r2=0.75,h=0.7,center=true);
           color("Silver")
              translate([0,Pins_pitch*a,Board_thickness/2+0.3])
                 cylinder(r1=0.75,r2=0,h=0.7,center=true);
          }
         }
   }

module Pins_to_254_8()
   {

   translate([0,0,0])
      for(a=[0:1:7])
         {
          hull()
            {
            translate([0,2*a,0])
              sphere(0.4);
            translate([1,-1.75+2.54*a,-2])
              sphere(0.4);
            }

         color("Silver")
            translate([0,Pins_pitch*a,0])
               sphere(r=0.75);

         color("Silver")
            translate([0.9,-1.8+2.54*a,-2])
               sphere(r=0.85);
         }
   }

module Pins_to_254_6()
   {

   translate([0,0,0])
      for(a=[0:1:5])
         {
          hull()
            {
            translate([0,2*a,0])
              sphere(0.4);
            translate([3.5,-1.4+2.54*a,-2])
              sphere(0.4);
            }

         color("Silver")
            translate([0,Pins_pitch*a,0])
               sphere(r=0.75);

         color("Silver")
            translate([3,-1.4+2.54*a,-2])
               sphere(r=0.85);
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

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

module ESP12E(Pins_enabled,Pins_up)
translate([1.3,0.2,2])
  {

  X1=8;
  Y1=-3.5;
  X2=-8;
  Y2=-3.5;
  X3=5;
  Y3=12;

  difference()
     {
     union()
        {  
        color("Royalblue")
        translate([0,0,0])
          Board(16,24,Board_thickness);

        translate([X1,Y1,0])
          rotate([0,0,0])
            Pins_copper_rings(8,Pins_pitch,0.75);
        translate([X2,Y2,0])
          rotate([0,0,0])
            Pins_copper_rings(8,Pins_pitch,0.75);
        translate([X3,Y3,0])
          rotate([0,0,90])
            Pins_copper_rings(6,Pins_pitch,0.75);



    color("Silver")
      translate([0,3,0.5])
        rotate([0,0,0])
          Component(12,15,2.5);
        }

     translate([X1,Y1,0])
        rotate([0,0,0])
           Pins_holes(8,Pins_pitch,0.55);
      translate([X2,Y2,0])
        rotate([0,0,0])
           Pins_holes(8,Pins_pitch,0.55);
      translate([X3,Y3,0])
        rotate([0,0,90])
           Pins_holes(6,Pins_pitch,0.55);

      translate([0,27,0])
      cube([30,30,30],center=true);
      translate([23,0,0])
      cube([30,30,30],center=true);
      translate([-23,0,0])
      cube([30,30,30],center=true);


      color("Black")
        translate([1,-2.5,2.95])
          rotate([0,0,90])
            linear_extrude(1)
              text("ESP12E",size=2);
     }

  translate([0,0,0])
    {
    if(Pins_enabled==1 && Pins_up==0 && Pins_to_254==0)
    {
    translate([X1,Y1,0])
      rotate([0,0,0])
        Pins(8,Pins_pitch);

    translate([X2,Y2,0])
          rotate([0,0,0])
            Pins(8,Pins_pitch);
    translate([X3,Y3,0])
          rotate([0,0,90])
            Pins(6,Pins_pitch);

    }

if(Pins_enabled==1 && Pins_up==0 && Pins_to_254==1)
    {
    translate([X1,Y1,0])
      rotate([0,0,0])
        Pins_to_254_8();
translate([X2,Y2,0])
      mirror([1,0,0])
        Pins_to_254_8();
translate([X3,Y3,0])
      rotate([0,0,90])
        Pins_to_254_6();
    }

    if(Pins_enabled==1 && Pins_up==1 && Pins_to_254==0)
{
    translate([X1,Y1,0])
      rotate([0,180,0])
        Pins(8,Pins_pitch);
translate([X2,Y2,0])
      rotate([0,180,0])
        Pins(8,Pins_pitch);
translate([X3,Y3,0])
      rotate([0,180,90])
        Pins(6,Pins_pitch);
}

    color("Goldenrod")
      translate([-4.3,-11,0.5])
        rotate([0,0,0])
          Component(5,0.5,0.1);
    color("Goldenrod")
      translate([1,-6,0.5])
        rotate([0,0,0])
          Component(7,0.5,0.1);
    color("Goldenrod")
      translate([4.25,-8.5,0.5])
        rotate([0,0,0])
          Component(0.5,5,0.1);
    color("Goldenrod")
      translate([2.5,-9.2,0.5])
        rotate([0,0,0])
          Component(0.5,4.1,0.1);
    color("Goldenrod")
      translate([1,-9.2,0.5])
        rotate([0,0,0])
          Component(0.5,4.1,0.1);
color("Goldenrod")
      translate([-0.5,-9.2,0.5])
        rotate([0,0,0])
          Component(0.5,4.1,0.1);
color("Goldenrod")
      translate([-2,-9.2,0.5])
        rotate([0,0,0])
          Component(0.5,4.1,0.1);
    color("Goldenrod")
      translate([3.5,-11,0.5])
        rotate([0,0,0])
          Component(2,0.5,0.1);
color("Goldenrod")
      translate([0.2,-11,0.5])
        rotate([0,0,0])
          Component(1.75,0.5,0.1);
color("Goldenrod")
      translate([1.75,-7.4,0.5])
        rotate([0,0,0])
          Component(1.75,0.5,0.1);
color("Goldenrod")
      translate([-1.3,-7.4,0.5])
        rotate([0,0,0])
          Component(1.75,0.5,0.1);
    

  }
}

ESP12E(Pins_enabled,Pins_up);
//PCB(35,35,1,2.54,1);
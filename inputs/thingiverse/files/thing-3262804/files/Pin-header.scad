$fn=36;
Pitch=2.54;
Pins_number=10;
Pins_up=1;
Type=0;    // 0=vertical 1 row    1=vertical 2 rows  2=90 degrees 1 row   3=90 degrees 2 rows
Solder=1;

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
                  translate([Pitch,0,0.35])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }
         }
   }

module Pins_double(Pins_number,Pitch,Solder)
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
            translate([-Pitch,Pitch*a,-2])
               cube([0.6,0.6,10],center=true);
        
        color("Goldenrod")
            translate([0,Pitch*a,-7.6])
              rotate([0,0,45])
               cylinder(r1=0,r2=0.425,h=0.6,$fn=4);
        color("Goldenrod")
            translate([0,Pitch*a,3])
              rotate([0,0,45])
               cylinder(r2=0,r1=0.425,h=0.6,$fn=4);
        
        color("Goldenrod")
            translate([-Pitch,Pitch*a,-7.6])
              rotate([0,0,45])
               cylinder(r1=0,r2=0.425,h=0.6,$fn=4);
        color("Goldenrod")
            translate([-Pitch,Pitch*a,3])
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
        color("Black")
            translate([-Pitch,Pitch*a,-2])
               Component(2,2,1.25);
        if(a<Pins_number-1)
         color("Black")
            translate([-Pitch,Pitch*a+Pitch/2,-2])
               Component(1.6,1,1.25);
        if(a<Pins_number)
         color("Black")
            translate([-Pitch/2,Pitch*a,-2])
               Component(1,1.6,1.25);

        if(Solder==1)
          translate([0,Pitch*a-Pitch,0])
            rotate([0,0,90])
              {
              color("Silver")
                  translate([Pitch,0,0.35])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);

              color("Silver")
                  translate([Pitch,Pitch,0.35])
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
                  translate([Pitch,0,0.35])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              }
         }
   }

module Pins_90_double(Pins_number,Pitch,Solder)
   {
   translate([0,-(Pitch*round(Pins_number/2))+Pitch,0])
      for(a=[0:1:Pins_number-1])
         {
          translate([0,0,-10/6])
         {
         color("Goldenrod")
            translate([0,Pitch*a,1])
               cube([0.6,0.6,4],center=true);
        color("Goldenrod")
            translate([-2.54,Pitch*a,1-Pitch/2])
               cube([0.6,0.6,4+Pitch],center=true);

        color("Goldenrod")
            translate([4.7,Pitch*a,-Pitch/2])
               rotate([0,90,0])
               cube([0.6,0.6,10],center=true);
        color("Goldenrod")
            translate([4.7-Pitch/2,Pitch*a,-Pitch*1.5])
               rotate([0,90,0])
               cube([0.6,0.6,10+Pitch],center=true);

        color("Goldenrod")
            translate([10.3,Pitch*a,-Pitch/2])
              rotate([0,-90,0])
              rotate([0,0,45])
               cylinder(r1=0,r2=0.425,h=0.6,$fn=4);
        color("Goldenrod")
            translate([0,Pitch*a,3])
              rotate([0,0,45])
               cylinder(r2=0,r1=0.425,h=0.6,$fn=4);
        
        color("Goldenrod")
            translate([10.3,Pitch*a,-Pitch*1.5])
              rotate([0,-90,0])
              rotate([0,0,45])
               cylinder(r1=0,r2=0.425,h=0.6,$fn=4);
        color("Goldenrod")
            translate([-Pitch,Pitch*a,3])
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
         color("Black")
            translate([-Pitch,Pitch*a,-2])
               Component(2,2,1.25);
        if(a<Pins_number-1)
         color("Black")
            translate([-Pitch,Pitch*a+Pitch/2,-2])
               Component(1.6,1,1.25);
        if(a<Pins_number)
         color("Black")
            translate([-Pitch/2,Pitch*a,-2])
               Component(1,1.6,1.25);

        if(Solder==1)
          translate([0,Pitch*a-Pitch,0])
            rotate([0,0,90])
              {
              color("Silver")
                  translate([Pitch,0,0.35])
                    rotate([0,0,0])
                      scale([1,1,1.1])
                        sphere(d=2);
              color("Silver")
                  translate([Pitch,Pitch,0.35])
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

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

module PIN_HEADER(Pins_number,Pins_up,Type,Solder)
  {
  if(Pins_up==0)
    translate([0,0,0.65])
      rotate([0,0,90])
        Pins(Pins_number,Pitch,Solder);
  if(Pins_up==1)
    translate([0,0,0.4])
      rotate([0,180,90])
        Pins(Pins_number,Pitch,Solder);
}

module PIN_HEADER_DOUBLE(Pins_number,Pins_up,Type,Solder)
  {
  if(Pins_up==0)
    translate([0,0,0.65])
      rotate([0,0,90])
        Pins_double(Pins_number,Pitch,Solder);
  if(Pins_up==1)
    translate([0,0,0.4])
      rotate([0,180,90])
        Pins_double(Pins_number,Pitch,Solder);
}

module PIN_HEADER_90(Pins_number,Pins_up,Type,Solder)
  {
  if(Pins_up==0)
    translate([0,0,0.65])
      rotate([0,0,90])
        Pins_90(Pins_number,Pitch,Solder);
  if(Pins_up==1)
    translate([0,0,0.4])
      rotate([0,180,90])
        Pins_90(Pins_number,Pitch,Solder);

}

module PIN_HEADER_90_DOUBLE(Pins_number,Pins_up,Type,Solder)
  {
  if(Pins_up==0)
    translate([0,0,0.65])
      rotate([0,0,90])
        Pins_90_double(Pins_number,Pitch,Solder);
  if(Pins_up==1)
    translate([0,0,0.4])
      rotate([0,180,90])
        Pins_90_double(Pins_number,Pitch,Solder);

}

module Pin_header(Pins_number,Pins_up,Type,Solder)
  {
if(Type==0)
PIN_HEADER(Pins_number,Pins_up,Type,Solder);
if(Type==1)
PIN_HEADER_DOUBLE(Pins_number,Pins_up,Type,Solder);
if(Type==2)
PIN_HEADER_90(Pins_number,Pins_up,Type,Solder);
if(Type==3)
PIN_HEADER_90_DOUBLE(Pins_number,Pins_up,Type,Solder);
}

Pin_header(Pins_number,Pins_up,Type,Solder);

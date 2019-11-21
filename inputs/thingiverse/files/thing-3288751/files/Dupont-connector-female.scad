$fn=36;
Pitch=2.54;
Positions=6;
Solder=1;

module Dupont_connector_female(Pitch,Positions,Solder)
   {
   translate([0,-Pitch*round(Positions/2),0])
    rotate([0,180,0])
      for(a=[0:1:Positions-1])
         {
         color("Goldenrod")
            translate([0,Pitch*a,1])
               cube([0.6,0.6,4],center=true);
        if(Solder==1)
          {
           color("Silver")
              translate([0,Pitch*a,-2])
                 cylinder(r1=0,r2=1,h=1);
           color("Silver")
              translate([0,Pitch*a,0.5])
                 cylinder(r1=1,r2=0,h=1);
          }
        difference()
          {
         color("Black")
            translate([0,Pitch*a,-11])
               Component(2,2.55,10);
          color("grey")
            translate([0,Pitch*a,-12])
               Component(1.25,1.25,10);
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

Dupont_connector_female(Pitch,Positions,Solder);
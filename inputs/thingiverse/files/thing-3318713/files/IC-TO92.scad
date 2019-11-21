$fn=36;
Pitch=2.54;
Text="BC";
Text1="337";
P1="B";
P2="C";
P3="E";
Color="Black";
Solder=1;

module TO92(Text,Text1,P1,P2,P3,Color,Solder)
  {    translate([0,0,3])
      difference()
         {
         union()
            {
             color("Silver")
               translate([Pitch,0,-18])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([-Pitch,0,-18])
                  cube([0.5,0.5,30],center=true);
            color("Silver")
               translate([1.75,0,-1])
                  rotate([0,-20,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([-1.75,0,-1])
                  rotate([0,20,0])
                  cube([0.5,0.5,5],center=true);
            color("Silver")
               translate([0,0,-16])
                  cube([0.5,0.5,34],center=true);

          if(Solder==1)
            {
            color("Silver")
                translate([Pitch,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);
            color("Silver")
                translate([0,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);
            color("Silver")
                translate([-Pitch,0,-3])
                  rotate([0,0,0])
                    scale([1,1,1.1])
                      sphere(d=2);

            }

            color(Color)
               {
                  translate([0,0,1])
                     cylinder(d=5,h=4);
               }
            }
         color("SlateGray")
          translate([0,-6.5,4])
            cube([10,10,10],center=true);

        color("White")
          translate([0,-1.48,3.75])
            rotate([90,0,0])
              linear_extrude(1)
                text(Text,size=1,valign="center",halign="center");
        color("White")
          translate([0,-1.48,2.5])
            rotate([90,0,0])
              linear_extrude(1)
                text(Text1,size=1,valign="center",halign="center");

        color("White")
          translate([-1.5,-1.48,1.5])
            rotate([90,0,0])
              linear_extrude(1)
                text(P1,size=0.5,valign="center",halign="center");
        color("White")
          translate([0,-1.48,1.5])
            rotate([90,0,0])
              linear_extrude(1)
                text(P2,size=0.5,valign="center",halign="center");
        color("White")
          translate([1.5,-1.48,1.5])
            rotate([90,0,0])
              linear_extrude(1)
                text(P3,size=0.5,valign="center",halign="center");
         }  
  }

TO92(Text,Text1,P1,P2,P3,Color,Solder);
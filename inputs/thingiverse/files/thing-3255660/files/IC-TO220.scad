
$fn=36;
Text="NDP";
Text1="6020P";
Type=0;  //0=vertical   1=90 degrees
Solder=1;


module TO220(Text,Text1,Type,Solder)
  {
if(Type==0)
  translate([0.1+2.54,0.03-2.54*2,6])
    rotate([0,-90,0])
      difference()
         {
         union()
            {
            color("silver")
              translate([0.1,0.1,0])
               cube([15,9.8,1.2]);
            
            color("Black")
               translate([0,0,0.01])
                  cube([8.5,10,4.5]);
            
            color("Silver")
               translate([-2,2,2.5])
                  cube([5,1,0.3]);
            color("Silver")
               translate([-2,2+2.54,2.5])
                  cube([5,1,0.3]);
            color("Silver")
               translate([-2,2+2.54*2,2.5])
                  cube([5,1,0.3]);

            color("Silver")
               translate([-14,2+0.2,2.5])
                  cube([13,0.6,0.3]);
            color("Silver")
               translate([-14,2+2.54+0.2,2.5])
                  cube([13,0.6,0.3]);
            color("Silver")
               translate([-14,2+2.54*2+0.2,2.5])
                  cube([13,0.6,0.3]);
            }

            translate([12,5,-2])
               cylinder(d=3.5,h=10);

          color("White")
            translate([6,5,4.45])
              rotate([0,0,-90])
                linear_extrude(1)
                  text(Text,size=2,valign="center",halign="center");
          color("White")
            translate([3,5,4.45])
              rotate([0,0,-90])
                linear_extrude(1)
                  text(Text1,size=2,valign="center",halign="center");
         }
     if(Solder==1)
      translate([0,0,4.25])
      rotate([0,0,90])
        {
        color("Silver")
            translate([2.54*1,0,-3.75])
              rotate([0,0,0])
                scale([1,1,1.1])
                  sphere(d=2);
        color("Silver")
            translate([-2.54*0,0,-3.75])
              rotate([0,0,0])
                scale([1,1,1.1])
                  sphere(d=2);
        color("Silver")
            translate([-2.54*1,0,-3.75])
              rotate([0,0,0])
                scale([1,1,1.1])
                  sphere(d=2);
        }

if(Type==1)
  {
  translate([0.1+2.54,0.03-2.54*2,2])
    rotate([0,0,0])
      difference()
        {
        union()
          {
          color("silver")
            translate([0.1,0.1,0])
             cube([15,9.8,1.2]);
          
          color("Black")
             translate([0,0,0.01])
                cube([8.5,10,4.5]);
          
          color("Silver")
             translate([-2.8,2,2.5])
                cube([5,1,0.3]);
          color("Silver")
             translate([-2.8,2+2.54,2.5])
                cube([5,1,0.3]);
          color("Silver")
             translate([-2.8,2+2.54*2,2.5])
                cube([5,1,0.3]);

          color("Silver")
             translate([-2.8,2+0.2,2.5])
                rotate([0,90,0])
                  cube([13,0.6,0.3]);
          color("Silver")
             translate([-2.8,2+2.54+0.2,2.5])
                rotate([0,90,0])
                  cube([13,0.6,0.3]);
          color("Silver")
             translate([-2.8,2+2.54*2+0.2,2.5])
                rotate([0,90,0])
                  cube([13,0.6,0.3]);
          }

        translate([12,5,-2])
          cylinder(d=3.5,h=10);

        color("White")
          translate([6,5,4.45])
            rotate([0,0,-90])
              linear_extrude(1)
                text(Text,size=2,valign="center",halign="center");
        color("White")
          translate([3,5,4.45])
            rotate([0,0,-90])
              linear_extrude(1)
                text(Text1,size=2,valign="center",halign="center");
        }
     if(Solder==1)
      translate([0,0,4.25])
      rotate([0,0,90])
        {
        color("Silver")
            translate([2.54*1,0,-3.75])
              rotate([0,0,0])
                scale([1,1,1.1])
                  sphere(d=2);
        color("Silver")
            translate([-2.54*0,0,-3.75])
              rotate([0,0,0])
                scale([1,1,1.1])
                  sphere(d=2);
        color("Silver")
            translate([-2.54*1,0,-3.75])
              rotate([0,0,0])
                scale([1,1,1.1])
                  sphere(d=2);
        }
    }
  }


TO220(Text,Text1,Type,Solder);


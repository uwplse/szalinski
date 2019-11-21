
$fn=36;
Pins_number=6;
Text="BPC817C";
Type=0;   //0=small    1=big
Solder=1;


module IC_DIP(Pins_number,Text,Type,Solder)
{
if(Type==0)
translate([0.25,1.252-(round(Pins_number/4)*2.54),2])
difference()
   {
   for(a=[0:1:Pins_number/2-1])
    translate([0,a*2.54,0])
      {
      color("Black")
        translate([0,0,0])
         cube([7.1,2.54,3.5]);
      
      color("Silver")
         translate([-0.45,1.252-0.5,1.5])
            cube([5,1,0.3]);
      color("Silver")
         translate([2.55,1.252-0.5,1.5])
            cube([5,1,0.3]);

      color("Silver")
         translate([-0.45,1.252-0.3,-4.2])
            cube([0.3,0.6,6]);
      color("Silver")
         translate([7.25,1.252-0.3,-4.2])
            cube([0.3,0.6,6]);

      color("Silver")
         translate([-0.45,1.252-0.5,-0.4])
            cube([0.3,1,2]);
      color("Silver")
         translate([7.25,1.252-0.5,-0.4])
            cube([0.3,1,2]);

if(Solder==1)
  {
  color("Silver")
      translate([2.54*3-0.25,1.257,-1.5])
        rotate([0,0,0])
          scale([1,1,1.1])
            sphere(d=2);
  color("Silver")
      translate([-2.54*0-0.25,1.257,-1.5])
        rotate([0,0,0])
          scale([1,1,1.1])
            sphere(d=2);
  }
      }

      translate([12,5,-2])
         cylinder(d=3.5,h=10);

    if(Pins_number>4)
    color("White")
      translate([4,2.54*Pins_number/4+0.5,3.45])
        rotate([0,0,90])
          linear_extrude(1)
            text(Text,size=1,valign="center",halign="center");

    if(Pins_number<5)
    color("White")
      translate([3.5,2.54*Pins_number/4,3.45])
        rotate([0,0,0])
          linear_extrude(1)
            text(Text,size=1,valign="center",halign="center");

    color("White")
    translate([4,0,3.4])
    cylinder(r=1,h=1);
    color("White")
    translate([6,1,3.4])
    cylinder(r=0.5,h=1);

   }

if(Type==1)
translate([0.25,1.252-(round(Pins_number/4)*2.54),3])
{
difference()
   {
   for(a=[0:1:Pins_number/2-1])
    translate([0,a*2.54,0])
      {
      color("Black")
        translate([0,0,0])
         cube([14.7,2.54,3.5]);
      
      color("Silver")
         translate([-0.45,1.252-0.5,1.5])
            cube([5,1,0.3]);
      color("Silver")
         translate([10.15,1.252-0.5,1.5])
            cube([5,1,0.3]);

      color("Silver")
         translate([-0.45,1.252-0.3,-4.2])
            cube([0.3,0.6,6]);
      color("Silver")
         translate([14.85,1.252-0.3,-4.2])
            cube([0.3,0.6,6]);

      color("Silver")
         translate([-0.45,1.252-0.5,-0.4])
            cube([0.3,1,2]);
      color("Silver")
         translate([14.85,1.252-0.5,-0.4])
            cube([0.3,1,2]);

if(Solder==1)
  {
  color("Silver")
      translate([2.54*6-0.25,1.257,-1.5])
        rotate([0,0,0])
          scale([1,1,1.1])
            sphere(d=2);
  color("Silver")
      translate([-2.54*0-0.25,1.257,-1.5])
        rotate([0,0,0])
          scale([1,1,1.1])
            sphere(d=2);
  }
      }

    if(Pins_number>4)
    color("White")
      translate([7,2.54*Pins_number/4+0.5,3.45])
        rotate([0,0,90])
          linear_extrude(1)
            text(Text,size=1,valign="center",halign="center");

    if(Pins_number<5)
    color("White")
      translate([3.5,2.54*Pins_number/4,3.45])
        rotate([0,0,0])
          linear_extrude(1)
            text(Text,size=1,valign="center",halign="center");

    color("White")
    translate([7.5,0,3.4])
    cylinder(r=1,h=1);
    color("White")
    translate([13,1,3.4])
    cylinder(r=0.5,h=1);
   }
}



}

IC_DIP(Pins_number,Text,Type,Solder);


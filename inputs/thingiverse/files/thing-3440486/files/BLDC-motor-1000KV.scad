$fn=72;

Motor_diameter_top=17;
Motor_height_top=4.5;
Motor_diameter_middle=28;
Motor_height_middle=17;
Motor_diameter_bottom=25;
Motor_height_bottom=4.5;
Motor_shaft_diameter=3.17;
Motor_shaft_length=40;
Motor_shaft_Z_offset=5;
Stator_poles=12;
Top_holes_diameter=7;
Top_holes_radial_position=8.5;
Bottom_holes_diameter=16;
Bottom_holes_radial_position=16;
Bearing_diameter=8.2;
Fixing_holes_radial_position_1=9.5;
Fixing_holes_radial_position_2=8;
Color_1="Orange";  //Motor body color
Color_2="Silver";     //Shaft and bearing color
Color_3="Black";     //Cable and seeger color
Color_4="Silver";   //Motor middle band colorr
Color_5="darkgreen"; //Stator color



module BLDC_1000KV(Motor_diameter_top,Motor_height_top,Motor_diameter_middle,Motor_height_middle,Motor_diameter_bottom,Motor_height_bottom,Motor_shaft_diameter,Motor_shaft_length,Motor_shaft_Z_offset,Stator_poles,Top_holes_diameter,Top_holes_radial_position,Bottom_holes_diameter,Bottom_holes_radial_position,Bearing_diameter,Fixing_holes_radial_position_1,Fixing_holes_radial_position_2,Color_1,Color_2,Color_3,Color_4,Color_5)
{
difference()
  {
  union()
    {
    color(c=Color_1)
      cylinder(d=Motor_diameter_middle,h=Motor_height_middle,center=true);
    color(c=Color_4)
      cylinder(d=Motor_diameter_middle+0.1,h=Motor_height_middle-1,center=true);
    color(c=Color_1)
      translate([0,0,Motor_height_middle/2+Motor_height_top+0.5])
        cylinder(d=8,h=1,center=true);
    color(c=Color_1)
      translate([0,0,Motor_height_middle/2+Motor_height_top/2])
        cylinder(d1=Motor_diameter_middle,d2=Motor_diameter_top,h=Motor_height_top,center=true);
    color(c=Color_1)
      translate([0,0,-(Motor_height_middle/2+Motor_height_bottom/2)])
        cylinder(d2=Motor_diameter_middle,d1=Motor_diameter_bottom,h=Motor_height_bottom,center=true);
    }

    color(c=Color_1)
      cylinder(d=Motor_diameter_middle-3,h=Motor_height_middle+0.1,center=true);
    color(c=Color_1)
      translate([0,0,Motor_height_middle/2+Motor_height_top/2-1])
        cylinder(d1=Motor_diameter_middle-3,d2=Motor_diameter_top-3,h=Motor_height_top-1,center=true);
    color(c=Color_1)
      translate([0,0,-(Motor_height_middle/2+Motor_height_bottom/2-1)])
        cylinder(d2=Motor_diameter_middle-3,d1=Motor_diameter_bottom-3,h=Motor_height_bottom-1,center=true);

//Fixing screw holes
  color(c=Color_1)
  for (a=[0: 180:360])
    rotate([0,0,a])
    translate([Fixing_holes_radial_position_1,0,-(Motor_height_middle/2+Motor_height_bottom/2)])
      cylinder(d=3,h=5,center=true);
  color(c=Color_1)
  for (a=[90: 180:270])
    rotate([0,0,a])
    translate([Fixing_holes_radial_position_2,0,-(Motor_height_middle/2+Motor_height_bottom/2)])
      cylinder(d=3,h=5,center=true);

//Top holes
color(c=Color_1)
  for (a=[0: 90:359])
    rotate([0,0,a])
    translate([Top_holes_radial_position,0,(Motor_height_middle/2+Motor_height_top/2)])
      cylinder(d=Top_holes_diameter,h=Motor_height_top+2,center=true);

//Bottom_holes
color(c=Color_1)
  for (a=[0: 90:359])
    rotate([0,0,a+45])
    translate([Bottom_holes_radial_position,0,-(Motor_height_middle/2+Motor_height_bottom/2)-0.99])
      cylinder(d=Bottom_holes_diameter,h=Motor_height_bottom+2,center=true);

*translate([100,0,0])
  cube([200,200,200],center=true);

  }

  color(Color_2)
    translate([0,0,(Motor_height_top/2-Motor_height_bottom/2)+Motor_shaft_Z_offset])
      cylinder(d=Motor_shaft_diameter,h=Motor_shaft_length,center=true);

  color(Color_2)
    translate([0,0,-(Motor_height_middle/2+Motor_height_bottom)+1.45])
      cylinder(d=Bearing_diameter,h=3,center=true);
  color(c=Color_1)
    translate([0,0,-(Motor_height_middle/2+Motor_height_bottom)+1.5])
      cylinder(d=Bearing_diameter+1,h=3,center=true);

  translate([0,0,0])
  for(a=[0:360/Stator_poles:359])
    {
    color(c=Color_5)
    rotate([0,0,a])
      translate([0,Motor_diameter_middle/5,0])
        cube([1,Motor_diameter_middle/2.5,Motor_height_middle],center=true);

    color(c=Color_5)
    rotate([0,0,a])
      translate([0,Motor_diameter_middle/2.5,0])
        cube([4,1,Motor_height_middle],center=true);

    color(c=[204/255,102/255,0])
      rotate([0,0,a])
        translate([0,Motor_diameter_middle/4,0])
          rotate([90,0,0])
            scale([0.5,1,1])
            cylinder(d=Motor_height_middle+1,h=Motor_diameter_middle/4,center=true);
    }

  color(Color_3)
    translate([-8,8,-(Motor_height_middle/2+Motor_height_bottom/2)+0.75])
      rotate([90,0,45])
        scale([2,1,1])
        cylinder(d=3,h=Motor_diameter_middle/2,center=true);

  color(Color_3)
    translate([0,0,-(Motor_height_middle/2+Motor_height_bottom/2)-3.5])
      cylinder(d=5,h=0.5,center=true);

}



BLDC_1000KV(Motor_diameter_top,Motor_height_top,Motor_diameter_middle,Motor_height_middle,Motor_diameter_bottom,Motor_height_bottom,Motor_shaft_diameter,Motor_shaft_length,Motor_shaft_Z_offset,Stator_poles,Top_holes_diameter,Top_holes_radial_position,Bottom_holes_diameter,Bottom_holes_radial_position,Bearing_diameter,Fixing_holes_radial_position_1,Fixing_holes_radial_position_2,Color_1,Color_2,Color_3,Color_4,Color_5);
$fn=36;

MotorHeight=40;
MotorWidth=42;
ShaftDiameter=5;
ShaftLength=28;
FixingHolesInteraxis=31;

module Part1(MotorWidth,Height,CornerFillet)
{
  hull()
  {
    translate([MotorWidth/2-CornerFillet,MotorWidth/2,-0.25])
      sphere(0.25);
    translate([-MotorWidth/2+CornerFillet,MotorWidth/2,-0.25])
      sphere(0.25);
    translate([MotorWidth/2-CornerFillet,-MotorWidth/2,-0.25])
      sphere(0.25);
    translate([-MotorWidth/2+CornerFillet,-MotorWidth/2,-0.25])
      sphere(0.25);
    translate([MotorWidth/2,MotorWidth/2-CornerFillet,-0.25])
      sphere(0.25);
    translate([-MotorWidth/2,MotorWidth/2-CornerFillet,-0.25])
      sphere(0.25);
    translate([MotorWidth/2,-MotorWidth/2+CornerFillet,-0.25])
      sphere(0.25);
    translate([-MotorWidth/2,-MotorWidth/2+CornerFillet,-0.25])
      sphere(0.25);

    translate([MotorWidth/2-CornerFillet,MotorWidth/2,-Height+0.25])
      sphere(0.25);
    translate([-MotorWidth/2+CornerFillet,MotorWidth/2,-Height+0.25])
      sphere(0.25);
    translate([MotorWidth/2-CornerFillet,-MotorWidth/2,-Height+0.25])
      sphere(0.25);
    translate([-MotorWidth/2+CornerFillet,-MotorWidth/2,-Height+0.25])
      sphere(0.25);
    translate([MotorWidth/2,MotorWidth/2-CornerFillet,-Height+0.25])
      sphere(0.25);
    translate([-MotorWidth/2,MotorWidth/2-CornerFillet,-Height+0.25])
      sphere(0.25);
    translate([MotorWidth/2,-MotorWidth/2+CornerFillet,-Height+0.25])
      sphere(0.25);
    translate([-MotorWidth/2,-MotorWidth/2+CornerFillet,-Height+0.25])
      sphere(0.25);
  }
}

module Nema17(MotorHeight,MotorWidth,ShaftDiameter,ShaftLength,FixingHolesInteraxis)
{
  difference()
  {
    union()
    {
  //MotorShaft
      color("Silver")
        cylinder(d=ShaftDiameter,h=MotorHeight+ShaftLength);

      color("Black")
      translate([0,0,MotorHeight])
        cylinder(d=22,h=1);

  //motor body
      color("Silver")
        translate([0,0,MotorHeight])
          Part1(MotorWidth,8,3);
      color("Black")
        translate([0,0,MotorHeight-8])
          Part1(MotorWidth,MotorHeight-18,5);
      color("Silver")
        translate([0,0,10])
          Part1(MotorWidth,10,3);

  //Connector
      color("Silver")
        translate([MotorWidth/2,-8.1,0])
          cube([4,16.2,3]);

      difference()
      {
        color("White")
          translate([MotorWidth/2,-8,3])
            cube([5,16,6]);
        color("White")
          translate([MotorWidth/2+2.1,-7.5,4])
            cube([3,15,4]);
      }

      color("GoldenRod")
        translate([MotorWidth/2,1.27,6])
          rotate([0,90,0])
            cylinder(d=1,h=5);
      color("GoldenRod")
        translate([MotorWidth/2,1.27+2.54,6])
          rotate([0,90,0])
            cylinder(d=1,h=5);
      color("GoldenRod")
        translate([MotorWidth/2,1.27+2.54*2,6])
          rotate([0,90,0])
            cylinder(d=1,h=5);
      color("GoldenRod")
        translate([MotorWidth/2,-1.27,6])
          rotate([0,90,0])
            cylinder(d=1,h=5);
      color("GoldenRod")
        translate([MotorWidth/2,-1.27-2.54,6])
          rotate([0,90,0])
            cylinder(d=1,h=5);
      color("GoldenRod")
        translate([MotorWidth/2,-1.27-2.54*2,6])
          rotate([0,90,0])
            cylinder(d=1,h=5);
    }
    translate([FixingHolesInteraxis/2,FixingHolesInteraxis/2,-2])
      cylinder(d=3,h=MotorHeight+5);
    translate([-FixingHolesInteraxis/2,FixingHolesInteraxis/2,-2])
      cylinder(d=3,h=MotorHeight+5);
    translate([FixingHolesInteraxis/2,-FixingHolesInteraxis/2,-2])
      cylinder(d=3,h=MotorHeight+5);
    translate([-FixingHolesInteraxis/2,-FixingHolesInteraxis/2,-2])
      cylinder(d=3,h=MotorHeight+5);
  }
}

Nema17(MotorHeight,MotorWidth,ShaftDiameter,ShaftLength,FixingHolesInteraxis);

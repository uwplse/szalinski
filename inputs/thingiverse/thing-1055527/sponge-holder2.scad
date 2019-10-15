// Attempted bath sponge holder
include <rcube.scad>

thickness = 7;
supportWidth = 15 + thickness;

length = 90;
height = 5;
width = 60 + 2 * thickness;

module base()
{
  union()
  {
    translate([0, (width - thickness) / 2, 0])
      cube(size = [length, thickness, height]);
    difference()
    {
      cube(size = [length, width, height]);
      translate([thickness, thickness, - thickness])
        cube(size = [length - thickness * 2, width - thickness * 2, thickness * 2 + height]);
    }
    difference()
    {
      translate([thickness / 2, width - thickness / 2, thickness / 2])
        sphere(r = thickness, $fn = 50);
      translate([-thickness / 2, width - thickness * 1.5, -thickness * 2])
        cube([thickness * 2 , thickness * 2, thickness * 2]);
    }

    difference()
    {
      translate([length - thickness / 2, width - thickness / 2, thickness / 2])
        sphere(r = thickness, $fn = 50);
      translate([length - thickness * 1.4, width - thickness * 1.5, -thickness * 2])
        cube([thickness * 2 , thickness * 2, thickness * 2]);
    }
  }
}

module support()
{
  cube(size = [length, thickness, supportWidth]);
}

module halfCylinder(r, h)
{
  difference()
  {
    e = 0.2;
    cylinder(r = r, h = h, center = false);
    translate([0, -(r + e), -e])
      cube([2 * (r + e), 2 * (r + e), h + 2 * e]);
  }
}

module front()
{
  translate([length / 2, width, 0])
    rotate([90, 90, 0])
      halfCylinder(r = length / 2, h = thickness);
}

module assemble()
{
  union()
  {
    support();
    base();
    front();
  }
}

assemble();

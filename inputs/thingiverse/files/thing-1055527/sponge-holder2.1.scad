// Attempted bath sponge holder
include <rcube.scad>

thickness = 10;
supportHeight = 20;

length = 90;
height = 5;
width = 80;

module base()
{
  union()
  {
    // Support bars
    translate([0, (width - thickness) / 3, 0])
    {
      cube(size = [length, thickness, height]);
    }
    translate([0, (width - thickness) * (2/3), 0])
    {
      cube(size = [length, thickness, height]);
    }
    translate([width / 2, 0, 0])
    {
      cube(size = [thickness, length - thickness, height]);
    }

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

module support()
{
  translate([ thickness, 0, 0])
    cube(size = [length - thickness * 2, thickness, supportHeight]);
  translate([ length / 4, 0 , thickness / 2 ])
    rotate([0, 90, 90])
      halfCylinder(r = length / 4, h = thickness);
  translate([ length * (3/4), 0, thickness / 2 ])
    rotate([0, 90, 90])
      halfCylinder(r = length / 4, h = thickness);
}


module front()
{
  translate([length / 2, width, 0])
    rotate([90, 90, 0])
      halfCylinder(r = length / 2, h = thickness);
}

module assemble()
{
  width = width + 2 * thickness;

  union()
  {
    support();
    base();
    front();
  }
}

assemble();

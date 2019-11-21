$fn=100;
/*
  Robot Vac Skirt Extender
  For Model: Hoover Performer Plus
  Author: Brian Khuu 2019
  
  This ensures it doesn't go over carpets or doorstops if needed.
  This is mounted via M4 screws in the Hoover Performer Plus.

*/

// Minimum Skirt Enable?
minimum_skirt = false;

// Holes in extended skirt (needs printed support)
skirt_holes = true;

// Hole Dia
hole_dia=4.6;

// Hole Spacing
hole_spacing=28.5-4.6;

// Skirt Length from lower hole
skirt_length=30;

// Thickness
thickness=4;

// Skirt Thickness
thickness_skirt=3;

// Width
width=hole_dia*5;

// radius of bot
bot_radius=160;

// Bottom Skirt Height
bot_skirt_h=20;

module minimum_skirt(rounded_bottom)
{
  translate([skirt_length,0,0])
  difference()
  {
    union()
    {
      hull()
      {
        translate([0,0,0])
          cylinder(d=width, h=thickness, $fn=40, center=true);
        translate([hole_spacing,0,0])
          cylinder(d=width, h=thickness, $fn=40, center=true);
        translate([-skirt_length,0,0])
          cube([0.001,width,thickness], center=true);
        if (rounded_bottom)
          translate([-skirt_length,0,0])
            rotate([90,0,0])
              cylinder(d=thickness, h=width, $fn=40, center=true);
      }
    }
    translate([0,0,0])
      cylinder(d=hole_dia, h=2+thickness, $fn=40, center=true);
    translate([hole_spacing,0,0])
      cylinder(d=hole_dia, h=2+thickness, $fn=40, center=true);
  }
}

module full_skirt()
{
  translate([-bot_radius,0,0])
  union()
  {
    translate([bot_radius,0,0])
      rotate([0,-90,0])
        minimum_skirt(false);
    difference()
    {
      rotate([0,0,-45])
        rotate_extrude(angle=90)
          translate([bot_radius,bot_skirt_h/2,0])
            square([thickness_skirt,bot_skirt_h], center=true);
      
      if (skirt_holes)
      for(xi=[-25:1:25])
        rotate([0,0,xi])
          cube([1000,3,((bot_skirt_h-10)*2)], center=true);
    }
  }
}

if (minimum_skirt)
  minimum_skirt(true);
else
  full_skirt();
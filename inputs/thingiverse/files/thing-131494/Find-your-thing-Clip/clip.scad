// Inner diameter
diameter = 10;

// Wall thickness
thickness = 2;

// Clip length
length = 3;

// Opening angle
angle = 64;

cutout = diameter*2;

difference() {
  rotate_extrude($fn=200)
    translate([diameter/2,0,0])
      square([thickness, length]);

  translate([0,0,-1])linear_extrude(height=length*2)
    polygon([[0,0],[sin(angle/2)*cutout,cos(angle/2)*cutout],[-sin(angle/2)*cutout,cos(angle/2)*cutout]]);
}
// Copyright 2019 Pascal de Bruijn
// Licensed Creative Commons - Attribution - Share Alike

width = 40;
height = 40;

foot_height = 5.5;

plug_depth = 5;
plug_width = 4;

$fn = 360;

module plug ()
{
  rotate([0, 0, 0]) cube([1, plug_depth, plug_width], center = true);
  rotate([0, 90, 0]) cube([1, plug_depth, plug_width], center = true);
}


rotate([0, 0, 270])
union ()
{
  intersection ()
  {
    translate([-0.5*width, 0, 0]) cube([width, height+foot_height, height+foot_height], false);
    rotate([0, 90, 0]) cylinder(width, (height+foot_height), (height+foot_height), true);
    
    translate([0, 0, 0.5*(height+foot_height)]) rotate([0, 0, 90]) scale([2*((height+foot_height)/width), 1, 1]) cylinder(height+foot_height, 0.5*width, 0.5*width, true);
 
  }

  translate([-0.25*width, -plug_depth/2, 0.25*height + foot_height]) plug();
  translate([-0.25*width, -plug_depth/2, 0.75*height + foot_height]) plug();
  translate([ 0.25*width, -plug_depth/2, 0.25*height + foot_height]) plug();
  translate([ 0.25*width, -plug_depth/2, 0.75*height + foot_height]) plug();
}
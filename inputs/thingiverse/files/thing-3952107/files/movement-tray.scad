// Copyright 2019 Pascal de Bruijn
// Licensed Creative Commons - Attribution - Share Alike

// in mm
tray_thickness = 1;

// in mm
tray_edge = 2.5;

// in mm
tray_buffer = 0;

// in degrees
tray_chamfer_angle = 15;

tray_open = 0; // [0:Closed,1:Open]

base_shape = 1; // [1:Square,0:Round]

// in mm
base_height = 3.5;

// in mm
base_width = 20;

// in mm
base_length = 20;

// in mm
base_tolerance = 0.2;

// in bases
count_width = 4;

// in bases
count_length = 3;


// in steps
$fn = 360;

difference ()
{

  cube([count_width * (base_width+base_tolerance+tray_buffer) + tray_edge*2, count_length * (base_length+base_tolerance+tray_buffer) + tray_edge*2, base_height + tray_thickness]);

  union ()
  {
    for (x = [0:1:count_width-1])
    {
      for (y = [0:1:count_length-1])
      {
        if (base_shape != 0)
        {
          translate([tray_edge + x*(base_width+base_tolerance+tray_buffer) + tray_buffer/2, tray_edge + y*(base_length+base_tolerance+tray_buffer) + tray_buffer/2, tray_thickness]) cube([base_width+base_tolerance, base_length+base_tolerance, base_height+1]);
        }
        else
        {
          translate([tray_edge + x*(base_width+base_tolerance+tray_buffer) + (base_width+base_tolerance+tray_buffer)/2, tray_edge + y*(base_length+base_tolerance+tray_buffer) + (base_length+base_tolerance+tray_buffer)/2, tray_thickness]) scale([1, base_length/base_width, 1]) cylinder(base_height+1, (base_width+base_tolerance)/2, (base_width+base_tolerance)/2);
        }
      }
    }

    if (tray_open > 0)
    {
      translate([tray_edge, count_length * (base_length+base_tolerance+tray_buffer) + tray_edge, tray_thickness]) cube([count_width * (base_width+base_tolerance+tray_buffer),tray_edge,base_height]);
    }
    
    translate([count_width * (base_width+base_tolerance+tray_buffer) + tray_edge*2, 0, 0]) rotate([
tray_chamfer_angle, 0, 180]) cube([count_width * (base_width+base_tolerance+tray_buffer) + tray_edge*2, 10, 10]);
    
    translate([0, count_length * (base_length+base_tolerance+tray_buffer) + tray_edge*2, 0]) rotate([
tray_chamfer_angle, 0, 0]) cube([count_width * (base_width+base_tolerance+tray_buffer) + tray_edge*2, 10, 10]);

    translate([0, count_length * (base_length+base_tolerance+tray_buffer) + tray_edge*2, 0]) rotate([0, -
tray_chamfer_angle, 180]) cube([10, count_length * (base_length+base_tolerance+tray_buffer) + tray_edge*2, 10]);

    translate([count_width * (base_width+base_tolerance+tray_buffer) + tray_edge*2, 0, 0]) rotate([0, -
tray_chamfer_angle, 0]) cube([10, count_length * (base_length+base_tolerance+tray_buffer) + tray_edge*2, 10]);

  }

}
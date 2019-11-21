// Tripod Mount Plate

//
// Plate dimensions
//

// Plate X size, mm
size_x = 41;
// Plate Y size, mm
size_y = 41;

// Wall thickness, mm
wall_thickness = 2.5;

// Slope of side walls, degrees
side_slope = 10;
// Height of non-sloped part of the wall, must be > 0
slope_start_height = 2;

// Radius of plat corners, mm
top_corner_radius = 0.5;

//
// Screw properties
//

// Screw full length, including head, mm
screw_full_length = 14.3;

// How much of the screw should stick outside, mm.  Usually it is the deepness of mount screw hole in the camera
screw_work_length = 4.8;
// Length of non-threaded screw part (grip, neck, shank), mm
screw_shank_length = 3.5;

// Diameter of non-threaded screw part, mm.  Determines the narrower part of the slot
shank_shaft_diameter = 5.0;
// Diameter of threaded part screw port, mm.  Determines the wider part of the slot
thread_shaft_diameter = 6.5;

// Length of the screw head, mm
screwhead_length = 4;
// Diameter of the screw head, mm
screwhead_diameter = 12;

//
// computed properties
//
$fn = 0 + 50;

size_z = 0.5 + screw_full_length - screw_work_length;
wall_x = wall_thickness / cos(side_slope);

slope_x = (size_z - slope_start_height) * tan(side_slope);

internal_size_x = size_x - slope_x;
bottom_corner_radius = top_corner_radius + slope_x;

shank_shaft_radius = shank_shaft_diameter / 2;
thread_shaft_radius = thread_shaft_diameter / 2;
screwhead_radius = screwhead_diameter / 2;

screw_length = screw_full_length - screwhead_length;
screw_thread_length = screw_length - screw_shank_length;
screw_inside_length = screw_length - screw_work_length;
threaded_shaft_length = size_z - screw_thread_length;

slot_start = internal_size_x / 2 - screwhead_diameter;
slot_end = -slot_start;

module plate() {
  difference()
  {
      plateBlock();
      drillouts();
  }
}

module plateBlock() {
  roundedCube(size_x, size_y, size_z, bottom_corner_radius, top_corner_radius);
}


module roundedCube(x, y, z, r1, r2)
{
    translate([-x/2 + r1, -y / 2 + r1, 0])
      minkowski() {
        cube([x-2*r1,y-2*r1,slope_start_height]);
        cylinder(r1=r1,r2=r2,h = z - slope_start_height);
      };
}

module drillouts() {
    internalFacet();
    shankShaft();
    threadedShaft();
    eye();
}

module internalFacet() {
  difference() {
    translate([0, 0, -0.01])
    roundedCube(
      size_x - 2 * wall_x,
      size_y - 2 * wall_x,
      size_z - wall_thickness,
      top_corner_radius, 0);
    screwheadPad();
  }
}

module shankShaft() {
  hull() {
    translate([slot_start, 0, 0]) shankShaftBase();
    translate([slot_end, 0, 0]) shankShaftBase();
  }
}

module shankShaftBase() {
  cylinder(h=size_z + 0.01, r=shank_shaft_radius);
}

module threadedShaft() {
  hull() {
    translate([slot_start, 0, 0]) threadedShaftBase();
    translate([slot_end, 0, 0]) threadedShaftBase();
  }
}

module threadedShaftBase() {
  translate([0, 0, size_z + 1])
  hull() {
    translate([0, 0, -thread_shaft_radius])
      cylinder(r1 = 0, r2 = thread_shaft_radius, h = thread_shaft_radius);
    translate([0, 0, -thread_shaft_radius - threaded_shaft_length])
      cylinder(r1 = 0, r2 = thread_shaft_radius, h = thread_shaft_radius);
  }
}

module eye() {
  translate([slot_end, 0, 0]) {
    cylinder(h=size_z + 0.01, r = shank_shaft_radius);
    intersection() {
      cylinder(h=size_z + 0.01, r = thread_shaft_radius);
      for(angle = [0:60:360]) {
        rotate(angle)
          cube(size=[thread_shaft_radius * 10, thread_shaft_radius * 0.5, 2 * size_z + 2], center=true);
      }
    }
  }
}

module screwheadPad() {
  z_start = 0.5 + screwhead_length;
  h = size_z - z_start;

  translate([0, 0, z_start])
  hull() {
    translate([slot_start, 0, 0]) screwheadPadBase(h);
    translate([slot_end, 0, 0]) screwheadPadBase(h);
  }
}

module screwheadPadBase(h) {
      cylinder(
        r1 = screwhead_radius,
        r2 = screwhead_radius + 3,
        h = h
      );
}

plate();

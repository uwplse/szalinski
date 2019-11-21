// The width of the plate, in Openbeam holes
plate_width=3;

// The height of the plate, in Openbeam holes
plate_height=3;

// the thickness of the plate, in mm
plate_thickness=4;

// the thickness of the bottom, in mm
bottom_thickness=2;

// Whether the center part of a plate bigger than 2x2 has holes or is solid.
solid_center=0; // [0:false, 1:true]

$fn=40;

openbeam_plate([plate_width, plate_height], h=plate_thickness, solid_center=solid_center);

// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// roundedBox([width, height, depth], float radius, bool sidesonly);

// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);

// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}

//////////////////////////////////////////////////////////////////
/// tools.scad

openbeam_w=15;
hole_extra_size=0.50;

module rounded_xy_cube(size, r, center=false) {
  offset = center ? 0 : r;

  translate([offset, offset, 0]) {
    minkowski() {
      cube(size - [r*2, r*2, 0], center);
      cylinder(r=r, h=0.00001);
    }
  }
}

module openbeam_screw_hole(screw_shaft=3, screw_head=5.5,
                           screw_height=6, screw_head_height=3) {
  translate([0, 0, -screw_height])
    cylinder(r=(screw_shaft+hole_extra_size)/2, h=screw_height+0.05);
  cylinder(r=(screw_head+hole_extra_size)/2, h=screw_head_height+0.05);
}

//////////////////////////////////////////////////////////////////
/// plate.scad

module openbeam_plate(grid_size, h=4, solid_center=true) {
  size = [grid_size[0] * openbeam_w, grid_size[1] * openbeam_w, h];
  difference() {
    rounded_xy_cube(size, 4);

    // holes on the sides
    for (x = [0 : grid_size[0] - 1],
         y = [0 : grid_size[1] - 1]) {
      if (!solid_center
          || x == 0 || x == grid_size[0] - 1
          || y == 0 || y == grid_size[1] - 1) {
        translate([x * openbeam_w + openbeam_w/2,
                   y * openbeam_w + openbeam_w/2, 0]) {
          translate([0, 0, bottom_thickness]) {
            openbeam_screw_hole(screw_height=h+0.05, screw_head_height=h+0.05);
          }
        }
      }
    }
  }
}

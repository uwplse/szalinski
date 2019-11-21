// Created in 2016-2017 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// https://www.thingiverse.com/thing:2729961


// Match this value very closely to the desired door knob.
nom_knob_diam = 54.9;

knob_width = 20;
knob_thick = 4;
knob_smooth_rad = 3;

bolt_nomdiam = 5;
bolt_nomlen = 18;
bolt_shift_up = 1;

bolt_compressby = 2;
bolt_support_angle = 24;

lever_intersect_angle1 = -32;
lever_end_angle = 55;
lever_circ1_diam = 80;
lever_circ2_diam = 110;
lever_thick = 20;
lever_width = knob_width;

lever_midrad1 = lever_circ1_diam/2 - lever_thick/2;
lever_midrad2 = lever_circ2_diam/2 - lever_thick/2;

lever2_offx = (lever_midrad1 + lever_midrad2) * cos(lever_intersect_angle1);
lever2_offy = (lever_midrad1 + lever_midrad2) * sin(lever_intersect_angle1);

round_lever_by = 8;

splice_angle = 12;


knob_diam = nom_knob_diam + 1.6;
splice_rotby = 360 * (bolt_compressby / (PI*knob_diam));

bigval = 2 * (lever_circ1_diam + knob_diam + lever_circ2_diam);

knob_outer_rad = knob_diam/2 + knob_thick;

lever_hull_off = 10;
bolt_offset_out = 12 + knob_outer_rad;

display_angle = -105;


// smoothness = 2;  // For fast rendering.
// smoothness = 4;    // For smooth prints.
//smooth_angle = 0.5;
//smooth_size = 0.2;
smooth_angle = 2;
smooth_size = 1.0;


////// copied from threads.scad, https://www.thingiverse.com/thing:1686322 ////

// Provides standard metric hex head widths across the flats.
function HexAcrossFlats(diameter) =
  (diameter <= 64) ?
    lookup(diameter, [
      [2, 4],
      [2.5, 5],
      [3, 5.5],
      [3.5, 6],
      [4, 7],
      [5, 8],
      [6, 10],
      [7, 11],
      [8, 13],
      [10, 16],
      [12, 18],
      [14, 21],
      [16, 24],
      [18, 27],
      [20, 30],
      [22, 34],
      [24, 36],
      [27, 41],
      [30, 46],
      [33, 50],
      [36, 55],
      [39, 60],
      [42, 65],
      [48, 75],
      [52, 80],
      [56, 85],
      [60, 90],
      [64, 95]
    ]) :
    diameter * 95 / 64;


// Provides standard metric hex head widths across the corners.
function HexAcrossCorners(diameter) =
  HexAcrossFlats(diameter) / cos(30);


// Provides standard metric nut thickness.
function NutThickness(diameter) =
  (diameter <= 64) ?
    lookup(diameter, [
      [2, 1.6],
      [2.5, 2],
      [3, 2.4],
      [3.5, 2.8],
      [4, 3.2],
      [5, 4.7],
      [6, 5.2],
      [7, 6.0],
      [8, 6.8],
      [10, 8.4],
      [12, 10.8],
      [14, 12.8],
      [16, 14.8],
      [18, 15.8],
      [20, 18.0],
      [22, 21.1],
      [24, 21.5],
     [27, 23.8],
      [30, 25.6],
      [33, 28.7],
      [36, 31.0],
      [42, 34],
      [48, 38],
      [56, 45],
      [64, 51]
    ]) :
    diameter * 51 / 64;


// This inserts a ClearanceHole with a recessed bolt hole in its children.
// The rotation vector is applied first, then the position translation,
// starting from a position upward from the z-axis at z=0.  The default
// recessed parameters fit a standard metric bolt.
module RecessedClearanceHole(diameter, height, position=[0,0,0], rotation=[0,0,0], recessed_diam=-1, recessed_height=-1, tolerance=0.4) {
  recessed_diam = (recessed_diam < 0) ?
    HexAcrossCorners(diameter) : recessed_diam;
  recessed_height = (recessed_height < 0) ? diameter : recessed_height;
  extra_height = 0.001 * height;

  difference() {
    children();
    translate(position)
      rotate(rotation)
      translate([0, 0, -extra_height/2])
      cylinder(h=height + extra_height, r=(diameter/2+tolerance));
    translate(position)
      rotate(rotation)
      translate([0, 0, -extra_height/2])
      cylinder(h=recessed_height + extra_height/2,
        r=(recessed_diam/2+tolerance));
  }
}

////// end copied from threads.scad ////


module SmoothCylinder(radius, height, smooth_rad) {
  hull() {
    translate([0, 0, smooth_rad])
    rotate_extrude(convexity=10, $fa=smooth_angle, $fs=smooth_size)
      translate([radius-smooth_rad, 0, 0])
      circle(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([0, 0, height-smooth_rad])
    rotate_extrude(convexity=10, $fa=smooth_angle, $fs=smooth_size)
      translate([radius-smooth_rad, 0, 0])
      circle(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
  }
}


module HollowCylinder(outer_rad, inner_rad, height) {
  rad_diff = outer_rad-inner_rad;
  rotate_extrude(convexity=10, $fa=smooth_angle, $fs=smooth_size)
    translate([(outer_rad+inner_rad)/2, 0, 0])
    hull() {
      translate([0, rad_diff/2, 0])
      circle(r=rad_diff/2, $fa=smooth_angle, $fs=smooth_size);
      translate([0, height-rad_diff/2, 0])
      circle(r=rad_diff/2, $fa=smooth_angle, $fs=smooth_size);
    }
}


module SmoothHole(radius, height, smooth_rad,
  position=[0,0,0], rotation=[0,0,0]) {
  extra_height = 0.002 * height;

  render()
  difference() {
    children();
    translate(position)
      rotate(rotation)
      translate([0, 0, -extra_height/2])
      difference() {
        translate([0, 0, -extra_height])
          cylinder(r=radius+smooth_rad, h=height+2*extra_height,
            $fa=smooth_angle, $fs=smooth_size);
        HollowCylinder(radius+2*smooth_rad, radius, height+extra_height);
      }
  }
}


module SmoothCube(dim, smooth_rad) {
  scalex = (smooth_rad < dim[0]/2) ? 1 : dim[0]/(2*smooth_rad);
  scaley = (smooth_rad < dim[1]/2) ? 1 : dim[1]/(2*smooth_rad);
  scalez = (smooth_rad < dim[2]/2) ? 1 : dim[2]/(2*smooth_rad);
  smoothx = smooth_rad * scalex;
  smoothy = smooth_rad * scaley;
  smoothz = smooth_rad * scalez;

  hull() {
    translate([smoothx, smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([dim[0]-smoothx, smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([smoothx, dim[1]-smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([smoothx, smoothy, dim[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([dim[0]-smoothx, dim[1]-smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([dim[0]-smoothx, smoothy, dim[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([smoothx, dim[1]-smoothy, dim[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
    translate([dim[0]-smoothx, dim[1]-smoothy, dim[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_rad, $fa=smooth_angle, $fs=smooth_size);
  }
}


module NutPocket(nom_diameter, height, position=[0,0,0], rotation=[0,0,0], tolerance=0.4, post_rot_offset=[0,0,0]) {
  pocket_tolerance = pow(3*tolerance/HexAcrossCorners(nom_diameter),2)
      + 0.75*tolerance;

  difference() {
    children();
    translate(position)
      rotate(rotation)
      translate(post_rot_offset)
      translate([0,0,-0.0005*height])
      cylinder(h=height+0.001*height,
        r = (HexAcrossCorners(nom_diameter)+pocket_tolerance)/2, $fn=6);
  }
}


module KnobWrap() {
  SmoothCylinder(knob_outer_rad, knob_width, knob_smooth_rad);
}


module SmoothRing1() {
  SmoothHole(lever_circ1_diam/2 - lever_thick, lever_width,
    round_lever_by)
    SmoothCylinder(lever_circ1_diam/2, knob_width, round_lever_by);
}


module SmoothT() {
  SmoothHole(lever_circ1_diam/2 - lever_thick, lever_width,
    round_lever_by)
  SmoothHole(lever_circ1_diam/2 - lever_thick, lever_width,
    round_lever_by, [0, lever_thick-lever_circ1_diam, 0])
  translate([-lever_circ1_diam/2 + lever_thick - 0.01,
    lever_thick-lever_circ1_diam, 0])
    cube([lever_circ1_diam/2 - lever_thick + 0.02,
      lever_circ1_diam-lever_thick, lever_width]);
}


module LeverBase1() {
  intersection() {
    SmoothRing1();
    translate([0, lever_thick-lever_circ1_diam, 0])
      cube([lever_circ1_diam/2+0.02, lever_circ1_diam-lever_thick,
        lever_width]);
  }
}


module SmoothRing2() {
  SmoothHole(lever_circ2_diam/2 - lever_thick, lever_width,
    round_lever_by)
    SmoothCylinder(lever_circ2_diam/2, knob_width, round_lever_by);
}



module LeverPart1() {
	difference() {
		LeverBase1();

    translate([0, 0, -0.1])
		rotate([0, 0, lever_intersect_angle1])
			cube([lever_circ1_diam, lever_circ1_diam, lever_width+0.2]);
	}
}


module SmoothEndingArc() {
  rotate([0, 0, lever_end_angle])
  union() {
    intersection() {
      SmoothRing2();

      translate([-lever_circ2_diam/2 - lever_thick - 0.1, 0, -0.1])
        cube([lever_circ2_diam + 2*lever_thick + 0.2,
          lever_circ2_diam/2 + lever_thick + 0.1, lever_width+0.2]);
    }


    translate([lever_circ2_diam/2 - lever_thick, -round_lever_by, 0])
      intersection() {
        SmoothCube([lever_thick, 2*round_lever_by, lever_width],
          round_lever_by);
        translate([-0.1, -0.1, -0.1])
          cube([lever_thick+0.2, round_lever_by+0.2, lever_width+0.2]);
      }
  }
}


module LeverPart2() {
  difference() {
    SmoothEndingArc();

    translate([0, 0, -0.1])
      rotate([0, 0, 180 + lever_intersect_angle1 + 0.1])
        cube([lever_circ2_diam/2 + lever_thick + 0.1,
          lever_circ2_diam/2 + lever_thick + 0.1, lever_width+0.2]);
  }
}


module Handle() {
  translate([knob_outer_rad + lever_hull_off,
    lever_circ1_diam/2 - lever_thick/2, 0])
  union() {
    LeverPart1();
    translate([lever2_offx, lever2_offy, 0])
      LeverPart2();
  }
}


module KnobToLever() {
  hull() {
    KnobWrap();
    intersection() {
      Handle();
      translate([0, -lever_thick/2-0.1, -0.1])
        cube([knob_outer_rad + lever_hull_off + 0.01,
          lever_thick+0.2, lever_width+0.2]);
    }
  }
}

module FullDoorLeverUnsplit() {
  RecessedClearanceHole(bolt_nomdiam, knob_diam,
    [bolt_offset_out, lever_midrad1, knob_width/2],
    [90, 0, 0], recessed_height=lever_midrad1 - bolt_nomlen/2
    + NutThickness(bolt_nomdiam/2) - bolt_shift_up)
  NutPocket(bolt_nomdiam, knob_diam,
    [bolt_offset_out, lever_midrad1, knob_width/2],
    [90, 0, 0],
    post_rot_offset=[0, 0, lever_midrad1 + bolt_nomlen/2
    - NutThickness(bolt_nomdiam)/2 - bolt_shift_up])
  union() {
    KnobToLever();
    Handle();
  }
}


module DoorLever() {
  rotate([0, 0, display_angle])
  difference() {
    union() {
      rotate([0, 0, -splice_angle/2])
        difference() {
          FullDoorLeverUnsplit();
          translate([-0.1, 0, -0.1])
            cube([bigval/2, bigval/2, lever_width+0.2]);
        }

      rotate([0, 0, splice_angle/2])
        difference() {
          FullDoorLeverUnsplit();
          scale([1, -1, 1]) translate([-0.1, 0, -0.1])
            cube([bigval/2, bigval/2, lever_width+0.2]);
        }
    }

    cylinder(h=3*knob_width, r=knob_diam/2, center=true, $fa=smooth_angle, $fs=smooth_size);
  }
}


DoorLever();


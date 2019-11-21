// Created in 2016 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:1689741


// Basic comb parameters
target_toothed_len = 84;
tooth_pitch = 3.2;
thickness = 4;
outer_tooth_extent = 24;
tooth_tip_angle = 30;

ellipticity_factor = 2.5;
body_width = 31;

maximum_head_curvature_radius = 350;

// override default smoothness if non-negative.  Caps out at thickness/2.
force_smoothness_level = -1;

// Handle parameters
label = "Ryan Colyer";
label_size = 5;
label_thick = 0.8;

handle_len = 80;
handle_top_width = 18;
handle_bot_width = 27;

handle_hole_diameter = 3;


// Derived parameters
tryto_smooth_handle_by = (force_smoothness_level < 0) ?
  thickness / 2 : force_smoothness_level;
num_teeth = round(target_toothed_len / tooth_pitch - 0.5);
toothed_len = tooth_pitch * (num_teeth+0.5);
tooth_rad_y = tooth_pitch/4;
tooth_rad_z = thickness/2;
min_tooth_len = outer_tooth_extent - maximum_head_curvature_radius +
  sqrt(pow(maximum_head_curvature_radius, 2)
  - pow(((num_teeth+1)/2)*tooth_pitch, 2));
smooth_handle_by = (2*tryto_smooth_handle_by >= thickness) ?
  (thickness - 0.01)/2 :
  tryto_smooth_handle_by;
unsmoothed_thickness = thickness - 2*smooth_handle_by;
base_cyl_rad = (body_width-2*smooth_handle_by)/(2*ellipticity_factor);
tooth_tip_rad = (tooth_rad_y < tooth_rad_z) ? tooth_rad_y : tooth_rad_z;
tooth_max_rad = (tooth_rad_y > tooth_rad_z) ? tooth_rad_y : tooth_rad_z;
tooth_tip_dist = (tooth_max_rad*cos(tooth_tip_angle) -
                  tooth_tip_rad*sin(90-tooth_tip_angle))
  / (tan(tooth_tip_angle))
  + tooth_tip_rad*(1-cos(90-tooth_tip_angle))
  + tooth_max_rad*sin(tooth_tip_angle);

module Tooth(tooth_len) {
  scale([-1,1,1])
  hull() {
    cube([0.01, tooth_pitch/2, thickness]);
    translate([tooth_len-tooth_tip_dist, tooth_rad_y, tooth_rad_z])
      scale([1, tooth_rad_y/tooth_rad_z, 1])
      sphere(r=tooth_rad_z, $fn=48*tooth_rad_z);
    translate([tooth_len-tooth_tip_rad, tooth_rad_y, tooth_rad_z])
      sphere(r=tooth_tip_rad, $fn=48*tooth_tip_rad);
  }
}


module MakeTeeth() {
  for (i=[1:num_teeth]) {
    tooth_len = min_tooth_len + maximum_head_curvature_radius -
      sqrt(pow(maximum_head_curvature_radius, 2)
      - pow((i-(num_teeth+1)/2)*tooth_pitch, 2));
    translate([0, (i-1) * tooth_pitch, 0])
      Tooth(tooth_len);
  }
}


module BasicComb() {
  translate([outer_tooth_extent-body_width, base_cyl_rad + smooth_handle_by, 0]) {
    minkowski() {
      translate([0, 0, smooth_handle_by/2])
        rotate([0,-90,0])
        cylinder(h=smooth_handle_by, r=smooth_handle_by/2,
          $fn=24*smooth_handle_by/2, center=true);
      difference() {
        minkowski() {
          hull() {
            translate([-(outer_tooth_extent-body_width/2), 0, 0])
              scale([ellipticity_factor,1,1])
              cylinder(h=unsmoothed_thickness, r=base_cyl_rad,
              $fn=24*base_cyl_rad);
            translate([-(outer_tooth_extent-body_width/2),
              toothed_len+smooth_handle_by, 0])
              scale([ellipticity_factor,1,1])
              cylinder(h=unsmoothed_thickness, r=base_cyl_rad,
              $fn=24*base_cyl_rad);
          }
          translate([0,0,smooth_handle_by/2])
            sphere(r=smooth_handle_by/2, $fn=24*smooth_handle_by/2);
        }
        translate([-2*outer_tooth_extent+smooth_handle_by/2, 0, -thickness])
          cube([2*outer_tooth_extent, toothed_len+smooth_handle_by, 2*thickness]);
      }
    }
    translate([0, tooth_pitch/2 + smooth_handle_by/2, 0]) MakeTeeth();
  }
}


module HandledComb() {
  BasicComb();

  minkowski() {
    difference() {
      union() {
        hull() {
          translate([-handle_bot_width/2,
            handle_bot_width/2-handle_len, 0])
            cylinder(h=unsmoothed_thickness,
              r=handle_bot_width/2-smooth_handle_by,
              $fn=24*handle_bot_width);
          translate([-handle_top_width/2,
            -handle_top_width/2 + body_width/(2*ellipticity_factor), 0])
            cylinder(h=unsmoothed_thickness,
              r=handle_top_width/2-smooth_handle_by,
              $fn=24*handle_top_width);
        }
        hull() {
          translate([-handle_top_width/2,
            -handle_top_width/2 + body_width/(2*ellipticity_factor), 0])
            cylinder(h=unsmoothed_thickness,
              r=handle_top_width/2-smooth_handle_by,
              $fn=24*handle_top_width);
          translate([outer_tooth_extent-body_width, base_cyl_rad + smooth_handle_by, 0])
            translate([-(outer_tooth_extent-body_width/2), 0, 0])
            scale([ellipticity_factor,1,1])
            difference() {
              cylinder(h=unsmoothed_thickness, r=base_cyl_rad,
                $fn=24*base_cyl_rad);
              translate([-2*base_cyl_rad, -smooth_handle_by,
                -unsmoothed_thickness])
                cube([4*base_cyl_rad,4*base_cyl_rad,
                  3*unsmoothed_thickness]);
            }
        }
      }
      if (handle_hole_diameter > 0) {
        translate([-handle_bot_width/2,
          handle_bot_width/2-handle_len, 0])
          cylinder(h=unsmoothed_thickness,
            r=handle_hole_diameter+smooth_handle_by,
            $fn=24*handle_hole_diameter);
      }
    }

    translate([0,0,smooth_handle_by])
      sphere(r=smooth_handle_by, $fn=24*smooth_handle_by);
  }

  text_pos_y_start = base_cyl_rad;
  text_pos_y_end = (handle_hole_diameter > 0) ?
    handle_bot_width/2 - handle_len + handle_hole_diameter + smooth_handle_by :
    handle_bot_width/2 - handle_len;
  text_pos_y = (text_pos_y_start + text_pos_y_end)/2;
  text_pos_x = (handle_bot_width < handle_top_width) ?
    -handle_bot_width / 2 : -handle_top_width/2;
  minkowski() {
    sphere(r=label_thick/2, $fn=24*label_thick/2);
    translate([text_pos_x-label_size/2, text_pos_y, thickness])
      rotate([0,0,-90])
      linear_extrude(height=label_thick/2)
      text(label, size=label_size, halign="center", spacing=1.2,
        $fn=24*label_size);
  }
}


//BasicComb();
HandledComb();


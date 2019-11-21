/*
 * ISO-standard metric threads, following this specification:
 *          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
 *
 * Copyright 2016 Dan Kirshner - dan_kirshner@yahoo.com
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
 *
 * Version 2.2.  2017-01-01  Correction for angle; leadfac option.  (Thanks to
 *                           Andrew Allen <a2intl@gmail.com>.)
 * Version 2.1.  2016-12-04  Chamfer bottom end (low-z); leadin option.
 * Version 2.0.  2016-11-05  Backwards compatibility (earlier OpenSCAD) fixes.
 * Version 1.9.  2016-07-03  Option: tapered.
 * Version 1.8.  2016-01-08  Option: (non-standard) angle.
 * Version 1.7.  2015-11-28  Larger x-increment - for small-diameters.
 * Version 1.6.  2015-09-01  Options: square threads, rectangular threads.
 * Version 1.5.  2015-06-12  Options: thread_size, groove.
 * Version 1.4.  2014-10-17  Use "faces" instead of "triangles" for polyhedron
 * Version 1.3.  2013-12-01  Correct loop over turns -- don't have early cut-off
 * Version 1.2.  2012-09-09  Use discrete polyhedra rather than linear_extrude ()
 * Version 1.1.  2012-09-07  Corrected to right-hand threads!
 */

// Examples.
//
// Standard M8 x 1.
// metric_thread (diameter=8, pitch=1, length=4);

// Square thread.
// metric_thread (diameter=8, pitch=1, length=4, square=true);

// Non-standard: long pitch, same thread size.
//metric_thread (diameter=8, pitch=4, length=4, thread_size=1, groove=true);

// Non-standard: 20 mm diameter, long pitch, square "trough" width 3 mm,
// depth 1 mm.
//metric_thread (diameter=20, pitch=8, length=16, square=true, thread_size=6,
//               groove=true, rectangle=0.333);

// English: 1/4 x 20.
//english_thread (diameter=1/4, threads_per_inch=20, length=1);

// Tapered.  Example -- pipe size 3/4" -- per:
// http://www.engineeringtoolbox.com/npt-national-pipe-taper-threads-d_750.html
// english_thread (diameter=1.05, threads_per_inch=14, length=3/4, taper=1/16);

// Thread for mounting on Rohloff hub.
//difference () {
//   cylinder (r=20, h=10, $fn=100);
//
//   metric_thread (diameter=34, pitch=1, length=10, internal=true, n_starts=6);
//}


// ----------------------------------------------------------------------------
function segments (diameter) = min (50, ceil (diameter*6));


// ----------------------------------------------------------------------------
// diameter -    outside diameter of threads in mm. Default: 8.
// pitch    -    thread axial "travel" per turn in mm.  Default: 1.
// length   -    overall axial length of thread in mm.  Default: 1.
// internal -    true = clearances for internal thread (e.g., a nut).
//               false = clearances for external thread (e.g., a bolt).
//               (Internal threads should be "cut out" from a solid using
//               difference ()).
// n_starts -    Number of thread starts (e.g., DNA, a "double helix," has
//               n_starts=2).  See wikipedia Screw_thread.
// thread_size - (non-standard) axial width of a single thread "V" - independent
//               of pitch.  Default: same as pitch.
// groove      - (non-standard) subtract inverted "V" from cylinder (rather than
//               add protruding "V" to cylinder).
// square      - Square threads (per
//               https://en.wikipedia.org/wiki/Square_thread_form).
// rectangle   - (non-standard) "Rectangular" thread - ratio depth/(axial) width
//               Default: 1 (square).
// angle       - (non-standard) angle (deg) of thread side from perpendicular to
//               axis (default = standard = 30 degrees).
// taper       - diameter change per length (National Pipe Thread/ANSI B1.20.1
//               is 1" diameter per 16" length). Taper decreases from 'diameter'
//               as z increases.
// leadin      - 1 (default): chamfer (45 degree) at max-z end; 0: no chamfer;
//               2: chamfer at both ends, 3: chamfer at z=0 end.
// leadfac     - scale of leadin chamfer (default: 1.0 = 1/2 thread).
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0,
                      angle=30, taper=0, leadin=1, leadfac=1.0)
{
   // thread_size: size of thread "V" different than travel per turn (pitch).
   // Default: same as pitch.
   local_thread_size = thread_size == -1 ? pitch : thread_size;
   local_rectangle = rectangle ? rectangle : 1;

   n_segments = segments (diameter);
   h = (square || rectangle) ? local_thread_size*local_rectangle/2 : local_thread_size / (2 * tan(angle));

   h_fac1 = (square || rectangle) ? 0.90 : 0.625;

   // External thread includes additional relief.
   h_fac2 = (square || rectangle) ? 0.95 : 5.3/8;

   tapered_diameter = diameter - length*taper;

   difference () {
      union () {
         if (! groove) {
            metric_thread_turns (diameter, pitch, length, internal, n_starts,
                                 local_thread_size, groove, square, rectangle, angle,
                                 taper);
         }

         difference () {

            // Solid center, including Dmin truncation.
            if (groove) {
               cylinder (r1=diameter/2, r2=tapered_diameter/2,
                         h=length, $fn=n_segments);
            } else if (internal) {
               cylinder (r1=diameter/2 - h*h_fac1, r2=tapered_diameter/2 - h*h_fac1,
                         h=length, $fn=n_segments);
            } else {

               // External thread.
               cylinder (r1=diameter/2 - h*h_fac2, r2=tapered_diameter/2 - h*h_fac2,
                         h=length, $fn=n_segments);
            }

            if (groove) {
               metric_thread_turns (diameter, pitch, length, internal, n_starts,
                                    local_thread_size, groove, square, rectangle,
                                    angle, taper);
            }
         }
      }

      // chamfer z=0 end if leadin is 2 or 3
      if (leadin == 2 || leadin == 3) {
         difference () {
            cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);

            cylinder (r2=diameter/2, r1=diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
                      $fn=n_segments);
         }
      }

      // chamfer z-max end if leadin is 1 or 2.
      if (leadin == 1 || leadin == 2) {
         translate ([0, 0, length + 0.05 - h*h_fac1*leadfac]) {
            difference () {
               cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);
               cylinder (r1=tapered_diameter/2, r2=tapered_diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
                         $fn=n_segments);
            }
         }
      }
   }
}


// ----------------------------------------------------------------------------
// Input units in inches.
// Note: units of measure in drawing are mm!
module english_thread (diameter=0.25, threads_per_inch=20, length=1,
                      internal=false, n_starts=1, thread_size=-1, groove=false,
                      square=false, rectangle=0, angle=30, taper=0, leadin=1)
{
   // Convert to mm.
   mm_diameter = diameter*25.4;
   mm_pitch = (1.0/threads_per_inch)*25.4;
   mm_length = length*25.4;

   echo (str ("mm_diameter: ", mm_diameter));
   echo (str ("mm_pitch: ", mm_pitch));
   echo (str ("mm_length: ", mm_length));
   metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts,
                  thread_size, groove, square, rectangle, angle, taper, leadin);
}

// ----------------------------------------------------------------------------
module metric_thread_turns (diameter, pitch, length, internal, n_starts,
                            thread_size, groove, square, rectangle, angle,
                            taper)
{
   // Number of turns needed.
   n_turns = floor (length/pitch);

   intersection () {

      // Start one below z = 0.  Gives an extra turn at each end.
      for (i=[-1*n_starts : n_turns+1]) {
         translate ([0, 0, i*pitch]) {
            metric_thread_turn (diameter, pitch, internal, n_starts,
                                thread_size, groove, square, rectangle, angle,
                                taper, i*pitch);
         }
      }

      // Cut to length.
      translate ([0, 0, length/2]) {
         cube ([diameter*3, diameter*3, length], center=true);
      }
   }
}


// ----------------------------------------------------------------------------
module metric_thread_turn (diameter, pitch, internal, n_starts, thread_size,
                           groove, square, rectangle, angle, taper, z)
{
   n_segments = segments (diameter);
   fraction_circle = 1.0/n_segments;
   for (i=[0 : n_segments-1]) {
      rotate ([0, 0, i*360*fraction_circle]) {
         translate ([0, 0, i*n_starts*pitch*fraction_circle]) {
            //current_diameter = diameter - taper*(z + i*n_starts*pitch*fraction_circle);
            thread_polyhedron ((diameter - taper*(z + i*n_starts*pitch*fraction_circle))/2,
                               pitch, internal, n_starts, thread_size, groove,
                               square, rectangle, angle);
         }
      }
   }
}


// ----------------------------------------------------------------------------
module thread_polyhedron (radius, pitch, internal, n_starts, thread_size,
                          groove, square, rectangle, angle)
{
   n_segments = segments (radius*2);
   fraction_circle = 1.0/n_segments;

   local_rectangle = rectangle ? rectangle : 1;

   h = (square || rectangle) ? thread_size*local_rectangle/2 : thread_size / (2 * tan(angle));
   outer_r = radius + (internal ? h/20 : 0); // Adds internal relief.
   //echo (str ("outer_r: ", outer_r));

   // A little extra on square thread -- make sure overlaps cylinder.
   h_fac1 = (square || rectangle) ? 1.1 : 0.875;
   inner_r = radius - h*h_fac1; // Does NOT do Dmin_truncation - do later with
                                // cylinder.

   translate_y = groove ? outer_r + inner_r : 0;
   reflect_x   = groove ? 1 : 0;

   // Make these just slightly bigger (keep in proportion) so polyhedra will
   // overlap.
   x_incr_outer = (! groove ? outer_r : inner_r) * fraction_circle * 2 * PI * 1.02;
   x_incr_inner = (! groove ? inner_r : outer_r) * fraction_circle * 2 * PI * 1.02;
   z_incr = n_starts * pitch * fraction_circle * 1.005;

   /*
    (angles x0 and x3 inner are actually 60 deg)

                          /\  (x2_inner, z2_inner) [2]
                         /  \
   (x3_inner, z3_inner) /    \
                  [3]   \     \
                        |\     \ (x2_outer, z2_outer) [6]
                        | \    /
                        |  \  /|
             z          |[7]\/ / (x1_outer, z1_outer) [5]
             |          |   | /
             |   x      |   |/
             |  /       |   / (x0_outer, z0_outer) [4]
             | /        |  /     (behind: (x1_inner, z1_inner) [1]
             |/         | /
    y________|          |/
   (r)                  / (x0_inner, z0_inner) [0]

   */

   x1_outer = outer_r * fraction_circle * 2 * PI;

   z0_outer = (outer_r - inner_r) * tan(angle);
   //echo (str ("z0_outer: ", z0_outer));

   //polygon ([[inner_r, 0], [outer_r, z0_outer],
   //        [outer_r, 0.5*pitch], [inner_r, 0.5*pitch]]);
   z1_outer = z0_outer + z_incr;

   // Give internal square threads some clearance in the z direction, too.
   bottom = internal ? 0.235 : 0.25;
   top    = internal ? 0.765 : 0.75;

   translate ([0, translate_y, 0]) {
      mirror ([reflect_x, 0, 0]) {

         if (square || rectangle) {

            // Rule for face ordering: look at polyhedron from outside: points must
            // be in clockwise order.
            polyhedron (
               points = [
                         [-x_incr_inner/2, -inner_r, bottom*thread_size],         // [0]
                         [x_incr_inner/2, -inner_r, bottom*thread_size + z_incr], // [1]
                         [x_incr_inner/2, -inner_r, top*thread_size + z_incr],    // [2]
                         [-x_incr_inner/2, -inner_r, top*thread_size],            // [3]

                         [-x_incr_outer/2, -outer_r, bottom*thread_size],         // [4]
                         [x_incr_outer/2, -outer_r, bottom*thread_size + z_incr], // [5]
                         [x_incr_outer/2, -outer_r, top*thread_size + z_incr],    // [6]
                         [-x_incr_outer/2, -outer_r, top*thread_size]             // [7]
                        ],

               faces = [
                         [0, 3, 7, 4],  // This-side trapezoid

                         [1, 5, 6, 2],  // Back-side trapezoid

                         [0, 1, 2, 3],  // Inner rectangle

                         [4, 7, 6, 5],  // Outer rectangle

                         // These are not planar, so do with separate triangles.
                         [7, 2, 6],     // Upper rectangle, bottom
                         [7, 3, 2],     // Upper rectangle, top

                         [0, 5, 1],     // Lower rectangle, bottom
                         [0, 4, 5]      // Lower rectangle, top
                        ]
            );
         } else {

            // Rule for face ordering: look at polyhedron from outside: points must
            // be in clockwise order.
            polyhedron (
               points = [
                         [-x_incr_inner/2, -inner_r, 0],                        // [0]
                         [x_incr_inner/2, -inner_r, z_incr],                    // [1]
                         [x_incr_inner/2, -inner_r, thread_size + z_incr],      // [2]
                         [-x_incr_inner/2, -inner_r, thread_size],              // [3]

                         [-x_incr_outer/2, -outer_r, z0_outer],                 // [4]
                         [x_incr_outer/2, -outer_r, z0_outer + z_incr],         // [5]
                         [x_incr_outer/2, -outer_r, thread_size - z0_outer + z_incr], // [6]
                         [-x_incr_outer/2, -outer_r, thread_size - z0_outer]    // [7]
                        ],

               faces = [
                         [0, 3, 7, 4],  // This-side trapezoid

                         [1, 5, 6, 2],  // Back-side trapezoid

                         [0, 1, 2, 3],  // Inner rectangle

                         [4, 7, 6, 5],  // Outer rectangle

                         // These are not planar, so do with separate triangles.
                         [7, 2, 6],     // Upper rectangle, bottom
                         [7, 3, 2],     // Upper rectangle, top

                         [0, 5, 1],     // Lower rectangle, bottom
                         [0, 4, 5]      // Lower rectangle, top
                        ]
            );
         }
      }
   }
}
// Script to create a knob for a fan, heater, etc.
// http://www.thingiverse.com/thing:2220561

// Number of sides for polygon cylinder approximation
$fn=30; 

/* [Test fit model parameters] */
// Whether a test fit model should be generated instead of the full model
test_fit_model = "no"; // [yes:Yes, no:No]
// Height of the test fit model generated
knob_test_height = 1; 

/* [Main body options and dimensions] */
// Total height of the knob excluding the rounded top if applicable
knob_height = 20; 
// Diameter of the bottom section of the knob
knob_diameter = 60; 
// Fraction of knob height below chamfer
knob_bot_height_fraction = .1; 
// Fraction of knob height used for chamfer
knob_chamfer_height_fraction = .1; 
// Fraction of knob_diameter to be used for the diameter of the top of the knob (>0.0)
knob_top_daimeter_fraction = .95; 
// To be equally spaced around the top of the knob's perimeter
number_of_cutouts = 16; 
// Fraction of the diameter of the knob (knob_diameter)
diameter_of_cutouts = .1;
rounded_top = "no"; // [yes:Yes, no:No]
rounded_top_radius_multiplier = 5;

/* [Hole/Shaft options and dimensions] */
hole_type = "circle"; // [circle:Circle, polygon:Polygon]
// Diameter or side length of the hole (absolute)
hole_dimension = 0; 
// Fraction of total height (knob_height not including rounded top)
hole_height_fraction = .5; 
/* [Polygon hole only options] */
// Number of sides for the hole polygon (>= 3)
n_polygon_sides = 4; // [3:10]
/* [Circle hole only options] */
circle_hole_subtype = "full"; // [full:Full, D:D, keyway:Keyway]
// Fraction of the circle to be cutoff if the D subtype is selected
hole_cutoff_fraction = .4; 
// Width of the keyway (absolute)
hole_key_width = .5;
// Depth at edge intersection with circle (positive to cut notch into cylinder, negative to add a notch on the outside of the cylinder) (absolute)
hole_key_depth = .5; 

/* [Location indicator mark options] */
// Yes will cut a half circle mark into the knob and no will add a half circle mark to the outside of the knob
mark_cutout = "no"; // [yes:Yes, no:No]
top_location_mark = "no"; // [yes:Yes, no:No]
side_bot_location_mark = "no"; // [yes:Yes, no:No]
side_top_location_mark = "no"; // [yes:Yes, no:No]
// Degrees starting from the x-axis (cutouts will be rotated so the mark falls between them)
mark_angle = 0; 
// Fraction of knob_diameter
mark_diameter_fraction = .05; 

// End data input
// Some calculated quantities
knob_r = knob_diameter / 2;
knob_r2 = knob_top_daimeter_fraction * knob_r;
cutout_angle = 360 / number_of_cutouts;
knob_bot_height = knob_height * knob_bot_height_fraction;
knob_chamfer_height = knob_height * knob_chamfer_height_fraction;
knob_chamfer_top_height = knob_bot_height + knob_chamfer_height;
knob_cutout_height = knob_height - knob_chamfer_top_height;
cutout_offset_angle = cutout_angle - mark_angle - cutout_angle*floor(mark_angle/cutout_angle) - cutout_angle/2;
chamfer_angle = atan((knob_r-knob_r2)/knob_chamfer_height);

rounded_top_radius = rounded_top_radius_multiplier*knob_r2;
// Calculate the z offset for the sphere so that just
//  the desired portion is above the z=0 plane
z_offset = sqrt(rounded_top_radius*rounded_top_radius - knob_r2*knob_r2);
// Calculate the height of the knob including the rounded top
knob_max_height = knob_height + rounded_top_radius - z_offset;

module main_body() {
  if (test_fit_model == "no") {
    difference() {
      union() {
        cylinder(r=knob_r, h=knob_bot_height);
        translate([0, 0, knob_bot_height])
          cylinder(r1=knob_r, r2=knob_r2, h=knob_chamfer_height);
        translate([0, 0, knob_chamfer_top_height])
          cylinder(r=knob_r2, h=knob_cutout_height);
        if (rounded_top == "yes") {
          translate([0, 0, knob_height])
            intersection() {
              translate([0, 0, -z_offset])
                sphere(r=rounded_top_radius, $fn=2*$fn);
              cylinder(r=knob_r2, h=knob_height);
            };
        };
      };
      if (knob_r >= knob_r2) {
        for(i = [0:number_of_cutouts-1]) {
          translate([knob_r2*cos(i*cutout_angle-cutout_offset_angle), knob_r2*sin(i*cutout_angle-cutout_offset_angle), knob_chamfer_top_height])
            cylinder(d=diameter_of_cutouts*knob_diameter, h= knob_cutout_height * 1.5);
        }
      }
      else {
        for(i = [0:number_of_cutouts-1]) {
          translate([knob_r2*cos(i*cutout_angle-cutout_offset_angle), knob_r2*sin(i*cutout_angle-cutout_offset_angle), knob_bot_height])
            cylinder(d=diameter_of_cutouts*knob_diameter, h= knob_height * 1.5);
        }
      }
    };
  }
  else {
    cylinder(r=knob_r, h=knob_test_height);
  }
};
//main_body();

module hole() {
  hole_dim = hole_dimension;
  hole_height = knob_height * hole_height_fraction;
  key_offset = sqrt((hole_dim*hole_dim-hole_key_width*hole_key_width)/4);
  if (hole_type == "circle") {
    difference() {
      union() {
        translate([0, 0, -.1])
          cylinder(d=hole_dim, h = hole_height+.1);
        if (circle_hole_subtype == "keyway" && hole_key_depth < 0) {
          translate([key_offset, -hole_key_width/2, -.1])
            cube([-hole_key_depth, hole_key_width, hole_height+.1]);
        }
      }
      if (circle_hole_subtype == "D") {
        translate([hole_dim/2 - hole_dim*hole_cutoff_fraction, -hole_dim/2, -.2])
          cube([hole_dim, hole_dim, hole_height+.4]);
      }
      else if (circle_hole_subtype == "keyway"){
        translate([key_offset - hole_key_depth, -hole_key_width/2, -.2])
          cube([hole_dim, hole_key_width, hole_height+.4]);
      }
    }
  }
//  else if (hole_type == "square") {
//    translate([-hole_dim/2, -hole_dim/2, -.1])
//    cube([hole_dim, hole_dim, hole_height+.1]);
//  }
  else if (hole_type == "polygon") {
    if (n_polygon_sides < 3) {
      DisplayText("ERROR - the number of polygon points must be at least 3 for polygon holes.");    
    }
//    // Determine the radius of the circle on which the polygon will be inscribed
    r_hole = hole_dim / (2*sin(180/n_polygon_sides));
//    angle1 = 360 / n_polygon_sides;
//    // Calculate the points of the polygon using trig  
//    poly_points = [for (i = [0:n_polygon_sides-1]) let (x = r_hole*cos(i*angle1), y = r_hole*sin(i*angle1)) [x, y] ];
//    linear_extrude(height=2*hole_height, center=true)
//      polygon(points=poly_points);
    cylinder(r=r_hole, h=2*hole_height, center=true, $fn=n_polygon_sides);
  }
}
//hole();

module marks() {
  mark_r = knob_r * mark_diameter_fraction;
  x_edge = knob_r*cos(mark_angle);
  y_edge = knob_r*sin(mark_angle);
  x_edge2 = knob_r2*cos(mark_angle);
  y_edge2 = knob_r2*sin(mark_angle);
  
  x_edge3 = (knob_r)*cos(mark_angle);
  y_edge3 = (knob_r)*sin(mark_angle);
  x_edge4 = (knob_r2)*cos(mark_angle);
  y_edge4 = (knob_r2)*sin(mark_angle);
  
  x_edge5 = mark_r*cos(mark_angle);
  y_edge5 = mark_r*sin(mark_angle);
  if (test_fit_model == "no") {
    if (top_location_mark == "yes") {
      if (rounded_top == "yes") {
        angle1 = 360*mark_r/(2*rounded_top_radius*PI);
        angle2 = atan((knob_r2)/z_offset)+angle1/2;
        echo(angle1, angle2);
        translate([0, 0, knob_max_height+mark_r])
          color("RoyalBlue")
            rotate([0, 0, mark_angle-90])
              rotate([0, -90, 0])
                wedge_slice(mark_r, rounded_top_radius, angle1, angle2);
        translate([x_edge5, y_edge5, knob_max_height])
          color("RoyalBlue")
            sphere(r=mark_r);
      }
      else {
        translate([x_edge2, y_edge2, knob_height])
          color("RoyalBlue")
            rotate([0, 0, 180+mark_angle])
              rotate([0, 90, 0])
                cylinder(r=mark_r, h=knob_r2-mark_r);
        translate([x_edge5, y_edge5, knob_height])
          color("RoyalBlue")
            sphere(r=mark_r);
      }
    }
    if (side_bot_location_mark == "yes") {
      translate([x_edge, y_edge, -.1])
        color("RoyalBlue")
          cylinder(r=mark_r, h=knob_bot_height+.1);
    }
    if (side_top_location_mark == "yes") {
      translate([x_edge2, y_edge2, knob_chamfer_top_height])
        color("RoyalBlue")
          cylinder(r=mark_r, h=knob_cutout_height+.1);
      translate([x_edge2, y_edge2, knob_height])
        color("RoyalBlue")
          sphere(r=mark_r);  
    }
    if (side_bot_location_mark == "yes" || side_top_location_mark == "yes") {
      difference() {
        union() {
          // Bottom shpere
          translate([x_edge3, y_edge3, knob_bot_height])
            color("RoyalBlue")
              sphere(r=mark_r);   
          // Top sphere
          translate([x_edge4, y_edge4, knob_chamfer_top_height])
            color("RoyalBlue")
              sphere(r=mark_r);
          // Chamfer mark cylinder
          translate([x_edge, y_edge, knob_bot_height])
            color("RoyalBlue")
              rotate([0, 0, 180+mark_angle])
                rotate([0, chamfer_angle, 0])
                  cylinder(r=mark_r, h=(knob_r-knob_r2)/sin(chamfer_angle));
        }
        if (side_top_location_mark == "no") {
          if (knob_r >= knob_r2) {
            cylinder(r=knob_r2, h=knob_height);
          }
          else {
            translate([0, 0, knob_chamfer_top_height])
              cylinder(r=knob_r2, h=knob_cutout_height);
          }
        }
      }
    }
  }
  else {
    // Top
    translate([x_edge, y_edge, knob_test_height])
      color("RoyalBlue")
        rotate([0, 0, 180+mark_angle])
          rotate([0, 90, 0])
            cylinder(r=mark_r, h=knob_r-mark_r);
    // Corner
    translate([x_edge3, y_edge3, knob_test_height])
      color("RoyalBlue")
        sphere(r=mark_r);
    // Side
    translate([x_edge, y_edge, -.1])
      color("RoyalBlue")
        cylinder(r=mark_r, h=knob_test_height+.1);
  }
}
//marks();

module wedge_slice(radius1, radius2, angle1, angle2) {
  // Generate a cylindrical wedge slice of requested radius and angle
  // New versions Openscad can do this trivially with the angle argument for rotate extrude...
//  rotate_extrude(angle=angle1)
//   translate([radius2, 0]) circle(r=radius1);
  wedge_length = (radius1+radius2);
  wedge_height1 = wedge_length*sin(angle1);
  wedge_height2 = wedge_length*sin(angle2);
  translate([-wedge_length, 0, 0])
    intersection() {
      rotate_extrude($fn=2*$fn) translate([radius2, 0]) circle(r=radius1);
      linear_extrude(height=2*radius1, center=true)
        polygon([[0, 0], [wedge_length, wedge_height2], [wedge_length, wedge_height1]]);
  }
}

module DisplayText(s) {
  // Borrowed from https://www.thingiverse.com/thing:1695289
  rotate([0,0,45])
    rotate([80,0,0])
      text(s, font = "Liberation Sans");
  echo();
  echo(s);
  echo();
}

module knob() {
  if (mark_cutout == "yes") {
    difference() {
      main_body();
      hole();
      difference() {
        marks();
        // Subtract off an enlarged hole to ensure the mark doesn't interfere with test fitting
        if (test_fit_model == "yes") scale([1.3, 1.3, 1]) hole();
      }
    }
  }
  else {
    difference() {
      union() {
        main_body();
        difference() {
          marks();
          if (test_fit_model == "yes") scale([1.3, 1.3, 1]) hole();
        }
      }
      hole();
    }
  }
}


translate([0,0,-125])
union(){ 
    difference(){
    color ("green")
    cylinder (129, 20,20);
    color ("purple")
    minkowski(){
        metric_thread (diameter=30, pitch=20,    length=130, thread_size=25,square=true,    groove=true, rectangle=.365);
        cube(0.5,true);
    }
    translate([-2.5,0,0])
    color("blue")
    cube([5,25,125]);
}
    difference(){
    translate([0,0,0.05])
    rotate([0,180,0])
    knob();
    translate ([0,0,-12])
    color("red")
    cylinder(25,2.25,2.25,true);
    translate ([0,0,-1.824])
    color("green")
    cylinder(3.75,0,3.75,true);
}
}
//
// cover for wire though hole in cabinet or table etc
//
//  design by egil kvaleberg, 18 feb 2016
//  thread library by Dan Kirshner - dan_kirshner@yahoo.com

//



part = "section"; // [ frame, frame_upper, frame_lower, plug, section ]

// diameter of hole in material (allow for tolerance)
hole_dia = 66.0;
// thickness of material
hole_depth = 17.2;
// width of flange
lip = 5.0;
// diameter of wire to fit
wire_dia = 12.0;

// wall thickness of frame (inc. threads)
framewall = 4.0;
// flange wall thickness
wall = 1.2;

// have flange on both sides (requiring threads)? 
have_lower_frame = 1; // [[ 1:true, 0:false ]

// 0.0 for wire hole in centre
wire_hole_offset = 20.0;
// tolerance for fit
tol = 0.7;
// thread pitch
t_pitch = 1.75;
// number of thread starts, 1 or more
t_starts = 6;

// optional: cut in upper lip, left side, 0 if none
lip_cut_left = 0; // lip-(-1.0);
// optional: cut in lip, top side
lip_cut_top = 0; // lip-2.2;

/* [Hidden] */
t_angle = 45; // 30 is std, but 45 prints better
step = 2*wall;
fn = 180;

d = 0.01;


module frame() {
    difference () {
        union () {
            cylinder(d=hole_dia, h=hole_depth+d, $fn=120);
            translate([0,0,hole_depth]) cylinder(d=hole_dia+2*lip, h=wall, $fn=fn); // upper frame
            if (have_lower_frame) translate([0,0,-wall]) cylinder(d=hole_dia+2*lip, h=wall, $fn=fn); // lower frame
        }
        union () {
            translate([0,0,-wall-d]) cylinder(d=hole_dia-2*framewall-2*step, h=d+wall+hole_depth+wall+d, $fn=fn);
            translate([0,0,step]) cylinder(d1=hole_dia-2*framewall-2*step, d2=hole_dia-2*framewall, h=step+d, $fn=fn);
            translate([0,0,2*step]) cylinder(d=hole_dia-2*framewall, h=hole_depth+wall+d-2*step, $fn=fn);
            
            // extra cuts for wall, optional
            translate([-hole_dia/2,hole_dia/2 + lip-lip_cut_top,hole_depth-d]) cube([hole_dia,hole_dia,wall+2*d]);
            translate([-3*hole_dia/2 +lip_cut_left-lip,-hole_dia/2,hole_depth-d]) cube([hole_dia,hole_dia,wall+2*d]);            
            
        }
    }
}

module threads(is_internal) {
    translate([0,0,hole_depth*0.3-tol]) 
        metric_thread (diameter=hole_dia-framewall-tol+1.2*t_pitch + (is_internal ? 0:-1)*2*tol, 
                    pitch=t_pitch, length=hole_depth*0.4+tol, internal=is_internal,
                    n_starts=t_starts, angle=t_angle);
}

module frame1() {
    intersection () {
        frame();
        translate([0,0,-wall-d]) union () {          
            cylinder(d=hole_dia+2*lip, h=d+wall+hole_depth*0.3-tol, $fn=fn);
            cylinder(d=hole_dia-framewall-tol-t_pitch*0.5, h=d+wall+hole_depth*0.7, $fn=fn);
            translate([0,0,wall+d]) threads(false);
        }
    }
}

module frame2() {
    intersection () {
        frame();
        difference () {          
            translate([0,0,hole_depth*0.3]) cylinder(d=hole_dia+2*lip, h=hole_depth*0.7+wall+d, $fn=fn);
            union () {
                cylinder(d=hole_dia-framewall+tol-t_pitch*0.5, h=hole_depth*0.7+tol, $fn=fn);
                threads(true);
            }
        }
    }
}

module plug() {
    difference () {
        union () {
            if (have_lower_frame) translate([0,0,-wall]) cylinder(d=hole_dia-2*framewall-2*tol-2*step, h=wall+d, $fn=fn);
            cylinder(d=hole_dia-2*framewall-2*tol-2*step, h=hole_depth+wall, $fn=fn);
            translate([0,0,step]) cylinder(d1=hole_dia-2*framewall-2*tol-2*step, d2=hole_dia-2*framewall-2*tol, h=step+d, $fn=fn);
            translate([0,0,2*step]) cylinder(d=hole_dia-2*framewall-2*tol, h=hole_depth+wall-2*step, $fn=fn);
        }
        union () {
            translate([0,wire_hole_offset,-wall-d]) cylinder(d=wire_dia+2*tol, h=hole_depth+2*wall+2*d, $fn=fn);
            translate([-wire_dia/2-tol,wire_hole_offset,-wall-d]) cube([wire_dia+2*tol, hole_dia/2, hole_depth+2*wall+2*d]);
        }
    }
}

if (part=="section") {
    difference() {
        union() {
            frame1();
            frame2(); 
            plug();
        }
        translate([-hole_dia,-2*hole_dia,-d-wall]) cube([2*hole_dia,2*hole_dia,hole_depth+2*wall+2*d]);
    }
} 
if (part=="frame") rotate([180,0,0]) frame(); 
if (part=="frame_upper") frame1(); 
if (part=="frame_lower") rotate([180,0,0]) frame2(); 
if (part=="plug") plug();
    


////////////////////////////////////////////////////////////////////////////
/* http://dkprojects.net/openscad-threads/
 *
 * ISO-standard metric threads, following this specification:
 *          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
 *
 * Dan Kirshner - dan_kirshner@yahoo.com
 *
 * You are welcome to make free use of this software.  Retention of my
 * authorship credit would be appreciated.
 *
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

// Thread for mounting on Rohloff hub.
//difference () {
//   cylinder (r=20, h=10, $fn=100);
//
//   metric_thread (diameter=34, pitch=1, length=10, internal=true, n_starts=6);
//}


// ----------------------------------------------------------------------------
function segments (diameter) = min (50, ceil (diameter*6));


// ----------------------------------------------------------------------------
// internal -    true = clearances for internal thread (e.g., a nut).
//               false = clearances for external thread (e.g., a bolt).
//               (Internal threads should be "cut out" from a solid using
//               difference ()).
// n_starts -    Number of thread starts (e.g., DNA, a "double helix," has
//               n_starts=2).  See wikipedia Screw_thread.
// thread_size - (non-standard) size of a single thread "V" - independent of
//               pitch.  Default: same as pitch.
// groove      - (non-standard) subtract inverted "V" from cylinder (rather than
//               add protruding "V" to cylinder).
// square      - Square threads (per 
//               https://en.wikipedia.org/wiki/Square_thread_form).
// rectangle   - (non-standard) "Rectangular" thread - ratio depth/width
//               Default: 1 (square).
// angle       - (non-standard) angle (deg) of thread side from perpendicular to
//               axis (default = standard = 30 degrees).
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0,
                      angle=30)
{
   // thread_size: size of thread "V" different than travel per turn (pitch).
   // Default: same as pitch.
   local_thread_size = thread_size == -1 ? pitch : thread_size;
   local_rectangle = rectangle ? rectangle : 1;

   n_segments = segments (diameter);
   h = (square || rectangle) ? local_thread_size*local_rectangle/2 : local_thread_size * cos (angle);

   h_fac1 = (square || rectangle) ? 0.90 : 0.625;

   // External thread includes additional relief.
   h_fac2 = (square || rectangle) ? 0.95 : 5.3/8;

   if (! groove) {
      metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                           local_thread_size, groove, square, rectangle, angle);
   }

   difference () {

      // Solid center, including Dmin truncation.
      if (groove) {
         cylinder (r=diameter/2, h=length, $fn=n_segments);
      } else if (internal) {
         cylinder (r=diameter/2 - h*h_fac1, h=length, $fn=n_segments);
      } else {

         // External thread.
         cylinder (r=diameter/2 - h*h_fac2, h=length, $fn=n_segments);
      }

      if (groove) {
         metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                              local_thread_size, groove, square, rectangle,
                              angle);
      }
   }
}


// ----------------------------------------------------------------------------
// Input units in inches.
// Note: units of measure in drawing are mm!
module english_thread (diameter=0.25, threads_per_inch=20, length=1,
                      internal=false, n_starts=1, thread_size=-1, groove=false,
                      square=false, rectangle=0)
{
   // Convert to mm.
   mm_diameter = diameter*25.4;
   mm_pitch = (1.0/threads_per_inch)*25.4;
   mm_length = length*25.4;

   echo (str ("mm_diameter: ", mm_diameter));
   echo (str ("mm_pitch: ", mm_pitch));
   echo (str ("mm_length: ", mm_length));
   metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts, 
                  thread_size, groove, square, rectangle);
}

// ----------------------------------------------------------------------------
module metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                            thread_size, groove, square, rectangle, angle)
{
   // Number of turns needed.
   n_turns = floor (length/pitch);

   intersection () {

      // Start one below z = 0.  Gives an extra turn at each end.
      for (i=[-1*n_starts : n_turns+1]) {
         translate ([0, 0, i*pitch]) {
            metric_thread_turn (diameter, pitch, internal, n_starts, 
                                thread_size, groove, square, rectangle, angle);
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
                           groove, square, rectangle, angle)
{
   n_segments = segments (diameter);
   fraction_circle = 1.0/n_segments;
   for (i=[0 : n_segments-1]) {
      rotate ([0, 0, i*360*fraction_circle]) {
         translate ([0, 0, i*n_starts*pitch*fraction_circle]) {
            thread_polyhedron (diameter/2, pitch, internal, n_starts, 
                               thread_size, groove, square, rectangle, angle);
         }
      }
   }
}


// ----------------------------------------------------------------------------
// z (see diagram) as function of current radius.
// (Only good for first half-pitch.)
function z_fct (current_radius, radius, pitch, angle)
   = 0.5* (current_radius - (radius - 0.875*pitch*cos (angle)))
                                                       /cos (angle);

// ----------------------------------------------------------------------------
module thread_polyhedron (radius, pitch, internal, n_starts, thread_size,
                          groove, square, rectangle, angle)
{
   n_segments = segments (radius*2);
   fraction_circle = 1.0/n_segments;

   local_rectangle = rectangle ? rectangle : 1;

   h = (square || rectangle) ? thread_size*local_rectangle/2 : thread_size * cos (angle);
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

   z0_outer = z_fct (outer_r, radius, thread_size, angle);
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

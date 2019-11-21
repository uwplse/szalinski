// rod clamp customizable Angus Ainslie 2017 (c)

//include <threads.scad>

/*[clamp]*/
//
clamp_length=60;
clamp_height=36;
clamp_width=40;
clamp_thickness=10;
/*[bolt&press]*/
knob_length=25;
knob_diameter=20;
screw_diameter=14;
press_diameter=20;
/*[visibility]*/
show_bolt=0; //[0:No,1:Yes]
show_press=0; //[0:No,1:Yes]
show_clamp=1; //[0:No,1:Yes]
show_left_brace=1; //[0:No,1:Yes]
show_right_brace=0; //[0:No,1:Yes]
//don't print assembled!!! :)
show_assembled=0; //[0:No,1:Yes]
/*[rod_mount]*/
positions=12;

/*[hidden]*/
screw_length=clamp_length*0.70-8;
rounding=2;
length=clamp_length-rounding*2;
height=clamp_height-rounding*2;
width=clamp_width-rounding*2;
thickness=clamp_thickness-rounding*2;
hole_shift=width-15;
radius=1.7;//corners;
diameter_ball=8;
shrink_adjust=1.04;


if (show_assembled)rotate([0,0,180]){
  base();
  translate([-knob_length-radius*thickness-rounding-10,hole_shift,clamp_height/2]){
    rotate([0,90,0])bolt();
    translate([knob_length+screw_length+5+8,0,0])rotate([0,-90,0])press();
  }
}else{
  if(show_clamp)
    base();
  if(show_press)
    translate([30,width+20,0])press();
  if(show_bolt)
    translate([0,width+20,0])bolt();
}

module corner(tr){
  intersection(){
    difference(){
      cylinder(r=tr,h=height,$fn=64);
      translate([0,0,-.1])
        cylinder(r=thickness*(radius-1),h=height+.2,$fn=32);
    }
    translate([-tr,-tr,0])cube([tr,tr,height]); 
  }
}

module rod_mount() {
    difference() {
        union() { 
            cylinder( d=33*shrink_adjust, h=46*shrink_adjust );
        }
        union() {
            cylinder( d=23*shrink_adjust, h=46*shrink_adjust );
            translate([0,0,36*shrink_adjust]) cylinder( d=26*shrink_adjust, h=10*shrink_adjust );
        }
    }
    
    for( i = [ 0: 360/positions: 360 ] )
    rotate( [0,0,i+15 ] ) translate([11.5*shrink_adjust,-1.25,36]) cube( [ 2.5, 2.5, 10] );

    translate([10*shrink_adjust,-1.5,19.5]) cube( [ 2, 3, 5.5] );
}


module base(){
  difference() {
  union() {
      translate([0,0,rounding])
        difference(){
        minkowski(){
          assign(tr=thickness*radius,ti=thickness*(radius-1))union(){
            corner(tr);
            translate([-tr,0,0])cube([thickness,width,height]);
            translate([0,-tr,0])cube([length-ti*2,thickness,height]);
            translate([length-ti*2,0,0])rotate([0,0,90])corner(tr);
            translate([length-ti,0,0])cube([thickness,width,height]);
          }
          sphere(r=rounding,$fn=16);
        }
        translate([0,width-8,height/2])rotate([0,-90,0]) english_thread (diameter=1/4, threads_per_inch=20, length=1, internnal=true);
  
    }
  
    translate( [length-15,width-10,2] ) cube([15,10,height]);
  }
  translate( [(clamp_length-clamp_thickness)/2,0, clamp_height/2]) rotate([90,0,0]) cylinder( d=30, h=clamp_thickness*2 );
  }
  translate( [(clamp_length-clamp_thickness)/2,0, clamp_height/2]) rotate([90,0,0]) rod_mount();
  
  translate([-(thickness-rounding),-(thickness-rounding),height-2] ) brace();
  translate([-(thickness-rounding),-(thickness-rounding),2] ) brace(); 
     
}

module brace() {
  if ( show_left_brace || show_right_brace )
  difference() {
      union() {
        if( show_right_brace )
            cube([length/2,width,4]);
        if( show_left_brace )
            translate([length/2,0,0]) cube([length/2,width,4]);
      }
 
      translate([length/2,0,0]) rotate([0,0,45]) cube([length,length,4]);
  }
}

module bolt(){
    knurled_cyl(knob_length, knob_diameter, 2.5, 2.5, 1, 2, 10);
    translate([0,0,knob_length]) english_thread (diameter=1/4, threads_per_inch=20, length=screw_length);
    translate([0,0,knob_length+screw_length])cylinder(h=6,d=6,$fn=30);
}
module rounded(h=5,d=20,r=2){
  translate([0,0,r])
    minkowski(){
      cylinder(d=d-r*2,h=h-r*2);
      sphere(r=r);
    }
}
module press(){
    assign($fn=32)
    difference(){
      union(){
        rounded(h=5,d=press_diameter,r=1);
        rounded(h=10,d=14,r=1);
        difference() {
            translate([0,15,5]) rotate([90,0,0]) cylinder(d=22,h=30);
            translate([-11,16,5]) rotate([90,0,0]) cube([22,22,32]);
        }
        }
      translate([0,0,4]) cylinder(d=6.35*shrink_adjust,h=30);
      //translate([0,0,10-2])sphere(d=diameter_ball+.6);
      //for (i=[0,120,240])
      //  translate([0,0,6.5])rotate([90,0,90+i])hull(){
      //    cylinder(d=3,h=10);
      //    translate([0,5,0])cylinder(d=3,h=10);
      //  }
    }
}






/*
 * knurledFinishLib.scad
 * 
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:9095
 *
 * Usage:
 *
 *    knurled_cyl( Knurled cylinder height,
 *                 Knurled cylinder outer diameter,
 *                 Knurl polyhedron width,
 *                 Knurl polyhedron height,
 *                 Knurl polyhedron depth,
 *                 Cylinder ends smoothed height,
 *                 Knurled surface smoothing amount );
 */
module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
{
    cord=(cod+cdp+cdp*smt/100)/2;
    cird=cord-cdp;
    cfn=round(2*cird*PI/cwd);
    clf=360/cfn;
    crn=ceil(chg/csh);

    intersection()
    {
        shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

        translate([0,0,-(crn*csh-chg)/2])
          knurled_finish(cord, cird, clf, csh, cfn, crn);
    }
}

module shape(hsh, ird, ord, fn4, hg)
{
        union()
        {
            cylinder(h=hsh, r1=ird, r2=ord, $fn=fn4, center=false);

            translate([0,0,hsh-0.002])
              cylinder(h=hg-2*hsh+0.004, r=ord, $fn=fn4, center=false);

            translate([0,0,hg-hsh])
              cylinder(h=hsh, r1=ord, r2=ird, $fn=fn4, center=false);
        }

}

module knurled_finish(ord, ird, lf, sh, fn, rn)
{
    for(j=[0:rn-1])
    assign(h0=sh*j, h1=sh*(j+1/2), h2=sh*(j+1))
    {
        for(i=[0:fn-1])
        assign(lf0=lf*i, lf1=lf*(i+1/2), lf2=lf*(i+1))
        {
            polyhedron(
                points=[
                     [ 0,0,h0],
                     [ ord*cos(lf0), ord*sin(lf0), h0],
                     [ ird*cos(lf1), ird*sin(lf1), h0],
                     [ ord*cos(lf2), ord*sin(lf2), h0],

                     [ ird*cos(lf0), ird*sin(lf0), h1],
                     [ ord*cos(lf1), ord*sin(lf1), h1],
                     [ ird*cos(lf2), ird*sin(lf2), h1],

                     [ 0,0,h2],
                     [ ord*cos(lf0), ord*sin(lf0), h2],
                     [ ird*cos(lf1), ird*sin(lf1), h2],
                     [ ord*cos(lf2), ord*sin(lf2), h2]
                    ],
                triangles=[
                     [0,1,2],[2,3,0],
                     [1,0,4],[4,0,7],[7,8,4],
                     [8,7,9],[10,9,7],
                     [10,7,6],[6,7,0],[3,6,0],
                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
                    ],
                convexity=5);
         }
    }
}

/*
 * ISO-standard metric threads, following this specification:
 *          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
 *
 * Dan Kirshner - dan_kirshner@yahoo.com
 *
 * You are welcome to make free use of this software.  Retention of my
 * authorship credit would be appreciated.
 *
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
// taper       - diameter change per length (National Pipe Thread/ANSI B1.20.1
//               is 1" diameter per 16" length).
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0,
                      angle=30, taper=0)
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
                           local_thread_size, groove, square, rectangle, angle,
                           taper);
   }

   difference () {

      // Solid center, including Dmin truncation.
      tapered_diameter = diameter - length*taper;
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


// ----------------------------------------------------------------------------
// Input units in inches.
// Note: units of measure in drawing are mm!
module english_thread (diameter=0.25, threads_per_inch=20, length=1,
                      internal=false, n_starts=1, thread_size=-1, groove=false,
                      square=false, rectangle=0, angle=30, taper=0)
{
   // Convert to mm.
   mm_diameter = diameter*25.4;
   mm_pitch = (1.0/threads_per_inch)*25.4;
   mm_length = length*25.4;

   echo (str ("mm_diameter: ", mm_diameter));
   echo (str ("mm_pitch: ", mm_pitch));
   echo (str ("mm_length: ", mm_length));
   metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts, 
                  thread_size, groove, square, rectangle, angle, taper);
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
            current_diameter = diameter - taper*(z + i*n_starts*pitch*fraction_circle);
            thread_polyhedron (current_diameter/2, pitch, internal, n_starts, 
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



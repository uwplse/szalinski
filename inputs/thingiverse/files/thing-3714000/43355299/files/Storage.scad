
//
// Customizable Stackable Storage Container
//
// This part was designed June 2019 by Joe McKeown. 
// It's available under the terms of the Creative Commons CC-BY 4.0 license 
// (https://creativecommons.org/licenses/by/4.0/)
// 
// This project uses threads.scad library by Dan Kirshner (dan_kirshner@yahoo.com) 
// hosted at http://dkprojects.net/openscad-threads/ This library is intended to be
// accessed via the OpenSCAD use directive
// use <../lib/threads.scad>
// BUT Thingiverse Customizer does not support the use directive, so the library
// is manually included via cut-and-paste, probably the wost way of including a 
// library but c'est la vie.
//
// Joe's Customizable Stackable Storage Container is covered by the 
// "Works for Me Guarantee" (tm) That means it works for me, but you're on your own.
//

// History:
// V1.0 25 Jun 2019 First Release
// V1.1  2 Jul 2019 Added SD card holder

// Which Part(s) to create:
part = "starter"; // [starter:Starter Kit, cap:Cap, base:Base, addon:Add On Container, sd:SD Card Holder]

// Diameter of the Box
OuterDiameter=80;

// Additional height to add to the container
Extra_Height = 0; // [100]

// Split the containr into this number of partitions
Number_of_Partitions = 1; //[1:8]



/* [Hidden] */
Bevel=5;
InnerDiameter=OuterDiameter-Bevel-7; //Keep InnerDiameter < OuterDiameter - Bevel
ThreadPitch=4;
ThreadHeight=10;
ThreadMargin=1.5;
BaseThick=1.5;
LevelHeight=ThreadHeight+Bevel;

// Use more precision for rendering. UNFORTUNATELY $preview=undef before 2019.05
// So if you're seeing this, and are still on older versions your preview time
// will suck ass. Please upgrade.
$fn = $preview ? 0 : 100;
if (version()[0] < 2019 ) echo("Your version of OpenSCAD is old. Please Upgrade");


if (part == "starter")
    StarterKit(Extra_Height, Number_of_Partitions);
else if (part == "cap")
    Cap();
else if (part == "base")
    Base(Extra_Height, Number_of_Partitions);
else if (part == "addon")
    Container(Extra_Height, Number_of_Partitions);
else if (part == "sd")
    SDCardHolder();


/*
 * Create and SD Card holder compatible with the rest of the system
 */
module SDCardHolder(){
   SD=[25,3,32]; // spec size of SD card (plus some margin)
   InnerRadius = InnerDiameter/2;
   offsX = InnerRadius - SD[0] -1; // Offset of card along X-axis 
   offsTheta = 1;
   overallCardHeight = SD[2] + BaseThick + 2;
   exDepth = overallCardHeight - ThreadHeight - Bevel;
   topSpace=10;
   // Circumference of the circle at offsX = 2*PI*Offsx
   // we want an arc of SD[1] + offsTheta
   numCards = floor((2 * PI * offsX) / (SD[1] + offsTheta));
   echo(str("Inner Radius = ", InnerRadius));
      difference(){
         union(){
               LowerThreads();
               translate([0,0,LevelHeight])
                  cylinder(d=OuterDiameter, h=exDepth);
               translate([0,0,LevelHeight+exDepth])
                  UpperThreads();
         }
         translate([0,0,overallCardHeight-topSpace])
            cylinder(d=InnerDiameter, h=topSpace +0.01);
         for (theta = [0:360/numCards:360])
            rotate(theta)
               translate([offsX, -SD[1]/2, BaseThick])
                  color("red")cube(SD);
      }
}

/*
 * The main module. This creates a single container. 
 * Extra Depth can be added via the exDepth parameter.
 * The container will be split into partitions based on the numPartitions
 * parameter. Partition counts > 6 may be less than useful though.
 */
module Container(exDepth, numPartitions){
    difference(){
        union(){
            LowerThreads();
            translate([0,0,LevelHeight])
                cylinder(d=OuterDiameter, h=exDepth);
            translate([0,0,LevelHeight+exDepth])
                UpperThreads();
        }
        PartitionCut(LevelHeight+exDepth, numPartitions);
    }
}

/* 
 * Create the cap for closing the uppermost container 
 */
module Cap(){
    difference(){
        LowerThreads();
        PartitionCut(LevelHeight, 2);
    }
}

/* 
 * Base is like Container except there are no threads at the bottom
 */
module Base(exDepth, numPartitions){
    height = LevelHeight+exDepth;
    difference(){
        union(){
            cylinder(d=OuterDiameter, h=height);
            translate([0,0,height])
                UpperThreads();
        }
        PartitionCut(height, numPartitions);
    }
}

/* Simple function to create a base and cap at once. */
module StarterKit(exDepth, numPartitions){
    Offset = OuterDiameter/2 + 1;
    translate([-Offset,0,0])
        Cap();
    translate([ Offset,0,0])
        Base(exDepth, numPartitions);
}

// 
// Internal Modules beliw here...
//

/*
 * LowerThreads
 * Creates the male threads at the lower end of all units. Above the threads is a
 * 45-degree bevel that extends out to OuterDiameter. The total height of this
 * module is LevelHeight; i.e. ThreadHeight + BevelHeight. 
 * This is a solid piece so the inside of the container will still need to be 
 * differenced-out.
 */
module LowerThreads(){
    metric_thread(diameter=OuterDiameter-Bevel, pitch=ThreadPitch, length=ThreadHeight);
    translate([0,0,ThreadHeight])
        cylinder(d1=OuterDiameter-Bevel, d2=OuterDiameter, h=Bevel);
}

/*
 * UpperThreads
 * Creates the female threads ar the upper end of all units. A bevel is created to
 * mate with the bevel on the Lower Threads. The total height of this module is 
 * LevelHeight; i.e. ThreadHeight + BevelHeight.
 * This is a hollowed-out piece and can simply be stacked at the top of a container
 * module.   
 */
module UpperThreads(){
    difference(){
        cylinder(d=OuterDiameter, h=LevelHeight );
        metric_thread( diameter=OuterDiameter-Bevel+ThreadMargin, 
            pitch=ThreadPitch, length=ThreadHeight, internal=true);
        translate([0,0,ThreadHeight-0.01])
            cylinder(d1=OuterDiameter-Bevel, d2=OuterDiameter, h=Bevel+0.02);
        translate([0,0,-0.01]) // This is just here to remove rendering artifacts
            cylinder(d=OuterDiameter-Bevel+ThreadMargin, h=0.02);
    }
}

/*
 * Create a cut-out for the inside of the container. This will need to be removed
 * from a solid container via difference()
 */
module PartitionCut(height, numPartitions){
    n=floor(numPartitions);
    translate([0,0,BaseThick]){
        difference(){
            cylinder(d=InnerDiameter, h=height);
            if (n > 1)
            for(angle = [0:360/n:360])
            rotate(angle)
            translate([0,OuterDiameter/4,height/2])
                cube([5, OuterDiameter/2, height+2], true);
        }
    }
}




/*
 * ================================================================================
 * ================================================================================
 * ================================================================================
 * ================================================================================
 * ================================================================================
 
 * Here ends the work of Joe McKeown
 * 
 * Below this point is the threads library of Dan Kirshner.
 * This file downloaded from // http://dkprojects.net/openscad-threads/threads.scad

 * ================================================================================
 * ================================================================================
 * ================================================================================
 * ================================================================================
 * ================================================================================
 */


/*
 * ISO-standard metric threads, following this specification:
 *          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
 *
 * Copyright 2017 Dan Kirshner - dan_kirshner@yahoo.com
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
 * Version 2.3.  2017-08-31  Default for leadin: 0 (best for internal threads).
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
// leadin      - 0 (default): no chamfer; 1: chamfer (45 degree) at max-z end;
//               2: chamfer at both ends, 3: chamfer at z=0 end.
// leadfac     - scale of leadin chamfer (default: 1.0 = 1/2 thread).
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0,
                      angle=30, taper=0, leadin=0, leadfac=1.0)
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
                      square=false, rectangle=0, angle=30, taper=0, leadin=0,
                      leadfac=1.0)
{
   // Convert to mm.
   mm_diameter = diameter*25.4;
   mm_pitch = (1.0/threads_per_inch)*25.4;
   mm_length = length*25.4;

   echo (str ("mm_diameter: ", mm_diameter));
   echo (str ("mm_pitch: ", mm_pitch));
   echo (str ("mm_length: ", mm_length));
   metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts,
                  thread_size, groove, square, rectangle, angle, taper, leadin,
                  leadfac);
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



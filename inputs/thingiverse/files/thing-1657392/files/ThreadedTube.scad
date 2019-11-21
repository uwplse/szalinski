// ---------------------------------------------------------------
// ThreadedTube.scad
// ---------------------------------------------------------------
//
// Dependencies:
// threads.scad (http://dkprojects.net/openscad-threads/)
//   - metric_thread(diameter, pitch, length);
//
// ---------------------------------------------------------------
// Under the LGPL License
// Author: Hristo Iankov (http://www.thingiverse.com/itzo/about)
// ---------------------------------------------------------------
//
// imported libraries are included directly into the file
// at the bottom of this file.
//include <threads.scad>

/* [Hidden] */
// constants

// end types
END_TYPE_NONE = 0;
END_TYPE_MALE_THREAD = 1;
END_TYPE_FEMALE_THREAD = 2;
THREAD_SHARPENER_HEIGHT = 2;

// resolution
$fn = 50;
//$fa=0.5;
//$fs=0.5;

/* [Main] */
outerDiameter = 16;             // [5:100]
// minimum diameter.  must be less than the outer diameter (overridable by Advanced > middleSectionThickness)
innerDiameter = 8;              // [0:100]
// must be greater than bottom end length + top end length
length = 70;                    // [10:250]
// must be between the inner diameter and the outer diameter
threadDiameter = 13;            // [5:100]
threadPitch = 2;                //
topEndType = 2;                 // [0:no thread,1:male thread,2:female thread]
topEndLength = 11;              // [1:50]
bottomEndType = 1;              // [0:no thread,1:male thread,2:female thread]
bottomEndLength = 10;           // [1:50]

/* [Text] */
messageText = "ThreadedTube";   // 
messageFontSize = 6;            // [2:25]
messageStartPosition = 2;       // [0:50]
message = "embossed";           //[embossed,deembossed]
messageIsEmbossed = message == "embossed";  //
messageNumberOfSides = 1;       // [1,2,4]

/* [Advanced] */
// make the female thread diameter this much larger in order to accomodate a good fit
threadTolerance = 1;          //
// this setting overrides innerDiameter for the middle section of the tube (0 - off) This used to prevent material waste.
middleSectionThickness = 0;   // [0:25]

// ----------------
// main/test
// ----------------
threadedTubeWithMessage(outerDiameter, innerDiameter, length,
    threadDiameter, threadPitch, 
    topEndType, topEndLength, bottomEndType, bottomEndLength,
    middleSectionThickness,
    messageText, messageFontSize, messageStartPosition, messageIsEmbossed, 
    messageNumberOfSides);

// ----------------
// modules
// ----------------

// generate a tube with the given parameters
// all measurements are in millimeters.
module tube(outerDiameter, innerDiameter, length) {
    difference() {
        cylinder(h=length, d=outerDiameter);
        translate([0,0,-1]) {
            cylinder(h=length+2, d=innerDiameter);
        }
    }
}

module fullyOuterThreadedTube(threadDiameter, threadPitch, threadLength, 
    innerDiameter) {
    difference() {
        metric_thread(threadDiameter, threadPitch, threadLength);
        translate([0,0,-1]) {
            cylinder(h=threadLength+2, d=innerDiameter);
        }
    }
}

module fullyOuterThreadedTubeWithSharpenedTip(threadDiameter, threadPitch, threadLength,
    innerDiameter) {
    difference() {
        fullyOuterThreadedTube(threadDiameter, threadPitch, threadLength, 
                innerDiameter);
        // make a cutting cone for sharpening the tip of the thread
        translate([0,0,-0.1]) {
            difference() {
                cylinder(h=THREAD_SHARPENER_HEIGHT, 
                    r1 = threadDiameter/2 - threadPitch + 2, 
                    r2 = threadDiameter/2 + threadPitch/2 + 2);
                translate([0,0,-0.1]) {
                    cylinder(h=THREAD_SHARPENER_HEIGHT+0.2, 
                        r1 = threadDiameter/2 - threadPitch, 
                        r2 = threadDiameter/2 + threadPitch/2);
                }
            }
        }
    }
 }
 
 module fullyOuterThreadedTubeWithSharpenedTipAndBase(threadDiameter, threadPitch, threadLength,
    innerDiameter, outerDiameter) {
    baseHeight = 2;
    fullyOuterThreadedTubeWithSharpenedTip(threadDiameter, threadPitch, threadLength,
            innerDiameter);
    // generate the base
    translate([0,0,threadLength]) {
        tube(outerDiameter, innerDiameter, baseHeight);
    }
 }

module fullyInnerThreadedTube(threadDiameter, threadPitch, threadLength, 
    innerDiameter, outerDiameter) {
    difference() {
        cylinder(h=threadLength, d=outerDiameter);
        translate([0,0,-1]) {
            metric_thread(threadDiameter + threadTolerance, threadPitch, threadLength+2);
        }
    }
}

module fullyInnerThreadedTubeWithSharpenedTip(threadDiameter, threadPitch, threadLength, 
    innerDiameter, outerDiameter) {
    difference() {
        fullyInnerThreadedTube(threadDiameter, threadPitch, threadLength, 
                innerDiameter, outerDiameter);
        translate([0,0,-0.1]) {
            cylinder(h=THREAD_SHARPENER_HEIGHT, 
                r1 = threadDiameter/2 + threadPitch/2, 
                r2 = threadDiameter/2 - threadPitch/2);
        }
    }
}

// generate a tube end
module createTubeEnd(endType, length, outerDiameter, innerDiameter, 
    threadDiameter, threadPitch) {
    if(endType == END_TYPE_MALE_THREAD) {
        fullyOuterThreadedTubeWithSharpenedTipAndBase(threadDiameter, 
                threadPitch, length, innerDiameter, outerDiameter);
    } else if(endType == END_TYPE_FEMALE_THREAD) {
        fullyInnerThreadedTubeWithSharpenedTip(threadDiameter, 
                threadPitch, length, innerDiameter, outerDiameter);
    } else {
        // assume END_TYPE_NONE
        tube(outerDiameter, innerDiameter, length);
    }
}

// generate a tube with threaded portions
//
// end types:
// - none (plain tube)
// - male thread
// - female thread
//
// message info:
// - embossed = extruded out
// - debossed = impressed in
//
// restriction:
// - threadDiameter must be between tube inner and outer diameter
// - innerDiameter < threadDiameter - threadPitch
// - outerDiameter > threadDiameter
// - length >= topEndLength + bottomEndLength
//
module threadedTube(outerDiameter, innerDiameter, length,
    threadDiameter, threadPitch, 
    topEndType, topEndLength, bottomEndType, bottomEndLength,
    middleSectionThickness) {
        
    // generate the center of the tube
    // remove the top and bottom peices, added below
    if(length > topEndLength + bottomEndLength) {
        translate([0,0,bottomEndLength]) {
            tube(outerDiameter, 
                    middleSectionThickness > 0 ? outerDiameter - middleSectionThickness*2 : innerDiameter, 
                    length-(topEndLength + bottomEndLength));
        }
    }
        
    // generate the top end of the tube
    if(topEndLength > 0) {
        translate([0,0,length]) {
            rotate([0,180,0]) {
                createTubeEnd(topEndType, topEndLength, outerDiameter, innerDiameter, 
                    threadDiameter, threadPitch);
            }
        }
    }
        
    // generate the bottom end of the tube
    if(bottomEndLength > 0) {
        createTubeEnd(bottomEndType, bottomEndLength, outerDiameter, innerDiameter, 
                threadDiameter, threadPitch);
    }
}
 
module generateTubeMessage(messageText, messageFontSize, messageStartPosition,
    outerDiameter, bottomEndLength) {
    rotate([0,0,-90]) { // bring th etext to the front face
        translate([outerDiameter/2-1.5,messageFontSize/2,bottomEndLength + messageStartPosition]) {
            rotate([180,-90,0]) {
                linear_extrude(2) {
                    text(text=messageText, size=messageFontSize);
                }
            }
        }
    }
}

module generateTubeMessageMultipleSides(messageText, messageFontSize, messageStartPosition,
    outerDiameter, bottomEndLength, numberSides) {
    angleIterator = 
        (numberSides == 4) ? [0:90:360] :
        (numberSides == 2) ? [0:180:180] :
        [0:90:80];
        
    for(angle = angleIterator) {
        rotate([0,0,angle]) {
            generateTubeMessage(messageText, messageFontSize, messageStartPosition,
                    outerDiameter, bottomEndLength);
        }
    }
}

module threadedTubeWithMessage(outerDiameter, innerDiameter, length,
    threadDiameter, threadPitch, 
    topEndType, topEndLength, bottomEndType, bottomEndLength,
    middleSectionThickness,
    messageText, messageFontSize, messageStartPosition, messageIsEmbossed, 
    messageNumberOfSides) {
    
    if(messageIsEmbossed) {
        // the message is outset
        // generate the threaded tube
        threadedTube(outerDiameter, innerDiameter, length,
                threadDiameter, threadPitch, 
                topEndType, topEndLength, bottomEndType, bottomEndLength,
                middleSectionThickness);
                    
        // generate the message
        generateTubeMessageMultipleSides(messageText, messageFontSize, messageStartPosition,
                outerDiameter, bottomEndLength, messageNumberOfSides);
        
    } else {
        // the message is inset
        difference() {
            // generate the threaded tube
            threadedTube(outerDiameter, innerDiameter, length,
                    threadDiameter, threadPitch, 
                    topEndType, topEndLength, bottomEndType, bottomEndLength,
                    middleSectionThickness);
                        
            // generate the message
            generateTubeMessageMultipleSides(messageText, messageFontSize, messageStartPosition,
                    outerDiameter, bottomEndLength, messageNumberOfSides);
        }
    }
}







//*********************************************************************************
// External Libraries:
//
// Since customizer.makerbot does not allow imports of external libraries, the
// code of the imported libraries has to be contained within the files that use
// the libraries.  Once this limitation has been removed, the following librarie
// will be properly imported.
//
// All credit for the following libraries is owed to the original content creators.
// Please contact the original authors for any licensing information.
//*********************************************************************************

//*********************************************************************************
// threads.scad
//*********************************************************************************
/*
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








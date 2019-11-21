// copyright aeropic 2018

// play with this value to trim the length of the feet
longueur = 95; 



/* [Hidden] */


diam_plate = 16 ; // diametre du plateau
//  diametre de la tete spherique = diam_plate+4
$fn = 100;
angle = 00;





/*
 * ISO-standard metric threads, following this specification:
 *          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
 *
 * Dan Kirshner - dan_kirshner@yahoo.com
 *
 * You are welcome to make free use of this software.  Retention of my
 * authorship credit would be appreciated.
 *
 * Version 1.5.  2015-06-12  Options: thread_size, groove.
 * Version 1.4.  2014-10-17  Use "faces" instead of "triangles" for polyhedron
 * Version 1.3.  2013-12-01  Correct loop over turns -- don't have early cut-off
 * Version 1.2.  2012-09-09  Use discrete polyhedra rather than linear_extrude ()
 * Version 1.1.  2012-09-07  Corrected to right-hand threads!
 */

// Examples.
//
// Standard M8 x 1.
*metric_thread (diameter=8, pitch=1, length=4);

// Completely non-standard: long pitch, same thread size.
//metric_thread (diameter=8, pitch=4, length=4, thread_size=1, groove=true);

// English: 1/4 x 20.

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
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false)
{
   // thread_size: size of thread "V" different than travel per turn (pitch).
   // Default: same as pitch.
   local_thread_size = thread_size == -1 ? pitch : thread_size;

   n_segments = segments (diameter);
   h = local_thread_size * cos (30);

   if (! groove) {
      metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                           local_thread_size, groove);
   }

   difference () {

      // Solid center, including Dmin truncation.
      if (groove) {
         cylinder (r=diameter/2, h=length, $fn=n_segments);
      } else if (internal) {
         cylinder (r=diameter/2 - h*5/8, h=length, $fn=n_segments);
      } else {

         // External thread includes additional relief.
         cylinder (r=diameter/2 - h*5.3/8, h=length, $fn=n_segments);
      }

      if (groove) {
         metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                              local_thread_size, groove);
      }
   }
}


// ----------------------------------------------------------------------------
// Input units in inches.
// Note: units of measure in drawing are mm!
module english_thread (diameter=0.25, threads_per_inch=20, length=1,
                      internal=false, n_starts=1, thread_size=-1, groove)
{
   // Convert to mm.
   mm_diameter = diameter*25.4;
   mm_pitch = (1.0/threads_per_inch)*25.4;
   mm_length = length*25.4;

   echo (str ("mm_diameter: ", mm_diameter));
   echo (str ("mm_pitch: ", mm_pitch));
   echo (str ("mm_length: ", mm_length));
   metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts, 
                  thread_size, groove);
}

// ----------------------------------------------------------------------------
module metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                            thread_size, groove)
{
   // Number of turns needed.
   n_turns = floor (length/pitch);

   intersection () {

      // Start one below z = 0.  Gives an extra turn at each end.
      for (i=[-1*n_starts : n_turns+1]) {
         translate ([0, 0, i*pitch]) {
            metric_thread_turn (diameter, pitch, internal, n_starts, 
                                thread_size, groove);
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
                           groove)
{
   n_segments = segments (diameter);
   fraction_circle = 1.0/n_segments;
   for (i=[0 : n_segments-1]) {
      rotate ([0, 0, i*360*fraction_circle]) {
         translate ([0, 0, i*n_starts*pitch*fraction_circle]) {
            thread_polyhedron (diameter/2, pitch, internal, n_starts, 
                               thread_size, groove);
         }
      }
   }
}


// ----------------------------------------------------------------------------
// z (see diagram) as function of current radius.
// (Only good for first half-pitch.)
function z_fct (current_radius, radius, pitch)
   = 0.5* (current_radius - (radius - 0.875*pitch*cos (30)))
                                                       /cos (30);

// ----------------------------------------------------------------------------
module thread_polyhedron (radius, pitch, internal, n_starts, thread_size,
                          groove)
{
   n_segments = segments (radius*2);
   fraction_circle = 1.0/n_segments;


   h = thread_size * cos (30);
   outer_r = radius + (internal ? h/20 : 0); // Adds internal relief.
   //echo (str ("outer_r: ", outer_r));

   inner_r = radius - 0.875*h; // Does NOT do Dmin_truncation - do later with
                               // cylinder.

   translate_y = groove ? outer_r + inner_r : 0;
   reflect_x   = groove ? 1 : 0;

   // Make these just slightly bigger (keep in proportion) so polyhedra will
   // overlap.
   x_incr_outer = (! groove ? outer_r : inner_r) * fraction_circle * 2 * PI * 1.005;
   x_incr_inner = (! groove ? inner_r : outer_r) * fraction_circle * 2 * PI * 1.005;
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

   z0_outer = z_fct (outer_r, radius, thread_size);
   //echo (str ("z0_outer: ", z0_outer));

   //polygon ([[inner_r, 0], [outer_r, z0_outer], 
   //        [outer_r, 0.5*pitch], [inner_r, 0.5*pitch]]);
   z1_outer = z0_outer + z_incr;

   translate ([0, translate_y, 0]) {
      mirror ([reflect_x, 0, 0]) {

         // Rule for face ordering: look at polyhedron from outside: points must
         // be in clockwise order.
         polyhedron (
            points = [
                      [-x_incr_inner/2, -inner_r, 0],                        // [0]
                      [x_incr_inner/2, -inner_r, z_incr],                    // [1]
                      [x_incr_inner/2, -inner_r, thread_size + z_incr],     // [2]
                      [-x_incr_inner/2, -inner_r, thread_size],             // [3]

                      [-x_incr_outer/2, -outer_r, z0_outer],                 // [4]
                      [x_incr_outer/2, -outer_r, z0_outer + z_incr],         // [5]
                      [x_incr_outer/2, -outer_r, thread_size - z0_outer + z_incr], // [6]
                      [-x_incr_outer/2, -outer_r, thread_size - z0_outer]   // [7]
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


module barre(long, ball) {
    hull() {
        translate ([-3,0,-3]) sphere (d = 2, center = true);
        translate ([3,0,-3]) sphere (d = 2, center = true);
        translate ([-3,0,3]) sphere (d = 2, center = true);
        translate ([3,0,3]) sphere (d = 2, center = true);
        translate ([-3,long,-3]) sphere (d = 2, center = true);
        translate ([3,long,-3]) sphere (d = 2, center = true);
        translate ([-3,long,3]) sphere (d = 2, center = true);
        translate ([3,long,3]) sphere (d = 2, center = true);
        if (ball == "yes") {
        translate ([-0,long+3,0])sphere (d = 8, center = true);}
    }
}


module nut_torus1(){
    difference(){
        union() {
            rotate_extrude(convexity = 10, $fn = 100)
translate([diam_plate/2, 0, 0])
circle(d= 4, $fn = 100);
translate([0, 0, 1]) cylinder(d= diam_plate, h = 6, center = true);
}
rotate([0,0,90]) cylinder (d = 3.2, h = 15, center = true);
 translate([0, 0, -2])rotate([0,0,90]) cylinder (d = 6.2, h = 10, center = true); //tete vis

translate([-diam_plate/2-5, 0, -3])cube([10, 30, 10], center = true); //meplat
translate([diam_plate/2+5, 0, -3])cube([10, 30, 10], center = true);// meplat
} // end diff
}

module nut_torus(){
    difference(){
        union() {
          scale([1,1,0.825])  sphere (d = (diam_plate+4));
translate([0, 0, 1]) cylinder(d= diam_plate, h = 6, center = true);
}
rotate([0,0,90]) cylinder (d = 3.2, h = 15, center = true);
 #translate([0, 0, -1])rotate([0,0,90]) cylinder (d = 6.3, h = 8, center = true); // tete vis

translate([-diam_plate/2-5, 0, -3])cube([10, 30, 30], center = true); //meplat
*translate([diam_plate/2+5, 0, -3])cube([10, 30, 30], center = true);// meplat
translate([0, 0, -5-5])cube([30, 30, 10], center = true); //meplat haut
translate([0, 0, 5+5])cube([30, 30, 10], center = true);// meplat bas
} // end diff
}

module M3_nut () {
    rotate([180,0,0])difference(){
        union(){
        cylinder(d= diam_plate  , h = 4, center = true);
         translate([0, 0, -1])   cylinder(d= 12 , h = 6, center = true);
        for(i = [0 : 30 : 360]) {
    rotate([0,0,i]) translate ([diam_plate/2,0,0]) cylinder(d= 3 , h = 4, center = true);}
    } // end union
   # cylinder(d= 6.2 , h = 4, center = true, $fn = 6);
    # cylinder(d= 3.2 , h = 14, center = true);
} // end diff
}



module axe(large) {
    difference() {
 union(){
     barre(large+4 + diam_plate/2, "no");
    translate ([0,4+diam_plate/2+ large,diam_plate/2 - 4])rotate([0,90,0]) cylinder (d= diam_plate, h = 8, center = true);
  * #  translate ([-4,1.34*diam_plate/4+ large,1.9*diam_plate/4 ])rotate([-30,0,0]) cube([8,diam_plate/2,diam_plate/2], center = false); //butee
    } //end union
 translate ([0,4+diam_plate/2+ large,diam_plate/2 - 4]) rotate([0,90,0]) cylinder (d=3.2, h = 10, center = true);
} // end diff
    
    
}

 module foot(longueur, largeur) {
translate ([1,2,0]) rotate([0,0,90+45])barre(longueur, "yes");
axe(largeur);
}

module head(){
   difference() {
       union(){
           translate ([-17,0,-diam_plate/2-2.5]) rotate([0,0,0]) cylinder (d= 12, h = 3, center = true); //bossage vis
           hull() {
       sphere (d= diam_plate + 4 +4, center = true);
       translate ([-50+diam_plate/2,0,0]) rotate([0,-90,0]) cylinder (d= diam_plate + 4 +4, h = 2, center = true);
   } // end hull
   } // end union
   #translate ([2,0,0]) sphere (d= diam_plate+4 + 0.2, center = true);
   translate ([-15,0,0]) cube ([60,30,1.5], center = true); //fente
   translate ([11,0]) cube ([10,30,30], center = true); //haut
    translate ([-37.5,0,0])rotate([0,90,0]) difference(){ 
        scale([1,1,0.825])  sphere (d = (diam_plate+4)+ 0.2); // on perce le tore
        translate([0, 0, -5-5])cube([30, 30, 10], center = true); //meplat haut
        translate([0, 0, 5+5])cube([30, 30, 10], center = true);// meplat bas
    } // end diff
   translate ([-29,0,0]) rotate([0,-90,0]) cylinder (d1 =0,d2= diam_plate +1+0.2,  h = 8, center = true); //trou du bas cone
     translate ([-42,0,0]) rotate([0,-90,0]) cylinder (d= diam_plate +2.5,  h = 7, center = true); //trou du bas 
  scale([1,1,0.8]) translate ([-41,0,0]) rotate([0,-90,0]) cylinder (d= diam_plate +4,  h = 6, center = true); //trou ovale du bas 
   translate ([-17,0,0]) rotate([0,0,0]) cylinder (d= 3.2, h = 25, center = true); //trou vis
    translate ([-17,0,2.5]) rotate([0,0,0]) cylinder (d= 6.2, h = 5, center = true, $fn=6); //trou ecrou
     translate ([-17,0,10]) rotate([0,0,0]) cylinder (d= 6.2, h = 5, center = true); //trou tete vis
    translate ([1,8,0]) rotate([90,0,0]) cylinder (d= 7, h = 12, center = true); //trou axe withworth
    translate ([1+3.5,8,0]) rotate([90,0,0]) cube ([7,7,20], center = true); //trou axe withworth
   } // end diff
}

module bolt(){
english_thread (diameter=1/4+0.02, threads_per_inch=20, length=0.35);

}


module nut () {
    difference(){
        union(){
        cylinder(d= 20 , h = 4, center = true);
        for(i = [0 : 30 : 360]) {
    rotate([0,0,i]) translate ([10,0,0]) cylinder(d= 3 , h = 4, center = true);}
    } // end union
   #translate([0,0,-3]) bolt();
} // end diff
}



 module mysphere(){
   difference(){
     union() {
         difference(){
sphere(d= diam_plate+4, center = true, $fn= 100);
//translate([0,0,7])english_thread (diameter=1/4+0.02, threads_per_inch=20, length=0.35);
#translate([0,0,-13.5])cube([50,50,10], center = true);
}
english_thread (diameter=1/4-0.0051, threads_per_inch=20, length=1.1);
translate([0,0,5])cylinder (d = 6.5, h = 23, center = true);
}

#cylinder(d=3,h = 63, $fn=12, center = true);

}

} 

// remove one by one the "*" to print the head, the M3_nut, the Withworth nut, the sphere

* translate ([28+50,0,0]) rotate([30,0,0])head();

*M3_nut();
*nut();
*mysphere();

// comment this whole block of code to hidde the feet (
/* xxx */
 translate ([0,-4-diam_plate/2,-diam_plate/2+4])foot (longueur,0);
rotate([angle,0,0])translate ([8+2,-4-diam_plate/2-3,-diam_plate/2+4])foot (longueur*1.02+8*1.414,3);


rotate([2*angle,0,0])difference() {
    union() { // 3ieme pied avec tore
    translate ([16+4,-4-diam_plate/2-6,-diam_plate/2+4])foot (longueur*1.04+2*8*1.414,6);
translate ([29.,0,0])rotate([0,-90,0])nut_torus();
} // end union
#translate([13, 0, 0])rotate([0,90,0]) cylinder (d = 6.2, h = 10, center = true, $fn=6); //logement ecrou
}






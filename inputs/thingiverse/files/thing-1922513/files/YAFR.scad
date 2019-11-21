/* YAFR - Yet Another Filament Reel 
 *
 * 11/25/2016
 * TH Sturgill
 *
 * Run once with each value of male thread to create matching pieces
 */
 
 /******** USER VARIABLES ************/

/* [Thread] */ 
thread_type = "male"; // [first:male,second:female]

/* [ Flange_Diameter] */
flange_dia = 120; // [30:220]

/* [Flange_Thickness] */
flange_thick = 2.4; // [0:0.1:5]

/* [Hub_Diameter] */
hub_size = 60; // [30:100]  

/* [Hub Length] */
hub_length = 30; //[10:100]  




/* *********** DISPLAY SECTION ********** */

/* **DO NOT EDIT BELOW THIS POINT ** */ 
/* [Hidden] */

$fn=60;  // renders faster if evenly divisible into 360
hr = 1.8;

fr = (flange_dia <=220) ? flange_dia/2 : 110; // flange radius
h1 = (hub_size >=fr/2) ? hub_size/2 : fr/4 ; //hub radius 

fh = flange_thick;
malethread = (thread_type == "first") ? true:false;
if ( fh > 0 ) flange();
hub();

/* *********** MODULES ****************** */
module hub() {
    difference() {
        // set hub minimum at 10
        h2 = (hub_length > 10) ? hub_length/2 :5;
        // thread length must be half or less of hub length
        tl = (h2 > 10) ? 10:h2;
        // threading
        if (malethread) {
            difference() {
                union(){ 
                    translate([0,0,h2]) { 
                        make_thread(diameter=2*h1, length=tl-1,internal=false, pitch=3);}
                    cylinder(r=h1+2, h=h2, $fn=120);
                }
                translate([0,0,-1]) cylinder(r=h1-1, h=h2/2+1.05);
                translate([0,0,h2/2]) cylinder(r1=h1-0.5, r2=h1-3.5, h=h2/2-1);
                translate([0,0,-1]) cylinder(r=h1-3.5, h=h2+tl+2);
                } 
        } else  { 
                difference(){
                    cylinder(r=h1+2, h=h2, $fn=120);
                    translate([0,0,-1]) cylinder(r=h1-1, h=h2+2);
                    translate([0,0,h2-10]) make_thread(diameter=2*h1+2, length=tl, internal=false, pitch=3);
                }
        }
         // translate([0,0,-1]) cube([60,60,20]);
    }    
}
// ----------------------------------------------------------------------------
module flange(){
    difference() {
       union(){
        //flange  - minus radiused edge
        cylinder(r=fr-fh/2, h=fh, $fn=120);
        // radiused edge 
        translate([0, 0, fh/2])
        rotate_extrude(convexity = 10, $fn = 120)
              translate([fr-fh/2, 0, 0])  circle(r = fh/2, $fn = 120);
       }
        // center opening
        translate([0,0,-1]) cylinder(r=h1, h=fh+2);
        // Outer ring of holes 
        for (x=[0:60:360]) rotate([0,0,x]) translate([fr-8,0,-1]) hole();
        // large holes
        y1 =  (fr-h1-2)*0.8; //dia = 80% width of flange outside hub
        x1 = (fr+h1+2)/2-5; // arc length segment - 10mm
        
        for (x=[30:60:360]) rotate([0,0,x]) translate([(fr+h1+2)/2,0,-1]) resize(newsize=[y1,x1,fh+2]) cylinder(r=1, h=1);
        // Inner ring of holes
        for (x=[0:60:360]) rotate([0,0,x]) translate([h1+10,0,-1]) hole();    
        // Anchor Hole 
        translate([9,-34,-2]) { rotate([-10, 25, 0]) cylinder(h=15, r=hr); }
    } 
}
// ----------------------------------------------------------------------------
module hole() {
    cylinder(h=fh+2, r=hr);
}
// ----------------------------------------------------------------------------
/*
 * thread code based on stripped down version of thread library from:
 *  http://dkprojects.net/openscad-threads/ 
 *
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
 */
// ----------------------------------------------------------------------------
function segments (diameter) = min (50, ceil (diameter*6));
// ----------------------------------------------------------------------------
module make_thread (diameter=8, pitch=1, length=1, internal=false) {    
   angle=30; 
   $fn = min (50, ceil (diameter*6));
   h = pitch * cos (angle);
   h_fac1 = 0.625;

   // External thread includes additional relief.
   h_fac2 = 5.3/8;

   make_thread_turns (diameter, pitch, length, internal);
   
   difference () {
      // Solid center, including Dmin truncation.
      if (internal) {
         cylinder (r=diameter/2 - h*h_fac1, h=length);
      } else {
         cylinder (r=diameter/2 - h*h_fac2, h=length);
      }
   }
}
// ----------------------------------------------------------------------------
module make_thread_turns (diameter, pitch, length, internal) {
   // Number of turns needed.
   n_turns = floor (length/pitch);

   intersection () {
      // Start one below z = 0.  Gives an extra turn at each end.
      for (i=[-1 : n_turns+1]) 
         translate ([0, 0, i*pitch]) 
            make_thread_turn (diameter, pitch, internal, i*pitch);

      // Cut to length.
      translate ([0, 0, length/2]) 
         cube ([diameter*3, diameter*3, length], center=true);
   }
}
// ----------------------------------------------------------------------------
module make_thread_turn (diameter, pitch, internal, z) {
   n_segments = min (50, ceil (diameter*6));
   fraction_circle = 1.0/n_segments;
   for (i=[0 : n_segments-1]) 
      rotate ([0, 0, i*360*fraction_circle]) 
         translate ([0, 0, i*pitch*fraction_circle]) 
            thread_polyhedron ((diameter/2), pitch, internal);
}
// ----------------------------------------------------------------------------
function z_fct (current_radius, radius, pitch)
   = 0.5* (current_radius - (radius - 0.875*pitch*cos (30)))/cos (30);

// ----------------------------------------------------------------------------
module thread_polyhedron (radius, pitch, internal) {
   n_segments = segments (radius*2);
   fraction_circle = 1.0/n_segments;
   h = pitch * cos (30);
   
   outer_r = radius + (internal ? h/20 : 0); // Adds internal relief.
   
   // A little extra on square thread -- make sure overlaps cylinder.
   h_fac1 =  0.875;
   inner_r = radius - h*h_fac1 ; // Does NOT do Dmin_truncation - do later with
                                // cylinder.
   
   // Make these just slightly bigger (keep in proportion) so polyhedra will
   // overlap.
   x_incr_outer = outer_r  * fraction_circle * 2 * PI * 1.02;
   x_incr_inner = inner_r  * fraction_circle * 2 * PI * 1.02;
   x1_outer = outer_r * fraction_circle * 2 * PI;
   
   z_incr = pitch * fraction_circle * 1.005;
   z0_outer = z_fct (outer_r, radius, pitch); 
   z1_outer = z0_outer + z_incr;

   polyhedron (
       points = [
                 [-x_incr_inner/2, -inner_r, 0],                         // [0]
                 [ x_incr_inner/2, -inner_r, z_incr ],                   // [1]
                 [ x_incr_inner/2, -inner_r, pitch + z_incr],            // [2]
                 [-x_incr_inner/2, -inner_r, pitch],                     // [3]

                 [-x_incr_outer/2, -outer_r, z0_outer],                  // [4]
                 [ x_incr_outer/2, -outer_r, z0_outer + z_incr ],        // [5]
                 [ x_incr_outer/2, -outer_r, pitch - z0_outer + z_incr], // [6]
                 [-x_incr_outer/2, -outer_r, pitch - z0_outer]           // [7]
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
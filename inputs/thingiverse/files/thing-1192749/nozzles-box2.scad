// Author: GrAndAG

/* [Render] */
// Preview and render mode (select parts to make)
mode = 3; // [1:Bottom part only, 2: Lid only, 3: Bottom part + Lid, 4: Assembled view]

/* [Bottom part] */
// Height of bottom part (mm)
height = 8; // [8:25]
// Number of columns of holes
columns = 3; // [1:20]
// Number of rows of holes
rows = 2; // [1:20]
// Spacing between holes (mm)
spacing = 8; // [4:20]
// Width of text labels on the left of each row (if 0 -> no-text)
text_width = 8; // [2:50]
// Height of text labels on the left of each row (if 0 -> no-text)
text_height = 6; // [2:20]
// Labels on the left of each row, separated by semicolon ';' (empty -> no-text)
text = ".4;.5";
// Holes size
hole_diameter = 6; // [4:M4, 5:M5, 6:M6, 8:M8, 10:M10]
// Holes depth (mm)
hole_depth = 6; // [4:15]
// Make bottom part soli or hollow
solid = 0;  // [1:Yes, 0:No]

/* [Lid] */
// Enable lid generation
has_lid = 1; // [1:Yes, 2:No]
// Height of lid (mm)
lid_height = 10; // [6:25]
// Width of text on the lid top (if 0 -> no-text)
lid_text_width = 45; // [20:80]
// Height of text on the lid top (if 0 -> no-text)
lid_text_height = 11; // [2:20]
// Text on the lid top (empty -> no-text)
lid_text = "Nozzles";

/* [Misc] */
// Increase this value if holes are to tight
tolerance=0.5; // [-0.5:0.1:1.5]
// Thickness of walls (mm)
wall_thickness = 1.5; // [1.0:0.1:4.0]
// Render quality of round objects
$fn=64;

/* [Hidden] */
round_corners = 1.5;
text_embossing = 0.4;
eps = 0.05;
spacing_threshold_l = 6;
spacing_threshold_w = hole_diameter-2;

lid_mount_width = 2;

lid_mount_d = 6;
lid_mount_shaft_d = 1.75+0.1;

//        M4    M5    M6   x   M8   x   M10
pitches=[0.70, 0.80, 1.00, 0, 1.25, 0, 1.50];

//use <../lib/string.scad>
function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));
function getsplit(str, index=0, char=" ") = (index==0) ? substr(str, 0, search(char, str)[0]) : getsplit(   substr(str, search(char, str)[0]+1)   , index-1, char);

//use <../lib/threads.scad>
function segments (diameter) = min (50, ceil (diameter*6));
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0)
{
   // thread_size: size of thread "V" different than travel per turn (pitch).
   // Default: same as pitch.
   local_thread_size = thread_size == -1 ? pitch : thread_size;
   local_rectangle = rectangle ? rectangle : 1;

   n_segments = segments (diameter);
   h = (square || rectangle) ? local_thread_size*local_rectangle/2 : local_thread_size * cos (30);

   h_fac1 = (square || rectangle) ? 0.90 : 0.625;

   // External thread includes additional relief.
   h_fac2 = (square || rectangle) ? 0.95 : 5.3/8;

   if (! groove) {
      metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                           local_thread_size, groove, square, rectangle);
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
                              local_thread_size, groove, square, rectangle);
      }
   }
}


// ----------------------------------------------------------------------------
module metric_thread_turns (diameter, pitch, length, internal, n_starts, 
                            thread_size, groove, square, rectangle)
{
   // Number of turns needed.
   n_turns = floor (length/pitch);

   intersection () {

      // Start one below z = 0.  Gives an extra turn at each end.
      for (i=[-1*n_starts : n_turns+1]) {
         translate ([0, 0, i*pitch]) {
            metric_thread_turn (diameter, pitch, internal, n_starts, 
                                thread_size, groove, square, rectangle);
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
                           groove, square, rectangle)
{
   n_segments = segments (diameter);
   fraction_circle = 1.0/n_segments;
   for (i=[0 : n_segments-1]) {
      rotate ([0, 0, i*360*fraction_circle]) {
         translate ([0, 0, i*n_starts*pitch*fraction_circle]) {
            thread_polyhedron (diameter/2, pitch, internal, n_starts, 
                               thread_size, groove, square, rectangle);
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
                          groove, square, rectangle)
{
   n_segments = segments (radius*2);
   fraction_circle = 1.0/n_segments;

   local_rectangle = rectangle ? rectangle : 1;

   h = (square || rectangle) ? thread_size*local_rectangle/2 : thread_size * cos (30);
   // DKTMP - check
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




module main() {
height = (height < hole_depth+wall_thickness*2) ? hole_depth+wall_thickness*2 : height;
thread_diameter = hole_diameter + 0.3 + tolerance;
thread_pitch = pitches[hole_diameter - 4];

text_fixed = str(text, ";;;;;;;;;;;;;;;;;;;;");
text_width_to_add = (text_width <= spacing/2-wall_thickness) ? 0 : text_width - spacing/2+wall_thickness ;

add_left  = (!has_lid) ? 0 : (text_width_to_add+spacing/2 >= spacing_threshold_l) ? 0 : spacing_threshold_l - text_width_to_add - spacing/2;
add_right = (!has_lid) ? 0 : (spacing/2 >= spacing_threshold_l) ? 0 : spacing_threshold_l - spacing/2;
add_top   = (!has_lid) ? 0 : (spacing/2 >= spacing_threshold_w) ? 0 : spacing_threshold_w - spacing/2;

length = add_left+text_width_to_add + columns * (thread_diameter + spacing) + wall_thickness*2 + add_right;
width = add_top+rows * (thread_diameter + spacing) + wall_thickness*2;

lid_mount_offset_r = length-wall_thickness*2.5;
lid_mount_offset_l = wall_thickness*2.5;
lid_mount_hole_d = lid_mount_d+tolerance*2;
lid_mount_hole_w = lid_mount_width+tolerance*1.5;

module lid_mount_hole(add=0, shaft=false, hole=false) {
    difference() {
        d = (hole) ? lid_mount_d : lid_mount_hole_d+add;
        w = (hole) ? lid_mount_width : lid_mount_hole_w+add;
        s = d/2*sin(30)+d;
        union() {
            hull() {
                cylinder(d=d, h=w, center=true);
                translate([d/2+eps/2,(d-s)/2,0])
                    cube([eps, s, w], center=true);
                if (!hole)
                    translate([0,d/2+eps/2,0])
                        cube([d, eps, w], center=true);
            }
            if (shaft)
                cylinder(d=lid_mount_shaft_d, h=lid_mount_hole_w+wall_thickness*1.5+eps, center=true);
        }
        if (hole)
            cylinder(d=lid_mount_shaft_d+tolerance*0.7, h=lid_mount_hole_w+eps, center=true);
        if (add > 0) {
            translate([lid_mount_hole_d/2+eps/2,(d-s+eps)/2,0])
                cube([add+eps, s+eps, w], center=true);
            translate([0,lid_mount_hole_d/2+eps/2,0])
                cube([d, add+eps, w], center=true);
        }
    }
}

module holder() {
    
    f = 0.6;
    
    module holder_part() {
        size = thread_diameter + spacing;
        
        full_hole_depth = hole_depth+wall_thickness*2;
        difference() {
            if (solid) {
                cube([size, size, height]);
            } else {
                union() {
                    translate([0, 0, height - wall_thickness])
                        cube([size, size, wall_thickness]);
                    // make additional cylinders for threads
                    translate([size/2, size/2, height - full_hole_depth])
                        cylinder(d=thread_diameter+0.5+wall_thickness*2, h=full_hole_depth);
                }
            }
            // thread
            translate([size/2, size/2, 0]) {
                translate([0, 0 ,height-f+eps/2])
                    cylinder(d1=thread_diameter, d2=thread_diameter+f*2+eps/2, h=f+eps/2);
                translate([0, 0 ,height-thread_pitch*2])
                    cylinder(d1=thread_diameter-thread_pitch*2*0.89, d2=thread_diameter, h=thread_pitch*2);
                translate([0, 0 ,height-f-thread_pitch*4])
                    metric_thread (internal=true, diameter=thread_diameter, pitch=thread_pitch, length=thread_pitch*4+eps/2);
                translate([0, 0 ,height - full_hole_depth -eps/2])
                    cylinder(d=thread_diameter+0.5, h=full_hole_depth - thread_pitch*4 + eps/2);
            }
        }
        // bottom
        translate([size/2, size/2, height - full_hole_depth])
            cylinder(d=thread_diameter+0.5+wall_thickness*2, h=wall_thickness);
    }

    


    difference() {
        union() {
            difference() {
                translate([round_corners/2, round_corners/2, 0])
                    minkowski() {
                        cube([length - round_corners, width - round_corners, height-1]);
                        cylinder(d=round_corners, h=1);
                    }
                if (!solid) {
                    translate([round_corners/2 + wall_thickness, round_corners/2 + wall_thickness, -eps/2])
                        minkowski() {
                            cube([length - round_corners - wall_thickness*2, width - round_corners - wall_thickness*2, height - 1 + eps]);
                            cylinder(d=round_corners, h=1);
                        }
                }
            }
            
            // add some space fot text labels and fill top/left/right gaps
            if (text_width > 0 && text_height > 0 && len(text) > 0 && text_width_to_add > 0) {
                if (solid) {
                    translate([wall_thickness, 0, 0])
                        cube([text_width_to_add+add_left, width, height]);
                    translate([add_left+text_width_to_add + wall_thickness+columns*(spacing+thread_diameter), 0, 0])
                        cube([add_right, width, height]);
                    translate([wall_thickness, width-wall_thickness-add_top, 0])
                        cube([length-wall_thickness*2, add_top, height]);
                } else {
                    translate([wall_thickness, 0, height - wall_thickness])
                        cube([text_width_to_add+add_left, width, wall_thickness]);
                    translate([add_left+text_width_to_add + wall_thickness+columns*(spacing+thread_diameter), 0, height - wall_thickness])
                        cube([add_right, width, wall_thickness]);
                    translate([wall_thickness, width-wall_thickness-add_top, height - wall_thickness])
                        cube([length-wall_thickness*2, add_top, wall_thickness]);
                }
            }
            for(r=[0:1:rows-1]) {
                for(c=[0:1:columns-1])
                    translate([add_left+text_width_to_add + wall_thickness+c*(spacing+thread_diameter), wall_thickness+r*(spacing+thread_diameter), 0])
                        //render() 
                            holder_part();
            }
            if (has_lid && !solid) {
                // add placeholder for holes of lid mounts
                translate([lid_mount_offset_r, width-lid_mount_hole_d/2, height-lid_mount_hole_d/2])
                    rotate([0,-90,0]) lid_mount_hole(add=wall_thickness*2);
                    //cube([lid_mount_hole_w+wall_thickness*2, lid_mount_hole_d+eps, lid_mount_d+wall_thickness], center=true);
                translate([lid_mount_offset_l, width-lid_mount_hole_d/2, height-lid_mount_hole_d/2])
                    rotate([0,-90,0]) lid_mount_hole(add=wall_thickness*2);
                    //cube([lid_mount_hole_w+wall_thickness*2, lid_mount_hole_d+eps, lid_mount_d+wall_thickness], center=true);
            }
        }
        // emboss text labels
        if (text_width > 0 && text_height > 0 && len(text) > 0)
            for(r=[0:1:rows-1])
                //spacing/4 
                translate([wall_thickness + add_left + (text_width_to_add+spacing/2-f)/2, 
                wall_thickness+r*(spacing+thread_diameter)+(spacing+thread_diameter-text_height)/2, height-text_embossing])
                    resize([text_width-wall_thickness, text_height-wall_thickness])
                    linear_extrude(height = text_embossing)
                        text(getsplit(text_fixed, rows-1-r, ";"), size=text_height, halign="center", valign="bottom", font = "Arial");
        if (has_lid) {
            // make holes for lid mounts
            //offset_r = length-wall_thickness-thread_diameter-spacing;
            //offset_l = wall_thickness+text_width+thread_diameter+spacing;
            translate([lid_mount_offset_r, width-lid_mount_hole_d/2, height-lid_mount_hole_d/2])
                rotate([0,-90,0]) {
                    lid_mount_hole(shaft=true);
                    //if (solid)
                        // make holes on outer walls
                        translate([0, 0, -(lid_mount_hole_w+wall_thickness*3-eps)/2])
                            cylinder(d=lid_mount_shaft_d, h=wall_thickness*1.5+eps, center=true);
                }
            translate([lid_mount_offset_l, width-lid_mount_hole_d/2, height-lid_mount_hole_d/2])
                rotate([0,-90,0]) {
                    lid_mount_hole(shaft=true);
                    //if (solid)
                        // make holes on outer walls
                        translate([0, 0, (lid_mount_hole_w+wall_thickness*3-eps)/2])
                            cylinder(d=lid_mount_shaft_d, h=wall_thickness*1.5+eps, center=true);
                }
        }
    }
}

module lid() {
    difference() {
        lid_mounts_offset = 0.2;
        s = lid_mount_d/2*sin(30)+lid_mount_d;
        union() {
            difference() {
                translate([round_corners/2, round_corners/2, 0])
                    minkowski() {
                        cube([length - round_corners, width - round_corners, lid_height-1]);
                        cylinder(d=round_corners, h=1);
                    }
                translate([round_corners/2 + wall_thickness, round_corners/2 + wall_thickness, -eps/2])
                    minkowski() {
                        cube([length - round_corners - wall_thickness*2, width - round_corners - wall_thickness*2, lid_height - 1 + eps]);
                        cylinder(d=round_corners, h=1);
                    }
                translate([length+eps/2, width-lid_mount_hole_d/2, -lid_mount_d/2-lid_mounts_offset])
                    rotate([0,-90,0]) 
                        cylinder(d=d_cut, h=length+eps);
            }
            translate([wall_thickness, wall_thickness, lid_height-wall_thickness])
                cube([length-wall_thickness*2, width-wall_thickness*2, wall_thickness]);
            // mounts
            translate([lid_mount_offset_r, width-lid_mount_hole_d/2, -lid_mount_d/2-lid_mounts_offset])
                rotate([0,-90,0]) 
                    lid_mount_hole(hole=true);
            translate([lid_mount_offset_l, width-lid_mount_hole_d/2, -lid_mount_d/2-lid_mounts_offset])
                rotate([0,-90,0]) 
                    lid_mount_hole(hole=true);
            
            translate([lid_mount_offset_l/2+wall_thickness/2+lid_mount_width/4,
                        width-lid_mount_hole_d/2+(lid_mount_d-s)/2, (lid_height-eps-lid_mounts_offset)/2])
                cube([lid_mount_offset_l-wall_thickness+lid_mount_width/2,s,lid_height-eps+lid_mounts_offset], center=true);
            translate([lid_mount_offset_r+(lid_mount_offset_l-wall_thickness+lid_mount_width/2)/2-lid_mount_width/2,
                        width-lid_mount_hole_d/2+(lid_mount_d-s)/2, (lid_height-eps-lid_mounts_offset)/2])
                cube([lid_mount_offset_l-wall_thickness+lid_mount_width/2,s,lid_height-eps+lid_mounts_offset], center=true);
        }
        d_cut = sqrt(lid_mount_d*lid_mount_d/4 + lid_mount_hole_d*lid_mount_hole_d/4)*2 + tolerance*2-lid_mounts_offset*2;
        w_cut = lid_mount_offset_l-lid_mount_width/2;
        translate([w_cut, width-lid_mount_hole_d/2, -lid_mount_d/2-lid_mounts_offset])
            rotate([0,-90,0]) {
                cylinder(d=d_cut, h=w_cut+eps);
                translate([lid_mount_d/2,-s/2-lid_mount_d/4*sin(30)-eps/2,0])
                    cube([lid_mounts_offset+eps, s+eps, w_cut+eps]);
            }
        translate([length+eps, width-lid_mount_hole_d/2, -lid_mount_d/2-lid_mounts_offset])
            rotate([0,-90,0]) {
                cylinder(d=d_cut, h=w_cut+eps);
                translate([lid_mount_d/2,-s/2-lid_mount_d/4*sin(30)-eps/2,0])
                    cube([lid_mounts_offset+eps, s+eps, w_cut+eps]);
            }
        // lid text
        if (lid_text_width > 0 && lid_text_height > 0 && len(lid_text) > 0) {
            lid_text_width = min(lid_text_width, length-wall_thickness*2);
            lid_text_height = min(lid_text_height, width-wall_thickness*2);
            translate([length/2, width/2, lid_height-text_embossing])
                resize([lid_text_width, lid_text_height])
                    linear_extrude(height = text_embossing)
                        text(lid_text, size=lid_text_height, halign="center", valign="center", font = "Arial");
        }
    }

}

if (mode == 1 || mode == 3) 
    translate([0,(solid)?0:width,(solid)?0:height]) 
        rotate([(solid)?0:180,0,0]) 
            holder();
if (mode == 2)
    translate([0,width,lid_height]) 
        rotate([180,0,0]) 
            lid();
if (mode == 3 && has_lid)
    translate([0,-5,lid_height]) 
        rotate([180,0,0])
            lid();

if (mode == 4) {
    holder();
    if (has_lid)
        translate([0,-lid_mount_hole_d/2+width,height-lid_mount_d/2])
            rotate([-30,0,0])
                translate([0,lid_mount_hole_d/2-width,lid_mount_d/2])
                    lid();
}
}

main();

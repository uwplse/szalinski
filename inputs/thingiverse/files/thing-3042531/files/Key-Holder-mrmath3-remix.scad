/*----------------------------------------------------------------------------*/
/*-------                             Info                            --------*/
/*----------------------------------------------------------------------------*/

// Key Holder Remix
// Based off of ProteanMan's "Proteus Key Holder"
// link: https://www.thingiverse.com/thing:2749745
// Author: mrmath3
// Version: 3
// Last update: 3/4/19

// Version 2 - Added engraving
// Version 3 - Added simple mode for Thingiverse Customizer

/*----------------------------------------------------------------------------*/
/*-------                          Parameters                         --------*/
/*----------------------------------------------------------------------------*/

/* [DIMENSIONS] */

// The maximum length of the main body
length = 86; // [50 : 1 : 200]

// The maximum width of the main body
width = 25; // [15 : 1 : 40]

// The height of one of the halves
height = 6; // [3 : 0.5 : 8]

/* [TEXT] */

// Text to display at the top of the first half
text_frontTop1 = "AB6";

// Text size (height in mm) of the text above 
text_frontTop1_size = 5; // [2 : 0.5 : 7]

// Next line
text_frontTop2 = "Front";

// Text size (height in mm) of the text above 
text_frontTop2_size = 4; // [2 : 0.5 : 7]

// Text to display at the bottom of the first half
text_frontBottom1 = "DC3";

// Text size (height in mm) of the text above
text_frontBottom1_size = 5; // [2 : 0.5 : 7]

// Next line
text_frontBottom2 = "Room";

// Text size (height in mm) of the text above 
text_frontBottom2_size = 4; // [2 : 0.5 : 7]

// Text to display at the top of the second half
text_backTop1 = "DC2";

// Text size (height in mm) of the text above
text_backTop1_size = 5; // [2 : 0.5 : 7]

// Next line
text_backTop2 = "Locker";

// Text size (height in mm) of the text above 
text_backTop2_size = 4; // [2 : 0.5 : 7]

// Text to display at the bottom of the second half
text_backBottom1 = "DC5";

// Text size (height in mm) of the text above
text_backBottom1_size = 5; // [2 : 0.5 : 7]

// Next line
text_backBottom2 = "Office";

// Text size (height in mm) of the text above 
text_backBottom2_size = 4; // [2 : 0.5 : 7]

// How deep the text should be embossed / egraved?
text_depth = 1; // [0.5 : 0.5: 3]

// Embossed or engraved?
text_type = "engraved"; // ["embossed", "engraved"]

// How far away (in mm) the text should be from the bolt/screw holes
text_offset = 2; // [0.5 : 0.5 : 4]

/* [APPEARANCE] */

// Sharp base design (for Thingiverse Customizer) or smooth design (for OpenScad (takes ~4 min))
design = "sharp"; // ["sharp", "smooth"]

// How much of a slope to create for the trapezoid shape
offset = 2; // [0 : 0.5 : 5]

// How far (in mm) the rounding of the corners extends
smooth = 1; // [0 : 0.5 : 4]

// How rounded the corners are (high numbers take longer to render)
round = 20; // [5 : 1 : 40]

/* [KEY RING] */

// Choose whether or not to have a key ring
key_ring = "no"; // ["yes", "no"]

// The size of the hole's diameter
ring_hole_diameter = 4; // [2 : 1 : 8]

// The thickness of the perimeter of the key ring
ring_thickness = 3; // [2 : 0.5 : 5]

// The height of the key ring
ring_height = 5; // [3 : 0.5 : 8]

/* [SCREW & BOLT DIMENSIONS] */

// The length of the nut's diameter from flat part to flat part (apothem length)
nut_diameter = 5.4;

// The depth into the base that the nut should fall
nut_height = 3; // [1 : 0.5 : 4]

// The diameter of the head of the screw
screw_head_diameter = 5.8;

// The diameter of the shaft of the screw
screw_shaft_diameter = 2.85;

// Should the screw dig into the print? (else it will slide through hole)
screw_tight = "yes"; // ["yes", "no"]

// The depth into the base that the screw head should be inserted
screw_height = 3; // [1 : 0.5 : 4]

/* [FINGER INDENTATION] */

// The size of the circle that is removed to make the indentation
big_hole_diameter = 24; // [10 : 1 : 40]

// The location (from the end) of the indentation
down_big_hole = 30; // [10 : 1 : 60]

// The amount that the indentation cuts into the base shape (width-wise)
in_big_hole = 7; // [1 : 1 : 15]

// The number of fragments for the indent (the resolution)
finger_res = 50; // [10 : 5 : 80]

/* [SPACERS] */

// The number of spacers to print
n_spacers = 2; // [0 : 1 : 12]

// The outer diameter of the spacer
spacer_diameter = 10; // [3 : 1 : 15]

// The thickness of the spacer
spacer_height = 0.7; // [0.3 : 0.1 : 1.0]

/* [EXTRA SETTINGS] */

// The distance from the edge to the screw/bolt hole
small_hole_dist = 2; // [2 : 0.5 : 10]

/*----------------------------------------------------------------------------*/
/*-------                             Code                            --------*/
/*----------------------------------------------------------------------------*/

/* [HIDDEN] */

nut_wiggle = .5; // to make sure you can get the nut back out
screw_head_wiggle = .3; // smaller than nut wiggle, because easier to remove
spacer_radius_wiggle = 0.1; // to make sure no friction with screw
nut_hole_radius = (nut_diameter + nut_wiggle) / sqrt(3); // change to apothem
r_out_dia = ring_thickness * 2 + ring_hole_diameter; // outer diameter of key ring
text_overlap = (design == "sharp") ? 0 : .39 - round * 0.017; // if "round" is less than 20, then this is needed. This makes the text roughtly the right height
line_space = 1; // this is the space between the lines of text
fudge = .01; // to get diff command to work properly

/* [FUNCTIONS] */

function mod(num, div) = (num / div - floor(num / div)) * div;

/* [RENDER] */

top(key_ring);
bottom(key_ring);
spacers();

/* [MODULES] */

module top(ring = "yes") {
    if (text_type == "embossed")
        top_text(text_location = 0);
    difference() {
        if (ring == "yes" && design == "smooth") {
            union() {
                hole_base(part = 2, ring = "yes");
                key_ring();
            }
        }
        else if (ring == "no" && design == "smooth") {
            hole_base(part = 2, ring = "no");
        }
        else if (ring == "yes" && design == "sharp") {
            union() {
                simple_base(part = 2, ring == "yes");
                key_ring();
            }
        }
        else if (ring == "no" && design == "sharp") {
            simple_base(part = 2, ring = "no");
        }
        if (text_type == "engraved") 
            top_text(text_location = -text_depth);
        // screw holes
        // first
        translate([offset + (nut_diameter + nut_wiggle) / 2 + small_hole_dist, 0, 0])
            screw_hole();
        // last
        translate([length - (offset + (nut_diameter + nut_wiggle) / 2 + small_hole_dist), 0, 0])
            screw_hole();
        // middle
        translate([length / 2, 0, 0])
            screw_hole();
    }
}

module top_text(text_location = 0) {
    // text_frontTop1
    translate([text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist, width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, 90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_frontTop1, size = text_frontTop1_size, halign = "center", valign = "center");
    // text_frontTop2
    translate([text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist + text_frontTop1_size * .5 + text_frontTop2_size * .5 + line_space, width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, 90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_frontTop2, size = text_frontTop2_size, halign = "center", valign = "center");
    // text_frontBottom1
    translate([length - (text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist), width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, -90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_frontBottom1, size = text_frontBottom1_size, halign = "center", valign = "center");
    // text_frontBottom2
    translate([length - (text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist + text_frontBottom1_size * .5 + text_frontBottom2_size * .5 + line_space), width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, -90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_frontBottom2, size = text_frontBottom2_size, halign = "center", valign = "center");
}

module bottom(ring = "yes") {
  translate([0, 1.1 * width, 0]) {
      if (text_type == "embossed")
          bottom_text(text_location = 0);
      difference() {
          if (ring == "yes" && design == "smooth") {
            union() {
                hole_base(part = 1, ring = "yes");
                key_ring();
            }
        }
        else if (ring == "no" && design == "smooth") {
            hole_base(part = 1, ring = "no");
        }
        else if (ring == "yes" && design == "sharp") {
            union() {
                simple_base(part = 1, ring == "yes");
                key_ring();
            }
        }
        else if (ring == "no" && design == "sharp") {
            simple_base(part = 1, ring = "no");
        }
          if (text_type == "engraved")
            bottom_text(text_location = -text_depth);
        // nut holes
        // first
        translate([offset + (nut_diameter + nut_wiggle) / 2 + small_hole_dist, 0, 0])
            nut_hole();
        // last
        translate([length - (offset + (nut_diameter + nut_wiggle) / 2 + small_hole_dist), 0, 0])
            nut_hole();
        // middle
        translate([length / 2, 0, 0])
            nut_hole();
    }
    }
}

module bottom_text(text_location = 0) {
    // text_backTop1
    translate([text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist, width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, 90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_backTop1, size = text_backTop1_size, halign = "center", valign = "center");
    // text_backTop2
    translate([text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist + text_backTop1_size * .5 + text_backTop2_size * .5 + line_space, width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, 90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_backTop2, size = text_backTop2_size, halign = "center", valign = "center");
    // text_backBottom1
    translate([length - (text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist), width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, -90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_backBottom1, size = text_backBottom1_size, halign = "center", valign = "center");
    // text_backBottom2
    translate([length - (text_offset + offset + (nut_diameter + nut_wiggle) * 3 / 2 + small_hole_dist + text_backBottom1_size * .5 + text_backBottom2_size * .5 + line_space), width / 2, height - text_overlap + text_location + fudge * 3])
        rotate([0, 0, -90])
            linear_extrude(height = text_depth + fudge)
                text(text = text_backBottom2, size = text_backBottom2_size, halign = "center", valign = "center");
}

module spacers(n = n_spacers) {
  if (n == 0) {
    // don't print any spacers
  }
  else if (n >= 0) {
    max = floor(length / (1.1 * spacer_diameter)); // maximum spacers per column
    for (j = [0 : ceil(n / max) - 1])
      for (i = [0 : min(max - 1, n - j * max - 1)]) {
        translate([i * 1.1 * spacer_diameter, j * 1.1 * spacer_diameter, 0])
          spacer();
      }
    }
}

module spacer() {
  translate([spacer_diameter / 2, spacer_diameter / 2 + 2.2 * width, 0])
    difference() {
      cylinder(h = spacer_height, d = spacer_diameter, $fn = 40);
    // hole to be cut out
      translate([0, 0, -fudge / 2])
        cylinder(h = spacer_height + fudge, d = screw_shaft_diameter + 1, $fn = 30);
    }
}

module key_ring() {
    difference() {
        translate([-ring_hole_diameter / 2, r_out_dia / 4, 0]) {
            rotate([0, 0, 20]) {
                difference() {
                    minkowski() {
                        union() {
                            cylinder(h = ring_height - smooth, d = r_out_dia - 2 * smooth, $fn = 30);
                            translate([0, -r_out_dia / 2 + smooth, 0])
                                cube([2 * (r_out_dia - smooth), r_out_dia - 2 * smooth, ring_height - smooth]);
                        }
                        sphere(r = smooth, $fn = round);
                    }
                    translate([0, 0, -fudge / 2])
                        cylinder(h = ring_height + fudge, d = ring_hole_diameter, $fn = 30);
                }
            }
        }
        translate([-r_out_dia, -r_out_dia, -smooth  - fudge])
            cube([3 * r_out_dia, 3 * r_out_dia, smooth + fudge]);
    }
}

module hole_base(part = 1, ring = "no") { // takes a while to compile
    difference() { // make bottom sharp and flat
        minkowski() { // round edges
            difference() { // cut finger holes
                // Main shape
                polyhedron(PolyPoints, PolyFaces);
                
                // Finger holes on the sides
                translate([length * (1 - mod(part + 1, 2)) + pow(-1, part) * down_big_hole, in_big_hole - big_hole_diameter / 2 + smooth, 0])
                    finger_hole();
                translate([length * (1 - mod(part, 2)) + pow(-1, part + 1) * down_big_hole, big_hole_diameter / 2 + width - in_big_hole - smooth, 0])
                    finger_hole();
                
                // hole for key ring
                if (ring == "no") {
                    // don't cut out a space for the ring
                }
                else if (ring == "yes") {
                    // cut out a space for the ring
                    translate([-ring_hole_diameter / 2, width - r_out_dia / 4, -fudge]) 
                        cylinder(h = height + fudge, d = (ring_hole_diameter +  ring_thickness) + 2 * smooth, $fn = 40);

                }
            }
            sphere(r = smooth, $fn = round);
        }
        translate([0, 0, -(smooth + fudge)])
            cube([length, width, smooth + fudge]);
    }
}

module simple_base(part = 1, ring = "no") { // fast compile and render
    difference() { // cut finger holes
        // Main shape
        polyhedron(SimplePoints, PolyFaces);
        
        // Finger holes on the sides
        translate([length * (1 - mod(part + 1, 2)) + pow(-1, part) * down_big_hole, in_big_hole - big_hole_diameter / 2 + smooth, 0])
            finger_hole();
        translate([length * (1 - mod(part, 2)) + pow(-1, part + 1) * down_big_hole, big_hole_diameter / 2 + width - in_big_hole - smooth, 0])
            finger_hole();
        
        // hole for key ring
        if (ring == "no") {
            // don't cut out a space for the ring
        }
        else if (ring == "yes") {
            // cut out a space for the ring
            translate([-ring_hole_diameter / 2, width - r_out_dia / 4, -fudge]) 
                cylinder(h = height + fudge, d = (ring_hole_diameter +  ring_thickness) + 2 * smooth, $fn = 40);

        }
    }
}

module finger_hole() {
    translate([0 , 0, -fudge / 2])
            cylinder(h = height + fudge, d = big_hole_diameter, $fn=finger_res);
}

module screw_hole() {
    translate([0, width * .5, height - screw_height ])
        union() {
            cylinder(h = height + fudge, d = screw_head_diameter + screw_head_wiggle, $fn = 40);
            translate([0, 0, nut_height - height - fudge])
                if (screw_tight == "yes") {
                    cylinder(h = height, d = screw_shaft_diameter, $fn = 30);
                }
                else if (screw_tight == "no") {
                    cylinder(h = height, d = screw_shaft_diameter + .5, $fn = 30);
                }
        }
}


module nut_hole() {
    translate([0, width / 2, height - nut_height])
        rotate([0, 0, 30])
            union() {
                cylinder(h = height, r = nut_hole_radius, $fn = 6);
                translate([0, 0, nut_height - height - fudge])
                    if (screw_tight == "yes") {
                        cylinder(h = height, d = screw_shaft_diameter, $fn = 30);
                    }
                    else if (screw_tight == "no") {
                        cylinder(h = height, d = screw_shaft_diameter + .5, $fn = 30);
                    }
            }
}

PolyPoints = [ // this subtracts the radius of the sphere used in minkowski "smooth"
  // it also allows the user to change the slant angle of the trapezoid with "offset"
  [ smooth,                   smooth,                  0 ],           //0
  [ length - smooth,          smooth,                  0 ],           //1
  [ length - smooth,          width - smooth,          0 ],           //2
  [ smooth,                   width - smooth,          0 ],           //3
  [ smooth + offset,          smooth + offset,         height - smooth ],  //4
  [ length - smooth - offset, smooth + offset,         height - smooth ],  //5
  [ length - smooth - offset, width - smooth - offset, height - smooth ],  //6
  [ smooth + offset,          width - smooth - offset, height - smooth ]]; //7

SimplePoints = [ // use this one to compile faster
  [ 0,               0,              0 ],       //0
  [ length,          0,              0 ],       //1
  [ length,          width,          0 ],       //2
  [ 0,               width,          0 ],       //3
  [ offset,          offset,         height ],  //4
  [ length - offset, offset,         height ],  //5
  [ length - offset, width - offset, height ],  //6
  [ offset,          width - offset, height ]]; //7

PolyFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
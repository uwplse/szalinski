/* [Global] */

/* [Main Configuration] */

// Part Type (choose one: Box or Lid):
part = "both"; // [body:Main body only,lid:Lid only,both:Main body and Lid]

// Card Height (long dimension):
card_height = 91; // [10:0.5:200]

// Card Width (short dimension):
card_width = 59; // [10:0.5:200]

// Deck Depth (thickness of the stack of cards):
deck_depth = 33; // [10:0.1:400]

/* [Advanced Settings] */

// Outside corner radius (box edge/corner rounding):
outside_corner_radius = 2.0; // [0.0:0.1:10.0]

// Inside corner radius (interior edge/corner rounding):
inside_corner_radius = 1.0; // [0.0:0.1:10.0]

// Wall Thickness:
wall_thickness = 2.0; // [0.5:0.1:10.0]

// Text Panel inset depth (0 to disable panel):
inset_depth = 1.0; // [0.0:0.1:9.5]

// Text Panel Bevel (distance between edge of box and text panel):
inset_bevel_width = 4.0; // [0:0.1:100]

// Card Edge Reveal (determines location of box/lid split, amount of card that should protrude from the box):
card_edge_reveal = 20.0; // [0:0.1:100]

// Lid Lip Depth:
lid_lip_depth = 6; // [1.5:0.5:100]

// Lid Snap Depth (distance from edge of the lip to locate the snap tab/slots):
lid_snap_depth = 3; // [1:0.1:99]

// Tab Width:
snap_box_tab_width = 20; // [1:0.5:100]

// Tab Height:
snap_box_tab_height = 1; // [0.1:0.1:10]

// Tab Depth:
snap_box_tab_depth = 0.5; // [0.1:0.1:10]

// Slot Width (Recommend bigger than tab width by 2):
snap_lid_slot_width = 22; // [1:0.5:100]

// Slot Height (Recommend bigger than tab height by 1):
snap_lid_slot_height = 2; // [0.1:0.1:10]

// Slot Depth (Recommend bigger than tab depth by 0.1):
snap_lid_slot_depth = 0.6; // [0.1:0.1:10]

// Wiggle room (extra interior space for ease of insertion/removal):
wiggle_room = 1.0; // [0.0:0.1:100.0]


// Derivative values
box_x = card_height + (2 * wall_thickness) + wiggle_room;
box_y = deck_depth + (2 * wall_thickness) + wiggle_room;
box_z = card_width + (2 * wall_thickness) + wiggle_room;

hollow_x = card_height + wiggle_room;
hollow_y = deck_depth + wiggle_room;
hollow_z = card_width + wiggle_room;

body_z = wall_thickness + wiggle_room + card_width - card_edge_reveal;
lid_z = wall_thickness + card_edge_reveal + lid_lip_depth;

lip_thick = wall_thickness / 2;
lip_carve = lip_thick + 1;
lip_carve_offset = 1 * 1;
lip_depth_carve = lid_lip_depth + lip_carve_offset;
box_lip_z_offset = body_z - lid_lip_depth;


// Text Panel
inset_width = box_x - (2 * inset_bevel_width);
inset_height = body_z - (2 * inset_bevel_width) - lid_lip_depth;



// Body
module body() {
    translate([0,0,box_z/2])
    difference() {
        intersection() {
            roundedBox([box_x, box_y, box_z], outside_corner_radius, $fn = 32);
            translate([0, 0, (box_z - body_z) / -2]) {
                cube([box_x, box_y, body_z], true);
            }
        }
        union() {
            // Hollow inside
            roundedBox([hollow_x, hollow_y, hollow_z], inside_corner_radius, $fn = 32);
            // Lip creation
            //  -X Lip
            translate([(box_x/-2)-lip_carve+lip_thick,box_y/-2,box_lip_z_offset-box_z/2]) {
                cube([ lip_carve, box_y, lip_depth_carve]);
            }
            //  +X Lip
            translate([(box_x/2)-lip_thick,box_y/-2,box_lip_z_offset-box_z/2]) {
                cube([lip_carve, box_y, lip_depth_carve]);
            }
            //  -Y Lip
            translate([box_x/-2,(box_y/-2)-lip_carve+lip_thick,box_lip_z_offset-box_z/2]) {
                difference() {
                    cube([box_x, lip_carve, lip_depth_carve]);
                    translate([(box_x-snap_box_tab_width)/2, lip_carve-snap_box_tab_depth, lid_snap_depth-snap_box_tab_height/2]) {
                        //cube([snap_box_tab_width, snap_box_tab_depth, snap_box_tab_height]);
                        triprism(snap_box_tab_width, snap_box_tab_depth, snap_box_tab_height);
                    }
                }
            }
            //  +Y Lip
            translate([box_x/-2,(box_y/2)-lip_thick,box_lip_z_offset-box_z/2]) {
                difference() {
                    cube([box_x, lip_carve, lip_depth_carve]);
                    translate([(box_x - snap_box_tab_width)/2+snap_box_tab_width, snap_box_tab_depth, lid_snap_depth-snap_box_tab_height/2]) {
                        //cube([snap_box_tab_width, snap_box_tab_depth, snap_box_tab_height]);
                        translate([0,-0.001,0])
                            rotate(a=180, v=[0,0,1])
                                triprism(snap_box_tab_width, snap_box_tab_depth, snap_box_tab_height);
                    }
                }
            }
            // Text Panel -Y
            translate([0, (box_y-inset_depth) / 2, lid_z/-2]) {
                cube([inset_width, inset_depth + 0.001, inset_height], true);
            }
            // Text Panel +Y
            translate([0, (box_y-inset_depth) / -2, lid_z/-2]) {
                cube([inset_width, inset_depth + 0.001, inset_height], true);
            }
        }
    }
}

// Lid
module lid() {
    translate([0,0,box_z/2]) rotate([180,0,0])
    difference() {
        intersection() {
            roundedBox([box_x, box_y, box_z], outside_corner_radius, $fn = 32);
            translate([0, 0, (box_z - lid_z) / 2]) {
                cube([box_x, box_y, lid_z], true);
            }
        }
        union() {
            roundedBox([hollow_x, hollow_y, hollow_z], inside_corner_radius, $fn = 32);
            // Lip creation
            translate([box_x/-2+lip_thick, box_y/-2+lip_thick, box_lip_z_offset-box_z/2-lip_carve_offset]) {
                union() {
                    cube([box_x-(lip_thick*2), box_y-(lip_thick*2), lid_lip_depth+lip_carve_offset]);
                    // Tab Slot -Y
                    translate([(box_x - snap_lid_slot_width)/2, -1*snap_lid_slot_depth, lid_snap_depth]) {
                        cube([snap_lid_slot_width, snap_lid_slot_depth+1, snap_lid_slot_height]);
                    }
                    // Tab Slot +Y
                    translate([(box_x - snap_lid_slot_width)/2, box_y-(lip_thick*2)-1, lid_snap_depth]) {
                        cube([snap_lid_slot_width, snap_lid_slot_depth+1, snap_lid_slot_height]);
                    }
                }
            }
        }
    }
}

module both() {
    body();
    translate([0,box_y*-1.5,0]) lid();
}

module print_part() {
    if (part == "body") {
        body();
    } else if (part == "lid") {
        lid();
    } else if (part == "body") {
        both();
    } else {
        both();
    }
}

print_part();


// MODULES
include <write/Write.scad>

// Module: roundedBox
// roundedBox([width, height, depth], float radius, bool sidesonly);

// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);

// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}



// Module: triprism
// triprism(length, width, height);

// EXAMPLE USAGE:
// triprism(10, 5, 3);

module triprism(l, w, h){
    polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
    // preview unfolded (do not include in your function
    z = 0.08;
    separation = 2;
    border = .2;
    translate([0,w+separation,0])
        cube([l,w,z]);
    translate([0,w+separation+w+border,0])
        cube([l,h,z]);
    translate([0,w+separation+w+border+h+border,0])
        cube([l,sqrt(w*w+h*h),z]);
    translate([l+border,w+separation+w+border+h+border,0])
        polyhedron(
            points=[[0,0,0],[h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[h,0,z],[0,sqrt(w*w+h*h),z]],
            faces=[[0,1,2], [3,5,4], [0,3,4,1], [1,4,5,2], [2,5,3,0]]
        );
    translate([0-border,w+separation+w+border+h+border,0])
        polyhedron(
            points=[[0,0,0],[0-h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[0-h,0,z],[0,sqrt(w*w+h*h),z]],
            faces=[[1,0,2],[5,3,4],[0,1,4,3],[1,2,5,4],[2,0,3,5]]
        );
}





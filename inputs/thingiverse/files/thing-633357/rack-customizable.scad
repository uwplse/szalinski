/* [Global] */

// preview[view:north west, tilt:top diagonal]

// Smoothness
$fn = 36;		// [92:Ultimate,36:Smooth,12:Edgy,6:Hexagonal,5:Pentagonal]

/* [Object look and feel] */

// Height of the object on the print platform
fatness = 18; // [10:300]

// Length of the top holder
length_upper =  30; // [20:Mini,30:Standard,40:Large]

// Length of the bottom holder
length_lower = 100; // [85:Mini,100:Standard,120:Large]

// Wall thickness
wall_thickness = 6; // [3:Slim,6:Standard,12:Heavy]

// Height of the object
rack_height = 55; // [50:Mini,55:Standard,60:Large]

// Angle of the holders
rack_angle = 20; // [0:Flat,15:Low,20:Normal,30:Steep,45:Wrapped]

/* [Rod parameters] */

// Rod diameter (more than 10 may be too heavy)
rod_d    =   8; // [6,7,8,9,10,11,12,14,16,18,20]

// Hole closure
closure  = "none"; // [none,left,right]

/* [Screw sizing] */

// Screw diameter
sroub_r  =   5; // [5,6,7,8]

// Screw head diameter
sroub_h  =  10; // [10,11,12,13,15]

// Screw type
screw_type = "recessed"; // [recessed,flat]

/* [Hidden] */
// Screw length
sroub_l  =  30;
fudge    =   0.3;

odstup = (rack_height / 5 > wall_thickness) ? (rack_height / 5) : (wall_thickness);

module zaslepka() {
  color("orange") cylinder(r = rod_d / 2 + fudge, h = fatness / 3);
}

module zaslepky() {
  rotate([0, 0, rack_angle]) translate([rack_height - wall_thickness / 2, wall_thickness / 2 + length_lower, 0])
    zaslepka();
  rotate([0, 0, rack_angle]) translate([wall_thickness / 2, wall_thickness / 2 + length_upper, 0])
    zaslepka();
}

module dira_tycky() {
  translate([0, 0, -fudge])
    cylinder(r = rod_d / 2 + fudge / 2, h = fatness + 2*fudge);
}

module tycka() {
  difference() {
    cylinder(r = (rod_d + wall_thickness) / 2, h = fatness);
    dira_tycky();
  }
}

module rack(closed) {
  translate([wall_thickness / 2, 0, 0])
    cube([rack_height - wall_thickness, wall_thickness, fatness]);

  difference() {
    hull() {
      translate([wall_thickness / 2, wall_thickness / 2, 0])
        cylinder(r=wall_thickness / 2, h = fatness);
      rotate([0, 0, rack_angle]) translate([wall_thickness / 2, wall_thickness / 2 + length_upper, 0])
        tycka();
    }
    rotate([0, 0, rack_angle]) translate([wall_thickness / 2, wall_thickness / 2 + length_upper, 0])
      dira_tycky();
  }

  difference() {
    hull() {
      translate([rack_height - wall_thickness / 2, wall_thickness / 2, 0])
        cylinder(r=wall_thickness / 2, h = fatness);
      rotate([0, 0, rack_angle]) translate([rack_height - wall_thickness / 2, wall_thickness / 2 + length_lower, 0])
        tycka();
     }
    rotate([0, 0, rack_angle]) translate([rack_height - wall_thickness / 2, wall_thickness / 2 + length_lower, 0])
      dira_tycky();
  }

  if (closed == "right") {
    zaslepky();
  }
  if (closed == "left") {
    translate([0, 0, fatness / 3 * 2]) zaslepky();
  }
}

module hole() {
  rotate([-90, 0, 0]) {
    cylinder(r = sroub_r / 2, h = sroub_l);
    if (screw_type == "recessed") {
      translate([0, 0, sroub_l / 10 * 9])
        cylinder(r1 = sroub_r / 2, r2 = sroub_h / 2, h = sroub_l / 10);
      translate([0, 0, sroub_l])
        cylinder(r = sroub_h / 2, h = 1);
    } else {
      translate([0, 0, sroub_l / 10 * 9])
        cylinder(r = sroub_h / 2, h = sroub_l / 3);
    }
  }
}

module rack_dira(closed = closure) {
  difference() {
  rack(closed);
    # translate([odstup, wall_thickness + fudge - sroub_l, fatness / 2])
      hole();
  }
}

module anotherone() {
  translate([0, 0, 200]) 
    rack_dira(closed = "right");
}

module centerone() {
  translate([0, 0, 100 - fatness / 2]) 
    rack_dira(closed = "none");
}

module poles() {
  rotate([0, 0, rack_angle]) translate([wall_thickness / 2, wall_thickness / 2 + length_upper, fatness / 3]) cylinder(r=rod_d / 2, h = 200 + fatness - fatness / 3 * 2);
  rotate([0, 0, rack_angle]) translate([rack_height - wall_thickness / 2, wall_thickness / 2 + length_lower, fatness / 3]) cylinder(r=rod_d / 2, h = 200 + fatness - fatness / 3 * 2);
}

rack_dira();

/* [Dimensions] */
base_thickness = 1.5;

foot_width = 21.6;
foot_length = 29.4;
foot_thickness = 7.7;

clamp_width = 18.1;
clamp_length = 28;
clamp_thickness = 3.4;

hole_width = 15.3;
hole_offset = -5.5;

/* [Hidden] */
hole_length = foot_length;
overlap = 0.001;

module foot_block() {
  intersection() {
    cylinder(d = foot_length, h = foot_thickness);
    translate([0, 0, foot_thickness / 2]) resize([foot_width, foot_length, foot_thickness]) cube(center = true);
  }
}

module clamp() {
    translate([0, -(foot_length - clamp_length), base_thickness]) {
        intersection() {
            cylinder(d = clamp_length, h = clamp_thickness);
            translate([0, 0, clamp_thickness / 2]) resize([clamp_width, foot_length, clamp_thickness]) cube(center = true);
        }
    }
}

module top_hole() {
  translate([0, hole_offset, -overlap + foot_thickness / 2 + base_thickness + clamp_thickness]) resize([hole_width, hole_length, foot_thickness]) 
    cube(center = true);
}

module foot() {
    difference() {
        foot_block();
        union() {
            clamp();
            top_hole();
        }
    }
}

//color("red", 1) foot_block();
//color("green", 1) clamp();
//color("blue", 1) top_hole();
foot();

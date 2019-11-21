// shamelessly stolen from http://forum.openscad.org/rounded-corners-td3843.html
module fillet_extrude(r, h) {
    translate([r / 2, r / 2, 0]) difference() {
        cube([r + 0.01, r + 0.01, h], center = true);
        translate([r/2, r/2, 0]) cylinder(r = r, h = h + 1, center = true);
    }
}

module inverse_fillet(r, h) {
    difference() {
        cube([r * 2, r * 2, h]);
        fillet_extrude(r, h * 2);
    }
}

/////
/// VARIABLES
/////

// precision
$fn = 128;

// measure with a caliper (multiple times, then average)
top_leg_size = [11, 23, 4.5];
bottom_leg_size = [11, 30, 4.1];

// can be adjusted to suit your printer
fudge_factor = 0.2;

// derived from above
hole_radius = 3.6 + fudge_factor / 2;
hole_padding = (top_leg_size[0] - hole_radius * 2) / 2;
hole_diameter = hole_radius * 2;

// serves as a check
outer_hole_diameter = hole_diameter + (hole_padding * 2);

hole_offset = [hole_radius + hole_padding, -hole_radius - hole_padding, 0];
rotor_width = 3.9 + fudge_factor;

// circle center to circle center
rotor_length = 14.5 + fudge_factor;
rotor_height = 1;

/////
/// OBJECT GENERATION
/////

// fillet corner
translate([0, top_leg_size[1], bottom_leg_size[1]]) difference() {
    rotate([0, 90, 0]) rotate([0, 0, -90]) inverse_fillet(8, top_leg_size[0]);

    // invert fillet shape
    translate([0, -bottom_leg_size[2], -top_leg_size[2]]) rotate([0, 90, 0]) rotate([0, 0, -90]) inverse_fillet(8, top_leg_size[0] + fudge_factor);

    // hole cutout
    translate([hole_radius + hole_padding, -top_leg_size[1] + hole_radius + hole_padding, -top_leg_size[2] - fudge_factor]) cylinder(d = outer_hole_diameter, h = top_leg_size[2] + fudge_factor);

    // top rotor cutout
    translate([hole_radius + hole_padding, -rotor_length - hole_radius + hole_padding / 2, -rotor_height]) linear_extrude(height = rotor_height) hull() {
        translate([0, rotor_length, 0]) circle(d = rotor_width);
        circle(d = hole_diameter);
    };

    // bottom rotor cutout
    #translate([hole_radius + hole_padding, -bottom_leg_size[2] + rotor_height, -bottom_leg_size[1] + hole_radius + hole_padding / 2]) rotate([90, 0, 0]) linear_extrude(height = bottom_leg_size[2]) hull() {
        translate([0, rotor_length, 0]) circle(d = rotor_width);
        circle(d = hole_diameter);
    };
};

// top endcap with hole
translate([0, 0, bottom_leg_size[1] - top_leg_size[2]]) difference() {
    // outer shape
    translate([0, top_leg_size[0], 0]) linear_extrude(height = top_leg_size[2]) difference() {
        hull() {
            translate(hole_offset) circle(d = outer_hole_diameter);
            square([top_leg_size[0], hole_diameter / 2]);
        };
        // cut out the inner hole diameter
        translate(hole_offset) circle(d = hole_diameter);
    };

    // cut out the rotor holder
    translate([hole_radius + hole_padding, hole_radius + hole_padding, top_leg_size[2] - rotor_height]) linear_extrude(height = rotor_height) hull() {
        translate([0, rotor_length, 0]) circle(d = rotor_width);
        circle(d = hole_diameter);
    };
}

// bottom endcap with hole
translate([0, top_leg_size[1], 0]) rotate([90, 0, 0]) difference() {
    // outer shape
    translate([0, top_leg_size[0], 0]) linear_extrude(height = bottom_leg_size[2]) difference() {
        hull() {
            translate(hole_offset) circle(d = outer_hole_diameter);
            square([top_leg_size[0], hole_diameter / 2]);
        };
        // cut out the inner hole diameter
        translate(hole_offset) circle(d = hole_diameter);
    };

    // cut out the rotor holder
    translate([hole_radius + hole_padding, hole_radius + hole_padding, bottom_leg_size[2] - rotor_height]) linear_extrude(height = rotor_height) hull() {
        translate([0, rotor_length, 0]) circle(d = rotor_width);
        circle(d = hole_diameter);
    };
}
// 3D Printable Surface Mount
// Copyright (C) 2017  Daniel Benoy  <daniel@benoy.name>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

$fn=60;

//CUSTOMIZER VARIABLES

// Whether to place an edge holder on the side(s) of the stand
type = 0; // [0:Corner-A, 1:Corner-B, 2:Side]

// The width of the entire bracket not counting the clip thickness
bracket_width=30;

// The thickness of the clips (the parts that grip on the object with the tooth on top)
clip_thickness=3;

// How deep and tall the teeth are
tooth_size=4;

// The height of the object that will be put in the bracket
height=25;

// The thickness of the base of the object (Make sure it's thick enough to accomodate your desired screw size)
base_thickness=5;

// The diameter of the screw hole
screw_diameter=3.45;

// The diameter of the head of the screw (For countersinking)
screw_head_diameter=6.9;

// The separation tolerance (This is to prevent things from fusing together that aren't supposed to, and will depend on your printer. You probably don't have to change this)
tolerence=0.5;

//CUSTOMIZER VARIABLES END


module clip(width, height, thickness, tooth_size) {
    cube([thickness, width, height + tooth_size]);
    translate([thickness, 0, 0]) translate([0, 0, height]) intersection() {
        cube([tooth_size, width, tooth_size]);
        translate([0, 0, tooth_size]) rotate([0, 135, 0]) cube([tooth_size * sqrt(2), width, tooth_size * sqrt(2)]);
    }
}

module fh_screw_hole(diameter, head_diameter, length) {
    cylinder(d1=head_diameter, d2=0, h=head_diameter/2);
    cylinder(d=diameter, h=length);
}

module surface_mount_corner(
    tolerence=tolerence,
    bracket_width=bracket_width,
    height=height,
    base_thickness=base_thickness,
    clip_thickness=clip_thickness,
    tooth_size=tooth_size,
    screw_diameter=screw_diameter,
    screw_head_diameter=screw_head_diameter
) {
    rotate([90, 0, 0]) translate([-clip_thickness, -clip_thickness, -base_thickness]) difference() {
        union() {
            intersection() {
                cube([clip_thickness + bracket_width, clip_thickness + bracket_width, height + tooth_size + base_thickness]);
                translate([clip_thickness, clip_thickness, 0]) cylinder(h=height + tooth_size + base_thickness, r=bracket_width);
                cube([bracket_width + clip_thickness, bracket_width + clip_thickness, base_thickness]);
            }
            clip(width=bracket_width + clip_thickness, height=height + base_thickness, thickness=clip_thickness, tooth_size=tooth_size);
            translate([clip_thickness + tolerence, 0, 0]) cube([bracket_width - tolerence, clip_thickness, height + base_thickness - tolerence]);
        }
        translate([bracket_width * cos(45) / 2 + clip_thickness, bracket_width * sin(45) / 2 + clip_thickness, base_thickness + 0.1]) rotate([180, 0, 0]) fh_screw_hole(diameter=screw_diameter, head_diameter=screw_head_diameter, length=base_thickness+0.2);
    }
}

module surface_mount_side(
    bracket_width=bracket_width,
    height=height,
    base_thickness=base_thickness,
    clip_thickness=clip_thickness,
    tooth_size=tooth_size,
    screw_diameter=screw_diameter,
    screw_head_diameter=screw_head_diameter
) {
    rotate([90, 0, 0]) translate([-clip_thickness, 0, -base_thickness]) difference() {
        intersection() {
            cube([bracket_width + clip_thickness, bracket_width + clip_thickness, height + tooth_size + base_thickness]);
            union() {
                cube([bracket_width/3 + clip_thickness, bracket_width, height + tooth_size + base_thickness]);
                translate([bracket_width/3 + clip_thickness, bracket_width/2, 0]) cylinder(h=height + tooth_size + base_thickness, d=bracket_width);
            }
            union() {
                cube([bracket_width + clip_thickness, bracket_width, base_thickness]);
                translate([0, 0, base_thickness]) clip(width=bracket_width, height=height, thickness=clip_thickness, tooth_size=tooth_size);
            }
        }
        translate([clip_thickness + bracket_width/2.5, bracket_width/2, base_thickness + 0.1]) rotate([180, 0, 0]) fh_screw_hole(diameter=screw_diameter, head_diameter=screw_head_diameter, length=base_thickness+0.2);
    }
}

if (type == 0) {
    surface_mount_corner();
} else if (type == 1) {
    mirror([1, 0, 0]) surface_mount_corner();
} else if (type == 2) {
    surface_mount_side();
}

// A little demo for screen shotting
if (false) {
    translate([80, 0, -80]) mirror([1, 0, 0]) surface_mount_corner();
    translate([-80, 0, -80]) surface_mount_corner();
    translate([80, 0, 80]) rotate([0, 180, 0]) surface_mount_corner();
    translate([-80, 0, 80]) mirror([1, 0, 0]) rotate([0, 180, 0]) surface_mount_corner();
    translate([80, 0, 15]) rotate([0, 180, 0]) surface_mount_side();
    translate([-80, 0, -15]) surface_mount_side();
}
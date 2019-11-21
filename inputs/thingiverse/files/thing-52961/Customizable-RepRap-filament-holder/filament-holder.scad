// Copyright (c) 2013, Jacob Helwig <jacob@technosorcery.net>
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the
// distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
// OF THE POSSIBILITY OF SUCH DAMAGE.

use <utils/build_plate.scad>;

// Which build plate do you want?
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual plate size]
// Manual x dimension in mm:
build_plate_manual_x = 200; //[100:400]
// Manual y dimension in mm:
build_plate_manual_y = 200; //[100:400]
// Pegs minus this percent, and peg holes plus this percent
peg_tolerance = 5;

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// Choose a piece:
part = "all"; // [bottom:Bottom bar,top:Top bar,cap:Retaining cap,all:All pieces]

// Diameter of top threaded cross-bar in mm.
crossbar_diameter = 8;
// Distance between top cross-bars (Center to center) in mm.
crossbar_spacing = 58;
// Diameter of rod to connect top & bottom bars.
vertical_bar_diameter = 6;

print_part();

module print_part() {
    if (part == "bottom") {
        translate([0,0,crossbar_diameter]) bottom_bar();
    } else if (part == "top") {
        translate([0,0,crossbar_diameter]) top_bar();
    } else if (part == "cap") {
        retaining_cap();
    } else if (part == "all") {
        all_parts();
    } else {
        all_parts();
    }
}

module bottom_bar() {
    translate([0,0,crossbar_diameter]) rotate([90,0,0]) {
        difference() {
            union() {
                cube(
                    size = [
                        crossbar_spacing + vertical_bar_diameter*4,
                        crossbar_diameter * 2,
                        crossbar_diameter * 2
                    ],
                    center = true
                );
                translate(v = [(crossbar_spacing + vertical_bar_diameter*4)/2, 0, 0]) rounded_end();
                translate(v = [-(crossbar_spacing + vertical_bar_diameter*4)/2, 0, 0]) rounded_end();
            }

            hull() {
                translate(v = [crossbar_spacing/2,0,0]) bar_hole(crossbar_diameter);
                translate(v = [crossbar_spacing/2,0,-crossbar_diameter]) bar_hole(crossbar_diameter);
            }
            hull() {
                translate(v = [-crossbar_spacing/2,0,0]) bar_hole(crossbar_diameter);
                translate(v = [-crossbar_spacing/2,0,-crossbar_diameter]) bar_hole(crossbar_diameter);
            }

            rotate([90,0,0]) translate(v = [(crossbar_spacing/2) + (crossbar_diameter + vertical_bar_diameter/2),0,0]) bar_hole(vertical_bar_diameter);
            rotate([90,0,0]) translate(v = [-((crossbar_spacing/2) + (crossbar_diameter + vertical_bar_diameter/2)),0,0]) bar_hole(vertical_bar_diameter);
        }
    }
}

module top_bar() {
    translate([0,0,crossbar_diameter]) rotate([-90,0,0]) {
        difference() {
            union() {
                cube(
                    size = [
                        crossbar_spacing + vertical_bar_diameter*4,
                        crossbar_diameter * 2,
                        crossbar_diameter * 2
                    ],
                    center = true
                );
                translate(v = [(crossbar_spacing + vertical_bar_diameter*4)/2, 0, 0]) rounded_end();
                translate(v = [-(crossbar_spacing + vertical_bar_diameter*4)/2, 0, 0]) rounded_end();
            }

            rotate([90,0,0]) translate(v = [(crossbar_spacing/2) + (crossbar_diameter + vertical_bar_diameter/2),0,0]) bar_hole(vertical_bar_diameter);
            rotate([90,0,0]) translate(v = [-((crossbar_spacing/2) + (crossbar_diameter + vertical_bar_diameter/2)),0,0]) bar_hole(vertical_bar_diameter);

            hull() {
                bar_hole(vertical_bar_diameter);
                translate(v = [0,0,crossbar_diameter]) bar_hole(vertical_bar_diameter);
            }
            translate(v = [0,-crossbar_diameter,0]) cap_holes(1 + peg_tolerance / 100.0);
        }
    }
}

module retaining_cap() {
    translate([0,0,(vertical_bar_diameter*.25)/2]) rotate([90,0,0]) union() {
        difference() {
            hull() {
                translate([vertical_bar_diameter*2,0,0]) rotate([90,0,0]) cylinder(
                    h = vertical_bar_diameter * .25,
                    r = vertical_bar_diameter,
                    center = true
                );
                translate([-vertical_bar_diameter*2,0,0]) rotate([90,0,0]) cylinder(
                    h = vertical_bar_diameter * .25,
                    r = vertical_bar_diameter,
                    center = true
                );
            }
            hull() {
                bar_hole(vertical_bar_diameter);
                translate(v = [0,0,crossbar_diameter]) bar_hole(vertical_bar_diameter);
            }
        }
        translate(v = [0,vertical_bar_diameter * (.25/3) + crossbar_diameter/4,0]) cap_pegs(1 - peg_tolerance / 100.0);
    }
}

module all_parts() {
    translate([0,-crossbar_diameter*4,0]) retaining_cap();
    translate([0,0,0]) top_bar();
    translate([0,crossbar_diameter*4,0]) bottom_bar();
}

module cap_pegs(tolerance) {
    translate(v = [vertical_bar_diameter*2, 0, 0]) scale([tolerance,tolerance,tolerance]) cap_peg();
    translate(v = [-vertical_bar_diameter*2, 0, 0]) scale([tolerance,tolerance,tolerance]) cap_peg();
}

module cap_peg() {
    rotate([90,0,0]) cylinder(
        h = crossbar_diameter/2,
        r = vertical_bar_diameter / 2,
        center = true
    );
}

module cap_holes(tolerance) {
    translate(v = [vertical_bar_diameter*2, 0, 0])  scale([tolerance,tolerance,tolerance]) cap_hole();
    translate(v = [-vertical_bar_diameter*2, 0, 0]) scale([tolerance,tolerance,tolerance]) cap_hole();
}

module cap_hole() {
    rotate([90,0,0]) cylinder(
        h = crossbar_diameter,
        r = vertical_bar_diameter / 2,
        center = true
    );
}

module bar_hole(diameter) {
    rotate([90,90,0]) cylinder(
        h = crossbar_diameter * 3,
        r = diameter/2,
        center = true
    );
}

module rounded_end() {
    rotate([90,90,0]) cylinder(
        h = crossbar_diameter * 2,
        r = crossbar_diameter,
        center = true
    );
}

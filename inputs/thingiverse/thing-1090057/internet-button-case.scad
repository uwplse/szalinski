// internet-button-case.scad
//
// generates an l-bracket from the given parameters


// Copyright (c) 2015, Patrick Barrett
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

wall_thickness = 2;
internal_diameter = 72.5;
internal_depth = 10;

boss_diameter = 5;
boss_height = 5;
boss_internal_diameter = 3;

screw_hole_diameter = 5;

use_tabs = true;

tab_height = 15;
tab_width = 4;
tab_bump_radius = 2;

$fs = 1;
$fa = 5;

// customizable variables end here

abit = 0.000001;
alot = 10000000;

difference() {
    union() {
        difference() {
            union() {
                difference() {
                    // main body
                    cylinder(h = internal_depth + wall_thickness,
                             d = internal_diameter +  wall_thickness*2);
                    
                    if(use_tabs){
                        // tab cutouts
                        translate([0,0,wall_thickness + tab_height/2 + abit])
                            cube([internal_diameter +  wall_thickness*2, tab_width+1, tab_height], center=true);
                        translate([0,0,wall_thickness + tab_height/2 + abit])
                            cube([tab_width+1, internal_diameter +  wall_thickness*2, tab_height], center=true);
                    }
                }
                if(use_tabs){
                    // tabs
                    translate([0,0,wall_thickness + tab_height/2 - abit])
                        cube([internal_diameter +  wall_thickness*2, tab_width, tab_height], center=true);
                    translate([0,0,wall_thickness + tab_height/2 - abit])
                        cube([tab_width, internal_diameter +  wall_thickness*2, tab_height], center=true);
                }
            }
            // main cutout
            translate([0,0,wall_thickness])
                cylinder(h = alot, d = internal_diameter);
        }
        // screw boss
        translate([0,0,wall_thickness-abit])
            cylinder(h = boss_height, d = boss_diameter);
        
        if(use_tabs){
            // tab dots
            translate([internal_diameter/2,0,wall_thickness + tab_height - (tab_bump_radius)])
                sphere(tab_bump_radius, center=true);
            translate([0,internal_diameter/2,wall_thickness + tab_height - (tab_bump_radius)])
                sphere(tab_bump_radius, center=true);
            translate([-internal_diameter/2,0,wall_thickness + tab_height - (tab_bump_radius)])
                sphere(tab_bump_radius, center=true);
            translate([0,-internal_diameter/2,wall_thickness + tab_height - (tab_bump_radius)])
                sphere(tab_bump_radius, center=true);
        }
    }
    // screw boss hole
    translate([0,0,-5])
        cylinder(h = 20, d = boss_internal_diameter);
    
    // wall mount holes
    translate([25,0,-5])
        cylinder(h = alot, d = screw_hole_diameter);
    translate([-25,0,-5])
        cylinder(h = alot, d = screw_hole_diameter);
}

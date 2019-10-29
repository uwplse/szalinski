// Flush holder
// Copyright (C) 2016  Andre-Patrick Bubel <code@andre-bubel.de>
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
//
// This work is also licensed under a Creative Commons
// Attribution-ShareAlike 4.0 International License.

screw_hole_diameter = 4.5;

nut_width = 7.5;
nut_height = 3.2;

layer_height = 0.3;

case_inner_width = 60;
case_inner_height = 50;
case_inner_length = 70;

wall_thickness = 5;
fastening_plate_height = 5;

/* [Hidden] */
// how much puncher parts should overlap to avoid zero thickness leftovers
punch = 1000;

case_inner_dim_punch = [case_inner_width+punch, case_inner_length, case_inner_height+punch];

case_outer_width = case_inner_width + wall_thickness;
case_outer_height = case_inner_height + wall_thickness;
case_outer_length = case_inner_length + 2*wall_thickness;

case_outer_dim = [case_outer_width, case_outer_length, case_outer_height];

fastening_plate_length = 3/2 * nut_width;
fastening_plate_width = case_outer_width;
fastening_plate_height = nut_height + layer_height * 6;

fastening_plate_dim = [fastening_plate_width, fastening_plate_length, fastening_plate_height];

module hole_puncher() {
    union() {
        cylinder(punch, d = nut_width, $fn=6);
        translate([0,0,-punch+1])
        cylinder(punch, d = screw_hole_diameter);
    }
}

module fastening_plate() {
    difference() {
        cube(fastening_plate_dim);
        translate([nut_width, fastening_plate_length/2, layer_height * 9])
        hole_puncher();
        translate([fastening_plate_width - nut_width, fastening_plate_length/2, layer_height * 9])
        hole_puncher();        
    }
};

$fn = 50;

rotate([0,90,90])
difference() {
    union() {
        translate([0,-fastening_plate_length,0])
        fastening_plate();
        translate([0,case_outer_length,0])
        fastening_plate();    
        cube(case_outer_dim);
    }
    translate([-punch, wall_thickness, -punch])
    cube(case_inner_dim_punch);
}
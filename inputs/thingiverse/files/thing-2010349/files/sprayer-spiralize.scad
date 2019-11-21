//  Simple Sprayer
//  Created by Nick Horvath
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

// this matches my 1/4" poly tubing and will fit 1/4" quick connect fittings
tube_od_radius=3.05;
tube_id_radius=2;
tube_length=15;

// NOTE: you may need to play with hole radius, the goal is to have pinholes in the finished print
// my printer tends to undersize holes in the first layers of a print so these holes are larger than they should be
hole_radius=0.75;

// the diameter of the nozzle
face_radius=12.5;
wall_thickness=1.5;

// the height of the transition between tube and face
// if you increase face_radius you should increase this so you don't run into overhang issues
cone_height=15;

// set facet size for rendering
$fa=0.5;
$fs=0.5;

module generate_holes(num_holes=1, hole_offset=0) {
    for(i=[0:num_holes]) {
        rotate([0,0,i*360/num_holes]) translate([hole_offset,0,-0.1]) cylinder(r=hole_radius, h=wall_thickness+0.2);
    };
};

// tube
difference() {
    cylinder(r=tube_od_radius, h=tube_length);
    translate([0,0,-0.1]) cylinder(r=tube_id_radius, h=tube_length+0.2);
};

// cone top
translate([0,0,-cone_height]) difference() {
    cylinder(r1=face_radius, r2=tube_od_radius, h=cone_height);
    translate([0,0,-0.1]) cylinder(r1=face_radius-wall_thickness, r2=tube_id_radius, h=cone_height+0.2);
};

// face and cylinder
translate([0,0,-cone_height-wall_thickness-1]) difference() {
    cylinder(r=face_radius, h=wall_thickness+1);
    translate([0,0,wall_thickness]) cylinder(r=face_radius-wall_thickness, h=1.1);
    union() {
        generate_holes(num_holes=1, hole_offset=0);
        generate_holes(num_holes=8, hole_offset=5);
        generate_holes(num_holes=16, hole_offset=10);
    };
};

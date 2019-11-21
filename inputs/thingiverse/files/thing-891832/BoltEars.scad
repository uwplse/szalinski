/*
Finger-Friendly Snap-On Hex Socket (a.k.a. Bolt Ears)
Copyright (C) 2015 Marcio Teixeira

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

/* Combination hex socket and finger friendly Mickey ears, great
 * for easy removal of access panels (I used to curse my central AC
 * whenever it came time to change the filter. Not anymore!)
 */

/* [Hex Socket] */

// Measurement from flat face to opposite face on the bolt head, make it snug so it stays on firmly
head_dimension  = 8;

// Just a bit deeper than the depth of the bolt head
socket_depth    = 3.0;

/* [Customize] */
wall_thickness = 3.0;
ear_diameter   = head_dimension*1.5;
ear_thickness  = 2.0;
ear_spacing    = 0.43;     // [0:0.05:0.75]
ear_style      = "mickey"; // [mickey, pill, retro]

/* [Hidden] */

$fn=40;

module hull_or_not(hull) {
    if(hull == true) {
        hull() children();
    } else {
        children();
    }
}

module symmetry(axis) {
    mirror(axis) {
        children();
    }
    children();
}

/* Constructs a hexagon */
module hexagon(d, h,sides=6) {
    w  = (d/2)*tan(360/(sides*2))*2;
    translate([0,0,h/2])
        for( a = [0:360/sides:360] ) {
            rotate([0,0,a])
                cube([d,w,h],center=true);
        }
}

/* Constructs a hex socket */
module hex_socket(d, h, wall_thickness, sides=6) {
    difference() {
        cylinder(d=d+wall_thickness*2,h=h+wall_thickness);
        translate([0,0,-0.1])
            hexagon(d,h);
    }
}

/* Combination hex socket and finger friendly Mickey ears */
module finger_wrench() {
    hex_socket(head_dimension, socket_depth, wall_thickness);

    cylinder_width = head_dimension+wall_thickness*2;
    
    // Give it ears
    if(ear_style == "retro") {
        // Fancy tapered style
        hull() {
            symmetry([0,1,0])
            translate([0,ear_diameter*(ear_spacing+1)/2, socket_depth + ear_diameter*3/4])
                rotate([0,90,0])
                    hull() {
                        cylinder(r=ear_diameter/4, center=true, h=ear_thickness);
                        translate([ear_diameter/4,0,0])
                            cylinder(r=ear_diameter/4, center=true, h=ear_thickness);
                    }
            
            translate([0,0, socket_depth + wall_thickness/2])
                cube(size=[ear_thickness*1.5,cylinder_width,ear_thickness], center=true);
        }
    } else {
        // Pill and mickey styles differ only by whether they are hulled
        hull_or_not(ear_style != "mickey")
        symmetry([0,1,0])
        translate([0,ear_diameter*ear_spacing,ear_diameter/2+socket_depth])
        rotate([0,90,0])
            cylinder(d=ear_diameter,h=ear_thickness, center=true);
    }
}

finger_wrench();
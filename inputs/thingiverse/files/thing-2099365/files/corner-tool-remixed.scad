/*  Square Check tool remix. Remixed for the fun of it from Thingverse thing : http://www.thingiverse.com/thing:1731023
    Copyright (C) 2017  PMorel for Thilab (www.thilab.fr)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
/* [Tool] */
// Height of the tool
tool_height = 24;
// Depth of the hollows on the sides
hollow_depth = 7;

/* [Square part] */
// Square part sides length
square_side=38;
// Thickness of the square that slips under the piece to measure
square_thickness = 4;

/* [Cylindrical part] */
// Distance between the center of the square and the center of the cylinder
dist_cube_cylinder = 51;
// Radius of the cylinder
cylinder_radius = 24;
// Thickness of the shell containing the rotating part
shell_thickness = 1;
// Gap between the shell and the rotating part
gap = 1;

/* [Rotating part] */
// Bevel size inside the rotating part
bevel=2;
// Height of the top and bottom parts of the rotating cylinder
top_bottom_height = 3;
// Width of the tape that fits into the rotating cylinder
tape_width = 26;
// Thickness of the hollow part where the tape end sits
tape_thickness = 3;

/* [Magnet] */
magnet="yes"; // [yes, no]
magnet_height = 1;
magnet_radius = 2;

/* [Hidden] */
$fn=96;
// Big radius of the hollow part
rot_hollow_big_radius = cylinder_radius - shell_thickness;
// Small radius of the hollow part
rot_hollow_small_radius = cylinder_radius - shell_thickness - bevel;
// Height of the top and bottom parts of the hollow cylinder
rot_hollow_top_bottom_height = top_bottom_height + gap;
// Height of the center part of the hollow cylinder
rot_hollow_center_height = tool_height - 2*rot_hollow_top_bottom_height;
// Big radius of the rotating part
big_radius = cylinder_radius - shell_thickness - gap;
// Small radius of the rotating part
small_radius = cylinder_radius - shell_thickness - gap - bevel;
// Height of the center part of the rotating part
center_height = tool_height - 2*top_bottom_height;

difference() {
    // Main part
    hull() {
        rotate([0,0,45])
            cube([square_side,square_side,tool_height],center=true);
        translate([dist_cube_cylinder,0,0]) 
            cylinder(r=cylinder_radius,h=tool_height,center=true);
    }

    // Rotating part hole
    translate( [dist_cube_cylinder,0,0 ])
        make_rotating_part(rot_hollow_big_radius,rot_hollow_small_radius,rot_hollow_top_bottom_height+0.1,rot_hollow_center_height);
    
    // Square hollow
    translate([-square_thickness,0,square_thickness])
        rotate([0,0,45])
                cube([square_side,square_side,tool_height], center=true);

    // Hollow on the sides
    translate([dist_cube_cylinder/2,-cylinder_radius*2+hollow_depth,0]) 
        cylinder(h=tool_height+0.1,r=cylinder_radius,center=true);
    translate([dist_cube_cylinder/2,cylinder_radius*2-hollow_depth,0]) 
        cylinder(h=tool_height+0.1,r=cylinder_radius,center=true);
    

}

// Rotating cylinder
translate([dist_cube_cylinder,0,0])
    difference() {
        make_rotating_part(big_radius,small_radius,top_bottom_height,center_height);
        // Hollow for tape end
        rotate ([0,0,90]) 
            cube([tape_width,tape_thickness,tool_height+0.1],center=true);
        // Hollow for magnet
        if( magnet=="yes" ) {
           translate([-big_radius/2,0,-tool_height/2+magnet_height/2]) 
                cylinder(h=magnet_height+0.1, r=magnet_radius, center=true);
        }
}

// Module used to create the hollow part and the rotating cylindrical part as they are identical in shape
module make_rotating_part( big_radius, small_radius, h1, h2 ) {
    union() {
        //center part
        translate([0,0,0]) 
            cylinder(h=h2,r=small_radius,center=true);
        // Upper bevel
        translate([0,0,h2/2-bevel]) 
            cylinder(h=bevel,r2=big_radius,r1=small_radius,center=false);
        // Upper cylinder
        translate([0,0,h2/2]) 
            cylinder(h=h1,r=big_radius,center=false);
        // Lower bevel
        translate([0,0,-h2/2]) 
            cylinder(h=bevel,r1=big_radius,r2=small_radius,center=false);
        // Lower cylinder
        translate([0,0,-h2/2-h1]) 
            cylinder(h=h1,r=big_radius,center=false);
    }
}
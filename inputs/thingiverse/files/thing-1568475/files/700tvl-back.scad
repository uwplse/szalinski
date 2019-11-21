/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in May 2016
 *
 * Licensed under the
 * Creative Commons - Attribution - Share Alike license.
 */

// -----------------------------------------------------------

width = 36;
height = 36;
depth = 1;

hole_bottom = 2.8;
hole_top = 3.8;
hole_dist = 3.7;

cut_height = 4.4;
cut_width = 8;
cut_dist_x = 20.4;
cut_dist_y = 2;

font = "Liberation Sans:style=Bold";
text_depth = 0.4;
string = "FPV";

$fn = 20;

// -----------------------------------------------------------

difference() {
    cube([width, height, depth]);
    
    translate([width - hole_dist, hole_dist, 0])
        cylinder(d1 = hole_bottom, d2 = hole_top, h = depth);
    
    translate([hole_dist, height - hole_dist, 0])
        cylinder(d1 = hole_bottom, d2 = hole_top, h = depth);
    
    translate([cut_dist_x, cut_dist_y, 0])
        cube([cut_width, cut_height, depth]);
    
    translate([width / 2, height / 2, depth - text_depth])
        linear_extrude(height = text_depth)
        text(string, font = font, size = 10, halign = "center", valign = "center");
}

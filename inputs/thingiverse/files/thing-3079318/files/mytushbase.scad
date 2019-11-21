//#############################################################################
//
// Customizable TUSH base
// ======================
//
// Impressed with the TUSH but I found them to be a little unstable on their own. I looked for a base for them
// but most came in sizes which I have never seen here in the UK. So I decided to design my own parametric version
// and this is the result.
// This is still work in progress and I am also open to suggestions.
// The width is the spool walls, centre to centre.
//
// Author: Dave Johns 2018
// Licensed under the Creative Commons - Attribution-NonCommercial 4.0 International (CC BY-NC 4.0). 
// https://creativecommons.org/licenses/by-nc/4.0/
//
//#############################################################################width=62.5

// Width of the spool centre to centre
width = 62.5; // 1Kg standard spool
//width = 47; // 750g spool
wall_thickness = 1.5;
wall_height = 4;
stretcher_width = 6;
stretcher_height = 3;
font = "Comic Sans";
font_size = 4;
spacing = 1.5;
text = "TUSH";
tush_length = 127;
tush_width = 15;

foot();
translate([0, width, 0])
    foot();
translate([(tush_length / 3) + wall_thickness - stretcher_width, tush_width + (2 * wall_thickness), 0])
    cube([stretcher_width, width - tush_width - (2 * wall_thickness), stretcher_height]);
translate([(2 * tush_length / 3) + wall_thickness, tush_width + (2 * wall_thickness), 0])
    cube([stretcher_width, width - tush_width - (2 * wall_thickness), stretcher_height]);
translate([(tush_length / 3) + wall_thickness - (stretcher_width / 2), wall_thickness + (width + tush_width) / 2, stretcher_height]) linear_extrude(1) rotate([0, 0, 90]) text(text,size=font_size,font=font,halign="center",valign="center",spacing=spacing);

module foot() {
    difference() {
        cube([tush_length + (2 * wall_thickness), tush_width + (2 * wall_thickness), wall_height + wall_thickness], false);
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([tush_length, tush_width, wall_height+1], false);
    }
}

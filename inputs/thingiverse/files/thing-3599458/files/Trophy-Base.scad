// Trophy Base 1.0
// Author: Alexander Smith
// Released: April 30, 2019.
// License: CC BY 4.0 <https://creativecommons.org/licenses/by/4.0/>
//
// This renders a trophy base with text.

// The variables at the top are formatted for the Thingiverse Customizer.

// Set this to false to incrase detail for the final render. Rendering will be much slower.
preview = true; // [true: "Low-res preview", false: "Slow, high-res final"]

// Part to render.
part = "preview1";   // [single:Single-extruder, preview1:v1 Preview, base:v1 Dual - Base, text:v1 Dual - Text, preview2:v2 Preview, column:v2 Dual - Base, plaque:v2 Dual - Plaque, support:'Print as support' model]

// Height of the trophy base.
trophy_h = 120;     // [0:1:300]

// Diameter of the top plate.
top_diam = 120;     // [0:1:300]

// Height and width of the steps.
step_width = 5;     // [0:0.5:10]

// Plaque width.
plaque_w = 110;     // [0:1:300]

// Plaque height.
plaque_h = 80;      // [0:1:300]

// Distance plaque extends from front of cylinder.
plaque_ext = 5;    // [0:0.5:20]

// Text extrusion
text_d = 2;         // [0:0.05:5]


// Top line of text.
text_1 = "World's";

// Middle line of text.
text_2 = "#1";

// Bottom line of text.
text_3 = "Person";


// Size of top line of text. Very small text won't print well. 
text_size_1 = 15;   // [0:0.5:300]

// Size of middle line of text.
text_size_2 = 40;   // [0:0.5:300]

// Size of bottom line of text.
text_size_3 = 15;   // [0:0.5:300]


// Font for the top line of text. The Google Fonts should all work (fonts.google.com).
text_font_1 = "Gentium Basic";

// Font for the middle line of text.
text_font_2 = "Wendy One";

// Font for the bottom line of text.
text_font_3 = "Gentium Basic";


// Fine tune vertical position of top line of text.
text_nudge_1 = 0;   // [-10:0.1:10]

// Fine tune middle line of text.
text_nudge_2 = 0;   // [-10:0.1:10]

// Fine tune bottom line of text.
text_nudge_3 = 0;   // [-10:0.1:10]


/* [Preview Colours] */
// Base colour.
base_color = [0.74, 0.6, 0.42];

// Plaque & text colour.
plaque_color = [0.8, 0.8, 0.8];


/* [Hidden] */
$fa = preview ? 6 : 0.5;
eps = preview ? 1.0e-2 : 1.0e-3;

// preview[view:south, tilt=top diagonal]

// Sum the first n items of vector v.
function add_first(v, n=0) = 
    (n==0)
        ? 0.0
        : v[n-1] + add_first(v, n-1);


module column(trophy_h, top_diam, step_width) {
    r = top_diam/2;
    
    union() {
        cylinder(r=r, h=trophy_h);
        cylinder(r=r + step_width, h=trophy_h - step_width);
        
        cylinder(r=r + 2*step_width, h=2*step_width);
        cylinder(r=r + 3*step_width, h=step_width);
    }
}


module plaque_plate(trophy_h, top_diam, step_width, plaque_size, plaque_ext) {
    r = top_diam/2 + step_width + plaque_ext;
    w = plaque_size[0];
    h = plaque_size[1];
    
    dh = (trophy_h - 3*step_width) / 2 + 2*step_width;
    
    translate([0, -r, dh]) rotate([90, 0, 0])
        translate([-w/2, -h/2, -r])
            cube([w, h, r]);
}

module plaque_plate_support(trophy_h, top_diam, step_width, plaque_size, plaque_ext) {
    r = top_diam/2 + step_width + plaque_ext;
    w = plaque_size[0];
    h = plaque_size[1];
    
    dh = (trophy_h - 3*step_width) / 2 + 2*step_width;
    
    difference() {
        translate([0, -r, 0]) rotate([90, 0, 0])
            // We shrink the box by eps so that the difference comes otu clean.
            translate([-w/2, 0, -r] + [eps, eps, 0])
                cube([w, h, r] - eps*[2, 2, 1]);
        
        union() {
            column(trophy_h, top_diam, step_width);
            plaque_plate(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
        }
    }
}


module plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d, text_lines, text_sizes, text_nudge, text_fonts) {
    r = top_diam/2 + step_width + plaque_ext;
    h = plaque_size[1];
    dh = (trophy_h - 3*step_width) / 2 + 2*step_width;
    
    // Space out the text evenly.
    dt = (h - add_first(text_sizes, 3)) / 4;
    
    etch_depth = min(4, r/10);
    
    translate([0, -r, dh]) rotate([90, 0, 0])
        for (i = [0:2]) {   // 0:2
            if (len(text_lines[i]) > 0) {
                padding = (i+1)*dt;
                prev_sizes = add_first(text_sizes, i);
                v_shift = padding + prev_sizes + text_sizes[i]/2;
                translate([0, h/2 - v_shift + text_nudge[i], -etch_depth])
                    linear_extrude(etch_depth + text_d)
                        text(text=text_lines[i], size=text_sizes[i],
                             font=text_fonts[i], valign="center", halign="center");
            }
        }
}


module column_and_plaque(trophy_h, top_diam, step_width, plaque_size, plaque_ext) {
    column(trophy_h, top_diam, step_width);
    plaque_plate(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
}


/*
 * Render a trophy base.
 * trophy_y: total height of the base
 * top_diam: diameter of the top platform
 * step_width: width and height of the trophy steps
 * plaque_size: [width, height] of the plaque
 * plaque_ext: how far the plaque extends from the column (recommended: = 2*step_width)
 * text_d: how far the text extends out from the surface of the plaque
 * text_lines: three text strings. (If you only want one, use the middle one.)
 * text_nudge: vertical shift to apply to each line of text
 * text_sizes: size of each line of text
 * text_fonts: font names to use for each line
 * part: which part to render:
 *     "single": single-extruder: everything
 *     "base": dual-extruder v1: column and plaque
 *     "text": dual-extruder v2: text
 *     "column": dual-extruder v2: column
 *     "plaque": dual-extruder v2: plaque and text
 *     "preview1": color render of v1 (default)
 *     "preview2": color render of v2
 */
module trophy_base(
    trophy_h = 120,
    top_diam = 120,
    step_width = 5,
    plaque_size = [110, 80],
    plaque_ext = 5,
    text_d = 2,
    text_lines = ["OpenSCAD", chr(9786) /* smiley face emoji U+263A */, "Rocks!"],
    text_sizes = [12, 40, 12],
    text_nudge = [0, 0, 0],
    text_fonts = ["Liberation Serif", "Liberation Serif", "Liberation Serif"],
    part = "single",
    base_color = [0.74, 0.6, 0.42],
    plaque_color = [0.8, 0.8, 0.8])
{
    if (part == "preview1") {
        color(base_color) column_and_plaque(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
        color(plaque_color) plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d, text_lines, text_sizes, text_nudge, text_fonts);
    
    } else if (part == "preview2") {
        color(base_color) column(trophy_h, top_diam, step_width);
        color(plaque_color) {
            plaque_plate(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
            plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d, text_lines, text_sizes, text_nudge, text_fonts);
        }
    
    } else if (part == "base") {    // version 1
        color(base_color) difference() {
            column_and_plaque(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
            plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d + 1, text_lines, text_sizes, text_nudge, text_fonts);
        }
    
    } else if (part == "text") {    // version 1
        color(plaque_color) plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d, text_lines, text_sizes, text_nudge, text_fonts);
    
    } else if (part == "column") {   // version 2
        color(base_color) difference() {
            column(trophy_h, top_diam, step_width);
            union() {
                plaque_plate(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
                plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d, text_lines, text_sizes, text_nudge, text_fonts);
            }
        }
    
    } else if (part == "plaque") {  // version 2
        color(plaque_color) {
            plaque_plate(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
            plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d + 1, text_lines, text_sizes, text_nudge, text_fonts);
        }
    
    } else if (part == "support") {
        plaque_plate_support(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
    
    } else {    // "single" or unknown
        column_and_plaque(trophy_h, top_diam, step_width, plaque_size, plaque_ext);
        plaque_text(trophy_h, top_diam, step_width, plaque_size, plaque_ext, text_d, text_lines, text_sizes, text_nudge, text_fonts);
    }
}


trophy_base(trophy_h, top_diam, step_width,
    plaque_size=[plaque_w, plaque_h],
    plaque_ext=plaque_ext,
    text_d=text_d,
    text_lines=[text_1, text_2, text_3],
    text_sizes=[text_size_1, text_size_2, text_size_3],
    text_nudge=[text_nudge_1, text_nudge_2, text_nudge_3],
    text_fonts=[text_font_1, text_font_2, text_font_3],
    part=part
);

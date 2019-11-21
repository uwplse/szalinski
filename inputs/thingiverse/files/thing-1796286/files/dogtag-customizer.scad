/******************************************************************************
**  DOG TAG GENERATOR version 1.2.0 (2016-09-28)                             **
**  Copyright (c) Michal A. Valasek - Altairis, 2016                         **
******************************************************************************/ 

/* [Text] */
// (pet name)
line_1_text = "BOLT";
// (try 2-6, decimals allowed)
line_1_size = 6;
// phone number
line_2_text = "555-123456";
// (try 2-6, decimals allowed)
line_2_size = 4;
// (in OpenSCAD format; do not modify unless you know exactly what you are doing)
text_font = "Arial:style=Bold";
// (ISO  code  such as en, de, it, fr, es...; may help with non-standard characters)
text_language = "cs";

/* [Appearance] */
// (mm)
total_diameter = 36;
// (mm)
hole_diameter = 5;
// from side to side (mm)
hole_distance = 3;
// (mm)
border_width = 1;

/* [Print Settings] */
number_of_text_layers = 2; 
number_of_base_layers = 5;
// (mm)
first_layer_height = 0.15;
// (mm) 
normal_layer_height = 0.2; 

/* [Hidden] */
total_radius = total_diameter / 2;                                                      // computed overall radius
hole_radius = hole_diameter / 2;                                                        // computed hole radius
text_height = normal_layer_height * number_of_text_layers;                              // text and rim extrusion height
plate_height = (number_of_base_layers - 1) * normal_layer_height + first_layer_height;  // base plate height in mm
$fn = 36;                                                                               // default number of fragments

// Border
if(border_width > 0){
    translate([0, 0, plate_height + text_height / 2] ) { 
        difference() {
            cylinder(h = text_height, r = total_radius, center = true);
            cylinder(h = text_height + 1, r = total_radius - border_width, center = true);
        }
        translate([0, total_radius - hole_distance - hole_radius, 0]) {
            difference() {
                cylinder(h = text_height, r = hole_radius + border_width, center = true);
                cylinder(h = text_height + 1, r = hole_radius, center = true);
            }
        }
    }
}

// Text
translate([0, 0, plate_height]) {
    // Name (text line 1)
    linear_extrude(height = text_height) text(text = line_1_text, size = line_1_size, font = text_font, halign = "center", valign = "baseline", language = text_language);

    // Phone number (text line 2)
    translate([0, - total_radius / 2, 0]) linear_extrude(height = text_height) text(text = line_2_text, size = line_2_size, font = text_font, halign = "center", valign = "bottom", language = text_language);
}

// Base plate with hole
translate([0, 0, plate_height / 2]) {
    difference() {
        cylinder(h = plate_height, r = total_radius, center = true);
        translate([0, total_radius - hole_distance - hole_radius, 0]) cylinder(h = plate_height + 1, r = hole_radius, center = true);
    }
}

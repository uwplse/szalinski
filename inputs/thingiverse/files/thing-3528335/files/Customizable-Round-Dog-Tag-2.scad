

/* [Text] */
// pet name (Holding the WIN key and tap the period may allow you to add symbols)
line_1_text = "I LUV";
// try 2-6, decimals allowed
line_1_size = 6;
// phone number
line_2_text = "MY DOG";
// try 2-6, decimals allowed
line_2_size = 5;
// ISO language code (en, de, it, fr, es...) may help with non-standard characters
text_language = "en";
fontname="DejaVu Sans:DejaVu Sans Condensed Bold"; // [DejaVu Sans:DejaVu Sans Condensed Bold, Coustard:Coustard bold, Permanent Marker, Gloria Hallelujah, Arial:Arial bold, Pacifico, Courgette, Domine:Domine bold, Ultra, Bevan ]


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
number_of_text_layers = 3; 
number_of_base_layers = 5;
// (mm)
first_layer_height = 0.15;
// (mm) 
normal_layer_height = 0.15; 

/* [Hidden] */
total_radius = total_diameter / 2;                                                      // computed overall radius
hole_radius = hole_diameter / 2;                                                        // computed hole radius
text_height = normal_layer_height * number_of_text_layers;                              // text and rim extrusion height
plate_height = (number_of_base_layers - 1) * normal_layer_height + first_layer_height;  // base plate height in mm
$fn = 36;         

// default number of fragments

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
    linear_extrude(height = text_height) text(text = line_1_text, size = line_1_size, font = fontname, halign = "center", valign = "baseline", language = text_language);

    // Phone number (text line 2)
    translate([0, - total_radius / 2, 0]) linear_extrude(height = text_height) text(text = line_2_text, size = line_2_size, font = fontname, halign = "center", valign = "bottom", language = text_language);
}
// Base plate with hole
translate([0, 0, plate_height / 2]) {
    difference() {
        cylinder(h = plate_height, r = total_radius, center = true);
        translate([0, total_radius - hole_distance - hole_radius, 0]) cylinder(h = plate_height + 1, r = hole_radius, center = true);
    }
}
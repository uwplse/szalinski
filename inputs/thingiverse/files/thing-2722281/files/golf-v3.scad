// Hole diameter (108mm is the standard 4.25" golf hole, though 57mm is also good for office golf)
hole_diameter = 57;

// Base diameter
base_diameter = 200;

// Hole height
height = 12;

// Top text
top_label = "Top line!";

// Top text size
top_text_size = 15;

// Top font:
top_font = "Liberation Sans";

// Top line text height adjustment (positive moves up, negative down)
top_height_adjust = 0;

// Bottom text
bottom_label = "Play ball!";

// Bottom text size
bottom_text_size = 15;

// Bottom font:
bottom_font = "Liberation Sans";

// Bottom line text height adjustment (positive moves up, negative down)
bottom_height_adjust = 0;

//---------------------------------------------------

// Math:
hole_radius = hole_diameter /2;
base_radius = base_diameter / 2;
cone_height = height / ((base_radius - hole_radius) / base_radius); 

bottom_text_center = -bottom_height_adjust + hole_radius + (base_radius-hole_radius) /3;
top_text_center = top_height_adjust + hole_radius + (base_radius-hole_radius) /3;


// Subtract hole & text from cone
difference() {
    // Draw cone
    cylinder(h = cone_height, r1 = base_radius, r2 = 0, center = true);

    // Subtract hole
    cylinder(h = cone_height, r1 = hole_radius, r2 = hole_radius, center = true);
    
    // Subtract bottom label
    translate([0, -bottom_text_center, 1]) {
        linear_extrude(height = cone_height,center=true) {
            text(text = bottom_label, font = bottom_font, size = bottom_text_size, valign = "center", halign = "center");
        }
    }
    
    // Subtract top label
    translate([0, top_text_center, 1]) {
        linear_extrude(height = cone_height,center=true) {
            text(text = top_label, font = top_font, size = top_text_size, valign = "center", halign = "center");
        }
    }
    
}
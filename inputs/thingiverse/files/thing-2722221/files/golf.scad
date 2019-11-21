// Hole diameter (57.15mm is the standard 4.25" golf hole)
hole_diameter = 57.15;

// Base diameter
base_diameter = 150;

// Height
height = 10;

// label
label = "Play ball!";

// Text size
text_size = 15;

// Font:
font = "Liberation Sans";

// Text height adjustment (positive moves up, negative down)
height_adjust = 0;



// Math:
hole_radius = hole_diameter /2;
base_radius = base_diameter / 2;
cone_height = height / ((base_radius - hole_radius) / base_radius); 
text_center = -height_adjust + hole_radius + (base_radius-hole_radius) /3;


// Subtract hole & text from cone
difference() {
    // Draw cone
    cylinder(h = cone_height, r1 = base_radius, r2 = 0, center = true);

    // Subtract hole
    cylinder(h = cone_height, r1 = hole_radius, r2 = hole_radius, center = true);
    
    // Subtract label
    translate([0, -text_center, 0]) {
        linear_extrude(height = cone_height,center=true) {
            text(text = label, font = font, size = text_size, valign = "center", halign = "center");
        }
    }
}
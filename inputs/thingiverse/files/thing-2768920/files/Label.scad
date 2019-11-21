// Label text
label = "Sockets";

//Label length
label_length = 87;

// Label thickness
label_thickness = 1.5;

// Text thickness
text_thickness = 1.5;

// Text size
font_size = 16;

// Label height
label_height = 20;

// Font
font = "REGISTRATION PLATE UK:style=Bold";

// Make the label
// Make the base
color("red") cube([label_length,label_height,label_thickness]);

// Create the text
color("white") translate([2,2,label_thickness])
linear_extrude(height = text_thickness) {
        text(text = str(label), font = font, size = font_size);
}

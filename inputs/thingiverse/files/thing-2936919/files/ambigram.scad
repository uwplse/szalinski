text_1 = "HELLO";

text_2 = "WORLD";

font_size = 20;

//size of the space between letters
font_spacing = 8;

font = "Source Code Pro:style=Bold";

build_base = "yes"; //[yes,no]

base_type = "circle"; //[circle,square]

union() {
    length = max(len(text_1), len(text_2));    
    base_offset = build_base == "yes" ? font_size / 5 : 0;
    
    // generate letters
    translate([0, 0, base_offset]) intersection() {
        
        // generate letter extrusions for first text
        translate([0, (font_spacing + font_size) * length, 0]) rotate([90, 0, 0]) {
            for (i = [0 : len(text_1) - 1]) {
                linear_extrude(height = (font_spacing + font_size) * length) // extrude the letters
                    translate([(font_size + font_spacing) * (i + 0.5), 0, 0]) // shift half the total allocated space
                    text(text_1[i], size = font_size, font = font, halign = "center");
            }
        }
        
        // generate letter extrusions for second text
        rotate([90, 0, 90]) {
            for (i = [0 : len(text_2) - 1]) {
                linear_extrude(height = (font_spacing + font_size) * length) // extrude the letters
                    translate([(font_size + font_spacing) * (i + 0.5), 0, 0]) // shift half the total allocated space
                    text(text_2[i], size = font_size, font = font, halign = "center");
            }
        }

        // generate cubes around desired letters
        for (i = [0 : length - 1]) {
            translate([(font_size + font_spacing) * i, (font_size + font_spacing) * i, 0]) 
                cube(font_size + font_spacing);
        }

    }

    //generate base
    if (build_base == "yes") {
        hull() {
            translate([(font_size + font_spacing) * (0.5), (font_size + font_spacing) * (0.5), font_size / 5 * (0.5)])
                if (base_type == "circle") {
                    cylinder(h = font_size / 5, r = (font_size + font_spacing) / 2, center = true);
                } else {
                    cube([font_size + font_spacing, font_size + font_spacing, font_size / 5], center = true);
                }
            translate([(font_size + font_spacing) * (length - 0.5), (font_size + font_spacing) * (length - 0.5), font_size / 5 * (0.5)])
                if (base_type == "circle") {
                    cylinder(h = font_size / 5, r = (font_size + font_spacing) / 2, center = true);
                } else {
                    cube([font_size + font_spacing, font_size + font_spacing, font_size / 5], center = true);
                }
        }
    }
}
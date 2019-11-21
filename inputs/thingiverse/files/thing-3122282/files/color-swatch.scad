
label_text = "Example";
text_size = 4;
text_emboss_depth = 0.4;
swatch_square_size = 15;
num_squares = 5;
3d_line_width = 0.45;
3d_line_height = 0.2;
add_hole = "yes"; // [yes,no]
hole_diameter = 5;

/* [Hidden] */
border = 3d_line_width * 2;
total_width = swatch_square_size * 1.5 + (border * 2);
total_len = swatch_square_size * num_squares + (border * 2);
swatch_len = total_len - (border * 2);
ext_dist = 1;
_text_depth = 3d_line_height * num_squares - text_emboss_depth;
thickness = 3d_line_height * num_squares;

// preview[view:south, tilt:top]

module _text(label) {
    translate([border + 1, total_width - border * 2, _text_depth])
    linear_extrude(ext_dist) 
    text(label, size = text_size, valign = "top", halign = "left", font = "Helvetica:style=Bold");
}

difference() {
    union() {
        difference() {
            translate([0, 0, 0]) cube([total_len, total_width, 3d_line_height * num_squares]);
            translate([border, border, 0]) cube([swatch_len, swatch_square_size, 3d_line_height * 9]);
        }
        
        for(i = [0:num_squares - 1]) {
            translate([border, border, 3d_line_height * i]) cube([swatch_len - swatch_square_size * i, swatch_square_size, 3d_line_height]);
        }
        
    }
    
    _text(label_text);
    
    if(add_hole == "yes") {
        translate([total_len - hole_diameter + 1, total_width - ((total_width - swatch_square_size) / 2) + 1, -3d_line_height])
        cylinder($fn = 150, h = thickness + 3d_line_height * 2, r = hole_diameter / 2);
    }
}

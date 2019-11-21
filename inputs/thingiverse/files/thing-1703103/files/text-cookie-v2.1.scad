// (recommended ALL UPPERCASE/CAPITAL LETTERS)
text = "TEXT";

text_size = 50; // [5:1:300]

// (less than 100% helps letters stay connected)
letter_spacing_percentage = 80; // [10:1:200]

// (also helps to keep letters joined)
include_underline = 1; // [0:No, 1:Yes]

underline_height_percentage = 15; // [1:1:50]

// (millimeters)
wall_height = 20; // [1:0.1:40]

// (millimeters)
wall_thickness = 1; // [0:0.1:10]

// (millimeters)
top_support_overhang = 2; // [0:0.1:10]

// (millimeters)
top_support_thickness = 1; // [0:0.1:10]

number_of_support_lines = 3; // [0:1:10]

support_line_height_percentage = 18; // [0:1:50]

support_line_offset_percentage = 12; // [-100:1:100]

// Render a preview of the cookie (turn this OFF before saving/printing)
cookie_preview = 0; // [0:Off, 1:On]


// str2vec from Nathanael Jourdane (nathanael@jourdane.net)
// http://www.thingiverse.com/thing:1237203
function str2vec(str, v=[], i=0) =
	i == len(str) ? v :
	str2vec(str, concat(v, str[i]), i+1);

module Text2D(text, size, underline=0, underline_height=0.16, spacing=0.8, radius=0) {
    offset(r=radius) {
        text(str(text),
            size=size,
            font="Helvetica:style=Bold",
            halign="center",
            spacing=spacing);
        if (underline == 1) {
            descenders = len([ for (a = search(str2vec("qpjg"), str2vec(str(text)))) if (a > 0) a ]) > 0;
            descender_correction = descenders ? 0.3 * size * underline_height : 0;
            translate([0, -1 * descender_correction, 0]) projection(cut = false) scale([1, -1 * underline_height, 1]) hull() BoundingBox() linear_extrude(height=1, convexity=4) {
                text(str(text),
                    size=size,
                    font="Helvetica:style=Bold",
                    halign="center",
                    spacing=spacing);
            }
        }
    }
}

module OutlineText(text, size, underline=0, underline_height=0.16, spacing=0.8, height=3, thickness=1) {
    linear_extrude(height=height, convexity=4) {
        difference() {
            Text2D(text, size, underline, underline_height, spacing, thickness);
            translate([0, 0, 0.1]) scale([1, 1, 1.5]) Text2D(text, size, underline, underline_height, spacing, 0);
        }
    }
}

module OutlineTextSupports(text, size, underline=0, spacing=0.8, thickness=1, height=3, overhang=10, number_of_support_lines=3, support_line_height=0.15, support_line_offset=0, underline_height=0.16) {
    linear_extrude(height=height, convexity=4) union() {
        difference() {
            offset(overhang) projection(cut = false) hull() BoundingBox() linear_extrude(height=1, convexity=4) Text2D(text, size, underline, underline_height, spacing, thickness);
            Text2D(text, size, underline, underline_height, spacing, 0);
        }
        
        descenders = len([ for (a = search(str2vec("qpjg"), str2vec(str(text)))) if (a > 0) a ]) > 0;
        descender_correction = descenders ? 0.3 * size * underline_height : 0;
        underline_size = (underline == 1) ? size * underline_height + descender_correction : 0;
        v_size = size + underline_size;
        v_space = v_size / number_of_support_lines;
        
        for (s = [0 : 1 : number_of_support_lines - 1]) {
            translate([0, s * v_space - underline_size + (v_space / 2) - (support_line_height * size / 2) + (support_line_offset * v_space), 0]) projection(cut = false) scale([1, support_line_height, 1]) hull() BoundingBox() linear_extrude(height=1, convexity=4) Text2D(text, size, underline, underline_height, spacing, thickness);
        }
    }
}

module BoundingBox() {
    intersection() {
        translate([0,0,0])
        linear_extrude(height = 1000, center = true, convexity = 10, twist = 0) 
        projection(cut=false) intersection() {
            rotate([0,90,0]) 
            linear_extrude(height = 1000, center = true, convexity = 10, twist = 0) 
            projection(cut=false) 
            rotate([0,-90,0]) 
            children(0);
            rotate([90,0,0]) 
            linear_extrude(height = 1000, center = true, convexity = 10, twist = 0) 
            projection(cut=false) 
            rotate([-90,0,0]) 
            children(0);
        }
        rotate([90,0,0]) 
        linear_extrude(height = 1000, center = true, convexity = 10, twist = 0) 
        projection(cut=false) 
        rotate([-90,0,0])
        intersection() {
            rotate([0,90,0]) 
            linear_extrude(height = 1000, center = true, convexity = 10, twist = 0) 
            projection(cut=false) 
            rotate([0,-90,0]) 
            children(0);
            rotate([0,0,0]) 
            linear_extrude(height = 1000, center = true, convexity = 10, twist = 0) 
            projection(cut=false) 
            rotate([0,0,0]) 
            children(0);
        }
    }
}


// Lower the minimum fragment size for smoother edges
$fs = 0.1;

if (cookie_preview == 1) {
    linear_extrude(height=4, convexity=4) {
        Text2D(text, text_size, include_underline, underline_height_percentage / 100.0, letter_spacing_percentage / 100.0, 0);
    }
} else {
    translate([0, 0, wall_height + top_support_thickness - 0.01]) scale([-1, 1, -1]) union() {
        OutlineText(text, text_size, include_underline, underline_height_percentage / 100.0, letter_spacing_percentage / 100.0, wall_height + top_support_thickness, wall_thickness);
        translate([0, 0, wall_height]) OutlineTextSupports(text, text_size, include_underline, letter_spacing_percentage / 100.0, wall_thickness, top_support_thickness, top_support_overhang, number_of_support_lines, support_line_height_percentage / 100.0, support_line_offset_percentage / 100.0, underline_height_percentage / 100.0);
    }
}

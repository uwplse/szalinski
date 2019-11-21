// Customizable section

top_text = "Customizable";
top_text_font_size = 13;

bottom_text = "3D Printing";
bottom_text_font_size = 13;


// Multiplier for extra space around each text character; slightly more space should prevent stringing and make text easier to paint. If you want to fit more text, go down to 1.0
spacing = 1.1; //[1.0:Original Size, 1.1:1.1x spacing, 1.2:1.2x spacing, 1.3:1.3x spacing]

// How high to raise up the text, in mm
text_height = 2;


/* [Hidden] */

hole_radius = 3.75;
hole_center_distance_x = 146;
hole_center_distance_y = 70;
hole_offset_x = 15.5 + hole_radius;
hole_offset_top_y = 19.4 + hole_radius;
hole_offset_bottom_y = 24.5 + hole_radius;


wall_width = 3;
total_height = 3;

border_distance_x = 184.15;
border_distance_y = 121;

corner_radius = 12;

side_border = 16.2;
top_border = 19.5;
bottom_border = 25;

module screw_hole() {
    cylinder(r=hole_radius, h=total_height);
}

module mounting_screw_holes() {
    translate([hole_offset_x, hole_offset_bottom_y, 0]) {
        screw_hole();
        translate([hole_center_distance_x,0,0]) { screw_hole(); }
        translate([hole_center_distance_x,hole_center_distance_y,0]) { screw_hole(); }
        translate([0, hole_center_distance_y, 0]) { screw_hole(); }
    }
}

module screw_hole_border() {
        square_part = 2 * wall_width + 2*hole_radius;
        translate([0,0,total_height/2]) {
            cylinder(r=hole_radius + wall_width, h=total_height, center = true);
        }
        
}

module mounting_screw_holes_border() {
    translate([hole_offset_x, hole_offset_bottom_y, 0]) {
        screw_hole_border();
        translate([hole_center_distance_x,0,0]) { screw_hole_border(); }
        translate([hole_center_distance_x,hole_center_distance_y,0]) { screw_hole_border(); }
        translate([0, hole_center_distance_y, 0]) { screw_hole_border(); }
    }
}


module border(border_distance_x, border_distance_y, wall_width, offset) {
    translate([offset,offset,0]) {
        // main body
        translate([corner_radius, 0, 0]) {
            cube([border_distance_x - 2*corner_radius, border_distance_y, wall_width]);
        }
        translate([0,corner_radius, 0]) {
            cube([border_distance_x, border_distance_y - 2*corner_radius, wall_width]);
        }
        
        // rounded corners
        translate([corner_radius, corner_radius, 0]) {
            cylinder(r=corner_radius, h=wall_width);
        }
        translate([border_distance_x - corner_radius, corner_radius, 0]) {
            cylinder(r=corner_radius, h=wall_width);
        }
        translate([border_distance_x - corner_radius, border_distance_y - corner_radius, 0]) {
            cylinder(r=corner_radius, h=wall_width);
        }
        translate([corner_radius, border_distance_y - corner_radius, 0]) {
            cylinder(r=corner_radius, h=wall_width);
        }
    }
}

module open_plate_area() {
        translate([side_border, bottom_border, 0]) {
            cube([border_distance_x - 2 * side_border, border_distance_y - top_border - bottom_border, total_height]);
        }
}

module top_text() {
        translate([border_distance_x / 2, border_distance_y - (top_border / 2), total_height]) {
                linear_extrude(text_height) {
                    text(top_text, halign = "center", valign = "center", size=top_text_font_size, spacing=spacing);
                }
        }
}

module bottom_text() {
        translate([border_distance_x / 2, bottom_border / 2, total_height]) {
                linear_extrude(text_height) {
                    text(bottom_text, halign = "center", valign = "center", size=bottom_text_font_size, spacing = spacing);
                }
        }
}



top_text();
bottom_text();

difference() {
    union() {
        difference() {
            // main body
            border(border_distance_x, border_distance_y, total_height, 0);
            open_plate_area();
        }
        difference() {
            mounting_screw_holes_border();
        }         
    }
    // clear out room for screws
    mounting_screw_holes();
   
}

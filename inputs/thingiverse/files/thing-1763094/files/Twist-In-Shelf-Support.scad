// The thickness of the circle that fits into the hole in the metal track.
dot_thickness = 1.25;

// The thickness of the oval portion behind the dot. This should fill the rest of the space inside the track.
oval_thickness = 2.5;

// The thickness of the vertical and horizontal flat portions of the support.
clip_thickness = 2.5;

// The distance between the "oval" and the back of the support. This depends on the thickness of the front portion of the metal track.
spacer_thickness = 1.8;

// Diameter of the hole in the metal track.
dot_diameter = 5;

// Width of the inside of the metal track.
oval_width = 10;

// Width of the support. Independent of the track size.
clip_width = 10;

// Depth of the support. (How much of the shelf rests on the support.)
clip_depth = 12;

module twist_in_shelf_support(dot_thickness=dot_thickness, oval_thickness=oval_thickness, clip_thickness=clip_thickness, spacer_thickness=spacer_thickness, dot_diameter=dot_diameter, oval_width=oval_width, clip_width=clip_width, clip_depth=clip_depth) {
    $fs = .1;
    $fa = 1;
        
    rotate([0, -90, 0]) {
        
        translate([dot_diameter/2, 0, clip_thickness]) cylinder( r=dot_diameter/2, h=dot_thickness + oval_thickness + spacer_thickness );

        translate([dot_diameter/2, 0, clip_thickness + spacer_thickness]) {
            translate([0, (max(oval_width, dot_diameter) - dot_diameter ) / 2, 0]) cylinder( r=dot_diameter/2, h=oval_thickness );
            translate([0, -(max(oval_width, dot_diameter) - dot_diameter ) / 2, 0]) cylinder( r=dot_diameter/2, h=oval_thickness );
            translate([-dot_diameter/2, -(max(oval_width, dot_diameter) - dot_diameter)/2, 0]) cube([dot_diameter, max(oval_width, dot_diameter) - dot_diameter, oval_thickness]) ;
        }

        translate([0, -clip_width / 2, 0]) {
            cube([max( clip_depth, clip_width ) - ( clip_width / 2 ), clip_width, clip_thickness]);
            translate([max( clip_depth, clip_width ) - ( clip_width / 2 ), clip_width / 2, 0]) cylinder(r=clip_width/2, h=clip_thickness);
        }


        translate([0, -clip_width / 2, clip_thickness]) rotate([0, 90, 0 ]) {
            cube([max( clip_depth, clip_width ) - ( clip_width / 2 ), clip_width, clip_thickness]);
            translate([max( clip_depth, clip_width ) - ( clip_width / 2 ), clip_width / 2, 0]) cylinder(r=clip_width/2, h=clip_thickness);
        }

        translate([clip_thickness, -clip_thickness/2, 0]) rotate([-90, 0, 0]) linear_extrude(clip_thickness) polygon(points = [[0, 0], [max( clip_depth, clip_width ) - clip_thickness - clip_thickness, 0], [0, max( clip_depth, clip_width ) - clip_thickness - clip_thickness]]);
    }
}
twist_in_shelf_support(dot_thickness, oval_thickness, clip_thickness, spacer_thickness, dot_diameter, oval_width, clip_width, clip_depth);
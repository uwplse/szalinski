aperture_width = 161;
aperture_height = 94;
frame_thickness = 2;
outer_frame_width = 5;
lip_depth = 5;
rounded_corners = true;

/* [Hidden] */
$fn = 36;

frame_total_width = aperture_width + (2 * outer_frame_width);
frame_total_height = aperture_height + (2 * outer_frame_width);

half_frame_width = outer_frame_width / 2;

module RoundedCorner() {
    intersection() {
        cylinder(r1=half_frame_width, r2=half_frame_width, frame_thickness);

        cube([
            half_frame_width,
            half_frame_width,
            frame_thickness
        ]);
    }
}

module RoundedCornerMask() {
    difference() {
        cube([half_frame_width+1, half_frame_width+1, frame_thickness]);
        RoundedCorner();
    }
}

difference() {
    union() {
        cube([frame_total_width, frame_total_height, frame_thickness]);
        translate([outer_frame_width, outer_frame_width, frame_thickness]) cube([aperture_width, aperture_height, lip_depth]);
    };
    
    translate([
        outer_frame_width + frame_thickness,
        outer_frame_width + frame_thickness,
        0
    ]) {
        cube([
            aperture_width - (2 * frame_thickness),
            aperture_height - (2 * frame_thickness),
            frame_thickness + lip_depth + 2
        ]);
    }
    
    if (rounded_corners) {
        translate([half_frame_width, half_frame_width, 0]) rotate([0, 0, 180]) RoundedCornerMask();
        translate([frame_total_width - half_frame_width, frame_total_height - half_frame_width, 0]) rotate([0, 0, 0]) RoundedCornerMask();
        translate([half_frame_width, frame_total_height - half_frame_width, 0]) rotate([0, 0, 90]) RoundedCornerMask();
        translate([frame_total_width - half_frame_width, half_frame_width, 0]) rotate([0, 0, 270]) RoundedCornerMask();
    }
}

/* [Dimensions] */
// Cord diameter
cord_d=3;
// Height of the cutout in the clip
clip_cutout = 17;

/* [Advanced] */
// Quality
$fn=100;
// Height of the holder
holder_height=7;
// Wall thickness of the holder
holder_thickness=2;
// A bit of margin for the cord
cord_margin=0.5;
// Angle of the cutout
cutout_angle=asin(cord_d/2/(cord_d + cord_margin + holder_thickness * 2)) * 1.3;
// X, Y dimensions of the clip (width, depth)
clip_xy = [20, 20];
// How wide the base of the trapezoid connecting the holder and the clip is
merger_plate_size=12;
// Wall thickness of the clip
clip_thickness = 2;
// Text size
text_size=3;

module holder() {
    difference() {
        cylinder(h=holder_height, d=cord_d + cord_margin + holder_thickness * 2, center=true);
        cylinder(h=holder_height, d=cord_d + cord_margin, center=true);
        translate([-(cord_d + cord_margin + holder_thickness * 2)/2, 0, -holder_height/2]) cutout();
    }
    module half_cutout() {
        rotate_extrude(angle=cutout_angle) 
           translate([holder_thickness + cord_margin, 0, 0]) square(size=2 * (cord_d + cord_margin + holder_thickness * 2), center=false);
    }
    module cutout() {
        half_cutout();
        mirror([0, 1, 0]) half_cutout();
    }
}

module cute_box(size) {
    resize(size) translate([1, 1, 1]) minkowski() {cube(size, false); sphere(1);}
}

module clip() {
    difference() {
        cute_box([clip_xy[0], clip_xy[1], clip_thickness]);
        
        translate([clip_xy[0]/5, clip_xy[1]/5, clip_thickness-0.2])
            linear_extrude(height=0.3)
            text(str(cord_d, "x", clip_cutout), size=text_size);
    }        
    
    translate([0, 0, clip_thickness + clip_cutout])
        cute_box([clip_xy[0], clip_xy[1], clip_thickness]);
        
    cute_box([clip_xy[0], clip_thickness, clip_cutout + clip_thickness * 2]);    
}

module holder_merger() {
    /*let (D=cord_d + cord_margin + holder_thickness * 2)*/ {
        translate([0, 0, -holder_height/2])
        rotate([0, 0, -90])
        difference() {
            hull() {
                cylinder(h=holder_height, d=cord_d + cord_margin + holder_thickness * 2, center=false);
                translate([-merger_plate_size/2, -(cord_d + cord_margin + holder_thickness * 2)/2, holder_height]) rotate([90, 90, 0]) cube([holder_height, merger_plate_size, 0.5]);
            };
            cylinder(h=holder_height, d=(cord_d + cord_margin + holder_thickness * 2), center=false);
        }
    }
}

clip();
translate([clip_xy[0] / 2, clip_xy[1] / 2, clip_cutout + clip_thickness * 2 + (cord_d + cord_margin + holder_thickness * 2) / 2]) rotate([0, -90, 90]) holder();

translate([clip_xy[0] / 2, clip_xy[1] / 2, clip_cutout + clip_thickness * 2 + (cord_d + cord_margin + holder_thickness * 2) / 2]) rotate([0, -90, 90]) holder_merger();


// Lens size for the outer mount (must be the larger of the two lens sizes)
outer_lens_size = 58;

// Lens size for the inner mount (must be the smaller of the two lens sizes)
inner_lens_size = 52;

// Width of your strap (should be slightly larger than the actual strap)
strap_width = 27;

// How large of an opening for the strap to go through
strap_hole = 7;

// Width of the small gap to feed the strap through to get it into the hole
strap_gap = 2;

// How thick to make the walls
wall_thickness = 3;

// The extra space between mounts
mount_height = 3.25;

// Thickness of the base and tabss
base_thickness = 3;

// How far to offset the strap hole from the circular part
offset_clip_to_strap_hole = 3;

// How curved to make the edges around the perimeter
edge_curve_radius = 1;

// Height of the ridges that the lens cap will clip onto
ridge_size = 0.75;

// Number of ridges to make
num_ridges = 3;

// Small value for part merging
delta = 0.001;

// Number of points on a circle
$fn = 32;

h_ridges = num_ridges*ridge_size;
radius_outermost = (outer_lens_size/2) + wall_thickness;

// Main code here
difference() {
    build_base();
    remove_holes();
}

module ridge_cut(base_radius) {
    translate([0, 0, -delta])
        cylinder(r1=base_radius+delta, r2=base_radius-ridge_size-delta, h=(ridge_size/2)+2*delta);
    translate([0, 0, (ridge_size/2)-delta])
        cylinder(r2=base_radius+delta, r1=base_radius-ridge_size-delta, h=(ridge_size/2)+2*delta);
}

module all_ridge_cuts(base_radius) {
    union() {
        for ( i = [1 : num_ridges] ) {
            translate([0, 0, mount_height-i*ridge_size])
                ridge_cut(base_radius);
        }
        cylinder(r=base_radius, h=mount_height-h_ridges+delta);
    }
}

module remove_holes() {
    translate([0, 0, base_thickness+mount_height])
        all_ridge_cuts(outer_lens_size/2);
    translate([0, 0, base_thickness])
        all_ridge_cuts(inner_lens_size/2);

   // I'm not sure just offsetting X by -delta didn't work. It must have something to do with the minkowski edge intersection.
   translate([radius_outermost+offset_clip_to_strap_hole+strap_hole-1,-strap_gap/2, -delta])
        cube([wall_thickness+2, strap_gap, base_thickness+2*delta]);
   translate([-radius_outermost-offset_clip_to_strap_hole-strap_hole-wall_thickness-1,-strap_gap/2, -delta])
        cube([wall_thickness+2, strap_gap, base_thickness+2*delta]);

    minkowski() {
        translate([radius_outermost+offset_clip_to_strap_hole+edge_curve_radius, -strap_width/2+edge_curve_radius, -delta])
        cube([strap_hole-2*edge_curve_radius, strap_width-2*edge_curve_radius, base_thickness+2*delta]);
        sphere(r=edge_curve_radius);
    }
    minkowski() {
        translate([-radius_outermost-offset_clip_to_strap_hole-strap_hole+edge_curve_radius, -strap_width/2+edge_curve_radius, -delta])
            cube([strap_hole-2*edge_curve_radius, strap_width-2*edge_curve_radius, base_thickness+2*delta]);
        sphere(r=edge_curve_radius);
    }
}

module build_base() {
    translate([0, 0, edge_curve_radius])
        minkowski() {
            union() {
                cylinder(r=radius_outermost-edge_curve_radius, h=2*mount_height+base_thickness-2*edge_curve_radius);
                
                translate([0, 0, base_thickness/2-edge_curve_radius])
                    cube([2*(radius_outermost+offset_clip_to_strap_hole+strap_hole+wall_thickness-edge_curve_radius),
                          strap_width+2*wall_thickness-2*edge_curve_radius,
                          base_thickness-2*edge_curve_radius],
                         center=true);
            }
            sphere(r=edge_curve_radius);
        }
    
    curve_strap_to_clip();
}

module curve_strap_to_clip() {
    difference() {
        intersection() {
            cylinder(r=radius_outermost+offset_clip_to_strap_hole, h=base_thickness+offset_clip_to_strap_hole);
            cube([2*(radius_outermost+offset_clip_to_strap_hole+delta),
                  strap_width+2*wall_thickness-2*edge_curve_radius, 
                  3*(base_thickness+offset_clip_to_strap_hole)],
                 center=true);
        }
        rotate_extrude(convexity=10)
                translate([radius_outermost+edge_curve_radius+offset_clip_to_strap_hole-delta, base_thickness+offset_clip_to_strap_hole+edge_curve_radius, 0])
                    circle(r=offset_clip_to_strap_hole+edge_curve_radius);
    }
}

/*

difference() {
    minkowski() {
        cube([box_width, box_height, box_thickness]);
        sphere(r=curve_radius);
    }
    
    translate([-delta-curve_radius, 0, 0])
        cube([box_width+2*curve_radius+2*delta, box_height, box_thickness]);
    
    translate([-delta-curve_radius, tab_height, box_thickness-delta])
        cube([box_width+2*curve_radius+2*delta, box_height-2*tab_height, curve_radius+2*delta]);
    
    translate([tab_width, -curve_radius-delta, 0])
        cube([box_width-2*tab_width, box_height+2*curve_radius+2*delta, box_thickness+curve_radius+delta]);
    
    translate([box_width/2, box_height/4, -curve_radius-delta])
        cylinder(r=hole_radius, h=curve_radius+2*delta);
    
    translate([box_width/2, box_height*3/4, -curve_radius-delta])
        cylinder(r=hole_radius, h=curve_radius+2*delta);

}
*/

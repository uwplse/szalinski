// AM8 Z frame alignment jig
// gmarsh23@thingiverse
// V1.1, apr.27/2018

// distance from rear of printer to rear of Z frame
// 127mm for standard AM8 design
magic_distance = 127;

// main bracket thickness
thickness = 3;
// height of 'ridge' in center of bracket
ridge_height = 2;
// height and width of "hook" on end of bracket
hook_height = 5;
hook_width = 5;

// shrinks center ridge slightly so it fits better in slot without getting stuck
ridge_shrink = 0.2;
// reduces effect of "corner bulge" in corners
corner_radius = 0.5;

// chamfer on end of base that butts against Z frame
// prevents first layer overextrusion from making bracket inconsistently longer
end_chamfer = 0.5;

// hole diameter and chamfer
hole_dia = 5.5;
hole_chamfer = 0.5;

// number of segments in holes/corners/etc
$fn=16;

// nudge (makes previews look nice, doesn't affect geometry)
nudge = 0.01;


difference() {
    union() {
        
        // base
        linear_extrude(height=thickness) offset(r=corner_radius) offset(r=-corner_radius)
            polygon([
                [-10,-hook_width],
                [-10,(magic_distance-30)],
                [-30,(magic_distance-10)],
                [-30,magic_distance],
                [30,magic_distance],
                [30,(magic_distance-10)],
                [10,(magic_distance-30)],
                [10,-hook_width]
            ]);
        
        // ridge
        ridge_width = 6-ridge_shrink;
        linear_extrude(height=ridge_height+thickness) offset(r=corner_radius) offset(r=-corner_radius)
            polygon([
                [-ridge_width/2,20+ridge_shrink/2],
                [-ridge_width/2,magic_distance-20],
                [ridge_width/2,magic_distance-20],
                [ridge_width/2,20+ridge_shrink/2]
            ]);
        
        // end hook
        linear_extrude(height=thickness+hook_height) offset(r=corner_radius) offset(r=-corner_radius)
            polygon([[-10,0],[-10,-hook_width],[10,-hook_width],[10,0]]);
    }
    
    // holes
    translate([0,10,-nudge]) {
        cylinder(d=hole_dia,h=thickness+2*nudge);
        cylinder(d1=hole_dia+2*hole_chamfer,d2=hole_dia,h=hole_chamfer+nudge);
    }
    translate([0,magic_distance-10,-nudge]) {
        cylinder(d=hole_dia,h=thickness+2*nudge);
        cylinder(d1=hole_dia+2*hole_chamfer,d2=hole_dia,h=hole_chamfer+nudge);
    }
    
    // end chamfer
    chamfer_yz = end_chamfer * (2*sin(45));
    translate([0,magic_distance,0])
        rotate([45,0,0])
            cube([61,chamfer_yz,chamfer_yz],center=true);
    
}

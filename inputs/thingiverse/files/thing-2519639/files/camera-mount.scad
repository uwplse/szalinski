/*
    Author: Tanner Netterville
    License: CC BY 4.0 ( https://creativecommons.org/licenses/by/4.0/ )

    All units in mm
*/

standoff_distance=34; // the distance between the centers of the two standoffs
standoff_radius=2.5; // M3 round knurled standoffs are about 5mm in diameter
standoff_wrap_height=8;
standoff_wrap_thickness=1;
camera_width=19; // common sizes: HS1177=28.5mm; Mini=22.3mm; Micro=19mm;
camera_forward_offset=11;
camera_downward_offset=4;
camera_lens_blade_radius=13; // common lens lengths: HS1177=25mm; Mini=17mm; Micro=10mm;
camera_lens_blade_thickness=2.5;
camera_body_radius=4;
camera_screw_hole_diameter=2.1; // common sizes: M2=2.1mm; M3=3.15mm; 
camera_screw_counterbore_diameter=4.4; // common sizes: M2=4.4mm; M3=6.5mm;
camera_screw_counterbore_depth=0.5; // make sure this isn't too deep for your camera_lens_blade_thickness
material_engrave_width=0.4;


module circle_quadrant(r) {
    difference() {
        circle(r);
        polygon([
            [0,0],
            [r,0],
            [r,-r],
            [-r,-r],
            [-r,r],
            [0,r]
        ]);
    }
}

module lens_blade() {
    translate([0,0,-camera_lens_blade_thickness])
    linear_extrude(height=camera_lens_blade_thickness) {
        union() {
            circle_quadrant(camera_lens_blade_radius);
            scale([1, camera_body_radius/camera_lens_blade_radius, 1]) rotate([0,0,-90]) circle_quadrant(camera_lens_blade_radius);
            scale([camera_body_radius/camera_lens_blade_radius, 1, 1]) rotate([0,0,90]) circle_quadrant(camera_lens_blade_radius);
            rotate([0,0,180]) circle_quadrant(camera_body_radius);
        }
    }
}

module right_bracket() {
    difference() {
        union() {
            translate([camera_width/2,camera_forward_offset,standoff_wrap_height-camera_downward_offset]) rotate([0,-90,0]) lens_blade();
            hull() {
                translate([standoff_distance/2,0,0]) cylinder(r=standoff_radius+standoff_wrap_thickness, h=standoff_wrap_height);
                translate([camera_width/2+camera_lens_blade_thickness/2,camera_forward_offset,0]) hull() {
                    translate([0,0,camera_lens_blade_thickness/2]) sphere(r=camera_lens_blade_thickness/2);
                    translate([0,0,standoff_wrap_height-camera_lens_blade_thickness/2]) sphere(r=camera_lens_blade_thickness/2);
                }
            }
        }
        translate([standoff_distance/2,0,0]) cylinder(r=standoff_radius, h=1+ max(standoff_wrap_height*2, camera_lens_blade_radius*2), center=true);
        translate([0, camera_forward_offset, standoff_wrap_height-camera_downward_offset]) rotate([0,90,0]) cylinder(r=camera_screw_hole_diameter/2, h=standoff_distance, $fn=30);
        translate([camera_width/2+camera_lens_blade_thickness-camera_screw_counterbore_depth,camera_forward_offset,standoff_wrap_height-camera_downward_offset])  rotate([0,90,0]) cylinder(r=camera_screw_counterbore_diameter/2, h=standoff_distance);
        for (i=[-90:10:0]) {
            translate([camera_width/2,camera_forward_offset,standoff_wrap_height-camera_downward_offset]) rotate([i,0,0]) translate([0,0,camera_lens_blade_radius*(2/3)]) cylinder(r=material_engrave_width/2, h=camera_lens_blade_radius/3-1);
        }
    }
}

$fn=100;
right_bracket();
mirror() right_bracket();

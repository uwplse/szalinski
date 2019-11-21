//outside diameter of column, which will fit over vertical frame support rod
column_dia = 7;
//inside diameter of column - make a but undersize, and drill out to precise desired diameter (I use a #29 drill bit for the Mini Owl)
column_hole_dia = 4;
//overall height of the completed mount - should be the same height as the vertical support rods
column_ht = 20;
//center-to-center distance between the columns (I use 21mm for the Mini Owl)
column_spacing = 21;

//diameter of the hole in the mount for the camera lens - will clamp around narrow neck of camera lens
lens_dia = 8.2;
//distance in mm, forward (positive) or backward (negative), to offset mounting plate for camera (at zero, front edge of plate will be centered between the vertical support rods)
lens_offset = 0;
//thickness of the mounting plate for the camera lens
mount_thickness = 2.85; 

//angle from horizontal that camera should point (positive points upward, negative points downward)
camera_angle = 15;

//distance between printed top and bottom halves of mount
print_offset = 20;

module mount(offset, angle) {
    $fn=40;
    translate([0, offset, 0]) {
        difference() {
            union() {
                columns();
                mount_wall();
            }
            
            column_holes();
            lens_hole(angle);
        }
    }
}

module columns() {
    translate([column_spacing/2, mount_thickness, 0])
        cylinder(d=column_dia, h=column_ht/2);

    translate([-column_spacing/2, mount_thickness, 0])
        cylinder(d=column_dia, h=column_ht/2);
}

module column_holes() {
    translate([column_spacing/2, mount_thickness, 0])
        cylinder(d=column_hole_dia, h=column_ht/2);

    translate([-column_spacing/2, mount_thickness, 0])
        cylinder(d=column_hole_dia, h=column_ht/2);
}

module mount_wall() {
    translate([-column_spacing/2, lens_offset, 0])
        cube([column_spacing, mount_thickness, column_ht/2]);
}

module lens_hole(angle) {
    translate([0, 0, column_ht/2])
        rotate([90 + angle, 0, 0])
            cylinder(d=lens_dia, h=mount_thickness*4, center=true);
}

mount(0, camera_angle);
mount(print_offset, -camera_angle);

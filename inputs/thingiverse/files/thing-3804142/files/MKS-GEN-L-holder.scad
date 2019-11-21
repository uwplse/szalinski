m3rad_mount = 1.45;
m3rad = 3.3;
mks_mount_size = 1.0;
yadj = 2;

module mks_holes() {
    cylinder(20, m3rad_mount, m3rad_mount, $fn = 45);
    translate([102, 0, 0]) cylinder(20, m3rad_mount, m3rad_mount, $fn = 45);
    translate([0, 76, 0]) cylinder(20, m3rad_mount, m3rad_mount, $fn = 45);
    translate([102, 76, 0]) cylinder(20, m3rad_mount, m3rad_mount, $fn = 45);
}

module mks_mounts() {
    cylinder(6, m3rad_mount + mks_mount_size + 2, m3rad_mount + mks_mount_size, $fn = 90);
    translate([102, 0, 0]) cylinder(6, m3rad_mount + mks_mount_size + 2, m3rad_mount + mks_mount_size, $fn = 90);
    translate([0, 76, 0]) cylinder(6, m3rad_mount + mks_mount_size + 2, m3rad_mount + mks_mount_size, $fn = 90);
    translate([102, 76, 0]) cylinder(6, m3rad_mount + mks_mount_size + 2, m3rad_mount + mks_mount_size, $fn = 90);
}

module frame() {
    translate([0, -1, 0]) cube([111, 8, 3], center = true);
    translate([0, 77, 0]) cube([111, 8, 3], center = true);
    
    translate([-51.5, 76 / 2, 0]) cube([8, 80, 3], center = true);
    translate([+51.5, 76 / 2, 0]) cube([8, 80, 3], center = true);

    translate([0, 38, 0]) rotate([0, 0, +54]) cube([8, 122, 3], center = true);
    translate([0, 38, 0]) rotate([0, 0, -54]) cube([8, 122, 3], center = true);
}

difference() {
    union() {
        translate([-10 + 51, -10, 1.5]) frame();
        translate([-10, -10, 2.5]) color([1, 0, 0]) mks_mounts();

        translate([5, -34, 0]) rotate([0, 0, 90]) import("MKS_GEN_L_holder_clip.stl");
        translate([92.5, -34, 0]) rotate([0, 0, 90]) import("MKS_GEN_L_holder_clip.stl");
    
        translate([-20, -11, 0]) import("MKS_GEN_L_holder_clip.stl");
        translate([-20, 67, 0]) import("MKS_GEN_L_holder_clip.stl");

        translate([5, -19, +1.5]) cube([8, 11, 3], center = true);
        translate([92.5, -19, +1.5]) cube([8, 11, 3], center = true);
    }    
    translate([-10, -10, -1]) color([1, 0, 0]) mks_holes();
}
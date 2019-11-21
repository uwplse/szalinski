// Screw Fastened Foot
// by Nathan Wittstock <nate@fardog.io>

/* [Foot Dimensions] */
foot_lower_radius = 15;
foot_upper_radius = 20;
foot_height = 18;

/* [Inset] */
foot_inset_radius = 4;
foot_inset_depth = 3;

/* [Screw] */
foot_screw_radius = 4;
foot_screw_inset = 6;
foot_screw_head_radius = 8;

/* [Misc] */
tolerance = 0.2;
resolution = 50;

/* [Hidden] */
$fn=resolution;

rotate([0, 180, 0]) // rotate for better view in customizer
difference() {
    cylinder(r1=foot_lower_radius, r2=foot_upper_radius, h=foot_height);
    cylinder(r=foot_lower_radius-foot_inset_radius, h=foot_inset_depth);
    union() {
        translate([0, 0, foot_inset_depth])
            cylinder(r=foot_screw_head_radius+tolerance, h=foot_screw_inset);
        cylinder(r=foot_screw_radius+tolerance, h=foot_height);
    }
}

/* 
 * Special key generator
 * All units are in millimeters
 *
 * remixed by GrAndAG
 * v1.0 - initial remix (customizable handle) 
 * v1.1 - reorganized code to speed up the script 
 *
 * based on the model
 * http://www.thingiverse.com/thing:1183190
 *
 * author R. A. - 2015/12/08
 * e-mail: thingiverse@dexter.sk
 * Thingiverse username: dexterko
 *
 * Feel free to modify and distribute, but please keep the credits;-)
 */

// preview[view:south west, tilt:top diagonal]

/* [Shank] */
shank_outer_diameter    = 12;   // [3:25]
shank_inner_diameter    = 11;   // [3:25]
shank_height            = 20;   // [5:80]
number_of_center_sides  = 3;    // [3:10]
depth_of_center_hole    = 8;    // [1:100]

/* [Handle] */
bow_number_of_handles   = 2;    // [1:25]
bow_handle_length       = 20;   // [5:100]
bow_thickenss           = 8;    // [3:20]
bow_center_coeff        = 1.3;  // [1:0.1:3]
bow_round_corners_radius= 0.6;  // [0.2:0.1:3.0]

/* [Key ring hole] */
key_ring_hole           = 1;    // [1:Yes, 0:No]
key_ring_hole_diameter  = 5;    // [2:8]
// CAUTION!!! if this option is enabled the renderring will be very VERY slow!
key_ring_hole_with_rounded_edges = 0; // [0:No, 1:Yes]

/* [Hidden] */

$fn = 64;
eps = 0.05;

module key() {
    bow_round_corners = bow_round_corners_radius*2;
    l = bow_handle_length - shank_outer_diameter/2;
    h = bow_thickenss - bow_round_corners;
    d = shank_outer_diameter-bow_round_corners;
    d_center = shank_outer_diameter*bow_center_coeff-bow_round_corners;
    key_ring_hole_diameter = (key_ring_hole_diameter>h) ? h : key_ring_hole_diameter;

    // key bow
    difference() {
        translate([0,0,bow_round_corners/2]) {
            a_step = 360 / bow_number_of_handles;
            for (a=[0:bow_number_of_handles-1]) {
                rotate([0,0,a*a_step]) minkowski() {
                    difference() {
                        hull() {
                            translate([-l, 0, 0])
                                cylinder(d=d, h=h);
                            cylinder(d=d_center, h=h);
                        }
                        //a hole in the bow (so sloooow if do it here!)
                        if (key_ring_hole && key_ring_hole_with_rounded_edges && a==0) 
                            hull() {
                                translate([-l, -((d_center+shank_outer_diameter)/2+bow_round_corners+eps)/2, bow_thickenss/2])
                                    sphere(d=key_ring_hole_diameter, h=(d_center+shank_outer_diameter)/2+bow_round_corners+eps);
                                translate([-l, ((d_center+shank_outer_diameter)/2+bow_round_corners+eps)/2, bow_thickenss/2])
                                    sphere(d=key_ring_hole_diameter, h=(d_center+shank_outer_diameter)/2+bow_round_corners+eps);
                            }
                    }
                    sphere(d=bow_round_corners);
                }
            }
        }
        //a hole in the bow
        if (key_ring_hole && !key_ring_hole_with_rounded_edges) 
            hull() {
                translate([-l-shank_outer_diameter/2+key_ring_hole_diameter+0.5, -((d_center+shank_outer_diameter)/2+bow_round_corners+eps)/2, bow_thickenss/2])
                    sphere(d=key_ring_hole_diameter, h=(d_center+shank_outer_diameter)/2+bow_round_corners+eps);
                translate([-l-shank_outer_diameter/2+key_ring_hole_diameter+0.5, ((d_center+shank_outer_diameter)/2+bow_round_corners+eps)/2, bow_thickenss/2])
                    sphere(d=key_ring_hole_diameter, h=(d_center+shank_outer_diameter)/2+bow_round_corners+eps);
            }
    }

    // Shank
    difference() {
        d1 = (shank_outer_diameter+bow_round_corners > d_center) ? d_center : shank_outer_diameter+bow_round_corners;
        d2 = d1 - shank_outer_diameter;
        union() {
            translate([0, 0, bow_thickenss-bow_round_corners_radius-eps])
                cylinder(d=shank_outer_diameter, h=shank_height+bow_round_corners_radius+eps, $fn=64);
            if (d2 > 0)
                translate([0, 0, bow_thickenss-eps])
                    cylinder(d=d1, h=d2/2+eps);
        }
        // inner hole
        translate([0,0, bow_thickenss+shank_height-depth_of_center_hole])
            cylinder(d=shank_inner_diameter, h=depth_of_center_hole+eps, $fn=number_of_center_sides);
        // some rounding
        if (d2 > 0)
            translate([0, 0, bow_thickenss+d2/2])
                rotate_extrude(convexity = 10, $fn = 180)
                    translate([d1/2, 0, 0])
                        circle(d=d2, $fn = 64);

    }

}

key();

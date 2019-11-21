/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in June 2016
 *
 * Licensed under the
 * Creative Commons - Attribution - Share Alike license.
 */

// -----------------------------------------------------------

d_min = 8.7;
d_max = 9.2;
d_inner = 5.5;
d_outer = 14;
d_grip = 11;
w_grip = 20;
h_top = 5;
h_mid = 35;
h_bottom = 10;
sphere_ratio = 1.25;
grip_ratio = 1.75;
grip_angle = 20;

$fn = 20;

// -----------------------------------------------------------

difference() {
    union() {
        difference() {
            intersection() {
                translate([-w_grip / 2, -w_grip / 2, 0])
                    cube([w_grip, w_grip, h_bottom]);
                sphere(d = w_grip * sphere_ratio);
            }
            
            for(angle = [0, 90, 180, 270]) {
                rotate([0, 0, angle])
                    translate([0, -w_grip / grip_ratio, -w_grip / 4])
                    rotate([grip_angle, 0, 0])
                    cylinder(d = h_bottom, h = h_bottom + (w_grip / 2));
            }
        }
        
        translate([0, 0, h_bottom])
            cylinder(d = d_outer, h = h_mid + h_top);
    }
    
    translate([0, 0, -1])
        cylinder(d = d_grip, h = h_bottom + 1);
    
    translate([0, 0, h_bottom - 1])
        cylinder(d1 = d_max, d2 = d_min, h = h_mid + 1, $fn = 6);
    
    translate([0, 0, h_bottom + h_mid - 1])
        cylinder(d = d_inner, h = h_top + 2);
}

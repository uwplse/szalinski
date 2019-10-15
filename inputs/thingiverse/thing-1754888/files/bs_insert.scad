/*
 * Ball and socket adapter for PCB Workstation with Articulated Arms 
 *   (http://www.thingiverse.com/thing:801279)
 *
 * Author: Scott Shumate <scott@shumatech.com>
 *
 * This ball and socket insert sticks into the end of a
 * flexible coolant pipe and adapts it for use with all
 * of the accessories available for the PCB Workstation.
 * Flexible coolant pipes hold and wear much better than
 * 3D printed arms and are cheap and readily available at
 * a number of Ebay sellers.
 */

// Diameter of the insert shaft (mm)
shaft_diameter = 6.7;

// Total height of the insert (mm)
total_height = 19;

// Diameter of the middle hole (mm)
hole_diameter = 4.5;

// PCB Workstation ball size (mm)
pcb_ball_diameter = 10.5;

$fa=1;
$fs=0.5;

create();

module create() {
    difference() {
        union() {
            cylinder(d=shaft_diameter, h=total_height-pcb_ball_diameter/2);

            translate([0, 0, total_height-pcb_ball_diameter/2]) {
                sphere(d=pcb_ball_diameter);
            }
        }
        union() {
            cylinder(d=hole_diameter, h=total_height);
        }
    }
}

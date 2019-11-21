/*
 * Base plate joint for PCB Workstation with Articulated Arms 
 *   (http://www.thingiverse.com/thing:801279)
 *
 * Author: Scott Shumate <scott@shumatech.com>
 *
 * This base plate joint is for use with a flexible coolant
 * pipe.
 */

// Size of the pipe ball (mm)
pipe_ball_diameter = 11.7;

// Diameter of the insert shaft (mm)
shaft_diameter = 6.7;

// Total height of the insert (mm)
total_height = 21;

// Diameter of the middle hole (mm)
hole_diameter = 4.5;

// Height of slot for cable exit (mm)
exit_slot_height = 2;

// Width of slot for cable exit (mm)
exit_slot_width = 1.8;

// Diameter of mating shaft for PCB base plate (mm)
pcb_shaft_diameter = 7.2;

// Width of the slot through the pipe ball (mm)
ball_slot_width = 1.8;

// Height of the slot through the pipe ball (mm)
ball_slot_height = 7;

$fa=1;
$fs=0.5;

create();

module create() {
    
    // Measured parameters for PCB base plate
    pcb_shaft_height = 6;
    pcb_shaft_hole = 3;
    pcb_key_width = 1.8;
    pcb_key_radius = 5.65;
    pcb_ledge_height = 1;
    
    difference() {
        union() {
            cylinder(d=shaft_diameter, h=total_height-pipe_ball_diameter/2);

            translate([0, 0, total_height-pipe_ball_diameter/2]) {
                sphere(d=pipe_ball_diameter);
            }
            
            translate([-pcb_key_width/2, 0, 0]) {
                cube([pcb_key_width, pcb_key_radius, pcb_shaft_height]);
            }
            translate([0, pcb_key_radius, 0]) {
                cylinder(d=pcb_key_width, h=pcb_shaft_height);
            }
            translate([-shaft_diameter/2, 0, pcb_shaft_height]) {
                cube([shaft_diameter, shaft_diameter/2, pcb_ledge_height]);
            }
            translate([0, shaft_diameter/2, pcb_shaft_height]) {
                cylinder(d=shaft_diameter, h=pcb_ledge_height);
            }
        }
        union() {
            cylinder(d=hole_diameter, h=total_height);
            
            translate([-exit_slot_width/2, -shaft_diameter, 0]) {
                cube([exit_slot_width, shaft_diameter, exit_slot_height+pcb_shaft_height+pcb_ledge_height]);
            }
            
            translate([0, 0, exit_slot_height+pcb_shaft_height+pcb_ledge_height]) {
                rotate([90, 0, 0]) cylinder(r=exit_slot_width/2, h=shaft_diameter);
            }
            
            translate([0, 0, total_height - 0.5 * ball_slot_height]) {
                cube([pipe_ball_diameter, ball_slot_width, ball_slot_height], center=true);
            }
            
            translate([-pipe_ball_diameter/2, 0, total_height - ball_slot_height]) {
                rotate([0, 90, 0]) cylinder(d=ball_slot_width, h=pipe_ball_diameter);
            }            
        }
    }
}

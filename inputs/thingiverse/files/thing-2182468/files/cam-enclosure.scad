/* Cam Enclosure for Cams saved from old Notebook Displays to use as 
normal USB Device 

Copyright (c) 2017 Michael Sauer
*/

/* [Basic] */

render_mode = 1; // [0:off, 1:on]

// Thickness of outer walls
wall_thickness = 2; // [1:0.1:4]
// Width dimension of your cam pcb
pcb_width = 70;  // [30:0.1:100]
// Height dimension of you cam pcb
pcb_height = 10; // [10:0.1:50]
// Thickness of your cam pcb including the cam sensor
pcb_thickness = 7; // [3:0.1:15]
// Finish of the enclosure (round edges)
enclosure_finish = 1; // [0:0.1:3]

// Offset of the cam hole from left side (normally half of pcb_width)
cam_hole_offset_left = pcb_width / 2; // [5:0.1:90] 
                                   
// Offset of the cam hole from top                                    
cam_hole_offset_top = pcb_height / 2 + wall_thickness; // [2:0.1:48]   
// Diameter of cam hole
cam_hole_diameter = 4; // [1:0.1:6]
// Finish of cam hole
cam_hole_finish = 0.8; // [0:0.1:2]
                      
// Side of cable hole                      
cable_hole_side = 0; // [0:left, 1:right]
// Diameter of cable hole
cable_hole_diameter = 3; // [1:0.1:6]

// Diamter of mount hole 1
mount1_diameter = 1.8; // [1:0.1:6]
// Offset 1 for hole base from left of pcb
mount1_offset_left = 60.3; // [5:0.1:90]
// Offset 1 for hole base from top of pcb
mount1_offset_top = 7.5; // [2:0.1:48]

// Diameter of mount hole 2 (mostly same as mount 1)
mount2_diameter = mount1_diameter; // [1:0.1:6]
// Offset 2 for hole base from left of pcb
mount2_offset_left = 10; // [5:0.1:90]
// Offset 2 for hole base from top of pcb
mount2_offset_top = 3.2; // [2:0.1:48]

/* [Hidden] */

// Circle resolution
$fn = render_mode? 10: 50;

/* Begin Model Code */
enclosure(); // Enclosure
translate([(wall_thickness / 2), pcb_height + 10, 0])
    cap(); // Cap

module enclosure() {
    difference() {
        // Main enclosure frame with rounded corners
        minkowski() {
            cube([pcb_width + (2 * wall_thickness), 
                  pcb_height + (2 * wall_thickness), 
                  pcb_thickness + wall_thickness]);
            cylinder(r=enclosure_finish,h=2);
        }
        // Inner cut
        translate([wall_thickness, wall_thickness, wall_thickness]) 
            cube([pcb_width, 
                  pcb_height, 
                  pcb_thickness + wall_thickness]); 
        
        // Bevel for cap
        translate([(wall_thickness / 2), 
                   (wall_thickness / 2), 
                   pcb_thickness + wall_thickness])
            cube([pcb_width + wall_thickness,
                  pcb_height + wall_thickness,
                  pcb_thickness]);

        // Camera hole
        translate([cam_hole_offset_left + wall_thickness, 
                   cam_hole_offset_top,
                   0])
            cylinder(h = pcb_thickness + wall_thickness, d = cam_hole_diameter); // hole
        
        translate([cam_hole_offset_left + wall_thickness,
                   pcb_thickness,
                   -3.2])
            sphere(d = (cam_hole_diameter * 2) + cam_hole_finish); // finish
            
        // Cable hole
        if (cable_hole_side == 0) { // Left side hole
            translate([-3,
                   pcb_thickness, 
                   (pcb_height / 2)])
                rotate([0,90,0])
                    cylinder(h = wall_thickness + 3, d = cable_hole_diameter);
        } else if (cable_hole_side == 1) {
            translate([pcb_width + (wall_thickness * 2)-3,
                   pcb_thickness, 
                   (pcb_height / 2)])
                rotate([0,90,0])
                    cylinder(h = wall_thickness + 3, d = cable_hole_diameter);
        } else {
            // No cable hole if out of constrain
        }
    }
    
    // Mounting cylinders
    // left
    translate([wall_thickness + mount1_offset_left, mount1_offset_top + wall_thickness, wall_thickness])
        cylinder(h = pcb_thickness - 1, d = mount1_diameter * 2);
    translate([wall_thickness + mount1_offset_left, mount1_offset_top + wall_thickness, wall_thickness + 1])
        cylinder(h = pcb_thickness + 1, d = mount1_diameter);
    
    // right
    translate([wall_thickness + mount2_offset_left, mount2_offset_top + wall_thickness, wall_thickness])
        cylinder(h = pcb_thickness - 1, d = mount2_diameter * 2);
    translate([wall_thickness + mount2_offset_left, mount2_offset_top + wall_thickness, wall_thickness + 1])
        cylinder(h = pcb_thickness + 1, d = mount2_diameter);
    
    
}

module cap() {
    difference() {
        union() {
            // Main cap plate
            cube([pcb_width + wall_thickness, 
                  pcb_height + wall_thickness, 
                  (wall_thickness / 2)]);
    
            // Leading plate for cap
            translate([(wall_thickness / 2), 
                       (wall_thickness / 2), 
                       (wall_thickness / 2)]) 
                    cube([pcb_width, 
                          pcb_height, 
                          (wall_thickness / 2)]); 
        }
    }
}
    

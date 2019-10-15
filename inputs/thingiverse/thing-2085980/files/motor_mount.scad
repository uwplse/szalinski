/*
Copyright © 2017 Richard Jorgensen
This work is free. You can redistribute it and/or modify it under the
terms of the Do What The Fuck You Want To Public License, Version 2,
as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.
*/

/* [Motor Bracket] */
// Width of the bracket
width = 20;
// Radius of the motor
radius = 14;
// Thickness of bracket above motor
crown_height = 4;
// The amount of empty space to leave between brackets
gap = 1;

/* [Fastener] */
// Width of the fastener surface 
screw_plate_width = 12;
// Radius of bore for the screw
screw_radius = 2.4;
// Radius of counterbore for screw head
screw_head_radius = 4.5;
// Depth of counterbore for screw head
screw_head_height = 5;
// Type of screw head
screw_head_type = 1; //[0:None,1:Round,2:Hex,3:Tapered,4:Square(Carriage Bolt)]

/* [Hidden] */
bracket_height = radius + crown_height - gap;
bracket_length = (radius + screw_plate_width) * 2;

difference() {
    // Body
    translate([0, 0, bracket_height / 2])
    cube(size = [width, bracket_length, bracket_height], center = true);
    
    // Motor cutout
    translate([0, 0, -gap])
    rotate(a=180, v=[1,0,1])
    cylinder(h = width + 1, r = radius, center = true);
    
    for (dir = [1, -1]) {
        // Screw shaft
        translate([0, (radius + screw_plate_width / 2) * dir, bracket_height / 2])
        cylinder(h = bracket_height, r = screw_radius, center = true);

        // Screw head
        head_trans = [0, (radius + screw_plate_width / 2) * dir, bracket_height];
        if (screw_head_type == 1) {
            translate(head_trans)
            cylinder(r = screw_head_radius, h = screw_head_height, center = true);
        }
        if(screw_head_type == 2) {
            steps = 6;
            translate(head_trans)
            cylinder(r = screw_head_radius, h = screw_head_height, $fn = steps, center = true);
        }
        if(screw_head_type == 3) {
            /* TODO: Allow user to input chamfer angle of countersink head
                     instead of using the radii. */
            translate(head_trans)
            cylinder(r1 = screw_radius, r2 = screw_head_radius, h = screw_head_height, center = true);
        }
        if(screw_head_type == 4) {
            steps = 4;
            translate(head_trans)
            rotate(a=[0, 0, 45])
            cylinder(r = screw_head_radius, h = screw_head_height, $fn = steps, center = true);
        }
    }
}

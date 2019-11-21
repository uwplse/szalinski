/*******************************************************************\
|                                                                   |
|                    Triangular Box Kite v.2                        |
|                                                                   |
|                      designed by Svenny                           |
|                                                                   |
|       source: https://www.thingiverse.com/thing:3885716           |
|                                                                   |
\*******************************************************************/


/* [GENERAL] */
// rendering precission - use 4 for rectangular sticks
$fn = 50;
// outer diameter
outer_d = 6;
// diameter of hole for stick (note that it's diagonal size for rectangular stick)
inner_d = 4.1;
// arm length (approx.)
arm_len = 20;

module corner_60() {
    rotations = [[0,0,0],[-90,0,30],[-90,0,-30]];
    combinations = [[0,1],[0,2],[1,2]];
    arrange_angle = 180+49.1;
    
    intersection() {
        translate([0,0,arm_len*cos(49.1)])
        rotate([arrange_angle,0,0])
        difference() {
            union() {
                sphere(d=outer_d, $fn=50);
                for(rot=rotations) {
                    rotate(rot)
                    rotate(45)
                    cylinder(d=outer_d, h=2*arm_len);
                }
                for(c=combinations) {
                    hull() {
                        rotate(rotations[c[0]])
                        translate([0,0,arm_len/2])
                        cylinder(d=2, h=arm_len/2, $fn=40);
                        rotate(rotations[c[1]])
                        translate([0,0,arm_len/2])
                        cylinder(d=2, h=arm_len/2, $fn=40);
                    }
                }
            }
            
            for(rot=rotations) {
                rotate(rot)
                translate([0,0,outer_d])
                rotate(45)
                cylinder(d=inner_d, h=arm_len);
            }
        }
        
        translate([0,0,arm_len])
        cube(2*arm_len, center=true);
    }
}

module middle_60() {
    rotations = [[0,0,0],[-90,0,30],[-90,0,-30],[180,0,0]];
    combinations = [[0,1],[0,2],[1,2],[1,3],[2,3]];
    arrange_angle = 180+49.1;
    
    intersection() {
        translate([0,0,arm_len*cos(49.1)])
        rotate([180-2*arrange_angle,0,0])
        translate([0,0,-arm_len*cos(49.1)])
        intersection() {
            translate([0,0,arm_len*cos(49.1)])
            rotate([arrange_angle,0,0])
            difference() {
                union() {
                    sphere(d=outer_d);
                    for(rot=rotations) {
                        rotate(rot)
                        rotate(45)
                        cylinder(d=outer_d, h=2*arm_len);
                    }
                    for(c=combinations) {
                        hull() {
                            rotate(rotations[c[0]])
                            translate([0,0,arm_len/2])
                            cylinder(d=2, h=arm_len/2, $fn=40);
                            rotate(rotations[c[1]])
                            translate([0,0,arm_len/2])
                            cylinder(d=2, h=arm_len/2, $fn=40);
                        }
                    }
                }
                
                for(rot=rotations) {
                    rotate(rot)
                    translate([0,0,outer_d])
                    rotate(45)
                    cylinder(d=inner_d, h=arm_len);
                }
                rotate(45)
                cylinder(d=inner_d, h=2*arm_len, center=true);
            }
            
            translate([0,0,arm_len])
            cube(2*arm_len, center=true);
        }
        
        translate([0,0,arm_len])
        cube(2*arm_len, center=true);
    }
}

module middle_60_wing() {
    rotations = [[0,0,0],[-90,0,30],[-90,0,-30],[180,0,0],[90,0,-16]];
    combinations = [[0,1],[0,2],[1,2],[1,3],[2,3],[0,4],[1,4],[2,4],[3,4]];
    arrange_angle = 180+49.1;
    
    intersection() {
        translate([0,0,arm_len*cos(49.1)])
        rotate([180-2*arrange_angle,0,0])
        translate([0,0,-arm_len*cos(49.1)])
        intersection() {
            translate([0,0,arm_len*cos(49.1)])
            rotate([arrange_angle,0,0])
            difference() {
                union() {
                    sphere(d=outer_d);
                    for(rot=rotations) {
                        rotate(rot)
                        rotate(45)
                        cylinder(d=outer_d, h=1.17*arm_len);
                    }
                    for(c=combinations) {
                        hull() {
                            rotate(rotations[c[0]])
                            translate([0,0,arm_len/2])
                            cylinder(d=2, h=arm_len/2, $fn=40);
                            rotate(rotations[c[1]])
                            translate([0,0,arm_len/2])
                            cylinder(d=2, h=arm_len/2, $fn=40);
                        }
                    }
                }
                
                for(rot=rotations) {
                    rotate(rot)
                    translate([0,0,outer_d])
                    rotate(45)
                    cylinder(d=inner_d, h=arm_len);
                }
                rotate(45)
                cylinder(d=inner_d, h=2*arm_len, center=true);
            }
            
            translate([0,0,arm_len])
            cube(2*arm_len, center=true);
        }
        
        translate([0,0,arm_len])
        cube(2*arm_len, center=true);
    }
}

translate([-100, 0, 0])
corner_60();
middle_60_wing();
translate([100, 0, 0])
middle_60();
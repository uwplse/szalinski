smoothing_radius = 3;
wall_thickness = 1.74; // Four lines @ 0.1mm slice, 0.4 nozzle.

ring_measured_length = 158;
ring_diameter = 7;

// Everything except for 'slow' is an approximation.
// The addtion of smoothing_radius via a minkowski is _SLOW_.
// So the 'size' is going to be 'undersized', by the amount of 
// smoothing_radius, but you can quick-check your overall layout faster.
quality = "medium"; // fast = no minkowski
                         // medium = minkowski $fn = 24;
                         // slow = minkowski $fn = 48;
$fn = (quality == "slow" ? 48 : (quality == "insane") ? 90 : 24);

// z offset, rotation, resize
// [distance from previous point, angle of part, [x width, y width]]
sections = [
    [0, 10, [25, 22]], // Tip
    [8, 45, [36, 30]], // Flare
    [5, -10, [34, 28]], // shaft (end by head)
    [9, 20, [32, 31]], // shaft
    [12, 20, [34, 30]], // shaft bend
    [18, 25, [34, 30]], // base
];
tip_z =  0.75 * sections[0][2][0];

angle_sum = sections[0][1] +
                     sections[1][1] +
                     sections[2][1] +
                     sections[3][1] +
                     sections[4][1] +
                     sections[5][1];
                     
chastity_set();

module chastity_set() {
    union() {
        // Main outer shell.
        difference() {
            union() {
                main_parts(extra = wall_thickness);
                // Translate to the bend.
                baseoffset() rotate([0, 0, 90]) mount();
            }
            // create a positive for removal.
            union() {
                main_parts();
                
                // Remove tip holes.
                translate([0, 5, -tip_z]) resize([6, 10, 0]) cylinder(d = 6, h = tip_z);
                translate([sections[0][2][1] / 2, 3, -tip_z]) resize([4, 6, 0]) cylinder(d = 6, h = tip_z);
                translate([-sections[0][2][1] / 2, 3, -tip_z]) resize([4, 6, 0]) cylinder(d = 6, h = tip_z);
                // Remove opening.
                // translate this to the shaft bend location.
                hull() {
                    translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
                        translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
                            translate([0, 0, sections[2][0]]) rotate([sections[2][1], 0, 0]) 
                                translate([0, 0, sections[3][0]]) rotate([sections[3][1], 0, 0]) 
                                    translate([0, 0, sections[4][0]]) rotate([sections[4][1], 0, 0]) 
                                        translate([0, -16, 16 + 2 * smoothing_radius])
                                            rotate([0, 90, 0]) cylinder(r = 16, h = sections[2][2][0] * 2, center = true);
                    
                    translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
                        translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
                            translate([0, 0, sections[2][0]]) rotate([sections[2][1], 0, 0]) 
                                translate([0, 0, sections[3][0]]) rotate([sections[3][1], 0, 0]) 
                                    translate([0, 0, sections[4][0]]) rotate([sections[4][1], 0, 0]) 
                                        translate([0, 0, sections[5][0]]) rotate([sections[5][1], 0, 0])
                                            translate([0, (sections[5][2][1] + smoothing_radius + wall_thickness) / 2, ((sections[5][2][1] + smoothing_radius + wall_thickness) / 2) + smoothing_radius + wall_thickness])
                                                rotate([0, 90, 0]) cylinder(d = (sections[5][2][1] + smoothing_radius + wall_thickness) , h = (sections[5][2][1] + smoothing_radius + wall_thickness) * 2, center = true);
                }
            }
        }
        
        // Ring and bracket.
        difference() {
            union() {
                baseoffset() rotate([0, 0, 90]) bracket();   
                baseoffset() 
                    translate([0, -smoothing_radius * 2, smoothing_radius ]) 
                        rotate([180 - 15, 0, 180])
                            ring(ring_measured_length, ring_diameter);
            }
                
            // subtract the outer wall + a bit from the mount
            main_parts(extra = wall_thickness + 0.4);
        }
    }
}


module main_parts(extra = 0) {
    unify(extra) {
        translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
            resize([sections[0][2][0], sections[0][2][1], tip_z]) sphere(d = 20);
        
        translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
            translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
                resize([sections[1][2][0], sections[1][2][1], 0]) cylinder(r = 10, h = 1);

        translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
            translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
                translate([0, 0, sections[2][0]]) rotate([sections[2][1], 0, 0]) 
                    resize([sections[2][2][0], sections[2][2][1], 0]) cylinder(r = 10, h = 1);

        translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
            translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
                translate([0, 0, sections[2][0]]) rotate([sections[2][1], 0, 0]) 
                    translate([0, 0, sections[3][0]]) rotate([sections[3][1], 0, 0]) 
                        resize([sections[3][2][0], sections[3][2][1], 0]) cylinder(r = 10, h = 1);

        translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
            translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
                translate([0, 0, sections[2][0]]) rotate([sections[2][1], 0, 0]) 
                    translate([0, 0, sections[3][0]]) rotate([sections[3][1], 0, 0]) 
                        translate([0, 0, sections[4][0]]) rotate([sections[4][1], 0, 0]) 
                            resize([sections[4][2][0], sections[4][2][1], 0]) cylinder(r = 10, h = 1);

        translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
            translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
                translate([0, 0, sections[2][0]]) rotate([sections[2][1], 0, 0]) 
                    translate([0, 0, sections[3][0]]) rotate([sections[3][1], 0, 0]) 
                        translate([0, 0, sections[4][0]]) rotate([sections[4][1], 0, 0]) 
                            translate([0, 0, sections[5][0]]) rotate([sections[5][1], 0, 0]) 
                            resize([sections[5][2][0], sections[5][2][1], 0]) cylinder(r = 10, h = 1);
    }
}

module baseoffset() {
    translate([0, 0, sections[0][0]]) rotate([sections[0][1], 0, 0])
        translate([0, 0, sections[1][0]]) rotate([sections[1][1], 0, 0]) 
            translate([0, 0, sections[2][0]]) rotate([sections[2][1], 0, 0]) 
                translate([0, 0, sections[3][0]]) rotate([sections[3][1], 0, 0]) 
                    translate([0, 0, sections[4][0]]) rotate([sections[4][1], 0, 0])
                        translate([0, sections[4][2][1] / 2 + smoothing_radius, sections[5][0]]) rotate([-angle_sum + sections[5][1], 0, 0]) {
                            children();
    }
}
    

module unify(extra = 0) {
    minkowski() {
        union() {
            for (i = [0:$children - 2]) {
                hull() {
                    children([i]);
                    children([i + 1]);
                }
            }
        };
        if (quality != "fast") {
            sphere(r = smoothing_radius + extra);
        }
    }
}


module ring(ring_measured_length = 158, ring_diameter = 7) {
    ring_goal_size = ring_measured_length > 0 ? ring_measured_length / PI : 52.5;
    echo("ring_goal_size:", ring_goal_size);

    verticald = ring_goal_size * 2;
    horizontald = ring_goal_size + ring_diameter;
    path = 0.01;

    union() {
        difference() {
            translate([0, -horizontald + 1.5 * ring_diameter, horizontald / 2 - 5]) 
            rotate([0, 0, 90])
            minkowski() {
                intersection() {
                    rotate([90, 0, 0]) translate([0, 0, -verticald / 2]) 
                        difference() {
                            cylinder(d = verticald, h = verticald);
                            cylinder(d = verticald - path, h = verticald);
                        }
                    ;
                    rotate([0, 90, 0]) 
                        difference() {
                            cylinder(d = horizontald, h = verticald);
                            cylinder(d = horizontald - path, h = verticald);
                        }
                    ;
                };
                sphere(d = ring_diameter - (2 * path));
            }
        }
    }
}

module bracket() {
    difference() {
        hull() {
            translate([-18, 0, 6]) rotate([90, 0, 0]) cylinder(r = 2, h = 30, center = true);
            translate([-3, -9.75 / 2, 6]) {
                    cube([0.01, 9.75, 9.5]);
                    cube([17, 9.75, 0.01]);
                    // radius is 7.5
                    translate([17 - 7.5, 9.75 / 2, 13 - 7.5]) 
                        rotate([90, 0, 0]) 
                            cylinder(r = 7.5, h = 30, center = true);
            }
            translate([12, 0, 0]) 
                rotate([90, 0, 0]) 
                    cylinder(r = 2, h = 30, center = true);
            translate([-8, 0, 0]) 
                rotate([90, 0, 0]) 
                    cylinder(r = 2, h = 30, center = true);
        };
        translate([-20, -15, 8]) cube([50, 3, 15]); 
        translate([-20, 15 - 3, 8]) cube([50, 3, 15]); 
        mount(0.3, true);
        
        // magic lock hole
        translate([3.25, -10, 6 + (5.88 / 2) + 4 ]) rotate([-90, 10, 0]) locker(positive = 0.25);
        translate([3.25, -20, 6 + (5.88 / 2) + 4 ]) rotate([-90, 10, 0]) locker(positive = 0.25);
        hull() {
            for (a = [10 : 5 : 45]) {
                translate([3.25, -10, 6 + (5.88 / 2) + 4 ]) rotate([-90, a, 0]) intersection() {
                    locker(positive = 0.25);
                    translate([-4, -4, 20 - 7]) cube([12, 8, 7]);
                }
            }
        }
        translate([3.25, 0, 6 + (5.88 / 2) + 4 ]) rotate([-90, 10, 0]) cylinder(d = 3, h = 30, center = true);
    }
}
 
module mount(outset = 0, solid = false) {
    difference() {
        union() {
            translate([0, 0, -6]) hull () {
                cylinder(d = 14 + outset, h = 6);
                translate([22 - 8.1, -9.25 - outset, 5.99]) {
                    translate([0, 1.25, -5.99]) cube([0.1, 16 + 2 * outset, 6]);
                }
            }
            hull() {
                cylinder(d1 = 14 + outset, d2 = 16 + 2 * outset, h = 6 + outset / 2);
                translate([22 - 8.1, -9.25 - outset, 5.99 + outset / 2]) {
                    hull() {
                        cube([.1, 18.5 + 2 * outset , 0.01]);
                        translate([0, 1.25, -5.99 - outset / 2]) cube([0.1, 16 + 2 * outset, 0.01]);
                    }
                }
            }
            translate([-3 - outset, -9.75 / 2, 6]) {
                hull() {
                    translate([0, -outset, 0]) {
                        cube([0.01, 9.75 + 2 * outset, 9.5]);
                        cube([17 + outset, 9.75 + 2 * outset, 0.01]);
                        // radius is 7.5
                        translate([17 - 7.5 + outset, 9.75 / 2 + outset, 13 - 7.5]) rotate([90, 0, 0]) cylinder(r = 7.5 + outset, h = 9.75 + outset, center = true);
                    }
                }
            }
        }

        if (!solid) {
            // magic lock hole
            translate([3.25, -10, 6 + (5.88 / 2) + 4 ]) rotate([-90, 10, 0]) locker(positive = 0.25);
            hull() {
                for (a = [10 : 5 : 45]) {
                    translate([3.25, -10, 6 + (5.88 / 2) + 4 ]) rotate([-90, a, 0]) intersection() {
                        locker(positive = 0.25);
                        translate([-4, -4, 20 - 7]) cube([12, 8, 7]);
                    }
                }
            }
        }
    }
}

module locker(positive = 0) {
    union() {
        cylinder(d = 5.88 + positive, h = 20);
        translate([0, -1.5, 0]) cube([6.9 + positive, 2.9 + positive, 20]);
    }
}

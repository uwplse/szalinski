// Master options.
$fs=0.25;// Need fine resolution for a part this small.
depth = 8;

// Retaining wall options.
retaining_wall_thickness = 2.75 / 2; // radius!
retaining_wall_length = 20;
retaining_hole_radius = 1.5;
retaining_hole_offset = 2;

// Bracket options.
angle = 0;
wall_thickness = 0.8; // radius!
strip_height = 12.5;
strip_depth = 4;
gap = 2.5;

one = [0, 0, 0];
two = one + [-(retaining_wall_length - wall_thickness - retaining_wall_thickness), 0, 0];
three = [0, -(strip_height + 2*wall_thickness), 0];
four = three + [-(strip_depth + 2*wall_thickness), 0, 0];
five = four + [0, strip_height + 2*wall_thickness, 0];
six = five + [strip_depth - gap, 0, 0];

union(){
    // Ledge hook
    difference(){
        hull(){
            translate(one){
                cylinder(h=depth, r=retaining_wall_thickness);
            }
            translate(two + [+retaining_wall_thickness - wall_thickness, 0, 0]){
                cylinder(h=depth, r=retaining_wall_thickness);
            }
        }

        translate([-retaining_hole_radius - retaining_hole_offset, 2*retaining_wall_thickness, depth / 2]){
            rotate([90, 0, 0]){
                cylinder(h=4*retaining_wall_thickness, r=retaining_hole_radius);
            }
        }
    }

    // LED strip bracket
    translate(two + [0, retaining_wall_thickness - wall_thickness, 0]){
        rotate([0, 0, angle]){
            hull(){
                translate(one){
                    cylinder(h=depth, r=wall_thickness);
                }
                translate(three){
                    cylinder(h=depth, r=wall_thickness);
                }
            }

            hull(){
                translate(three){
                    cylinder(h=depth, r=wall_thickness);
                }
                translate(four){
                    cylinder(h=depth, r=wall_thickness);
                }
            }

            hull(){
                translate(four){
                    cylinder(h=depth, r=wall_thickness);
                }
                translate(five){
                    cylinder(h=depth, r=wall_thickness);
                }
            }

            hull(){
                translate(five){
                    cylinder(h=depth, r=wall_thickness);
                }
                translate(six){
                    union(){
                        cylinder(h=depth, r=wall_thickness);
                        translate([-wall_thickness, -wall_thickness, 0]){
                            cube([2 * wall_thickness, wall_thickness, depth], false);
                        }
                    }
                }
            }
        }
    }
}
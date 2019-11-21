// Common
width  = 18;
depth  = 4;

// Table desk (top part)
desk_height = 22;
desk_depth = 16;
desk_part_height = 30;

// Table side (middle and bottom part)
side_height = 80;
side_depth  = 18;
back_height = 10;

// Hook
hook_radius = desk_depth+5;

module joiner(size=0, pos=depth) {
    color("gray") {
        translate([0,(size/2)-(pos/2),0]) {
            cube([width,depth,depth], center=true);
        }
    }
}

module main() {
    cube([width, depth, side_height], center=true);
}

module fillet(r, h) {
    translate([r / 2, r / 2, 0]) {
        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0]) {
                cylinder(r = r, h = h + 1, center = true);
            }
        }
    }
}

module bottom() {
    translate([0, side_depth/2+depth/2, (-side_height/2)-(depth/2)]) {
        joiner(-side_depth);
    
        rotate([90,0,0]) {
            cube([width, depth, side_depth], center=true);
        }
    
        translate([0, (side_depth/2), (back_height/2)]) {
            cube([width, depth, back_height+depth], center=true);
        }
    }
}

module top() {
    translate([0, -desk_depth/2-depth/2, (side_height/2)+depth/2]) {
        joiner(desk_depth, -depth);
    
        rotate([90,0,0]) {
            cube([width, depth, desk_depth], center=true);
        }
    
        joiner(-desk_depth);
    
        translate([0, -(desk_depth/2)-depth/2, (desk_height/2)+depth/2]) {
            cube([width, depth, desk_height], center=true);

            translate([0,desk_part_height/2,desk_height/2]) {
                rotate([90,0,0]) {
                    cube([width, depth, desk_part_height+depth], center=true);
                }
            }
        }
    }
}

module hook() {
    translate([-width/2 , -hook_radius+depth/2, side_height/2]) {
        union() {
            rotate([90,0,90]) {
                difference() {
                    cylinder(h=width, r=hook_radius);
                    cylinder(h=width, r=hook_radius-depth);
                    translate([-hook_radius,0,0]) {
                        cube([hook_radius*2, hook_radius, width]);
                    }
                }
            }
            
            translate([0 , -hook_radius+depth/2, 0]) {
                rotate([90,135,90]) {
                    cylinder(h=width, r=depth/2);
                }
            }
        }
    }
}

// Main body
color("red") {
    main();
}

// Bottom part
color("green") {
    bottom();
}

// Top part
color("blue") {
    top();
}

color("black") {
    hook();
}
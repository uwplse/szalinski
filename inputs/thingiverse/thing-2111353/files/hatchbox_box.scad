inner_diameter = 80;
outer_diameter = 200;
height = 57;
gauge = 2;
hole_diameter = 4;
hole_x = 96;
hole_y = 5.5;
post_location = [hole_x, hole_y, gauge];

$fn = 100;

difference() {
    union() {
        // Make the box
        difference() {
            make_quarter(inner_diameter, outer_diameter, height, 0);
            translate([0, 0, gauge]) {
                make_quarter(inner_diameter+5, outer_diameter-5, height, gauge);
            }
        }

        // add the hinge casing
        translate(post_location) {
            cylinder(d=7.8, h=height-gauge);
        }
    }

    // make the hinge hole
    translate(post_location) {
        translate([0, 0, -4]) {
            // d=4 for #8, 3.5 for #6, although 4 works well for #6 on my setup
            cylinder(d=hole_diameter, h=height+10);
        }
    }
    
    // cutout a finger hole for opening the drawer
    translate([18, 100, height]) {
        rotate([90, 0, 0]) {
            cylinder(d=30, h=10);
        }
    }
}


module make_quarter(inner, outer, h, inset) {
    
difference() {
    cylinder(d=outer, h=h);
    translate([0,0,-1]) {
        cylinder(d=inner, h=h+2);
    }
    rotate([0, 0, 90]) {
        translate([-0.1 - inset, -0.1 - inset, -1]) {
            cube([150, 150, h+2]);
        }
    }
    rotate([0, 0, 180]) {
        translate([-0.1 - inset, -0.1 - inset, -1]) {
            cube([150, 150, h+2]);
        }
    }
    rotate([0, 0, 270]) {
        translate([-0.1 - inset, -0.1 - inset, -1]) {
            cube([150, 150, h+2]);
        }
    }
}
}
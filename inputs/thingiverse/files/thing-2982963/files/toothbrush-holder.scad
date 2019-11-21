// Comments below are for the Thingiverse customizer.

/* [Dimensions] */

// Number of item slots.
slot_count = 2;

// Diameter of each hole (across hexagon points, not flats). In millimeters.
holding_diameter = 18;

// Height from top hole to bottom plate; how high up the objects will be held. In millimeters.
holding_height = 110;

// Diameter to make available for objects' heads above the hole. This affects both the spacing of holes and the separation from the wall. No effect if smaller than Holding Diameter. In millimeters.
object_clearance_diameter = 50;

// General corner rounding and fillet radius. In millimeters.
rounding_radius = 3;

// Extra flat surface beyond the minimum beside and in front of the holes. In millimeters.
extra_width = 1;

/* [Hidden] */
// end of customizable parameters, start of implementation stuff

epsilon = 0.01;
reinforcement_d = 0.4;

// aliases for customizer-names vs internal names
insertion_hole_d = holding_diameter;
insertion_height = holding_height;
clearance_d = max(object_clearance_diameter, holding_diameter + rounding_radius * 4 /* fudge */);
// aliases for shorthand
rr = rounding_radius;
rd = rounding_radius * 2;
slot_spacing = clearance_d;

// calculated
clearance_r = clearance_d / 2;
hole_center_y = clearance_r;
round_bar_d = rd + epsilon;
basic_width = insertion_hole_d + round_bar_d * 2 + extra_width * 2 + clearance_d * (slot_count - 1);
stickout = hole_center_y + insertion_hole_d / 2 + rr + extra_width;

// Coordinate scheme: x = vertical as mounted, y = depth (perpendicular to wall), z = width

rotate([0, 0, 180])  // for better default view
main();

module main() {
    difference() {
        minkowski(convexity=10) {
            sphere(r=rounding_radius, $fn=8);
            
            shrunk_geometry();
        }
        
        reinforcement_neg();
    }
}

module shrunk_geometry() {
    // back plate
    translate([0, 0, -(basic_width - rd) / 2])
    cube([insertion_height, epsilon, basic_width - rd]);
    
    // base
    translate([0, 0, -(basic_width - rd) / 2])
    cube([epsilon, stickout, basic_width - rd]);
    fillet();

    translate([insertion_height / 2, 0, 0]) {
        ring();
        fillet();
        scale([-1, 1, 1]) fillet();
    }
    translate([insertion_height, 0, 0]) {
        ring();
        scale([-1, 1, 1]) fillet();
    }
}

module reinforcement_neg() {
    xn = 5;
    zn = 3;
    for (xi = [0:xn])
    for (zi = [0:zn]) {
        translate([(xi + 0.5) / (xn + 1) * insertion_height, 0, (zi - zn / 2) / (zn + 1) * (basic_width)])
        rotate([90, 0, 0])
        cylinder(d=reinforcement_d, h=rd - reinforcement_d * 8, center=true, $fn=4);
    }
}

module ring() {
    difference() {
        translate([0, 0, -(basic_width - rd) / 2])
        cube([epsilon, stickout, basic_width - rd]);
        
        for (i = [0:slot_count - 1]) {
            translate([0, hole_center_y, (i - slot_count / 2 + 0.5) * slot_spacing])
            rotate([0, 90, 0])
            rotate([0, 0, 90])
            cylinder(d=insertion_hole_d + rd, h=1000, center=true, $fn=6);
        }
    }
}

module fillet() {
    r = rd;
    h = basic_width - rd;
    rotate([0, 0, 180])
    translate([-r, -r, 0])
    difference() {
        translate([0, 0, -h / 2])
        cube([r, r, h]);
        cylinder(r=r, h=h + epsilon * 2, center=true, $fn=16);
    }
}
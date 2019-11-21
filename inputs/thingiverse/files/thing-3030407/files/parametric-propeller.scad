//number of Blades
blades = 3;

//base diameter of propeller blades
prop_diameter1 = 50;

//top diameter of propeller blades
prop_diameter2 = 10;

//base diameter of main cylinder
prop_shaft_diameter1 = 5;

//top diameter of main cylinder
prop_shaft_diameter2 = 5;

//diameter of hole
motor_shaft_diameter = 2.2;

blade_thickness = 1.5;

//total height
prop_height = 15;

//amount in degrees the propeller rotates from bottom to top
prop_rotation = 60;

//gives the propeller blades a rounded look. DO NOT EXCEED PROP_HEIGHT
rounding_diameter = 5;

/* [Hidden] */

$fn = 100;

module blade() {
    prop_diameter=max([prop_diameter1,prop_diameter2]);
    linear_extrude(height=prop_height, center=true, convexity=10, twist=prop_rotation, slices=50) {
        translate([0,-blade_thickness/2]) square([prop_diameter/2, blade_thickness]);
    }
}

module rounding_block() {
    minkowski() {
        cylinder(h=prop_height-rounding_diameter, d1=prop_diameter1-rounding_diameter, d2=prop_diameter2-rounding_diameter, center=true);
        sphere(d=rounding_diameter);
    }
}

module propeller() {
    difference() {
        intersection() {
            union() {
                for (i = [0:360/blades:360]) {
                    rotate([0,0,i]) blade();
                }
                cylinder(h=prop_height, d1=prop_shaft_diameter1, d2=prop_shaft_diameter2, center=true);
            }
            rounding_block();
        }
        cylinder(h=prop_height, d=motor_shaft_diameter, center=true);
    }
}

propeller();
//rounding_block();
    
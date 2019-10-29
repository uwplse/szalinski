// width
width = 70;

// length
length = 53;

// thickness
height = 2;

// rounded corners radius
corner_radius = 5;

// screw holes x offset
offset_x = 7;

// distance between holes
offset_y = 11.5;

// screw hole diameter
hole_diameter = 4.2;

// radius for beading
radius = 1.5;

/* [hidden] */
clearance = 0.01;


difference() {

    // plate
    union() {
        cube([width-corner_radius/2, length, height]);

        hull() {
            translate ([width-corner_radius/2, corner_radius/2, 0]) {
                cylinder(d=corner_radius, h=height, $fn=50);
            }
            translate ([width-corner_radius/2, length-corner_radius/2, 0]) {
                cylinder(d=corner_radius, h=height, $fn=50);
            }
        }

        hull () {
            translate ([width-corner_radius/2, corner_radius/2, height]) {
                sphere(radius, $fn = 40);
            }
            translate ([width-corner_radius/2, length-corner_radius/2, height]) {
                sphere(radius, $fn = 40);
            }
        }
    }

    // hole front
    translate ([offset_x, offset_y, -clearance]) {
        cylinder(d=hole_diameter, h=height+2*clearance, $fn=50);
    }

    // hole back
    translate ([offset_x, length - offset_y, -clearance]) {
        cylinder(d=hole_diameter, h=height+2*clearance, $fn=50);
    }
}

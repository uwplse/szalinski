// CSG-modules.scad - Basic usage of modules, if, color, $fs/$fa

// Change this to false to remove the helper geometry
debug = true;

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

d = 10;
c = 15;
r = 5;
h = 20;

// Main geometry
difference() {
    intersection() {
        body();
        intersector();
    }
    holes();
}


// Core geometric primitives.
// These can be modified to create variations of the final object

module body() {
    color("Blue") sphere(d);
}

module intersector() {
    color("Red") cube(c, center=true);
}

module holeObject() {
    color("Lime") cylinder(h=h, r=r, center=true);
}

// Various modules for visualizing intermediate components

module intersected() {
    intersection() {
        body();
        intersector();
    }
}

module holeA() rotate([0,90,0]) holeObject();
module holeB() rotate([90,0,0]) holeObject();
module holeC() holeObject();

module holes() {
    union() {
        holeA();
        holeB();
        holeC();
    }
}


echo(version=version());
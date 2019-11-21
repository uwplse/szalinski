bodyHeight = 8;
wallSize = 3;
lipSize = 3;
fullSize = 20;
gap = 5;

$fn = 15;

// -----------------------------------------------------------

module holder() {
    // lower body
    cube([wallSize, fullSize - wallSize, bodyHeight]);

    // upper border
    translate([0, fullSize - wallSize, 0])
        cube([(2 * wallSize) + gap, wallSize, bodyHeight]);

    // upper lip
    translate([wallSize + gap, fullSize - (2 * wallSize), 0])
        cube([wallSize, wallSize, bodyHeight]);

    // lower border
    translate([wallSize, 0, 0])
        cube([lipSize, lipSize, bodyHeight]);
}

module holes() {
    cylinder(d = 2.7, h = wallSize + 2);
    translate([45.6, 0, 0])
        cylinder(d = 2.7, h = wallSize + 2);
}

module mount() {
    difference() {
        union() {
            cube([45.6 + (2 * 4), 4, wallSize]);
            
            cube([8, 8, wallSize]);
            
            translate([45.6 + (2 * 4) - 8, 0, 0])
                cube([8, 8, wallSize]);
        }
        
        translate([4, 2.65 + 1.35, -1])
            holes();
    }
}

module mountA() {
    mount();

    translate([45.6 + (2 * 4), bodyHeight, wallSize])
        rotate([90, 90, 0])
        holder();
}

module mountB() {
    translate([45.6 + (2 * 4), bodyHeight, 0])
        rotate([0, 0, 180])
        mount();

    translate([45.6 + (2 * 4), bodyHeight, wallSize])
        rotate([90, 90, 0])
        holder();
}

mountB();

/*
rotate([90, 0, 0])
    mountA();

translate([0, 20, bodyHeight])
    rotate([-90, 0, 0])
    mountB();
*/

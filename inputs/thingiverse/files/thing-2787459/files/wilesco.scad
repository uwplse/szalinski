$fn = 15;

module holder() {
    difference() {
        cube([6, 6, 3]);
        
        translate([3, 3, -1])
            cylinder(d = 3.2, h = 5);
    }
}

module top() {
    rotate([90, 0, 0])
    difference() {
        cylinder(d = 8, h = 6);
        translate([0, 0, -1])
            cylinder(d = 4.2, h = 8);
    }
}

module prism(l, w, h){
    polyhedron(points = [
        [0,0,0],
        [l,0,0],
        [l,w,0],
        [0,w,0],
        [0,w,h],
        [l,w,h]
    ], faces = [
        [0,1,2,3],
        [5,4,3,2],
        [0,4,5,1],
        [0,3,4],
        [5,2,1]
    ]);
}

module adaptor() {
    polyhedron(points = [
        [6, 6, 3],
        [8, 6, 0],
        [8, 0, 0],
        [6, 0, 3],
        [20.5, 6, 49],
        [23, 6, 46.5],
        [23, 0, 46.5],
        [20.5, 0, 49]
    ], faces = [
        [3, 2, 1, 0], // a
        [0, 4, 7, 3], // b
        [1, 5, 4, 0], // c
        [2, 6, 5, 1], // d
        [2, 3, 7, 6], // e
        [4, 5, 6, 7] // f
    ]);
    
    
    translate([8, 0, 0])
        rotate([0, 0, 90])
        prism(6, 2, 3);
    
    
    /*
    difference() {
        translate([6, 0, 3])
            rotate([0, 45, 0])
            translate([0, 0, -5])
            cube([3.5, 6, 5]);
        
        translate([0, 0, -10])
            cube([10, 10, 10]);
    }
    */
}

holder();
translate([42, 0, 0])
    holder();

translate([48 / 2, 6, 50])
    top();

adaptor();
translate([48, 6, 0])
    rotate([0, 0, 180])
    adaptor();
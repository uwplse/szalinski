outside_diameter = 59;
height = 21;

module prism(l, w, h){
    polyhedron(
        points = [[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces = [[0,1,2,3], [5,4,3,2], [0,4,5,1], [0,3,4], [5,2,1]]
    );
}

module chunk() {
    wide = 0.1695 * outside_diameter;
    translate([0, (-0.0508 * outside_diameter), (-0.0424 * outside_diameter)]) {
        cube([(1.0169 * outside_diameter), (0.22 * outside_diameter), (0.0508 * outside_diameter) + wide]);
    };
    translate([0, (-0.0508 * outside_diameter), wide]) {
        prism((1.0169 * outside_diameter), (0.22 * outside_diameter), (0.22 * outside_diameter));
    };
}

rotate([180,0,0]) {
    union() {
        difference() {
            union() {
                difference() {
                    union() {
                        translate([0, 0, -1]) {
                            cylinder(d = (1.1017 * outside_diameter), h = 1, $fn = 200);
                        };
                        cylinder(d1 = (1.1017 * outside_diameter), d2 = (0.9661 * outside_diameter), h = (0.0678 * outside_diameter), $fn = 200);
                    };
                    translate([(0.5085 * outside_diameter),(0.5085 * outside_diameter),0]) {
                        rotate([90, 0, -90]) {
                            chunk();
                        };
                    };
                    translate([(-0.5085 * outside_diameter),(-0.5085 * outside_diameter),0]) {
                        rotate([90, 0, 90]) {
                            chunk();
                        };
                    };
                };
                translate([0, 0, -1]) {
                    cylinder(d = outside_diameter, h = height, $fn = 200);
                };
            };
            translate([0, 0, -1.5]) {
                cylinder(d = (0.9491 * outside_diameter), h = (height + 11), $fn = 200);
            };
        };
        translate([0, 0, (height - 3)]) {
            for(n = [2:8:outside_diameter]) {
                difference() {
                    cylinder(d = n, h = 2, $fn = 200);
                    translate([0, 0, -0.5]) {
                        cylinder(d = (n - 2), h = 3, $fn = 200);
                    };
                };
            };
        };
        translate([0, 0, (height - 2)]) {
            cube([(0.9491 * outside_diameter), 2, 2], center=true);
            cube([2, (0.9491 * outside_diameter), 2], center=true);
        };
    };
}
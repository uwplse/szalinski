outside_diameter = 42 ;	// [20:100]
inside_diameter = 37 ;	// [18:98]

module EndCap(id, od) {
    walls = od - id ;
    depth = .2 * od ;
    height = depth / 2 ;
    r = (pow(2 * height, 2) + pow((od + walls) / 2, 2)) / (4 * height) ;

    intersection() {
        union() {
            cylinder(h=height, r=(od + walls) / 2);
            translate([0, 0, height]) {
                difference() {
                    cylinder(h=depth, r1=(od + walls) / 2, r2=od / 2) ;
                    translate([0, 0, -1])
                        cylinder(h=depth + 2, r=od / 2) ;
                }
                difference() {
                    cylinder(h=depth, r=id/2) ;
                    translate([0, 0, -1])
                        cylinder(h=depth + 2, r=(id - walls) / 2) ;
                }
            }
        }
        translate([0, 0, r - height]) sphere(r) ;
        cylinder(h=depth + height, r=(od + 2 * walls / 3) / 2) ;
    }
}

EndCap(inside_diameter, outside_diameter) ;

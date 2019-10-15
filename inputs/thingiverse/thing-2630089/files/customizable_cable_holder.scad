wallThickness = 4;
depth = 20;
supportLength = 50;
supportThickness = 30;
cavity = 22;

module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}

rotate([0, -90, 0]) {
    union(){
        cube([depth, wallThickness, supportLength]);
        translate([0, wallThickness, 0]){
            cube([depth, supportThickness, wallThickness]);
        }
        translate([0, supportThickness+wallThickness, 0]){
            cube([depth, wallThickness, supportLength]);
        }
        translate([0, supportThickness+wallThickness*2, 0]){
            cube([depth, cavity, wallThickness]);
        }
        translate([depth/2, supportThickness+wallThickness*2, wallThickness]){
            rotate([90, 0, 90]){
                fillet(4, depth);
            }
        }
        translate([0, supportThickness+wallThickness*2+cavity, 0]){
            cube([depth, wallThickness, supportLength]);
        }
        translate([depth/2, supportThickness+wallThickness*2+cavity, wallThickness]){
            rotate([90, 0, -90]){
                fillet(4, depth);
            }
        }
        translate([0, supportThickness+wallThickness*2+(cavity-cavity/3*2), supportLength-wallThickness]){
            cube([depth, cavity/3*2, wallThickness]);
        }
        translate([depth/2, supportThickness+wallThickness*2+cavity, supportLength-wallThickness]){
            rotate([90, 90, 270]){
                fillet(4, depth);
            }
        }
        translate([depth/2, supportThickness+wallThickness*3+(cavity-cavity/3*2), supportLength-wallThickness]){
            rotate([90, 90, 90]){
                fillet(4, depth);
            }
        }
        translate([0, supportThickness+wallThickness*2+(cavity-cavity/3*2), supportLength-wallThickness-supportLength/3]){
            cube([depth, wallThickness, supportLength/3]);
        }
    }
}


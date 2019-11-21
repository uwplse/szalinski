module support() {
    
    module border() {
        difference() {
            translate([5, 0, 5]) {
                minkowski() {
                    cube([71, 10, 52]);
                    rotate([-90, 0, 0]) {
                        cylinder(r=5, h=11.5);
                    }
                }
            }       
        
            translate([10, -1, 10]) {
                minkowski() {
                    cube([71-10, 10, 52-10]);
                    rotate([-90, 0, 0]) {
                        cylinder(r=5, h=22);
                    }
                }
            }
        }
    }
    
    module holder() {
        difference() {
            union() {
                translate([3, 21.5, 61.5]) {
                    rotate([90, 0, 0]) {
                        linear_extrude(height = 21.5) {
                            polygon([[0, 0], [36, 21], [75, 0]]);
                        }
                    }
                }
                translate([35, 0, 79]) {
                    cube([7, 21.5, 95]);
                }
                translate([35, 0, 79]) {
                    cube([10, 21.5, 18]);
                }        
            }
            translate([52, -1, 97]) {
                rotate([-90, 0, 0]) {
                    cylinder(r=10, h=25, $fn=100);
                }
            }
            translate([45.5, -1, 84.5]) {
                rotate([-90, 0, 0]) {
                    cylinder(r=2, h=25, $fn=100);
                }
            }
            translate([39, -2, 84.5 + 40.5]) {
                cube([5, 5, 52]);
            }         
            * translate([40, -3, 84.5]) {
                cube([5, 5, 41.5]);
            }
            translate([44, 11, 84.5 + 42]) {
                rotate([-90, 0, 90]) {
                    cylinder(r=3, h=10, $fn=100);
                }
            }
            translate([44, 11, 84.5 + 77]) {
                rotate([-90, 0, 90]) {
                    cylinder(r=3, h=10, $fn=100);
                }
            }                        
        }
    }
    
    border();
    holder();    
}

support();
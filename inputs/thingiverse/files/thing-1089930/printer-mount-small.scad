difference() {
    difference() {
        translate([0,0,-1]){
            difference() {
                difference() {
                    difference() {
                        cube([38,38,32]);
                        translate([19,39
                        ,20])rotate([90,0,0])cylinder(h=40, r=4, $fs=0.01);
                        translate([15,-1,0])cube([8,40,20]);
                        translate([0,-1,9])cube([10,40,30]);
                        translate([28,-1,9])cube([10,40,30]);
                    }
                }

                difference() {
                    translate([10,0,27])cube([18,10,5]);
                    translate([19,9,27])cylinder(5,18,13,$fn=4);
                }
                translate([0,28,0])difference() {
                    translate([10,0,27])cube([18,10,5]);
                    translate([19,1,27])cylinder(5,18,13,$fn=4);
                }

                translate([33,8.3,0])cylinder(h=12, r=2, $fs=0.01);
                translate([33,29.7,0])cylinder(h=12, r=2, $fs=0.01);
                translate([5,8.3,0])cylinder(h=12, r=2, $fs=0.01);
                translate([5,29.7,0])cylinder(h=12, r=2, $fs=0.01);
                
            }

            difference() {
                translate([0,0,9])intersection() {
                    rotate([0,45,0])cube([15,38,15]);
                    cube([10,38,10]);
                }
                translate([0,24,9])cube([10,10,10]);
            }


            rotate([0,90,0])difference() {
                translate([-19,0,28])intersection() {
                    rotate([0,45,0])cube([15,38,15]);
                    cube([10,38,10]);
                }
                translate([-19,24,28])cube([10,10,10]);
            }
        }
        translate([0,0,-5])cube([40,40,5]);
    }
    cube([40,19,40]);
}
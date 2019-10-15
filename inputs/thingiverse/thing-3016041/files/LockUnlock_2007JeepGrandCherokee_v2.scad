$fa=1;
$fs=0.5;


module rounded_button_top() {
    hull() {
        translate([0,-11.5,4.3]) {
            rotate([0,90,0]) cylinder(r=2, h=10.7, center=true);
        }
        translate([0,11.5,4.3]) {
            rotate([0,90,0]) cylinder(r=2, h=10.7, center=true);
        }
        translate([10.7/2,0,5.8]) {
            rotate([90,0,0]) cylinder(r=0.5, h=23, center=true);
        }
        translate([-10.7/2,0,5.8]) {
            rotate([90,0,0]) cylinder(r=0.5, h=23, center=true);
        }
        translate([0,0,2.5/2]) cube([12.45, 27.7, 2.5], center=true);
    }
}

module button_top() {
    difference() {
    rounded_button_top();
    scale([9.35/12.45, 24.6/27.7, 5.0/6.3]) button_top_shape();
}
}

module button_top_shape() {
    hull() {
        translate([0,0,6.3/2]) cube([10.7, 23.0, 6.3], center=true);
        translate([0,0,2.5/2]) cube([12.45, 27.7, 2.5], center=true);
    }
}

module bt_with_rear_hole_tab() {
    difference() {
        union() {
            button_top();
            
            //tab for hole
            //translate([12.45/2-1.55,-5,-5]) cube([1.55,10,6]);
            translate([12.45/2-1.55,0,-0.95]) {
                rotate([0,90,0]) {
                    intersection() {
                        cylinder(r=5, h=1.55);
                        translate([3,0,0]) cube(10, center=true);
                    }
                }
            }
        }

        //larger rear hole
        translate([12.45/2-1.6,0,-0.95]) {
            rotate([0,90,0]) cylinder(r=1.9, h=1.8);
        }
    }
}
module bt_with_front_hole_tab() {
    difference() {
        union() {
            bt_with_rear_hole_tab();
            
            //tab for hole
            //translate([12.45/2-1.55,-5,-5]) cube([1.55,10,6]);
            translate([-(12.45/2-1.55),0,-0.95]) {
                rotate([0,-90,0]) {
                    intersection() {
                        cylinder(r=5, h=1.55);
                        translate([-3,0,0]) cube(10, center=true);
                    }
                }
            }
        }

        //smaller front hole
        translate([-(12.45/2-1.6),0,-0.95]) {
            rotate([0,-90,0]) cylinder(r=1.5, h=1.8);
        }
    }
}

module springtube() {
    difference() {
        cylinder(r=4.8/2, h=15);
        translate([0,0,-0.1]) cylinder(r=3.35/2, h=15.2);
    }
}

module switch_actuator_with_spring() {
    union() {
        hull() {
            cylinder(r=4.65/2, h=1.8);
            translate([0,4.5,0.9]) cube([4.65, 9.0, 1.8], center=true);
        }
        hull() {
            translate([0,9.0,0]) cylinder(r=4.65/2, h=1.8);
            translate([0,34-4.65/2,0.9]) cube([10, 0.1, 1.8], center=true);
        }
        rotate([-90,0,0]) {
            translate([0,-(1.8+3.35/2),19-4.65/2]) springtube();
        }
    }
}


union() {
    bt_with_front_hole_tab();
    translate([12.45/2-3.55,0,-(28.45-4.65/2)]) {
        rotate([0,0,-90]) {
            rotate([90,0,0]) {
                switch_actuator_with_spring();
            }
        }
    }
}
module holder() {
    
    union() {
        difference() {
            
            // head
            translate([0, 0, 0]) {
                cylinder(r=7.5, h=$width);        
            }
            translate([0, 0, -1]) {
                cylinder(r=2.5, h=$width+2);
            }
            translate([0, -2.5, -1]) {
                cube([10, 3, $width+2]);
            }
            translate([1.5, 0, -1]) {
                cube([10, 10, $width+2]);
            }            
            
            // gap
            translate([-9, -10, $width/2-$gap/2]) {
                rotate([0, 0, 55]) {
                    cube([20, 10, $gap]);
                }
            }
            translate([-10, 0, $width/2-$gap/2]) {
                rotate([0, 0, 0]) {
                    cube([15, 10, $gap]);
                }
            }            
        }
        
        // body
        translate([5, -6.5, 0]) {
            rotate([0, 0, 40]) {
                cube([25, $tick, $width]);
            }
        }
        translate([21.25, 8.5, 0]) {
            rotate([0, 0, 0]) {
                cube([45, $tick, $width]);
            }
        }
        translate([2.25, -7.2, 0]) {
            rotate([0, 0, 13.35]) {
                cube([67.5, $tick, $width]);
            }
        }
        
        // base
        translate([66.5, 14.2, 0]) {
            cylinder(r=6, h=$width);
        }
        
        // holder
        translate([-3, 26.2-$tick, 0]) {
            rotate([0, 0, -4.95]) {
                cube([70, $tick, $width]);
            }
        }
        translate([-3, 26.2-$tick, $width/2]) {
            rotate([-90, 0, -5]) {
                cylinder(r=$width/2, h=$tick);
            }
        }
    }
}

// modify the values as you want...

$fn=50;
$gap   = 3;    // [2..5]
$width = 13;   // [10..20]
$tick  = 4.5;  // [2..6]

holder();
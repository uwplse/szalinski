// preview[view:south, tilt:top]

// Number of holders in the X direction
holders_x = 8; // [1:100]
// Number of holders in the Y direction
holders_y = 1; // [1:100]

module paintmock(d=25, h=50, neck_d=20, neck_h=28) {
    cylinder(d=d, h=h, $fn=50);
    translate([0,0,neck_h]) cylinder(d=neck_d, h=50, $fn=50);
}

module rack(x, y = 1) { 
    for (j = [1:y])
        for (i = [1:x])
            translate([30*i,sin(70)*85*j,0])
                difference() {
                    translate([-15,0,0])
                    {
                        if (i != 1) {
                            translate([0,0,3])
                                cube([2, sin(70)*63,2]);
                        }
                        cube([30, 15, 15]);
                        translate([0,15,3])
                            rotate([0,90,0])
                            cylinder(r=3, h=30, $fn=50);
                        cube([30, sin(70)*63, 3]);
                        translate([0,sin(70)*63, 0])
                        {
                            cube([30, 5, 35]);
                            translate([0,0,3])
                                rotate([0,90,0])
                                cylinder(r=3, h=30, $fn=50);
                        }
                    }
                    translate([0,5,16])
                        rotate([-70,0,0]) {
                            paintmock();
                        }
                }
}


rack(holders_x, holders_y);

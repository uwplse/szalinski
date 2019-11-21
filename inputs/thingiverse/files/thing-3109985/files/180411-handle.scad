
handle_D = 0.5*25.4;  //handle diameter
handle_L = 6.25*25.4;  //handle mount hole spacing
handle_flat = 10;  //handle raised height off the bed (0 will be the center of the spheres)
ring_mount_ID = 4.1;
ring_mount_OD = 1/2 * 25.4;
ring_mount_H = 1 * 25.4 + handle_D + handle_flat;

difference()  {
    union()  {
        handle2();
        leg();
        leg2();
    }
    rotate([0,0,0])  {
            translate([0,0,2])  {
                cylinder(h = ring_mount_H+100, d = ring_mount_ID, center = false, $fn=100);
            }
        }
    rotate([0,0,0])  {
            translate([handle_L,0,2])  {
                cylinder(h = ring_mount_H+100, d = ring_mount_ID, center = false, $fn=100);
            }
        }
    }
module leg()  {
    translate([0,0,0])  {
        cylinder(h = ring_mount_H, d = ring_mount_OD, center = false, $fn=100);
    }        
}
module leg2()  {
    translate([handle_L,0,0])  {
        cylinder(h = ring_mount_H, d = ring_mount_OD, center = false, $fn=100);
    }
}

module handle2()  {
    hull()  {
        translate([0, 0, handle_flat]){
            difference()  {
                sphere(handle_D, $fn = 50);
                translate([-25, -25, -60]){
                    cube([50,50,50]);
                }
            }
        }
        translate([handle_L, 0, handle_flat]){
            difference()  {
                sphere(handle_D, $fn = 50);
                translate([-25, -25, -60]){
                    cube([50,50,50]);
                }
            }
        }
    }
}
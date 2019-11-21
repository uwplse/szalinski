difference() {
    union(){
        difference(){
            linear_extrude(height=40) circle(d=13.5, $fn=120);
            translate([-4,-4,-1]) cube([8.1,8.1,42]);
        }
        translate([6.5,-1.5,0]) cube([15,3,20]);
        translate([-15-6.5,-1.5,0]) cube([15,3,20]);
    }
    // keyhole
    translate([-7.5-13/2,2.5,10]) rotate([90,0,0]) linear_extrude(height=5) circle(d=8, $fn=120);
}
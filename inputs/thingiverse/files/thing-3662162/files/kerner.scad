
difference(){
    union(){
        sphere(20,$fn = 100);
        translate([0,0,0]) cylinder(r=10,h=30,$fn = 100);
        rotate_extrude(convexity = 10, $fn = 100)
        translate([10, 28, 0])
        circle(r = 2, $fn = 100);
            }
translate([25,0,0]) cube([20,80,80], center=true);
translate([-25,0,0]) cube([20,80,80], center=true);
translate([0,0,0]) cylinder(r=6,h=31,$fn = 100);

}
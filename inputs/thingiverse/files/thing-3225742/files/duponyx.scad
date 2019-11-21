//the number of "shells" to make
count = 11; // [1:10]
solid = 4;
module shell() {
    translate([2.8/2, 7, 2.8/2]) 
    rotate([90, 0, 0])
    union() {
        difference() {
            cube([2.8, 2.8, 14], center=true);
            // inner hole/hollow
            translate([0, 0, 1])
                cube([2, 2, 14], center=true);
            // pin hole
            rotate([0, 0, 45])
                cylinder(r=0.8, h=60, center=true, $fn=4);
            // chamfer
            translate([0, 0, -7.1]) rotate([0, 0, 45]) 
                cylinder(r1=2.5, r2=0.8, h=0.5, center=true, $fn=4);
            // tab hole 
            translate([0, -1, -0.5])
            cube([1.8, 1, 5], center=true);
        }
        // tab
         translate([0, -1.125, 0.8])
            cube([1.3, 0.25, 4.5], center=true);
    }
}

module shellx() {
    translate([2.5/2, 7, 2.5/2]) 
    rotate([90, 0, 0])
           cube([2.5, 2.5, 14], center=true);
};

 for(i = [0:count-1]) 
    translate([2.5*i, 0, 0]) 
     if (i==solid) shellx(); else   shell();
     





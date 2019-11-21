difference() {

    difference() {
        
        cylinder (h = 160, d=110, $fn=48);
        
        translate ([0,0,-0.1])
            cylinder (h = 160.2, d=100, $fn=48);
    };

    union() {
        for (y=[5:20:160])
            for (z=[0:15:360])
                translate([0,0,y])
                    rotate([90,0,z])
                        translate([0,0,45])
                            cube([1,10,20]);
    };

}
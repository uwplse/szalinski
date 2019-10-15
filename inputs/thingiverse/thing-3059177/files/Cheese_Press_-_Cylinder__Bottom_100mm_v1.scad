difference() {
    
    union() {
        difference() {
            cylinder (h = 44, d=98, $fn=48);
            translate ([0,0,55])
                sphere (d=100, $fn=48);
        }
        difference() {
            cylinder (h = 160, d=110, $fn=48);
            translate ([0,0,-0.1])
            cylinder (h = 160.2, d=100, $fn=48);
        }

    };
    
    union() {
        for (y=[20:20:200])
        for (z=[0:15:360])
            translate([0,0,y])
            rotate([135,0,z+3.75])
                cylinder(h=100,d=3,$fn=24);

        cylinder(h=100,d=3,$fn=24);
    };

};
// variable description
base_height = 20; // [10:100]
can_width = 84; // [10:200]

difference() {
    intersection() {
        cylinder(h = base_height, r = can_width/2+2, $fn=64);
        minkowski() {
            translate([0,0,2]) cylinder(h = base_height-2, r = can_width/2, $fn=64);
            sphere(r=2, center=true, $fn=24);
        }
    }
cylinder(h = base_height*2+1, r1 = can_width/2+2, r2 = can_width/2-4, center = true, $fn=64);

minkowski() {
    translate([0,0,base_height-3]) cylinder(h = base_height-4, r = can_width/2-2, $fn=64);
    sphere(r=2, center=true, $fn=24);
    }
}
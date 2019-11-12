h = 1;
gap = 5;

difference() {
    cube([190, 30, h]);
    for (i=[0:11]) {
        translate([i*i + gap * i, 15, 0])
       // rotate([0, 0, 30])
            cylinder(h=h, r1=i, r2=i, $fn=6);
    }
}
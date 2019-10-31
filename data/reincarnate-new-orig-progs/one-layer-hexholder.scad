h = 1;
gap = 1;

difference() {
    cube([100, 30, h]);
    for (i=[0:9]) {
        translate([i*i + gap * i, 15, 0])
            cylinder(h=h, r1=i, r2=i, $fn=6);
    }
}
h = 1;
gap = 1;

difference() {
    cube([100, 50, h]);
    for (o=[0:1]) {
        translate([0, o * 20, 0])
        for (i=[0:9]) {
            translate([i*i + gap * i, 15, 0])
                cylinder(h=h, r1=i, r2=i, $fn=6);
        }
    }
}

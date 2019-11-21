n = 6;
cylinder(r=5, $fn=12);
for (i = [0:n-1]) {
    rotate([0, 0, i * 360 / n])
    translate([1, -0.5, 0])
    cube([10, 1, 1]);
}

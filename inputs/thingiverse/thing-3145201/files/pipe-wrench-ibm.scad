outer = 10;
inner = 5.5 + 0.1;
ratio = 2 / sqrt(3);
height = 40;

translate([-height / 2, -outer / 2, 0])
    cube([height, outer, 10]);

difference() {
    cylinder(h=height, r=outer/2, $fn = 50);
    translate([0, 0, height - 30 + 0.1])
        rotate([0, 0, 30])
            cylinder(h=30, r=ratio * inner/2, $fn=6);
}

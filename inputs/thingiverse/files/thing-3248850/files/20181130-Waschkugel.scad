// jwi, 2018-11-30

/* [Configuration] */
// volume of inner sphere (will be reduced by cut-out)
ml = 120; // [10:1000]

/* [Hidden] */
$fn = 75;
pi = 3.141592654;
inner_r = pow(ml / (4/3 * pi), 1/3) * 10;
outer_r = inner_r + 3;

intersection() {
    difference () {
        sphere(outer_r);
        sphere(inner_r);
    }
    translate([0, 0, -10]) cube(2 * outer_r, true);
}
translate([0, 0, -outer_r + 2]) cylinder(h = 3, r1 = inner_r - 8, r2 = inner_r / 2, center = true);
translate([0, 0, -outer_r ]) cylinder(h = 2, r1 = inner_r - 8, r2 = inner_r - 8, center = true);    
thickness = 10;

toe_rad=10;
toe_sep=5;

depth=toe_rad*2+toe_sep*2;
length = 8*toe_rad + 4*toe_sep;
difference() {
    translate ([3 * length / 8, 0, 0])
    cube([length, depth, thickness], center=true);
for (i = [0:3])
    translate([i * length / 4, 0, 0])
        union() {
            translate([0, depth/4, 0])
                cube ([depth/2,depth/2,thickness], center=true);
            cylinder(thickness, toe_rad, toe_rad, center=true);
        }
}

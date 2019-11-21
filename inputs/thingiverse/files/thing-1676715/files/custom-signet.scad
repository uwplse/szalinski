// Image heightmap to customize the resulting seal. Beware that the having non-zero values in the corners may cause unexpected results.
signet = "foo.dat"; // [image_surface:100x100]
// (mm)
inner_diameter = 15; // [5:0.5:30]
// (mm)
signet_depth = 1.2; // [0.6:0.2:3]

$fa = 1;
$fs = 1;
sclfac = inner_diameter / 25;
sigscl = signet_depth / sclfac;
scale([sclfac, sclfac, sclfac])
difference() {
    sphere(40);
    rotate([0,20,0]) {
        translate([-40,-40,25]) {
            cube(80);
        }
    }
    rotate([0,-20,0]) {
        translate([-40,-40,-105]) {
            cube(80);
        }
    }
    translate([-105,-40,-40]) {
        cube(80);
    }
    translate([10,0,-40]) {
        cylinder(80,25,25);
    }
    translate([-25.1,0,3]) rotate([0,90,0]) rotate([0,0,90])
        scale([0.4,0.4,sigscl]) surface(file=signet);
}
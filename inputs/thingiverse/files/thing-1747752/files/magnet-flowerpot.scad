// preview[view:west, tilt:bottom diagonal]

/* [Flowerpot] */
diameter=70;

/* [Magnet] */
magnet_diameter=10;
magnet_height=5;

/* [Hidden] */
thickness=5;
magnet_translation=0.2 * magnet_diameter + 3;

module body() {
    difference() {
        sphere(d=diameter, $fn=200);

        rotate([0, 90, 0])
            translate([0, 0, diameter / 2])
                cylinder(d=magnet_diameter + 1, h=diameter, center=true, $fn=200);

        translate([0, 0, diameter * 0.85])
            cube(size=diameter, center=true);

        sphere(d=diameter - thickness);
    };

    color("red") rotate([0, 90, 0])
        translate([0, 0, diameter / 2 - magnet_translation])
            difference() {
                cylinder(d1=magnet_diameter + 1, d2=magnet_diameter + 7, h=magnet_height, center=true);
                cylinder(d=magnet_diameter + 1, h=magnet_height, $fn=200);
            }
}

module magnet() {
    color("blue")
        rotate([0, 90, 0])
            translate([0, 0, diameter / 2 - magnet_translation])
                cylinder(d=magnet_diameter, h=magnet_height);
}

rotate ([0, 180, 0]) body();
//magnet();
// diameter
inner = 5.75;

// diameter
outer = 9.75;


thickness = 1;

module washer (inner, outer, thickness) {

    difference() {
        cylinder(d=outer, h=thickness, $fn=100);
        translate([0,0,-thickness])
        cylinder(d=inner, h=thickness*3, $fn=100);
    };
}

// dimensions in mm
washer (inner, outer, thickness);
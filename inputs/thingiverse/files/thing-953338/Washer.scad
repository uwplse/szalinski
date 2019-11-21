// diameter
inner = 6;

// diameter
outer = 100;


thickness = 2;

module washer (inner, outer, thickness) {

    difference() {
        cylinder(d=outer, h=thickness, $fn=60);
        translate([0,0,-thickness])
        cylinder(d=inner, h=thickness*3, $fn=60);
    };
}

// dimensions in mm
washer (inner, outer, thickness);
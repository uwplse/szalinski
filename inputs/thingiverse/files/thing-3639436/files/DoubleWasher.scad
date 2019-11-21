inner1 = 8;
outer1 = 16;
thickness1 = 8;

inner2 = 4;
outer2 = 24.15;
thickness2 = 2;

segments = 120;
module washer (inner, outer, thickness) {

    difference() {
        cylinder(d=outer, h=thickness, $fn=segments);
        translate([0,0,-thickness])
        cylinder(d=inner, h=thickness*3, $fn=segments);
    };
}

// dimensions in mm
union() {
    washer (inner1, outer1, thickness1);
    washer (inner2, outer2, thickness2);
}
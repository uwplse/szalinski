// diameter in mm
inner = 9;

// diameter in mm
outer = 12;

// thickness in mm
thickness = 2;


volumeX = 4;
volumeY = 2;

module washer (inner, outer, thickness) {

    difference() {
        cylinder(d=outer, h=thickness, $fn=60);
        translate([0,0,-thickness])
        cylinder(d=inner, h=thickness*3, $fn=60);
    };
}

for (i=[1:volumeX]) {
    translate ([outer*(i-1)+thickness/2*i,0,0])
    for (j=[1:volumeY]) {
        translate([0,outer*(j-1)+thickness/2*j,0])
        washer (inner, outer, thickness);
    }
}
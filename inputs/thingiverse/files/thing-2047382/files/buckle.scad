//Parametric tri-glide webbing buckle

//INCH = 25.4;

//Width of webbing in mm
width = 9.525;

//Thickness of webbing
thickness = 1; //[0.5:0.1:2.0]

//Base thickness of buckle structure
BULK = 2;

module buckle(webbing_width, webbing_thickness=2) {
    width = webbing_width + 2*BULK;
    length = 4*webbing_thickness + 3 * BULK;
    difference() {
        minkowski() {
            cube([width-BULK, length-BULK, BULK/2], center=true);
            cylinder(BULK/2, BULK/2, BULK/2, center=true, $fn=12);
        }
        translate([0, -1.5*BULK, 0])
            cube([webbing_width, 2*webbing_thickness, 2*BULK], center=true);
        translate([0, 1.5*BULK, 0])
            cube([webbing_width, 2*webbing_thickness, 2*BULK], center=true);
        translate([0, 0, -BULK/4-0.1]) {
            cube([webbing_width, 2*BULK, BULK/2], center=true);
        }
        translate([0, 2*webbing_thickness+BULK, BULK/4+0.1]) {
            cube([webbing_width, 2*BULK, BULK/2], center=true);
        }
        translate([0, -2*webbing_thickness-BULK, BULK/4+0.1]) {
            cube([webbing_width, 2*BULK, BULK/2], center=true);
        }
    }
}

buckle(width, 2*thickness);
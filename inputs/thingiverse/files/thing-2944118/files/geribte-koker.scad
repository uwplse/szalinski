// Testje

radius = 50;
thickness = 8;
height = 130;
ribs = 30;
riblength = 6;
ribthickness = 4;
layers = 100;
curvyness = 3;

difference() {

    union() {
        cil(radius);

        intersection() {
            ribs();
//            #minkowski() {
                cil(radius + riblength);
//                sphere(10);
//            }
        }
    }
    
    hole();
}


module cil(radius) {
    for (layer = [0: height/layers: height - height/layers]) {
        translate([0, 0, layer]) {
            r = curve(radius, layer, height);
            rn = curve(radius, layer + height/layers, height);
            cylinder(height/layers, r, rn);
        }
    }
}

module ribs() {
    linear_extrude(height = height) {
        for (angle = [0: 360/ribs: 360]) {
            rotate(angle) {
                translate([-ribthickness/2, 0, 0]) {
                    square([ribthickness, radius + riblength * 2]);
                }
            }
        }
    }
}

module hole() {
    translate([0, 0, thickness]) {
        cylinder(height, radius-thickness, radius-thickness);
    }
}

function curve(radius, y, h) = radius - cos(360 * y / h) * curvyness;

echo(version=version());

//CUSTOMIZER VARIABLES

// Overall radius of the sphere
sphereRadius = 30;

// Number of holes to place in the sphere around the X, Y, and Z axis
holesPerAxis = 8;

// Radius of each hole at the surface of the sphere
holeTopRadius = 5.5;

// Radius of each hole at the bottom of the hole
holeBottomRadius = 5;

// Depth of the hole
holeDepth = 12;

// Where the holes are place around the sphere
holePathRadius = 24;

//CUSTOMIZER VARIABLES END


module holesX(qty, holeTopRadius, holeBottomRadius, holeDepth, pathRadius) {
    for (i = [1: 8]) {
        translate([pathRadius*cos(i*(360/qty)), pathRadius*sin(i*(360/qty)), 0]){
            rotate([(qty-i) * (360/qty), 90, 0]) {
                cylinder(h=holeDepth, r1=holeBottomRadius, r2=holeTopRadius, center=true);
            }
        }
    }
}
module holesY(qty, holeTopRadius, holeBottomRadius, holeDepth, pathRadius) {
    for (i = [1: 8]) {
        translate([pathRadius*cos(i*(360/qty)), 0, pathRadius*sin(i*(360/qty))]){
            rotate([0, (qty-i) * (360/qty) + 90, 0]) {
                cylinder(h=holeDepth, r1=holeBottomRadius, r2=holeTopRadius, center=true);
            }
        }
    }
}
module holesZ(qty, holeTopRadius, holeBottomRadius, holeDepth, pathRadius) {
    for (i = [1: 8]) {
        translate([0, pathRadius*cos(i*(360/qty)), pathRadius*sin(i*(360/qty))]){
            rotate([(i) * (360/qty) +270, 0, 0]) {
                cylinder(h=holeDepth, r1=holeBottomRadius, r2=holeTopRadius, center=true);
            }
        }
    }
}

module holes(holesPerAxis, holeTopRadius, holeBottomRadius, holeDepth, holePathRadius) {
    holesX(holesPerAxis, holeTopRadius, holeBottomRadius, holeDepth, holePathRadius);
    holesY(holesPerAxis, holeTopRadius, holeBottomRadius, holeDepth, holePathRadius);
    holesZ(holesPerAxis, holeTopRadius, holeBottomRadius, holeDepth, holePathRadius);
}

module crazyFortBall(sphereRadius, holesPerAxis, holeTopRadius, holeBottomRadius, holeDepth, holePathRadius) {
    difference() {
        sphere(r=sphereRadius);
        holes(holesPerAxis, holeTopRadius, holeBottomRadius, holeDepth, holePathRadius);
    }
}

crazyFortBall(sphereRadius, holesPerAxis, holeTopRadius, holeBottomRadius, holeDepth, holePathRadius);

//// Libraries.
use <MCAD/2Dshapes.scad>;
use <MCAD/nuts_and_bolts.scad>;


//// Parameters.

parts = "combo"; // [mount:Mount, bolt:Single bolt, combo:Mount + 2 bolts]

baseThickness = 5;
boltDiameter = 14.25;
boltGap = 35;
cageDepth = 60;
connectorOrientation = 0; // [0:Horizontal, 90:Vertical]

/* [Hidden] */
$fn = 360;
fn = 36;

connectorHeight = 19.15;
connectorWidth = 15.15;
connectorLength = 16.15;
connectorBoltDiameter = 5;


//// Modules.

// Base.
module base() {
    // Width - Adjust based on connector orientation.
    _width = connectorOrientation == 0 || connectorOrientation == 180
        ? connectorWidth : connectorLength;

    // Base plate.
    translate([0, 0, baseThickness / 2])
    cube([_width, boltGap, baseThickness], true);
    
    // Nuts.
    for (i = [-1:2:1]) {
        translate([0, i * (boltGap + boltDiameter) / 2, baseThickness / 2])
        nut(boltDiameter + 1.5, baseThickness);
    }
}

// Bolt.
module bolt() {
    _threadLength = 10;
    _boltLength = cageDepth - _threadLength + baseThickness;
    _totalLength = _boltLength + _threadLength + 5;

    translate([0, _totalLength / 2, 5]) difference() {
        translate([0, -5, 0]) rotate([90, 0, 0]) union() {
            cylinder(_boltLength, d = boltDiameter);

            translate([0, 0, _boltLength + _threadLength / 2])
            threadedRod(boltDiameter, _threadLength);

            translate([0, 0, -5])
            cylinder(5, d = boltDiameter + 10, $fn = 6);
        }
        
        // Flatten bolt.
        for (i = [-1:2:1]) {
            translate([0, -_totalLength / 2, i * (boltDiameter / 4 + 5)])
            cube([boltDiameter + 5, _totalLength + 1, boltDiameter / 2], true);
        }
    }
}

// Connector.
module connector() {
    _rads = [connectorWidth / 2, connectorWidth / 2];
    _toothWidth = connectorLength / 5;

    rotate([0, 0, connectorOrientation])
    translate([0, 0, -_toothWidth])
    difference() {
        union() {

            // Base.
            translate([0, 0, _toothWidth / 2])
            cube([connectorWidth, connectorLength, _toothWidth], true);

            // Teeth.
            translate([0, _toothWidth / 2, connectorHeight / 2])
            for (i = [-1:1]) {
                translate([0, i * _toothWidth * 2, 0])
                rotate([90, 0, 0])
                linear_extrude(_toothWidth)
                complexRoundSquare(
                    [connectorWidth, connectorHeight],
                    rads3 = _rads,
                    rads4 = _rads
                );
            }

        }

        // Bolt hole.
        translate([0, connectorLength / 2, connectorHeight - connectorWidth / 2]) 
        rotate([90, 0, 0])
        linear_extrude(connectorLength)
        boltHole(connectorBoltDiameter, proj = 1);
        
        // Nut hole.
        translate([0, -connectorLength / 2 + 2.25, connectorHeight - connectorWidth / 2])
        scale([1.1, 1, 1.1])
        rotate([90, 0, 0])
        nutHole(connectorBoltDiameter);
    }
}

// Nut.
module nut(diameter, height) {
    difference() {
        cylinder (h = height, r = (diameter + 10) / 2, center = true, $fn = 6);
        threadedRod(diameter, height);
    }
}

// Threaded rod - Modified version copied from MCAD/hardware.scad.
module threadedRod(rodsize = 6, height = 20) {
    rodpitch = rodsize / 6;

	linear_extrude(height = height, center = true, convexity = 10, twist = -360 * height / rodpitch, $fn = fn)
    translate([rodsize * 0.1 / 2, 0, 0])
    circle(r = rodsize * 0.9 / 2, $fn = fn);
}


//// Print.

// Base.
if (parts != "bolt") {
    translate([0, 0, baseThickness]) connector();

    base();
}

// Bolt(s).
if (parts != "mount") {
    _bolts = parts == "bolt" ? 1 : 2;

    for (i = [-1:2:_bolts - 1]) {
        translate([i * (boltDiameter + 15), 0, 0]) bolt();
    }
}

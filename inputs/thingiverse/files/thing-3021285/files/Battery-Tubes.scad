/* [Base Options] */

$fn = 64;

// Type
type = "18650"; // [custom, 18650, A, AA, AAA, AAAA, B, C, D, F, N]

// Number of tubes
numHolders = 2;

// Do export caps
exportCaps = 1; // [0, 1]

// Do export tubes
exportTubes = 1; // [0, 1]

/* [Custom Size Options] */

// Inner height of tube (Only used with Custom Type)
tubeHoleHeight = 66;

// Inner radius of tube (Only used with Custom Type)
tubeHoleRadius = 10;

/* [Overall] */

// Thickness of all tubes
wallThickness = 1.6;

// Cap and Tube Fillets
capTubeFillets = 2;

/* [Cap Options] */

// Height of cap overlap with tube
capOverlap = 4;

// Tolerance of cap and tube
capTolerance = 0.3;

// Chamfer on the cap opening
capChamfer = 0.4;

/* [Holding Groove] */

// Radius of groove to hold on cap
grooveRadius = 2;

// Height of groove center from top of tube
grooveOffset = 2;

// Depth of groove on the tube
grooveInset = 0.25;


/////// Do not edit below

holeRadius = type == "18650" ? 10 :
             type == "A" ? 9 :
             type == "AA" ? 8 :
             type == "AAA" ? 6 :
             type == "AAAA" ? 5 :
             type == "B" ? 11 :
             type == "C" ? 14 :
             type == "D" ? 18 :
             type == "F" ? 17 :
             type == "N" ? 7 : 
             tubeHoleRadius;
             
 holeHeight = type == "18650" ? 66 :
              type == "A" ? 51 :
              type == "AA" ? 51 :
              type == "AAA" ? 45 :
              type == "AAAA" ? 43 :
              type == "B" ? 61 :
              type == "C" ? 51 :
              type == "D" ? 62 :
              type == "F" ? 92 :
              type == "N" ? 31 : 
              tubeHoleHeight;

if (exportTubes == 1) tubes();
if (exportCaps == 1) caps();

function getOffset(n) = holeRadius * n * 2 + wallThickness * n;

module tubes() {
    difference() {
        // Create all the tubes next to each other
        union() {
            for(n = [0:numHolders - 1]) {
                translate([getOffset(n), 0, 0])
                tubeShell();
            }
        }
        
        // Remove the holes from the center of the tubes
        for(n = [0:numHolders - 1]) {
            translate([getOffset(n), 0, 0])
            tubeInner();
        }
    }
}

module caps() {
    // Move to in front of tubes
    translate([0, -(wallThickness * 2 + holeRadius * 2 + capTolerance + 10), wallThickness + capOverlap])
    // Flip over for optimal 3d printing
    mirror([0, 0, 1])
    difference() {
        // Create all caps
        union() {
            for(n = [0:numHolders - 1]) {                
                translate([getOffset(n), 0, wallThickness + capOverlap])
                mirror([0, 0, 1])
                circleFillet(capTubeFillets, holeRadius + wallThickness * 2 + capTolerance)
                linear_extrude(wallThickness + capOverlap)
                circle(holeRadius + wallThickness * 2 + capTolerance);
            }
        }
        
        // Remove insides of caps
        for(n = [0:numHolders - 1]) {
            translate([getOffset(n), 0, 0])
            capInner();
        }
    }
}

module capInner() {
    // hole for inside of cap
    translate([0, 0, -1])
    linear_extrude(capOverlap + 1)
    circle(holeRadius + wallThickness + capTolerance);
    
    // groove with tolerance
    translate([0, 0, capOverlap - grooveOffset - capTolerance])
    grooveExpanded();
    
    // chamfer
    translate([0, 0, capChamfer - 0.0001])
    rotate_extrude(angle = 360)
    translate([holeRadius + wallThickness + capTolerance, 0, 0])
    rotate([0, 0, 270])
    polygon([
            [0, 0],
            [capChamfer, capChamfer],
            [capChamfer, 0],
            [0, 0]
        ]);
}

module tubeShell() {
    circleFillet(capTubeFillets, holeRadius + wallThickness)
    linear_extrude(holeHeight + wallThickness)
    circle(holeRadius + wallThickness);
    
    translate([0, 0, holeHeight + wallThickness - grooveOffset])
    groove();
}

module tubeInner() {
    translate([0, 0, wallThickness])
    linear_extrude(holeHeight + 1)
    circle(holeRadius);
}

module groove() {
    difference() {
        rotate_extrude(angle = 360)
        translate([holeRadius + wallThickness + grooveInset - grooveRadius, 0])
        circle(r = grooveRadius);
        
        translate([0, 0, -grooveRadius])
        linear_extrude(grooveRadius * 2)
        circle(holeRadius + wallThickness - 0.0001);
    }
}

module grooveExpanded() {
    difference() {
        rotate_extrude(angle = 360)
        translate([holeRadius + capTolerance + wallThickness + grooveInset - grooveRadius, 0])
        circle(r = grooveRadius);
        
        translate([0, 0, -grooveRadius])
        linear_extrude(grooveRadius * 2)
        circle(holeRadius + wallThickness + capTolerance);
    }
}

module circleFillet(filletRadius, circleRadius) {
    difference() {
        children(0);
        circleFilletOutside(filletRadius, circleRadius);
    }
}

module circleFilletOutside(filletRadius, circleRadius) {
    difference() { 
        translate([0, 0, -1])
        rotate_extrude(angle = 360)
        translate([circleRadius - filletRadius, 0, 0])
        square(filletRadius + 1);
        
        translate([0, 0, filletRadius])
        rotate_extrude(angle = 360)
        translate([circleRadius - filletRadius, 0])
        circle(r = filletRadius);
    }
}
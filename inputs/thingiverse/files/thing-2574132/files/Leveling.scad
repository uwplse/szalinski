// Layer Height
layerHeight = 0.2; // [0.01:0.01:2]

// Width of your nozzle
layerWidth = 0.4; // [0.01:0.01:2]

// Length of test lines
testLength = 10; // [2:100]

// Mid-point Radius of test lines
distanceFromCenter = 40; //

// Number of test sizes per angle
numberOfSizes = 4;

// Outer Lines
for(i = [0:45:315]) {
    linear_extrude(layerHeight)
    rotate([0, 0, i])
    translate([0, distanceFromCenter])
    outerLine();
}


module outerLine() {
    
    lineSeg(layerWidth * numberOfSizes, testLength); 
    
    c = numberOfSizes + 1;
    for (j = [2:c]) {
        ij = c - j;
        
        translate([layerWidth * (j - 1) * c, 0])
        lineSeg(layerWidth * ij, testLength); 
        translate([-layerWidth * (j - 1) * c, 0])
        lineSeg(layerWidth * ij, testLength); 
    }
}

module lineSeg(w, l) {
    translate([-(w/2), 0])
    square([w, l]);
}
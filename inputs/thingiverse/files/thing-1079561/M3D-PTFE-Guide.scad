// M3D PTFE tube Holder
// Tony Hansen 2015
// Inspired by the filament guides <http://www.thingiverse.com/thing:858100>
// and <http://www.thingiverse.com/thing:865138>,
// which were designed to guide filament.
// This is instead sized to guide a 4mm PTFE tube
// and the values are customizable to any size.

// the hole where the PTFE tube goes
topHoleDiameter = 4.1;  
// the M3D cable going to the print head
bottomHoleDiameter = 6; 
// the filament thickness around the holes
wallThickness = 1.5;    
// the length of the tube
tubeLength = 8;             
// the distance between holes
distanceBetweenHoles = 4;              

difference() {
    epsilon=0.1;
    union() {
        // Cylinder connecting to M3D Cable
        cylinder(d=bottomHoleDiameter + wallThickness * 2,h=tubeLength,$fn=50);

        // "square portion"
        translate([0,-topHoleDiameter/2-wallThickness,0])
        cube([bottomHoleDiameter/2 + topHoleDiameter/2 + distanceBetweenHoles + wallThickness, 
            topHoleDiameter + 2*wallThickness, tubeLength]);

        // Top cylinder that holds the PTFE
        translate([bottomHoleDiameter/2+distanceBetweenHoles+topHoleDiameter/2+wallThickness,0,0])
            cylinder(d=topHoleDiameter+wallThickness*2, h=tubeLength, $fn=50);
    }

    // The hole for the M3D Cable
    translate([0,0,-epsilon]) 
        cylinder(d=bottomHoleDiameter,h=tubeLength+2*epsilon,$fn=50);

    // The hole for the PTFE tube
    translate([bottomHoleDiameter/2+distanceBetweenHoles+topHoleDiameter/2+wallThickness,
        0,0])
        translate([0,0,-epsilon])
        cylinder(d=topHoleDiameter, h=tubeLength+2*epsilon, $fn=50);

    // The wedge opening for the M3D Cable
    translate([-bottomHoleDiameter*7/8,0,0])
        rotate([0,0,45])
        translate([-bottomHoleDiameter/2,-bottomHoleDiameter/2,-epsilon])
        cube([bottomHoleDiameter,bottomHoleDiameter,tubeLength+2*epsilon]);
}
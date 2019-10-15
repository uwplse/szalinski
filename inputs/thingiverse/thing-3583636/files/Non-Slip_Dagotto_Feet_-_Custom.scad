tubeDiameter = 8; // [1:25]
nonSlipMatThickness = 10; // [3:13]

cubeHeight = nonSlipMatThickness + tubeDiameter + 2.6;


difference() { 
    cube([40, 30, cubeHeight]);                                                             // Main cube
    translate([1, 1, 0]) cube([38, 28, nonSlipMatThickness - 2]);                           // nonSlip cube
    translate([0, 15, cubeHeight - 1]) rotate(a=[0, 90, 0]) { cylinder(r=tubeDiameter, h=40, $fn=100); } // Tube
    translate([10, 15, cubeHeight - 1]) rotate(a=[0, 90, 0]) {                              // Electric Strip hole 1 
        difference() { 
            cylinder(r=tubeDiameter + 3, h=3, $fn=100);
            cylinder(r=tubeDiameter + 1, h=3, $fn=100);
        }
    }

    translate([30, 15, cubeHeight - 1]) rotate(a=[0, 90, 0]) {                              // Electric Strip hole 2
        difference() { 
            cylinder(r=tubeDiameter + 3, h=3, $fn=100);
            cylinder(r=tubeDiameter + 1, h=3, $fn=100);
        }
    }
    translate([0, 0, 10]) rotate(a=[60, 0, 0]) cube([ 40, 15, 10 ]);                        // Angled cutaway
    mirror([0, 1, 0]) translate([0, -30, 10]) rotate(a=[60, 0, 0]) cube([ 40, 15, 10 ]);    // Angled cutaway
}


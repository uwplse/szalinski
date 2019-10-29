/* [General] */
// Diameter of the Standoffs
standoffDiameter = 5;
// Spacing between the standoffs (center to center)
standoffSpacing = 33.5;
// Wall thickness of the base plate
walls = 1.0;
// Width of the baseplate (length of the standoffs)
width = 25;

/* [RX Antenna] */
// Diameter of the antenna holes, set to 0 to disable
rxAntennaHoleRadius = 1.5;
// Position of the Antenna holes
rxAntennaOffset = 5;

/* [VTX Antenna] */
// Diameter of the top part of the Antenna, set to 0 to disable
vtxTopDiameter = 15.5;
// Height of the top part of antenna
vtxTopHeight = 8;
// Height of the part where the antenna is transitioning from bigger to smaller diameter
vtxTransitionHeight = 3.5;
// Diameter of the Bottom part of the Antenna, set to 0 to disable
vtxBottomDiameter = 4;
//Height of the bottom part of the Antenna
vtxBottomHeight = 4;
// Wall thickness of the Antenna mount, set to 0 to disable
vtxAntennaWalls = 1.2;
// With of the support cross for the Antanna mount
vtxCrossWidth = 0.8;
// Diameter of the Antenna hole
vtxAntennaDiameter = 3.2;
// Position of the Antenna Holder
vtxOffset = 25;

/* [Buzzer] */
// Diameter of the Buzzer, set to 0 to disable
buzzerDiameter = 9;
// Position of the Buzzer hole
buzzerOffset = 11.5;

/* [HIDDEN] */
standoffRadius = standoffDiameter / 2;
buzzerRadius = buzzerDiameter / 2;

vtxTopRadius = vtxTopDiameter / 2;
vtxBottomRadius = vtxBottomDiameter / 2;
vtxAntennaRadius = vtxAntennaDiameter / 2;

center = width / 2;

$fn = 50;

holder();

module cross() {
    difference() {
        cylinder(r = vtxTopRadius + vtxAntennaWalls, h = vtxBottomHeight + vtxTransitionHeight);
        antennaMountFull();
        
        translate([0, 0, -1])
            cylinder(r = vtxBottomRadius, h = vtxBottomHeight + 2);
        
        for(a=[0:90:360]) {
            rotate([0, 0, a])
                translate([vtxCrossWidth / 2, vtxCrossWidth / 2, -1])
                    cube([vtxTopRadius + vtxAntennaWalls, vtxTopRadius + vtxAntennaWalls, vtxBottomHeight + vtxTransitionHeight + 2]);
        }
    }
}

module antennaMountFull() {
    cylinder(r = vtxBottomRadius + vtxAntennaWalls, h = vtxBottomHeight);

    hull() {
        translate([0, 0, vtxBottomHeight])
            cylinder(r = vtxBottomRadius + vtxAntennaWalls, h = 0.1);

        translate([0, 0, vtxBottomHeight + vtxTransitionHeight])
            cylinder(r = vtxTopRadius + vtxAntennaWalls, h = 0.1);
    }
    
    translate([0, 0, vtxBottomHeight + vtxTransitionHeight])
        cylinder(r = vtxTopRadius + vtxAntennaWalls, h = vtxTopHeight);
}

module antennaMount() {
    difference() {
        antennaMountFull();

        translate([0, 0, -1])
            cylinder(r = vtxBottomRadius, h = vtxBottomHeight + 2);
        
        hull() {
            translate([0, 0, vtxBottomHeight - 0.1])
                cylinder(r = vtxBottomRadius, h = 0.1);

            translate([0, 0, vtxBottomHeight + vtxTransitionHeight])
                cylinder(r = vtxTopRadius, h = 0.1);
        }
        
        translate([0, 0, vtxBottomHeight + vtxTransitionHeight])
            cylinder(r = vtxTopRadius, h = vtxTopHeight + 1);
    }
}

module holder() {
    difference() {
        group() {
            // Baseplate
            hull() {
                rotate([90, 0, 0]) {
                    cylinder(r = standoffRadius + walls, h = width);
                    translate([standoffSpacing, 0, 0])
                        cylinder(r = standoffRadius + walls, h = width);
                }
            }
            
            // VTX Antenna
            translate([vtxOffset, -center, standoffRadius + walls - 0.1]) {
                antennaMount();
                cross();
            }
        }
        
        // VTX Antenna Hole
        translate([25, -center, -(standoffRadius + walls + 1)])
                cylinder(r = vtxAntennaRadius, h = standoffDiameter + walls * 2 + 2);

        // RX Antenna hole
        translate([rxAntennaOffset, -center, -5.5]) {
            rotate([45, 0, 0])
                cylinder(r= rxAntennaHoleRadius, h = 20);
            rotate([-45, 0, 0])
                cylinder(r= rxAntennaHoleRadius, h = 20);
        }
        
        // Buzzer hole
        translate([buzzerOffset, -center, -(standoffRadius + walls + 1)])
            cylinder(r= buzzerRadius, h = standoffDiameter + walls * 2 + 2);

        // Standoff holes
        translate([0, 1, 0]) {
            rotate([90, 0, 0]) {
                cylinder(r = standoffRadius, h = width + 2);
                translate([standoffSpacing, 0, 0])
                    cylinder(r = standoffRadius, h = width + 2);
            }
        }    
    }
}
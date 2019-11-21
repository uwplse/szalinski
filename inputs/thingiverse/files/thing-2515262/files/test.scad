/* [General] */
innerDiameter = 17.5;

/* [Reflector] */
reflectorDiameter = 45.5;
reflectorThickness = 1.8;
reflectorWalls = 2;
reflectorCoverWalls = 1.2;
reflectorCoverBrim = 1;
rcbh = 0.6;

/* [Tolerances] */
reflectorCoverPadding = 0.20;
depth = 3;

/* [Hidden] */
$fn = 64;

reflectorRadius = reflectorDiameter / 2;
reflectorDiameterOuter = reflectorDiameter + (reflectorWalls * 2);

reflectorCoverHeight = reflectorWalls + reflectorThickness + rcbh;
reflectorCoverDepth = depth + reflectorCoverPadding * 2;

width =  reflectorDiameterOuter + reflectorCoverPadding * 2;

coverWidth = reflectorDiameter + (reflectorWalls + reflectorCoverWalls) * 2;
coverRadius = coverWidth / 2;

difference() {
    cylinder(r = coverRadius, h = reflectorCoverHeight);
    
    translate([0, 0, -1]) {
        #cube([width, reflectorCoverDepth, reflectorCoverHeight + 2]);
    }
    
}

translate([0, -20, 0]) {
    cube([width, reflectorCoverDepth, reflectorCoverHeight + 2]);
}

/* [Parameters] */
//Number of outer bearings
bearingCount = 3; //[1:8]
//Radius of the bearings being used
bearingRadius = 11;
//Height of the bearings being used
bearingHeight = 7;
//Distance from the center of the central bearing to the center of the outer bearings
bearingDistance = 40;
//Thickness between the bearing and the outer perimeters
thickness = 5;
//Tolerance compensation
tolerance = .3;

/* [Hidden] */
$fn = 80;

bearingDiameter = (bearingRadius*2) + tolerance;

difference() {
    for(i = [1:bearingCount]){
        hull() {
            rotate([0,0,(360/bearingCount)*i]) {
                translate([bearingDistance,0,0]) {
                    cylinder(bearingHeight, d = bearingDiameter + (thickness*2), true);
                }
            }
            cylinder(bearingHeight, d = bearingDiameter + (thickness*2), true);
        }
    }

    union() {
        for(i = [1:bearingCount]){
            rotate([0,0,(360/bearingCount)*i]) {
                translate([bearingDistance,0,0]) {
                    cylinder(bearingHeight, d = bearingDiameter, true);
                }
            }
        }
        cylinder(bearingHeight, d = bearingDiameter, true);
    }
}
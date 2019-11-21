plugLength = 23.7;
plugDiameter = 6.7;
frictionRingsDiameter = 7.1;
frictionRing1Pos = 9;
frictionRing2Pos = 14.35;
$fn=80*1;

cylinder(plugLength, d=plugDiameter, true);
translate([0, 0, frictionRing1Pos]) {
    cylinder(0.65, d=frictionRingsDiameter, true);
}

translate([0, 0, frictionRing2Pos]) {
    cylinder(0.65, d=frictionRingsDiameter, true);
}

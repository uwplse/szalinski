// Wide Sharpie holder
// Copyright (c) 2018 by Rod Smith
// Licensed under the terms of the GNU GPL, v.2

$fn=180;

maxMarkerWidth = 21;
minMarkerWidth = 16;
holderDepth = 65;
sphereSize = maxMarkerWidth * 10;

module MarkerHole() {
    $fn=90;
    hull() {
        extraX = (maxMarkerWidth - minMarkerWidth) / 2;

        translate([-extraX, 0, holderDepth]) cylinder(d=minMarkerWidth, h=minMarkerWidth);
        translate([extraX, 0, holderDepth]) cylinder(d=minMarkerWidth, h=minMarkerWidth);
        translate([-extraX, 0, 0]) sphere(d=minMarkerWidth);
        translate([extraX, 0, 0]) sphere(d=minMarkerWidth);
    }
}

difference() {
    translate([0, 0, 0]) hull() {
        translate([0,0,sphereSize/5]) sphere(d=sphereSize/2);
        cylinder(d=sphereSize/2, h=1);
    }
    for (a=[0:45:320]) {
        rotate([0, 15, a]) translate([22, 0, minMarkerWidth])
            #MarkerHole();
    }
    translate([0,0,4])
        cylinder(r1=minMarkerWidth*0.8, r2=maxMarkerWidth*1.2, h=sphereSize);
    translate([0, 0, -sphereSize/2])
        cube([sphereSize, sphereSize, sphereSize], center=true);
}

//The thickness of the Cube
CubeThickness=1;
//The size of the gap between the cross and the cube, measured on each face
GapSize=1;
//The thickness of the Cross
CrossThickness=1;
/* [Hidden] */
Size=1;
CubeHoleSize=GapSize*2+CrossThickness;
RealSize=CubeThickness*2+CubeHoleSize;
difference() {
    difference() {
        difference() {
            cube(RealSize);
            translate([CubeThickness,0,CubeThickness]) {
                cube([CubeHoleSize,RealSize,CubeHoleSize]);
            }
        }
        translate([0,CubeThickness,CubeThickness]) {
            cube([RealSize,CubeHoleSize,CubeHoleSize]);
        }
    }
    translate([CubeThickness,CubeThickness,0]) {
        cube([CubeHoleSize,CubeHoleSize,RealSize]);
    }
}
translate([CubeThickness+GapSize,CubeThickness+GapSize,0]) {
    cube([CrossThickness,CrossThickness,RealSize]);
}
translate([CubeThickness+GapSize,0,CubeThickness+GapSize]) {
    cube([CrossThickness,RealSize,CrossThickness]);
}
translate([0,CubeThickness+GapSize,CubeThickness+GapSize]) {
    cube([RealSize,CrossThickness,CrossThickness]);
}                                                                                       
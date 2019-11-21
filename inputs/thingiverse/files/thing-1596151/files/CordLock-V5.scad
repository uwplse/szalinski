
// diameter of the first or smaller chord
diameter1 = 6;

// diameter of the second or larger chord
diameter2 = 8;

// spacing between the 2 chords
offsetVal = 7;

// Thickness of part
thickness = 5;

// Thickness of bending snap fit
clampthickness = 3.2;

// Tightness of fit
fitVal = 3; // [1,2,3,4,5,6,7,8,9,10]

// adds an tolerance for over-sizing
OversizeTolerance = 0.3;

tightness = 2-(fitVal/20);
radius1 = (diameter1+OversizeTolerance)/2;
radius2 = (diameter2+OversizeTolerance)/2;
offset1 = offsetVal/2;

module build1(radius,offset) {
    difference() {
        cubeWidth = clampthickness*radius;
        cubeLength = offset + (2.3*radius);
        union() {
            cube([cubeLength,cubeWidth,thickness], false);
        }
        scale([1,1,2]) translate([0,0,-thickness*0.25])
        union() {
            $fn = 20;
            translate([offset+(radius),cubeWidth/2,0])
                cylinder(h = thickness, r = radius, center = false);

            translate([(offset+radius),(clampthickness-tightness)*radius/2,0])
                cube([2*radius,tightness*radius,thickness],false);
        }
    }
}

module chordLock(r1,r2,o1) {
    // this calculates the value for centering
    // the mirrored part
    alignOffset = (clampthickness*abs(r1-r2)/2);

    // this builds the first half
    build1(r1,o1);

    // this mirrors the second half
    mirror([1,0,0]) translate([0,-alignOffset,0])
    build1(r2,o1);
}

chordLock(radius1,radius2,offset1);

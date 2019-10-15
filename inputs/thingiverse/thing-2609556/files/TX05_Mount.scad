/* [Angle] */
// Angle in degrees
angle = 10; // [0:1:89]

/* [Measurements] */
// Wall thickness
walls = 1;
width = 8.7;
length = 20;
height = 8;

hookSpacing = 1.5;
hookHeight = 2;

displayCutoutLength = 7.25;

wireCutoutLength = 7;

camDiameter = 11;
camZOffset = 2.5;

/* [Hidden] */
outerLength = length + walls * 2;
outerWidth = width + walls * 2;
outerHeight = height + walls;

hookLength = outerLength + walls * 2 + hookSpacing * 2;

difference() {
    angled();
    
    rotate([angle, 0, 0])
        translate([hookSpacing + outerLength - wireCutoutLength + walls, -1, -1])
            cube([wireCutoutLength - walls / 2, walls + 4, walls + 2]);
}


module angled() {
    translate([0, 0, 0.01])
        wedge();
    rotate([angle, 0, 0])
        bracket();
}

module wedge() {
    a = outerWidth * cos(90 - angle);
    b = sqrt(outerWidth * outerWidth - a * a);

    difference() {
        cube([hookLength, b,  a]);
        rotate([angle, 0, 0])
            cube([hookLength, b,  a]);
    }
    
}

module bracket() {
    hook();
    rotate([0,0,0])
    translate([walls + hookSpacing, 0, 0])
        camMount();
}

module hook() {
    cube([hookLength, outerWidth, walls]);
    cube([walls, outerWidth, hookHeight + walls]);
    translate([hookLength - walls, 0, 0])
        cube([walls, outerWidth, hookHeight + walls]);
}

module camMount() {
    difference() {
        cube([outerLength, outerWidth, outerHeight]);
        
        translate([walls, walls, walls])
            cube([length, width, height + 1]);
        
        // Display cutout
        translate([walls, -1, walls])
            cube([displayCutoutLength + 1, outerWidth/2 + 1, height + 1]);
        
        translate([outerLength - wireCutoutLength, -1, walls])
            cube([wireCutoutLength + 1, outerWidth/2 + 1, height + 1]);
        
        // Cam cutout
        translate([length / 2 + walls - camDiameter / 2, width, camZOffset + walls])
            cube([camDiameter, walls + 2, outerHeight]);
    }
}

// Box width
boxWidth = 170; 

// Box depth
boxDepth = 135; 

// Box height
boxHeight = 40; 

// Lid height
lidHeight = 10; 

// Round corners
roundCorner=3; // [0.01:No, 3:Yes]

// Wall thickness
wallThickness=2.2; 

// Text on base (empty to remove)
textBase = "";

// Base text size
textBaseSize = 7; // [3:50]

// Text on lid (empty to remove)
textLid = "";

// Lid text size
textLidSize = 8; // [3:50]

// Number of vertical spaces
numSeparatorsX = 7; // [1:20]

// Number of horizontal spaces
numSeparatorsY = 1; // [1:20]

// Parts to show
showParts = 1; // [0:All, 1:Base, 2:Lid]

// Just for presentation purposes
showClosed = 0; // [0:Open, 1:Closed]

// Size of cut out dependable on box size. 0.5 is half of height. 0 to remove
cutOutSize = 0.5;


/* [Hidden] */
$fn=60;
tolerance = 0.8;
iw = 1.5;

if( showParts != 2 || showClosed ==1) {
    boxBase();
    separators(numSeparatorsX, numSeparatorsY, boxWidth, boxDepth, boxHeight);
}
if (showClosed == 1 ) {
    translate([0, 0, boxHeight]) rotate(a=[180, 0, 0]) boxLid();
}
else {
    if (showParts != 1) translate([boxWidth + 5, 0, 0]) boxLid();
}

module separators (nx, ny, w, d, h) {
    xS = w / nx;
    yS = d/ ny;
    union(){
        if ( nx > 1) {
            for ( a = [0 : nx-2] ) {
                                    difference() {
                translate([-w/2+xS*(a+1), 0, 0])

                        linear_extrude(height=h)
                        square([iw, d-2*wallThickness], center = true);
                        translate([-w/2+xS*(a+1), 0, h])
                        rotate ([0,90,0]) cylinder (4, h*cutOutSize, h*cutOutSize, center = true, $fn=100);
                    }
            }
        }
        if ( ny > 1) {
            for ( b = [0 : ny-2] ) {
                translate([0, -d/2+yS*(b+1), 0])
                    linear_extrude(height=h)
                    square([w-2*wallThickness, iw], center = true);
            }
        }
    }

}

module boxLid() {
    difference() {
        roundedCube(boxWidth+2*(tolerance+wallThickness), boxDepth+2*(tolerance+wallThickness), lidHeight, roundCorner);
             
        translate([0, 0, wallThickness]) roundedCube(boxWidth+2*tolerance, boxDepth+2*tolerance, lidHeight, roundCorner);
        
        translate([0, 0, 0.5]) rotate(a=[180, 0, 0]) linear_extrude(height=2) text(textLid, valign="center", halign="center", font="Arial", size=textLidSize);
    }
}

module boxBase() {
    difference() {
        roundedCube(boxWidth, boxDepth, boxHeight, roundCorner);
        translate([0, 0, wallThickness]) roundedCube(boxWidth-2*wallThickness, boxDepth-2*wallThickness, boxHeight, roundCorner);
        
        translate([0, -boxDepth/2+0.5, boxHeight/2]) rotate(a=[90, 0, 0]) linear_extrude(height=2) text(textBase, valign="center", halign="center", font="Arial", size=textBaseSize);
    }
}

module roundedCube (w, d, h, r) {
    hull() {
        translate([-w/2+r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([-w/2+r, d/2-r, 0]) cylinder(r=r, h=h);    
        translate([w/2-r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([w/2-r, d/2-r, 0]) cylinder(r=r, h=h);
    }
}
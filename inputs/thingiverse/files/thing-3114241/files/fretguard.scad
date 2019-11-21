// Maximum width of the fretboard
fretBoardWidth = 63;
// Width of a fret
fretWidth = 2.6;
// Height of a fret
fretHeight = 1.1;
// Calculated parameters, don't touch!
baseWidth = fretBoardWidth + 20;
baseLength = fretWidth + 2*5;
baseHeight = fretHeight/2;
edgeWidth = 1*1;
edgeHeight = 1*1;
$fn=90*1;

module base(width, length, height) {
   translate([0,0, height/2]) { 
        cube([width, length, height], true);
        translate([width/2, 0, -height/2]) {
            cylinder(height, d=length, true);
        }
        translate([-width/2, 0, -height/2]) {
            cylinder(height, d=length, true);
        }    
    }
}

module cutout() {
    cube([fretBoardWidth, fretWidth, (baseHeight+edgeHeight)*2], true);
}


difference() {
    base(baseWidth, baseLength, baseHeight + edgeHeight);
    translate([0, 0, baseHeight]) {
        base(baseWidth-edgeWidth, baseLength-edgeWidth, edgeHeight*2);
    }
    cutout();
}

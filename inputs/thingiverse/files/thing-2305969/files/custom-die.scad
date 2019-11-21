/* [Die Info] */
// width of die
faceWidth = 16;
// edge softness
edgeSoftness = 0.8;

/* [Face Label] */
// will be embossed into face
faceLabels = ["1", "2", "3", "4", "5", "6"];
//depth of the lettering
textDepth = 1;
// size of the font
textSize = 11;
// font to use
textFont = "Arial"; // [Arial,Times,Helvetica,Courier,Futura]

/* [hidden] */
// used to offset z collisions
fudge = 0.005;
// use 100 segments on rounded edges
$fn = 100;

difference() {
    cube(faceWidth, faceWidth, faceWidth);
    
    roundCorner([0,0,0], [0,0,0]);
    roundCorner([0,0,faceWidth], [0,90,0]);
    roundCorner([faceWidth,0,faceWidth], [0,180,0]);
    roundCorner([faceWidth,0,0], [0,-90,0]);
    
    roundCorner([0,faceWidth,faceWidth], [180,0,0]);
    roundCorner([faceWidth,faceWidth,faceWidth], [180,90,0]);
    roundCorner([faceWidth,faceWidth,0], [180,180,0]);
    roundCorner([0,faceWidth,0], [180,-90,0]);
    
    roundEdge([0,0,0], [0,0,0]);
    roundEdge([0,0,0], [90,0,90]);
    roundEdge([0,0,0], [90,-90,180]);
    
    roundEdge([faceWidth,0,faceWidth], [90,90,180]);
    roundEdge([faceWidth,0,faceWidth], [-90,0,90]);
    roundEdge([faceWidth,0,faceWidth], [0,180,0]);
    
    roundEdge([0,faceWidth,faceWidth], [180,90,90]);
    roundEdge([0,faceWidth,faceWidth], [90,180,90]);
    roundEdge([0,faceWidth,faceWidth], [0,180,180]);
    
    roundEdge([faceWidth,faceWidth,0], [90,-90,0]);
    roundEdge([faceWidth,faceWidth,0], [180,180,0]);
    roundEdge([faceWidth,faceWidth,0], [-90,180,90]);
    
    midFace = faceWidth/2;
    labelFace([midFace,0,midFace], [90,0,0], faceLabels[0]);
    labelFace([midFace,midFace,faceWidth], [0,0,0], faceLabels[1]);
    labelFace([0,midFace,midFace], [90,0,-90], faceLabels[2]);
    labelFace([faceWidth,midFace,midFace], [90,0,90], faceLabels[3]);
    labelFace([midFace,midFace,0], [180,0,0], faceLabels[4]);
    labelFace([midFace,faceWidth,midFace], [90,0,180], faceLabels[5]);
}

module roundEdge(corner, rotation) {
    translate(corner)
    rotate(rotation)
    difference() {
        translate([-fudge, -fudge, -fudge])
        cube([edgeSoftness+2*fudge, edgeSoftness+2*fudge, faceWidth+2*fudge]);
        translate([edgeSoftness, edgeSoftness, 0])
        cylinder(r=edgeSoftness, h=faceWidth);
    }
}

module roundCorner(corner, rotation) {
    translate(corner)
    rotate(rotation)
    difference() {
        translate([-fudge, -fudge, -fudge])
        cube([edgeSoftness+2*fudge, edgeSoftness+2*fudge, edgeSoftness+2*fudge]);
        translate([edgeSoftness, edgeSoftness, edgeSoftness])
        sphere(r=edgeSoftness, h=faceWidth);
    }
}

module labelFace(pos, rotation, title) {
    translate(pos)
    rotate(rotation)
    translate([0,0,-textDepth+fudge])
    linear_extrude(height = textDepth)
    text(title, size = textSize, font = textFont, valign="center", halign="center");
}
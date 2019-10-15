// PinHeaderCover.scad

numPinRows = 2;
numPinsInRow = 20;

blockHeight = 6;

// Pins have .1 inch centers and are .025 inch square
// but we're working in millimeters
pinLength = 0.635;
pinWidth = 0.635;
pinHoleLength = pinLength * 3.15; // ends up with decent measures for 0.4mm nozzle
//pinHoleWidth = pinWidth * 1.89; // a bit looser
pinHoleWidth = pinWidth * 1.6; // for tighter holes
//pinHoleWidth = pinWidth * 1.26; // originally
pinStepX = 2.54;
pinStepY = 2.54;
pinOffsetX = pinStepX/2;
pinOffsetY = pinStepY/2;
pinOffsetZ = 0.5+blockHeight/2;

blockLength = numPinsInRow * pinStepX;
blockWidth = numPinRows * pinStepY;

difference() {
    cube([blockLength, blockWidth, blockHeight], center=false);
    for (x=[0:numPinsInRow-1], y=[0:numPinRows-1]) {
        translate([x*pinStepX+pinOffsetX, y*pinStepY+pinOffsetY, pinOffsetZ]) {
            cube([pinHoleLength, pinHoleWidth, blockHeight], center=true);
        }
    }
}

echo(version=version());

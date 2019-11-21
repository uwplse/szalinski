/* [Barb] */

// The outer diameter of the hose barb -- should correspond to the inner diameter of your hose
barbOuterDiameter = 38.1;

// How thick to make the main section of the hose barb -- a taper will be added near the tip for better air flow
barbWallThickness = 4;

// How much of the end to taper;
barbTipTaperDistance = 12;

// After the taper how thick should the wall be?
barbTipMinimumWallThickness = 1;

// The barb interior wall will expand out to this diameter at the base. Must be less than the outer diameter!
barbBaseHoleDiameter = 31;

// The total height of the barb, measured from the base of the part
barbHeight = 50;

/* [Flange] */

// The length of each of the flange's sides
flangeSize = 70;

// The thickness of the flange
flangeThickness = 6;

// The diameter of the holes cut into the flange for mounting hardware
flangeBoltHoleDiameter = 3.1;

// The distance from the edge of the flange to each of the four mounting holes
flangeBoltHoleInset = 10;

/* [Hidden] */
$fn = 72;


module basicFlange () {
    boltHoleDistance = flangeSize-2*flangeBoltHoleInset;
    translate ([flangeBoltHoleInset,flangeBoltHoleInset]) {
        linear_extrude (flangeThickness) {
            offset (r=flangeBoltHoleInset) {
                square ([boltHoleDistance,boltHoleDistance]);
            }
        }
    }
}

module cutFlange () {
    difference () {
        basicFlange();
        
        // Central hole
        translate ([flangeSize/2,flangeSize/2])
            cylinder (d=barbOuterDiameter,h=flangeThickness);
        
        // Mounting holes
        translate ([flangeBoltHoleInset,flangeBoltHoleInset])
            cylinder (d = flangeBoltHoleDiameter, h=flangeThickness);
        translate ([flangeSize-flangeBoltHoleInset,flangeBoltHoleInset])
            cylinder (d = flangeBoltHoleDiameter, h=flangeThickness);
        translate ([flangeBoltHoleInset,flangeSize-flangeBoltHoleInset])
            cylinder (d = flangeBoltHoleDiameter, h=flangeThickness);
        translate ([flangeSize-flangeBoltHoleInset,flangeSize-flangeBoltHoleInset])
            cylinder (d = flangeBoltHoleDiameter, h=flangeThickness);
        
    }
}

module barb () {
    translate ([flangeSize/2,flangeSize/2]) {
        difference () {
            cylinder (d=barbOuterDiameter, h=barbHeight);
        
            cylinder (d=barbOuterDiameter-2*barbWallThickness, h=barbHeight);
            translate ([0,0,barbHeight-barbTipTaperDistance])
                cylinder (d1=barbOuterDiameter-2*barbWallThickness, d2=barbOuterDiameter-2*barbTipMinimumWallThickness, h=barbTipTaperDistance);
            cylinder (d1=barbBaseHoleDiameter, d2=barbOuterDiameter - 2*barbWallThickness, h=flangeThickness);
        }
    }
}

cutFlange();
barb();
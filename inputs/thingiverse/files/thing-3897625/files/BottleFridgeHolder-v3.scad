// Author: Exether Mega
// Published under: https://www.thingiverse.com/thing:3897625
// Remix of: https://www.thingiverse.com/thing:274664
$fn = 100;

// The bottle holder will be made of several parts, the total length is the inside width of the fridge.
totalLinkLength=500;
// The average diameter of the bottles to store (if an integer number doesn't fit in total length, it will be rounded).
approxBottleSpace = 70;
// Set pos start and end based on the part you want to render.
cutPosStart=0;
cutPosEnd=15;

linkHeight=3;
linkWidth=15;
// Depending on the length of the bottles to store (80 is for beer bottles)
linksDistance=80;

// In order to adjust the bump size, display the bottles to ensure they touch the bumps.
withBottles=false;

bumpHeight=14;
bumpLength=39;
bumpWidth=linkWidth-2;
bumpRounding=1;


module smooth(rounding, final = 0) {
    offset(rounding+final) { offset(-rounding) { offset(-rounding) { offset(rounding) {
        children(0);
    }}}}
}

module bumpIt(interLength) {
	translate([bumpWidth+(linkWidth-bumpWidth)/2,0,0]) { rotate([0,-90,0]) {
		translate([0,interLength+bumpHeight,0]) { rotate_extrude (angle=90) { children(0); }; }
		translate([0,bumpHeight,bumpWidth]) { rotate([180,0,0]) { rotate_extrude (angle=90) { children(0); }; } }
		translate([0,interLength+bumpHeight,0]) { rotate([90,0,0]) { linear_extrude(height=interLength) { children(0); } } }
	}}
}

module retentionPinOrHole(thickness, height, hole, left) {
	// The calculcation of the smoothing is critical, with PLA, a value of 0.1 was enough for me. But I encountered issues with PET so that I had to increase the hole.
	smoothResult=hole?0.3:0.0;
	smooth(rounding = 0.2,final = smoothResult) { polygon([[0,-1],[thickness,-1],[thickness,height+(left?thickness:0.0)],[0,height+(left?0.0:thickness)]]); }
}

module remover(cutPos,withPins) {
	union () {
		// This is the hole
		if (withPins) {
			translate([linkWidth/2+pinThickness*0.5,pinLength+cutPos*bottleSpace-epsilon,0]) {
				rotate([90,0,0]) { linear_extrude(pinLength) { retentionPinOrHole(pinThickness,bumpHeight/2,true,true); } }
				translate([linksDistance,0,0]) { rotate([90,0,0]) { linear_extrude(pinLength) { retentionPinOrHole(pinThickness,bumpHeight/2,true,true); } } }
			}
		}
		difference () {
			translate([(linksDistance/2+linkWidth),-totalLinkLength/2+cutPos*bottleSpace,0]) { cube([linksDistance+linkWidth*2+1,totalLinkLength,bottleSpace], center=true); }
			// This is the pin
			if (withPins) {
				translate([linkWidth/2-pinThickness*1.5,cutPos*bottleSpace+epsilon+0.1,0]) {
					rotate([90,0,0]) { linear_extrude(pinLength) { retentionPinOrHole(pinThickness,bumpHeight/2,false,false); } }
					translate([linksDistance,0,0]) { rotate([90,0,0]) { linear_extrude(pinLength) { retentionPinOrHole(pinThickness,bumpHeight/2,false,false); } } }
				}
			}
		}
	}
}

// --------------- the following is not intended to be configurable.
nbOfBottleSlots = round(totalLinkLength/approxBottleSpace);

realCutPosEnd = min(cutPosEnd,nbOfBottleSlots);

bottleSpace = totalLinkLength/nbOfBottleSlots;

pinThickness=2;
pinLength=bumpHeight/3;
epsilon = 0.01;


union () {
	difference() {
		union () {
			cube([linkWidth,totalLinkLength,linkHeight]);
			translate ([linksDistance,0,0]) { cube([linkWidth,totalLinkLength,linkHeight]); }
			for(i = [0:nbOfBottleSlots]) {
				//if (i < nbOfBottleSlots) {		translate ([linkWidth+(linksDistance-80-linkWidth)/2,10+bottleSpace*i,0]) { cube([80,bottleSpace-20,linkHeight]); }			}
				translate([0,bottleSpace*i-bumpLength/2,0]) {
					bumpIt (bumpLength-bumpHeight*2) { smooth(bumpRounding) { square([bumpHeight,bumpWidth]); } }
					translate([linksDistance,0,0]) { bumpIt (bumpLength-bumpHeight*2) { smooth(bumpRounding) { square([bumpHeight,bumpWidth]); } } }
				}
			}
		}
		
		remover(cutPosStart,cutPosStart>0?true:false);
		translate([(linksDistance+linkWidth)/2,totalLinkLength-(nbOfBottleSlots-realCutPosEnd)*bottleSpace,0]) { rotate ([0,0,180]) { translate([-(linksDistance+linkWidth)/2,0,0]) { remover(0,realCutPosEnd<nbOfBottleSlots?true:false); } } }
	}

	// Now building the interlink linkage.
	translate ([linkWidth/2,-bumpLength/4+bottleSpace*(cutPosStart+realCutPosEnd)/2,0]) { cube([linksDistance,linkWidth,linkHeight]); }
}

if (withBottles) {
	color(["#80FF80"]) {
		for (i = [0:nbOfBottleSlots-1]) {
			translate([-linksDistance*0.25,(bottleSpace)*(0.5+i),bottleSpace*0.5+linkHeight]) { rotate([0,90,0]) { cylinder (h=linksDistance*1.5, d=bottleSpace); } }
		}
	}
}
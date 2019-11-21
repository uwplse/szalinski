/*
 * Author:  Jean Philippe Neumann
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     http://www.thingiverse.com/thing:94611
 * 
 * Label text by Frank Scholl
 * Inclination by Alejandro M. Medrano Gil
 */
 
// MakerBot customizer settings:
// preview[view:south east, tilt:top diagonal]
use <write/Write.scad>

/*
 * parameters
 */

/* [primary parameters] */

// how many card holders to print
numberOfHolders = 1;
// how many lids to print
numberOfLids = 1;

// the length of your cards in mm
cardY = 63;
// the width of your cards in mm
cardX = 41;
// the height of the stack of cards you want to store in mm
cardStackZ = 6;
// the angle at which the card holder is to be tilted
cardAngle=35;
// The fudge factor allows fine tuning the distances between parts in the lock and key mechanisms of the holder. The right value is highly dependent on your printer. Is everything fitting too tight? Try increasing the factor by 0.1. Is everything fitting too loose? Try decreasing the factor by 0.1.
fudgeFactor = 0.5;

/* [secondary parameters] */

longWallStrength = 1.4;
shortWallStrength = 1.2;
bottomWallStrength = 1.4;

// thickness of the lower part of the lock mechanism
lowerLockY = 1.2;
// height of the lower part of the lock mechanism
lowerLockZ = 1.7;
// thickness of the upper part of the lock mechanism
upperLockY = 3.5;
// height of the upper part of the lock mechanism
upperLockZ = 1.2;
// how high is the part of the lid that slides in the locks rail
keyRailZLid = 1.0;
// how high is the part of the holders body that slides in the locks rail
keyRailZBody = 1.0;

// how thick the bit of plastic is that blocks the end of the lock's rail
stopBitStrength = 1.2;
// the "lock nub" is a tiny bump near the end of the lock's rail that makes other holders or lids snap in. This variable sets the size of that nub.
lockNubRadius = 0.45;
// position of the "lock nub"
lockNubDistanceToCorner = 3*stopBitStrength;

// how much extra space to leave around cards
spaceAroundCard = 1;
// how strong the lid's grip is
lidGripStrength = 3;
// how alrge the hole in the lid is
lidHoleRadius = (cardX + 2*spaceAroundCard + 2*longWallStrength)/2 - lidGripStrength;

// distance between objects on the print bed
printDistance = 10;

/* [Label Text] */

// text to be added to the side
label = "My Favorite Card Game";
// which font to use
font = "write/knewave.dxf"; // ["write/Letters.dxf":Letters,"write/orbitron.dxf":orbitron,"write/BlackRose.dxf":BlackRose,"write/knewave.dxf":knewave,"write/braille.dxf":braille]
// printed on top or engraved into the side
style = 0; // [0:Engraved, 1:Printed]


/* derived parameters */
/* [Hidden] */

release = 1;

// holder main body parameters
bodyX = cardX + 2*spaceAroundCard + 2*longWallStrength;
bodyY = cardY + 2*spaceAroundCard + 2*shortWallStrength + 2*upperLockY + 3*fudgeFactor;
bodyZ = cardStackZ + spaceAroundCard/2;

// lock, key and lid parameters
lockZ = lowerLockZ + upperLockZ;
keyZ = lowerLockZ + upperLockZ + fudgeFactor/3;
lidZ = lowerLockZ + upperLockZ - fudgeFactor;
keyRailX = bodyX - 2*stopBitStrength - 2*fudgeFactor;
keyRailY = upperLockY - lowerLockY + 0.7 - fudgeFactor;
keyMainY = cardY + 2*spaceAroundCard + 2*shortWallStrength;

// space around the card stack
cardSpaceX = cardX + 2*spaceAroundCard;
cardSpaceY = cardY + 2*spaceAroundCard;

// hole in the side of the holder
grabHoleX = longWallStrength + cardX/8;
grabHoleY = cardY * 1/2;

// misc 
holderZ = bodyZ + keyZ + lockZ;
inclination=-cardAngle;
skewMatrix=[
            [1,0,tan(inclination),0],
            [0,1,0,0],
            [0,0,1,0],
            [0,0,0,1]
           ];

/*
 * putting it all together
 */

if(numberOfHolders != 0) {
	for(i=[0:numberOfHolders-1]) {
		translate([-i*(printDistance + holderZ),0,0])
		
		if(release == 1) {
			translate([-holderZ, bodyY, 0])
			rotate([0,-90-inclination,180])
			multmatrix(m=skewMatrix)
            holder();
		} else {
			translate([-bodyX, 0, 0])
			multmatrix(m=skewMatrix)
			holder();
		}
	}
}

if(numberOfLids != 0) {
	for(i=[0:numberOfLids-1]) {
		translate([i*(printDistance + bodyX) + printDistance,0,0])
		lid();
	}
}

/*
 * modules
 */

module lid() {
	union() {
		difference() {
			key(bodyX, keyMainY, lidZ, keyRailX, keyRailY, keyRailZLid, true);
			
			translate([bodyX/2, bodyY/2, -1])
			cylinder(h=lidZ+2, r=lidHoleRadius, $fn=64);
		}
		translate([0, (bodyY-lidGripStrength)/2,0])
		cube([bodyX, lidGripStrength ,lidZ]);
	}
}

module key(mainX, mainY, mainZ, railX, railY, railZ, lidMode) {
	railPartY = 2*railY + mainY;
	
	translate([(bodyX-mainX)/2, (bodyY-mainY)/2,0])
	union() {
		color([0.5,0.7,0.9])
		cube([mainX, mainY, mainZ]);
		
		color([0.7,0.7,0.9])
		translate([(mainX-railX)/2,(mainY-railPartY)/2,0])
		cube([railX, railPartY, railZ]);
		
		if(lidMode == false) {
			color([1,0,0])
			translate([0, -(railPartY-mainY)/2, 0])
			cube([(mainX-railX)/2,railPartY,railZ]);
		}
	}
}

module holder() {
	difference() {
		union() {
			key(bodyX, keyMainY, keyZ, keyRailX, keyRailY, keyRailZBody, false);
			
			translate([0,0,keyZ])
			cube([bodyX, bodyY, bodyZ]);
			if(style == 1)
			writecube(label,[.4,bodyY/2,bodyZ/2],[bodyX*2, bodyY*2, bodyZ*2],face="right",center=true,font=font,up=3);

			translate([0,0,bodyZ+keyZ])
			lock(bodyX, lowerLockY, lowerLockZ, upperLockY, upperLockZ);
		}
		cardSpace();
		grabHole();
        if(style == 0)
		writecube(label,[-.4,bodyY/2,bodyZ/2],[bodyX*2, bodyY*2, bodyZ*2],face="right",center=true,font=font,up=3);

	}
}

module cardSpace() {
	color([1,0,0])
	translate([(bodyX-cardSpaceX)/2,(bodyY-cardSpaceY)/2,bottomWallStrength])
	cube([cardSpaceX, cardSpaceY, bodyZ+keyZ+bottomWallStrength]);
}

module grabHole() {
	cylinderRadius = 5;
	cubeX = grabHoleX-cylinderRadius;
	cubeY = grabHoleY-cylinderRadius;
	posY = (bodyY-cubeY)/2;
	
	$fn=64;
	translate([0, posY, -1])
	minkowski() {
		cube([cubeX, cubeY, bodyZ+keyZ+2]);
		cylinder(r=cylinderRadius, h=1);
	}
}

module lock() {
	union() {
		lockPart();
		mirror([0,1,0]) {
			translate([0,-bodyY,0])
			lockPart();
		}
	}
}

module lockPart() {
	union() {
		// lower lock
		color([0.9,0.4,0.3])
		cube([bodyX, lowerLockY, lowerLockZ]);
		
		// upper lock
		// subtracting 0.01 because of strange holes in the generated STL file
		translate([0,0,lowerLockZ-0.01])
		cube([bodyX, upperLockY, upperLockZ]);
		
		// stop bit
		color([0,1,0])
		// extra large lock bit / translate -Z because of strange holes in the generated STL file
		translate([bodyX-stopBitStrength, 0, -0.2])
		cube([stopBitStrength, upperLockY, lockZ+0.2]);
		
		// safety nub
		color([1,0,0])
		translate([bodyX-lockNubDistanceToCorner, upperLockY, lowerLockZ])
		rotate([90,0,0])
		cylinder(r=lockNubRadius, h=upperLockY, $fn=16);
	}
}

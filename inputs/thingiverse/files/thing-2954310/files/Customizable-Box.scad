/*
 * Customizable Card Boxes and Lids 
 * Version: 0.4 -- 2019-01-14
 * Author: Mark Phaedrus
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     https://www.thingiverse.com/thing:2954310
 
 * Remix Of: Customizable Board Game Card Storage with Multiple Sizes
 * Author:  Erwan Loisant
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     https://www.thingiverse.com/thing:2923849
 * 
 * Remix Of: Customizable Board Game Card Storage
 * Author:  Jean Philippe Neumann
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     http://www.thingiverse.com/thing:94611
 */
 
// MakerBot customizer settings:
// preview[view:south east, tilt:top diagonal]

/*
 * parameters
 */

/* [Basics] */

// What is the length of your cards (the longer dimension) in millimeters?
cardLength = 88;
// What is the width of your cards in millimeters?
cardWidth = 63;

// How should I position the boxes for printing? Printing them flat lets them print without support (if you use the angled lock). Standing them on their sides will let you fit more boxes on the build plate, but requires a lot of support.
boxPositioning = 0; // [0:Flat,1:On their sides]

// What style of lock should I use to let the boxes be stacked together and keep the lids on? The square lock uses 90-degree angles; it's strong, but winds up looking messy (or requires support) if you print the boxes flat. The angled lock is experimental and a bit weaker; but it's strong enough for most uses, and it can be printed without support in either position.
lockStyle = 1; // [0: Square lock,1:Angled lock] 

// How tightly should the boxes and lids fit together? The right value is highly dependent on your printer. Start with a value of 0. Are the locks too tight to slide together? Try decreasing the tightness by 1. Are the locks so loose that they slide apart on their own? Try increasing the tightness by 1.
fitTightness = 0; // [-5:1:5]

// What is the thickness of the stack of cards you're keeping in the first box, in millimeters?
cardBox1Thickness = 35;

// Should the box have a grab hole in the side to let you draw cards from the box? If so, do you also want a plug to cover the grab hole for storage?
cardBox1GrabHole = 2; // [2:Hole with plug,1:Hole without plug,0:No]

// What label should I put on the two narrow ends of the first box? (Leave this blank if you don't want a label there.)
cardBox1EndLabel = "";

// What label should I put on the long side of the first box opposite the grab hole? (Leave this blank if you don't want a label there.)
cardBox1SideLabel = "";

// Should the first card box have a key on the bottom? (Choosing this will make the box simpler, but won't let you lock any other boxes to the bottom of this one.)
cardBox1Key = 1; // [1:Bottom key,0:No bottom key]

// What label should I put on the lid? (Leave this blank if you don't want a label.)
lidLabel = "";

// What part should be displayed in the preview?
part="B1"; // [B1:Box 1,L1:Lid,B2:Box 2,B3:Box 3,B4:Box 4,B5:Box 5]

/* [Box 2 (if you want it)] */

// What is the thickness of the stack of cards you're keeping in the second box, in millimeters? (Leave this zero if you don't want a second box.)
cardBox2Thickness = 0;

// Should the box have a grab hole in the side to let you draw cards from the box? If so, do you also want a plug to cover the grab hole for storage?
cardBox2GrabHole = 2; // [2:Hole with plug,1:Hole without plug,0:No]

// What label should I put on the two narrow ends of the second box? (Leave this blank if you don't want a label there.)
cardBox2EndLabel = "";

// What label should I put on the long side of the second box opposite the grab hole? (Leave this blank if you don't want a label there.)
cardBox2SideLabel = "";

// Should the box have a key on the bottom? (Choosing this will make the box simpler, but won't let you lock any other boxes to the bottom of this one.)
cardBox2Key = 1; // [1:Bottom key,0:No bottom key]

/* [Box 3 (if you want it)] */

// What is the thickness of the stack of cards you're keeping in the third box, in millimeters? (Leave this zero if you don't want a third box.)
cardBox3Thickness = 0;

// Should the box have a grab hole in the side to let you draw cards from the box? If so, do you also want a plug to cover the grab hole for storage?
cardBox3GrabHole = 2; // [2:Hole with plug,1:Hole without plug,0:No]

// What label should I put on the two narrow ends of the third box? (Leave this blank if you don't want a label there.)
cardBox3EndLabel = "";

// What label should I put on the long side of the third box opposite the grab hole? (Leave this blank if you don't want a label there.)
cardBox3SideLabel = "";

// Should the box have a key on the bottom? (Choosing this will make the box simpler, but won't let you lock any other boxes to the bottom of this one.)
cardBox3Key = 1; // [1:Bottom key,0:No bottom key]

/* [Box 4 (if you want it)] */

// What is the thickness of the stack of cards you're keeping in the fourth box, in millimeters? (Leave this zero if you don't want a fourth box.)
cardBox4Thickness = 0;

// Should the box have a grab hole in the side to let you draw cards from the box? If so, do you also want a plug to cover the grab hole for storage?
cardBox4GrabHole = 2; // [2:Hole with plug,1:Hole without plug,0:No]

// What label should I put on the two narrow ends of the fourth box? (Leave this blank if you don't want a label there.)
cardBox4EndLabel = "";

// What label should I put on the long side of the first box opposite the grab hole? (Leave this blank if you don't want a label there.)
cardBox4SideLabel = "";

// Should the box have a key on the bottom? (Choosing this will make the box simpler, but won't let you lock any other boxes to the bottom of this one.)
cardBox4Key = 1; // [1:Bottom key,0:No bottom key]

/* [Box 5 (if you want it)] */

// What is the thickness of the stack of cards you're keeping in the fifth box, in millimeters? (Leave this zero if you don't want a fifth box.)
cardBox5Thickness = 0;

// Should the box have a grab hole in the side to let you draw cards from the box? If so, do you also want a plug to cover the grab hole for storage?
cardBox5GrabHole = 2; // [2:Hole with plug,1:Hole without plug,0:No]

// What label should I put on the two narrow ends of the fifth box? H(Leave this blank if you don't want a label there.)
cardBox5EndLabel = "";

// What label should I put on the long side of the fifth box opposite the grab hole? (Leave this blank if you don't want a label.)
cardBox5SideLabel = "";

// Should the box have a key on the bottom? (Choosing this will make the box simpler, but won't let you lock any other boxes to the bottom of this one.)
cardBox5Key = 1; // [1:Bottom key,0:No bottom key]

// Hiding all the parameters below from the customizer for now, because I haven't verified that they all work correctly with the new lock/key style.
/* [Hidden] */

partType = part[0];
partIndex = atoi(part[1]) - 1;

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

// How far the text on the lid is embedded into the lid
lidTextDepth = 0.8;

// How far the text on the boxes is embedded into the box
holderTextDepth = 1.2;

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

// **********
// * BEGIN INCLUDED CODE:
// * DisplayErrorsInPreview by kickahaota (https://www.thingiverse.com/thing:2918930)
// **********
// Convert strings to floating point for compatibility with Customizer
// Conversion code by jesse (https://www.thingiverse.com/thing:2247435)
function atoi(str, base=10, i=0, nb=0) =
	i == len(str) ? (str[0] == "-" ? -nb : nb) :
	i == 0 && str[0] == "-" ? atoi(str, base, 1) :
	atoi(str, base, i + 1,
		nb + search(str[i], "0123456789ABCDEF")[0] * pow(base, len(str) - i - 1));

function substr(str, pos=0, len=-1, substr="") =
	len == 0 ? substr :
	len == -1 ? substr(str, pos, len(str)-pos, substr) :
	substr(str, pos+1, len-1, str(substr, str[pos]));
    
function atof(str) = len(str) == 0 ? 0 : let( expon1 = search("e", str), expon = len(expon1) ? expon1 : search("E", str)) len(expon) ? atof(substr(str,pos=0,len=expon[0])) * pow(10, atoi(substr(str,pos=expon[0]+1))) : let( multiplyBy = (str[0] == "-") ? -1 : 1, str = (str[0] == "-" || str[0] == "+") ? substr(str, 1, len(str)-1) : str, decimal = search(".", str), beforeDecimal = decimal == [] ? str : substr(str, 0, decimal[0]), afterDecimal = decimal == [] ? "0" : substr(str, decimal[0]+1) ) (multiplyBy * (atoi(beforeDecimal) + atoi(afterDecimal)/pow(10,len(afterDecimal)))); 

function isdef(x) = (x != undef);
function isnumeric(x) = isdef(x) && ( x + 0 == x);
function isinteger(x) = isdef(x) && ( floor(x) == x) ;
function aorftof(numorstr) = (numorstr + 1 == undef) ? atof(numorstr) : numorstr;
function aoritoi(numorstr) = (numorstr + 1 == undef) ? atoi(numorstr) : numorstr;

module showfailedassertions() {
    translate([0,0,0]) linear_extrude(height=1) text(text="Please make these parameter changes:");
    for(idx = [0 : len(assertions)-1]) {
        if (!assertions[idx][0]) {
            translate([0, -12*idx, 0]) linear_extrude(height=1) text(text=assertions[idx][1]);
        }
    }
}

function anyassertionfailed(idx = len(assertions)-1) = (!(assertions[idx][0]) ? 1 : (idx <= 0) ? 0 : anyassertionfailed(idx-1)); 

// **********
// * END INCLUDED CODE:
// * DisplayErrorsInPreview by kickahaota (https://www.thingiverse.com/thing:2918930)
// **********

// Customizer may have converted numeric parameters into strings; turn them back into numbers
cardY = aorftof(cardLength);
cardX = aorftof(cardWidth);
cardStackZs = [cardBox1Thickness,cardBox2Thickness,cardBox3Thickness,cardBox4Thickness,cardBox5Thickness];
holderEndLabels = [cardBox1EndLabel,cardBox2EndLabel,cardBox3EndLabel,cardBox4EndLabel,cardBox5EndLabel];
holderSideLabels = [cardBox1SideLabel,cardBox2SideLabel,cardBox3SideLabel,cardBox4SideLabel,cardBox5SideLabel];
holderUseGrabHoles = [(cardBox1GrabHole > 0), (cardBox2GrabHole > 0), (cardBox3GrabHole > 0), (cardBox4GrabHole > 0), (cardBox5GrabHole > 0)];
holderUseGrabHolePlugs = [(cardBox1GrabHole == 2), (cardBox2GrabHole == 2), (cardBox3GrabHole == 2), (cardBox4GrabHole == 2), (cardBox5GrabHole == 2)];
holderSuppressKeys = [(cardBox1Key == 0), (cardBox2Key == 0), (cardBox3Key == 0), (cardBox4Key == 0), (cardBox5Key == 0)];
lidLabels = [lidLabel];
holdersOnSide = (aoritoi(boxPositioning) > 0) ;
fudgeFactor = .5 - (aorftof(fitTightness) / 10);
useAngledLockKeyStyle = (aoritoi(lockStyle) > 0);

function isNumeric(x) = (abs(x) != undef);
function isString(x) = !isNumeric(x) && (str(x) == x);
function isVector(x) = !isNumeric(x) && !isString(x);

function valueFromOptionalArray(valueOrArray, idx) = isVector(valueOrArray)? valueOrArray[idx % len(valueOrArray)] : valueOrArray;
function cardStackZ(idxHolder) = valueFromOptionalArray(cardStackZs, idxHolder);
function holderEndLabel(idxLid) = valueFromOptionalArray(holderEndLabels, idxLid);
function holderSideLabel(idxLid) = valueFromOptionalArray(holderSideLabels, idxLid);
function lidLabel(idxLid) = valueFromOptionalArray(lidLabels, idxLid);

// Assertions we want to verify before making the real object
assertions = [
    [fudgeFactor >= 0, "Fit tightness must be at least zero" ],
    [fudgeFactor <= 1, "Fit tightness cannot be greater than one"],
    [cardY >= cardX, "Card length can't be less than card width"],
    [cardY >= 10, "Card length must be at least 10 millimeters"],
    [cardX >= 10, "Card width must be at least 10 millimeters"],
    [len(part) == 2, "Part code must have 2 characters"],
    [(partType == "B") || (partType == "L"), "First character of part code must be 'B' to print a box or 'L' to print a lid."],
    [(partIndex >= 0) && (partIndex <= 8), "Second character of part code must be a digit from 1 through 9."], 
    [(partType == "B") || (partType == "L"), "Part type is unexpected."],
];


// holder main body parameters
bodyX = cardX + 2*spaceAroundCard + 2*longWallStrength;
bodyY = cardY + 2*spaceAroundCard + 2*shortWallStrength + 2*upperLockY + 3*fudgeFactor;
function bodyZ(idxHolder) = cardStackZ(idxHolder) + spaceAroundCard/2;

// lock, key and lid parameters
lockZ = lowerLockZ + upperLockZ;
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
grabHoleCylinderRadius = 5;
// misc 
function keyZ(idxHolder) = holderSuppressKeys[idxHolder] ? 0 : (lowerLockZ + upperLockZ + fudgeFactor/3);
function holderZ(idxHolder) = bodyZ(idxHolder) + keyZ(idxHolder) + lockZ;
function maxHolderZ(idxHolder = len(cardStackZs)-1) = (idxHolder < 0) ? 0 : max(holderZ(idxHolder), maxHolderZ(idxHolder-1));

/*
 * modules
 */

module lid(idxLid) {
    lidHoleRadius = (cardX + 2*spaceAroundCard + 2*longWallStrength)/2 - lidGripStrength;
    lidHoleBarY = lidGripStrength;
    lidHolePlugRadius = lidHoleRadius - 2;
    lidHolePlugThickness = max(1.2, lidZ * 2 / 3);
    lidHolePlugGapX = 2 * (lidHolePlugRadius * .75);
    lidHolePlugGapY = 4 * lidHoleBarY;


    textxsize = min(bodyX*.9, 12 * len(lidLabel(idxLid)));
    textysize = 12;
    difference() {
        union() {
            difference() {
                key(bodyX, keyMainY, lidZ, keyRailX, keyRailY, keyRailZLid, true);
            
                translate([bodyX/2, bodyY/2, -1])
                    cylinder(h=lidZ+2, r=lidHoleRadius, $fn=64);
            }
            translate([0, (bodyY-lidHoleBarY)/2,0])
                cube([bodyX, lidHoleBarY ,lidZ]);
            difference() {
                translate([bodyX/2, bodyY/2, 0])
                    cylinder(h=lidHolePlugThickness, r=lidHolePlugRadius, $fn=64);
                translate([(bodyX - lidHolePlugGapX) / 2,
                           (bodyY - lidHolePlugGapY) / 2, -1])
                    cube([lidHolePlugGapX, lidHolePlugGapY, lidZ+2]);
            }
            
        }
        translate([bodyX/2, 5, lidZ-lidTextDepth])
            resize([textxsize, textysize, 0], auto=false)     
                linear_extrude(height = lidTextDepth + 0.001)
                    text(text=lidLabel(idxLid), size=10, valign="bottom", halign="center");
    }

}

module key(mainX, mainY, mainZ, railX, railY, railZ, lidMode) {
	railPartY = 2*railY + mainY;
	
	translate([(bodyX-mainX)/2, (bodyY-mainY)/2,0])
	union() {
		// color([0.5,0.7,0.9])
            cube([mainX, mainY, mainZ]);
		
 		// color([0.7,0.7,0.9])
            translate([(mainX-railX)/2,(mainY-railPartY)/2,0])
                cube([railX, railPartY, railZ]);
		        
		if(lidMode == false)
        {
			// color([1,0,0])
            {
                translate([0, -(railPartY-mainY)/2, 0])
                {
                    cube([(mainX-railX)/2,railPartY,railZ]);
                    if (useAngledLockKeyStyle)
                    {
                        translate([railX,0.001,railZ - 0.001])
                        {
                            // color([0,0,0])
                            {   
                                rotate([0,270,0])
                                {
                                    linear_extrude(height=railX)
                                    {
                                        polygon([[0,0],[0,railY],[railY,railY]]);
                                    }
                                }
                            }
                        }
                        translate([railX, railPartY - 0.001, railZ - 0.001])
                        {
                            // color([0,0,0])
                            {   
                                rotate([0,270,0])
                                {
                                    linear_extrude(height=railX)
                                    {
                                        polygon([[0,0],[0,-railY],[railY,-railY]]);
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
		}
        else if (useAngledLockKeyStyle) 
        {
            size = railY;
            translate([(mainX+railX)/2,fudgeFactor-(mainX-railX),0])
            {
                // color([0,0,0])
                {   
                    rotate([0,270,0])
                    {
                        linear_extrude(height=railX)
                        {
                            polygon([[0,0],[0,size],[size,size]]);
                        }
                    }
                }
            }
            translate([(mainX+railX)/2, mainY - fudgeFactor + (mainX - railX),0])
            {
                // color([1,1,1])
                {   
                    rotate([0,270,0])
                    {
                        linear_extrude(height=railX)
                        {
                            polygon([[0,0],[0,-size],[size,-size]]);
                        }
                    }
                }
            }
        }
	}
}

module holder(idxHolder) {
	difference() {
		union() {
            if (!holderSuppressKeys[idxHolder])
            {
                key(bodyX, keyMainY, keyZ(idxHolder), keyRailX, keyRailY, keyRailZBody, false);
			}
			translate([0,0,keyZ(idxHolder)])
                cube([bodyX, bodyY, bodyZ(idxHolder)]);
			
			translate([0,0,bodyZ(idxHolder)+keyZ(idxHolder)])
                lock();
            
            color("Red") grabHolePlug(idxHolder);
		}
		cardSpace(idxHolder);
		grabHole(idxHolder);
        endLabel(idxHolder);
        sideLabel(idxHolder);
        if (!holderSuppressKeys[idxHolder])
        {
            if (useAngledLockKeyStyle)
            {
                size = (bodyY - keyMainY) / 2;
                translate([bodyX + 0.01,0,keyZ(idxHolder)])
                {
                    rotate([0, 270, 0])
                    {
                        linear_extrude(height=bodyX + 0.02)
                        {
                            polygon([[0,0], [size,0], [0, size]]);
                        }
                    }
                }
                translate([bodyX + 0.01, bodyY, keyZ(idxHolder)])
                {
                    rotate([0,270,0])
                    {
                        linear_extrude(height=bodyX + 0.02)
                        {
                            polygon([[0,0],[size,0],[0,-size]]);
                        }
                    }
                }
            }
        }
	}
}

module cardSpace(idxHolder) {
	// color([1,0,0])
        translate([(bodyX-cardSpaceX)/2,(bodyY-cardSpaceY)/2,bottomWallStrength])
            cube([cardSpaceX, cardSpaceY, bodyZ(idxHolder)+keyZ(idxHolder)+bottomWallStrength]);
}

function arccoords(startangle, step, endangle, xy_size, xoffset, yoffset)
    = ((step > 0 && startangle > endangle) || (step < 0 && startangle < endangle))
        ? []
        : concat([[xy_size * sin(startangle)+xoffset, xy_size * cos(startangle)+yoffset]],
                 arccoords(startangle+step, step, endangle, xy_size, xoffset, yoffset)); 


function grabHolePoly(shrinkage=0) = concat(
    [[-0.001, -0.001+shrinkage],
     [-0.001, grabHoleY-shrinkage],
     [grabHoleX - shrinkage, grabHoleY-shrinkage]],
    arccoords( 0, 3, 90,grabHoleCylinderRadius-shrinkage,grabHoleX-shrinkage,grabHoleY- grabHoleCylinderRadius),
    arccoords(90, 3,180,grabHoleCylinderRadius-shrinkage,grabHoleX-shrinkage,grabHoleCylinderRadius));

module grabHole(idxHolder) {
    cubeX = grabHoleX-grabHoleCylinderRadius;
    cubeY = grabHoleY-grabHoleCylinderRadius;
    posY = (bodyY-grabHoleY)/2;
    if (holderUseGrabHoles[idxHolder]) {
        $fn=64;
        translate([0, posY, -1]) {
            linear_extrude(height=bodyZ(idxHolder)+keyZ(idxHolder)+2)
            {
                polygon(grabHolePoly(0));
            }
        }
    }
    else
    {
        flexibilitySlitWidth = 2.0;
        translate([0, bodyY / 2, bottomWallStrength])
        {
            cube([longWallStrength, flexibilitySlitWidth, bodyZ(idxHolder) + lockZ + 0.001]);
        }
    }
}

module grabHolePlug(idxHolder) {
    shrinkage = 1; // 1.2 * fudgeFactor;
    plugInnerWallThickness = 1.0;
    posY = (bodyY-(grabHoleY))/2;
    plugPoly = grabHolePoly(shrinkage);
    echo(posY, bodyZ(idxHolder), plugPoly);
    if (holderUseGrabHolePlugs[idxHolder])
    {
        translate([-25,0,0])
        {
            rotate([0,270,0])
            {
                translate([0,(bodyY-cardSpaceY)/2 + shrinkage, bottomWallStrength + shrinkage])
                    cube([plugInnerWallThickness, cardSpaceY - (2 * shrinkage), cardStackZ(idxHolder) - shrinkage]);
             
                translate([0,posY,0])
                {
                    rotate([0, 0, 0])
                    {
                        linear_extrude(height=bottomWallStrength + shrinkage)
                        {
                            polygon(plugPoly);
                        }
                    }
                }
            }
        }
    }
}        

module endLabel(idxHolder)
{
    if (holderEndLabel(idxHolder) != "")
    {
        xsize = min(bodyX*.9, 12 * len(holderEndLabel(idxHolder)));
        ysize = min(bodyZ(idxHolder) / 2, 10);
        translate([bodyX / 2, holderTextDepth - 0.001, bodyZ(idxHolder) / 2 + lockZ + (useAngledLockKeyStyle ? 2.5 : 0)])
            rotate([90,0,0])
                resize([xsize, ysize, 0], auto=false)     
                    linear_extrude(height = holderTextDepth)
                        text(text=holderEndLabel(idxHolder), size=10, valign="center", halign="center");
        translate([bodyX / 2, bodyY - holderTextDepth + 0.001, bodyZ(idxHolder) / 2 + lockZ + (useAngledLockKeyStyle ? 2.5 : 0)])
            rotate([270, 180, 0])
                resize([xsize, ysize, 0], auto=false)     
                    linear_extrude(height = holderTextDepth)
                        text(text=holderEndLabel(idxHolder), size=10, valign="center", halign="center");
    }
}

module sideLabel(idxHolder)
{
    if (holderSideLabel(idxHolder) != "")
    {
        xsize = min(bodyY*.9, 12 * len(holderSideLabel(idxHolder)));
        ysize = min(bodyZ(idxHolder) / 2, 10);
        translate([bodyX - holderTextDepth + 0.001, bodyY / 2, bodyZ(idxHolder) / 2 + lockZ + (useAngledLockKeyStyle ? 2.5 : 0)])
            rotate([90,0,90])
                resize([xsize, ysize, 0], auto=false)     
                    linear_extrude(height = holderTextDepth)
                        text(text=holderSideLabel(idxHolder), size=10, valign="center", halign="center");
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
		// color([0.9,0.4,0.3])
            cube([bodyX, lowerLockY, lowerLockZ]);
		
		// upper lock
		// subtracting 0.01 because of strange holes in the generated STL file
        if (useAngledLockKeyStyle)
        {
            // color([1,1,1])
                translate([bodyX,0,0])
                {
                    rotate([0,270,0])
                    {
                        linear_extrude(height=bodyX)
                        {
                            polygon([[0,0],
                                     [lowerLockZ + upperLockZ, 0],
                                     [lowerLockZ + upperLockZ, upperLockY]]);
                        }
                    }
                }
                    
        }
        else
        {
            translate([0,0,lowerLockZ-0.01])
                cube([bodyX, upperLockY, upperLockZ]);
		}
		// stop bit
		// color([0,1,0])
		// extra large lock bit / translate -Z because of strange holes in the generated STL file
            translate([bodyX-stopBitStrength, 0, -0.2])
                cube([stopBitStrength, upperLockY, lockZ+0.2]);
		
		// safety nub
		// color([1,0,0])
            translate([bodyX-lockNubDistanceToCorner, upperLockY, lowerLockZ])
                rotate([90,0,0])
                    cylinder(r=lockNubRadius, h=upperLockY, $fn=16);
	}
}

module unneededfile()
{
    rotate([45,0,45])
    {
        linear_extrude(height=1) text(text="This file is not used in this box set.");
        translate([0,-12,0]) linear_extrude(height=1) text(text="You can delete it.");
    };
}

/*
 * putting it all together
 */

if (anyassertionfailed())
{
    rotate([45,0,45]) showfailedassertions();
}
else
{
    if (partType == "B")
    {
        if ((partIndex < len(cardStackZs)) && (cardStackZs[partIndex] > 0))
        {
            if(holdersOnSide) {
                rotate([0, -90, 180])
                    holder(partIndex);
            } else {
                holder(partIndex);
            }
        }
        else unneededfile();
    }

    if(partType == "L") {
        if (partIndex < len(lidLabels))
        {
            lid(partIndex);
        }
        else unneededfile();
    }
}

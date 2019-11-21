// Printrbot Simple Metal 1403 Spool Holder
// author: fiveangle@gmail.com
// date: 2015apr15
// ver: 1.0
// known issues: there's a bug when armWidth < stemWidth and armAngle != 90 where stem doesn't extend to arm full-width, but not really interested in fixing right now since it doesn't affect me.

// adjust to increase/decrease polygon count at expense of processing time (above 100 is probably useless)
$fn = 60; //

// actual is 148mm, but keep <125mm to fit printrbot metal build platform.
yZrodDistanceToYCenter = 124.9;

// this determines how long the 45-deg guideArm offset is
xZrodDistanceToYCenter = 6;
nozzleWidth = 0.4;

// increase to make stronger part around zrod.
shellsAroundZrod = 3;
// use printOnlyToHeight parameter to print just the zrod bearing surface to calibrate this value for tightest fit.
zRodBearingRadius = 6.26;
// this is length of zrod above z bearing block when printer head is at maximum z height
zRodBearingLength = 19;

// set by "shellsAroundZrod"; increase for strength, or replace with arbitrary width as desired.
stemWidth = 2 * (zRodBearingRadius + (shellsAroundZrod * nozzleWidth));

// symetrical be default, or replace with arbitrary length.
stemLength = stemWidth;

// maximum size that will print on Printerbot Metal. Default: 149.9
stemHeight = 149.9;

// make 13.4mm if you want to fit Taulman filament spools with 19mm holes.
armWidth = stemWidth;
armLength = 100;
armHeight = armWidth;

// increasing this may require shortening stemHeight, or rotating STL in your slicer so that arm is parallel to x or x printer axis.
armAngle = 92.5;
lipThickness = 3;
lipHeight = 4;

// increase to handle spools with greater permieter backset
lipInnerExtra = 5;
guideWidth = stemWidth;
guideLength = yZrodDistanceToYCenter - xZrodDistanceToYCenter;
guideHeight = 3;
guideWidth = 10;

// this needs to be approx 2.2mm radius, but you'll likely get a better print by making this "0" and drilling the hole manually afterward - your choice
guideHole = 2.2;
// "False" here if you don't want to include the filament guide arm
guideArm = 1; // [0:False,1:True]

// "True" here will generate a test print of just the zrod bearing section of the stem to calibrate for your zRodBearingRadius before printing entire holder.
printOnlyZrodBearing = 0; // [0:False,1:True]
printAboveZrod = printOnlyZrodBearing ? 0 : 500;
printOnlyToHeight = (zRodBearingLength + (zRodBearingRadius / 3) + 3) + printAboveZrod;

intersection() {
    translate([-5000, -10000 + printOnlyToHeight, 0]) {
        cube([10000, 10000, 10000]); // leave minimum of the zrod bearing surface to test-print tightness of zRodBearingRadius
    }

    union() {
        difference() {
            cube([stemWidth, stemHeight, stemLength]);
            translate([(stemWidth / 2), zRodBearingLength + zRodBearingRadius / 3, (stemWidth / 2)]) {
                rotate(a = 90, v = [1, 0, 0]) {
                    difference() {
                        cylinder(h = 1 + zRodBearingLength + zRodBearingRadius / 3, r = zRodBearingRadius);
                        cylinder(h = zRodBearingRadius / 2, r1 = zRodBearingRadius, r2 = 0, center = false);
                    }
                }
            }
        }
        translate([stemWidth, stemHeight, armWidth]) {
            rotate(a = 180 - armAngle, v = [0, 0, 1]) {
                rotate(a = 180, v = [0, 1, 0]) {
                    difference() {
                        cube([armHeight, armLength, armWidth]); // arm
                        translate([0, stemWidth + lipInnerExtra, 0]) {
                            cube([lipHeight, armLength - stemWidth - lipThickness - lipInnerExtra, armWidth]); // lip cutout
                        }
                    }
                    if (guideArm) {
                        translate([guideHeight, (stemWidth - guideWidth) / 2, 0]) {
                            rotate(a = 90, v = [0, 1, 0]) {
                                rotate(a = -90, v = [1, 0, 0]) {
                                    union() {
                                        cube([guideLength, guideHeight, guideWidth]);
                                        translate([guideLength, 0, 0]) {
                                            rotate(a = -45, v = [0, 1, 0]) {
                                                difference() {
                                                    cube([sqrt(pow(xZrodDistanceToYCenter + lipInnerExtra + (stemWidth / 2), 2) + pow(xZrodDistanceToYCenter + lipInnerExtra + (stemWidth / 2), 2)), guideHeight, guideWidth]);
                                                    translate([sqrt(pow(xZrodDistanceToYCenter + lipInnerExtra + (stemWidth / 2), 2) + pow(xZrodDistanceToYCenter + lipInnerExtra + (stemWidth / 2), 2)) - guideWidth / 2, 0, guideWidth / 2]) {
                                                        rotate(a = -90, v = [1, 0, 0]) {
                                                            cylinder(h = guideHeight, r = guideHole, center = false);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
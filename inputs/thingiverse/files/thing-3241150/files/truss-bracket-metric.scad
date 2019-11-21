/*
 * Configurable Strut Bracket
 *
 * by 4iqvmk, 2018-12-08
 * https://www.thingiverse.com/4iqvmk/about
 * 
 * Licenced under Creative Commons Attribution - Share Alike 4.0 
 *
 * version 1.00 - initial version
*/

/* [Hidden] */

inch2mm = 0.3048/12*1000;
mm2inch = 12/0.3048/1000;
$fn=30;

/* [Parameters] */

// mm
flangeThickness = 1.25;

// mm
flangeWidth = 6;

// mm
filletRadius = 2;

// mm
surroundHeight = 3.0;

// mm
surroundWidth = 1.5;

// mm
offsetDistance = 0;

// mm
tolerance = 0.05; // [0:0.01:0.2]

maskEdge = 1;  // [0: false, 1: true]

/* [Beam Angles] */

// deg, or -1 to disable
beam1Angle = 0;

// deg, or -1 to disable
beam2Angle = 30;

// deg, or -1 to disable
beam3Angle = 90;

// deg, or -1 to disable
beam4Angle = 150;

// deg, or -1 to disable
beam5Angle = 180;

// deg, or -1 to disable
beam6Angle = -1;

// deg, or -1 to disable
beam7Angle = -1;

// deg, or -1 to disable
beam8Angle = -1;

/* [Beam Widths] */

// mm, or -1 to disable
beam1Width = 4.5;

// mm, or -1 to disable
beam2Width = 3;

// mm, or -1 to disable
beam3Width = 3;

// mm, or -1 to disable
beam4Width = 3;

// mm, or -1 to disable
beam5Width = 4.5;

// mm, or -1 to disable
beam6Width = 3;

// mm, or -1 to disable
beam7Width = 3;

// mm, or -1 to disable
beam8Width = 3;


/* [Flange Lengths] */

// mm, or -1 to disable
beam1Length = 30;

// mm, or -1 to disable
beam2Length = 25;

// mm, or -1 to disable
beam3Length = 20;

// mm, or -1 to disable
beam4Length = 25;

// mm, or -1 to disable
beam5Length = 30;

// mm, or -1 to disable
beam6Length = 30;

// mm, or -1 to disable
beam7Length = 30;

// mm, or -1 to disable
beam8Length = 30;

/* [Hidden] */

/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////
allAngles = [beam1Angle, beam2Angle, beam3Angle, beam4Angle, beam5Angle, beam6Angle, beam7Angle, beam8Angle];
allWidths = [beam1Width, beam2Width, beam3Width, beam4Width, beam5Width, beam6Width, beam7Width, beam8Width];
allLengths = [beam1Length, beam2Length, beam3Length, beam4Length, beam5Length, beam6Length, beam7Length, beam8Length];

makeTruss(allAngles, allWidths, allLengths, flangeThickness, flangeWidth, filletRadius, surroundHeight, surroundWidth, offsetDistance, tolerance, maskEdge);


module makeTruss(allAngles, allWidths, allLengths, flangeThk, flangeWid, filletRad, surroundHgt, surroundWid, offsetDist, tol, maskEdge) {
    
    iBeam = [ for (k = [0:len(allAngles)-1]) (allAngles[k]>=0 && allWidths[k] > 0 && allLengths[k] > 0) ? true : false ];
        
    beamAngles = [ for (k = [0:len(allAngles)-1]) if (iBeam[k]) allAngles[k]];
    beamWidths = [ for (k = [0:len(allAngles)-1]) if (iBeam[k]) allWidths[k]];
    beamLengths = [ for (k = [0:len(allLengths)-1]) if (iBeam[k]) allLengths[k]];

    nBeams = len(beamAngles);

    beams = [ for (k=[0:nBeams-1]) [beamAngles[k], beamWidths[k], beamLengths[k]] ];

    fullBeams = [ for (k=[0:nBeams-1]) [beamAngles[k], beamWidths[k]+2*flangeWid+2*tol, beamLengths[k]] ];
        
    fullSurround = [ for (k=[0:nBeams-1]) [beamAngles[k], beamWidths[k] + 2*surroundWid + 2*tol, beamLengths[k]] ];

    iMin = index_min(beamAngles);
    iMax = index_max(beamAngles);

    beamA = beams[iMin];
    beamB = beams[iMax];

    maxLength = max(beamLengths);
    maxWidth = max(beamWidths);

    difference() {
        
        union() {
        
            if (maskEdge) {
                union() {
                    difference() {
                        makeFlange(fullBeams, flangeThk, filletRad);
                        outerMask(beamA, beamB, filletRad, offsetDist, maxLength, flangeThk, surroundHgt, maxWidth*1.5);
                    }
                    difference() {
                        makeFlange(fullSurround, flangeThk+surroundHgt, filletRad);
                        outerMask(beamA, beamB, filletRad, min(offsetDist,0), maxLength, flangeThk, surroundHgt, maxWidth*1.5);
                    }
                }
            } else {
                makeFlange(fullBeams, flangeThk, filletRad);
                makeFlange(fullSurround, flangeThk+surroundHgt, filletRad);
            }
        }

        makeBeamMask(beams, flangeThk, surroundHgt, filletRad, tol);
    }
}

module makeFlange(beam, height, filletRad) {
    linear_extrude(height = height) {
        soften_profile(radius=filletRad) {
            union() {
                for (k = [0:len(beam)-1]) {
                    flangeLeg(beam[k]);
                }
            }
        }
    }
}


module makeBeamMask(beam, flangeT, surroundH, filletR, tol) {
    translate([0, 0, flangeT]) {
        linear_extrude(height = 2*surroundH) {
            soften_profile(radius=filletR) {
                union() {
                    for (k = [0:len(beam)-1]) {
                        beamMask(beam[k], tol);
                    }
                }
            }
        }
    }
}


module flangeLeg(b) {
    
    angle = b[0];
    width = b[1];
    length = b[2];
    
    if (angle>=0) {
        rotate(a=angle, v=[0,0,1]) {
            union() {
                translate([length/2, 0, 0]) {
                    square([length, width], true);
                }
                circle(r=width/2);
            }
        }
    }
}


module beamMask(b, tol) {

    angle = b[0];
    width = b[1];
    length = b[2];

    if (angle>=0) {
        rotate(a=angle, v=[0,0,1]) {
            union() {
                translate([length, 0, 0]) {
                    square([length*2, width+tol], true);
                }
                circle(r=width/2);
            }
        }
    }
}


// remove the outside edge if selected
module outerMask(beamA, beamB, rad, off, maxLength, flangeT, surroundH, filletR) {

    r = 2*maxLength;
    n = 16;
    
    maxHeight = flangeT + surroundH;
    
    // angle half way from beamB around to beamA
    intAngle = wrap(0.5 * wrap360(beamA[0] - beamB[0]) + beamB[0]);
    
    // shift distance for mask
    
    linear_extrude(height = 4*maxHeight, center=true) {
    
        soften_profile(radius=filletR) {
            union() {

                dxyA = (beamA[1]/2 + off) / abs(sin(0.5*wrap(beamA[0] - beamB[0])));

                dxyB = (beamB[1]/2 + off) / abs(sin(0.5*wrap(beamA[0] - beamB[0])));

                translate([dxyA*cos(intAngle), dxyA*sin(intAngle), 0]) {
                    
                    for (k=[0:n-1]) {
                        
                        // intermediate angles from beamB around to beamA in n increments
                        intAngle0 = wrap(k/n * (wrap360(beamA[0] - intAngle)) + intAngle);
                        intAngle1 = wrap((k+1)/n * (wrap360(beamA[0] - intAngle)) + intAngle);
                        
                        polygon(points = [ [0,0], [r*cos(intAngle0), r*sin(intAngle0)], [r*cos(intAngle1), r*sin(intAngle1)],  [0,0]]);
                    }
                }
                translate([dxyB*cos(intAngle), dxyB*sin(intAngle), 0]) {
                    
                    for (k=[0:n-1]) {
                        
                        // intermediate angles from beamB around to beamA in n increments
                        intAngle0 = wrap(k/n * (wrap360(intAngle - beamB[0])) + beamB[0]);
                        intAngle1 = wrap((k+1)/n * (wrap360(intAngle - beamB[0])) + beamB[0]);
                        
                        polygon(points = [ [0,0], [r*cos(intAngle0), r*sin(intAngle0)], [r*cos(intAngle1), r*sin(intAngle1)],  [0,0]]);
                    }
                }
            }
        }
    }
}


function wrap(a) = atan2(sin(a), cos(a));


function wrap360(a) = wrap(a) - 360*floor(wrap(a)/360);


function index_min(x) = search(min(x), x)[0];


function index_max(x) = search(max(x), x)[0];


module soften_profile(radius) {
    offset(r=-0.5*radius) {
        offset(r=1.0*radius) {
            offset(r=-0.5*radius) {
                children();
            }
        }
    }
}

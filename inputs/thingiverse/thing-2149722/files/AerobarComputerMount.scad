//diameter of the bar onto which the clamp will be mounted
clampInnerDia = 22.3;
//thickness of the clamp wall wrapping around the bar
clampWallThick = 4;
//width of the clamp (ie, front-to-back, along the length of the bar) (bear in mind that this width must be greater than the bolt head and nut diameters, as they are countersunk into the clamp)
clampWidth = 12;

//length of the flat section of the arm - must be long enough to accomodate the needed adapterLen
armLen = 30;
//height of the arm (and bolt block)
armHt = 10;
//angle needed to achieve the depth above (negative angle) or below (positive angle) the bar that you need the arm to be (take into account the adapterHt value)
armAngle = 20;

//thickness of the gap between the nut and bolt blocks
blockGapThick = 3;
//width of the nut and bolt blocks (ie, distance from clamp toward arm
blockWidth = 10;
//height (thickness) of the nut block
nutBlockHt = 7;

//diameter of bolt head inset (use bolt head diameter plus 1-2mm) - must be a sensible value, as compared to clampWidth
boltHeadDia = 8;
//height of the clamp bolt head (ie, depth of the bolt head countersink)
boltHeadInset = 4; 
//diameter of the shank of the bolt
boltShankDia = 4;

//circular diameter of the nut, plus about 1mm (for a 6-sided nut, the distance between 2 opposite corners on the nut, plus a little)
nutDia = 10;
//depth of the nut countersink - must be a sensible value, as compared to nutBlockHt
nutInset = 3.5;

//length of the round adapter that fits on the arm - must be long enough for bands, ties, etc that hold your computer mount on
adapterLen = 30;
//outside diameter of the adapter - such that your computer mount will sit on it well
adapterDia = 25;
//height above the top, flat surface of the arm, that the top of the adapter should be
adapterHt = 5;
//if your aerobar is at an angle, where you'll be mounting the clamp, it can cant the arm one way or the other (so your computer would sit crooked) - this allows some compensation for that, if needed
adapterAngle = 0;

adapterStrapChannelSpacing = 15.5;
adapterStrapChannelWidth = 4;
adapterStrapChannelDepth = 2;

//printers tend to over-size exterior dimensions a bit, and correspondingly undersize interior dimensions, so this
// fudge factor widens and deepens the slot in the adapter, to allow the adapter to fit onto the arm better
//use this if/as needed for your printer. Set to total mm extra width needed.
adapterInteriorFudgeFactor = .8;

//enable/disable generation of the clamp - in case only want to print one or the other
generateClamp = true;
//enable/disable generation of the adapter - in case only want to print one or the other
generateAdapter = true;

//orientation for placement of adapter on print surface - 0 = vertical, 90 = horizontal (just for printing/plating purpose)
adapterPrintOrientation = 90;

$fn=50;

if (generateClamp) {
    clamp();
}
if (generateAdapter) {
    adapter();
}

//generates the adapter body, which sits on the arm, and allows the computer mount to sit on a bar-like surface
module adapter() {
    //this inset allows room for the corners of the arm to sit all the way up in the adapter
    // as well as provides a little more spring in the sides of the adapter, so that it can more firmly grip the arm
    // once attachment straps or bands are put around it and the arm
    blockCornerInsetDia = 5;
    
    //move away from orgin, so won't collide with clamp
    translate([0, 1.5*adapterDia, 0]) {
        rotate([0, adapterPrintOrientation, 0]) {
            //remove lower part of body, that would sit below bottom of arm
            difference() {
                //adapter body, minus arm slot and strap channels
                difference() {
                    //body of the adapter
                    cylinder(d=adapterDia, h=adapterLen);
                    //cutout for the arm - includes the arm cutout, the fudge factor and the corner insets
                    translate([armHt/2 - adapterDia/2 + adapterHt, 0, adapterLen/2]) {
                        rotate([adapterAngle, 0, 0]) {
                            //arm cutout with corner insets
                            union() {
                                cube([armHt + adapterInteriorFudgeFactor/2, clampWidth + adapterInteriorFudgeFactor, adapterLen*2], center=true);
                                translate([-armHt/2 - adapterInteriorFudgeFactor/2 + blockCornerInsetDia/4, -clampWidth/2 - adapterInteriorFudgeFactor/2 + blockCornerInsetDia/4, 0]) {
                                    cylinder(d=blockCornerInsetDia, h=adapterLen*2, center=true);
                                }
                                translate([-armHt/2 - adapterInteriorFudgeFactor/2 + blockCornerInsetDia/4, clampWidth/2 + adapterInteriorFudgeFactor/2 - blockCornerInsetDia/4, 0]) {
                                    cylinder(d=blockCornerInsetDia, h=adapterLen*2, center=true);
                                }
                            }
                        }
                    }
                    //strap channel cutouts - spaced 1/2 of adapterStrapChannelWidth from center of adapter length
                    translate([-adapterDia/2, -adapterDia/2, adapterLen/2 - adapterStrapChannelSpacing/2 - adapterStrapChannelWidth/2]) {
                        cube([adapterDia, adapterStrapChannelDepth, adapterStrapChannelWidth]);
                    }
                    translate([-adapterDia/2, -adapterDia/2, adapterLen/2 + adapterStrapChannelSpacing/2 - adapterStrapChannelWidth/2]) {
                        cube([adapterDia, adapterStrapChannelDepth, adapterStrapChannelWidth]);
                    }
                    translate([-adapterDia/2, adapterDia/2 - adapterStrapChannelDepth, adapterLen/2 - adapterStrapChannelSpacing/2 - adapterStrapChannelWidth/2]) {
                        cube([adapterDia, adapterStrapChannelDepth, adapterStrapChannelWidth]);
                    }
                    translate([-adapterDia/2, adapterDia/2 - adapterStrapChannelDepth, adapterLen/2 + adapterStrapChannelSpacing/2 - adapterStrapChannelWidth/2]) {
                        cube([adapterDia, adapterStrapChannelDepth, adapterStrapChannelWidth]);
                    }
                    
                }
                
                //cube to remove the lower part of the adapter body
                translate([-adapterDia/2 + adapterHt + armHt, -adapterDia/2, 0]) {
                    cube([adapterDia, adapterDia, adapterLen]);
                }
            }
        }
    }
}

//produce the clamp/arm assembly
module clamp() {
    ring();
    boltBlock();
    nutBlock();
    arm();
}

//generate a 6-sided pocket for the nut
module nutPocket() {
    hull() {
        for (a=[0:60:359]) {
            nutPoint(a);
        }
    }
}

//generates each corner point of the nut, which are then hulled together to construct the nut inset
module nutPoint(angle) {
    rotate([0, 0, angle]) {
        translate([nutDia/2, 0, 0]) {
            rotate([0, 0, 45]) {
                cylinder(d=.5, h=nutInset, center=true);
            }
        }
    }
}

//generate the clamp ring, including the clamp gap
module ring() {
    //difference gap from ring
    difference() {
        //outer - inner cylinder create ring
        difference() {
            cylinder(r=clampInnerDia/2 + clampWallThick, h = clampWidth);
            cylinder(d=clampInnerDia, h=clampWidth);
        }
        //generate the gap as a block
        translate([clampInnerDia/2 - .1*clampWallThick, -blockGapThick, 0]) {
            cube([1.2*clampWallThick, blockGapThick, clampWidth]);
        }
    }
}

//generate the nut block
module nutBlock() {
    //nut block minus the nut pocket and the bolt shank
    difference() {
        //the nut block itself
        translate([clampInnerDia/2, -nutBlockHt - blockGapThick, 0]) {
            cube([blockWidth + clampWallThick, nutBlockHt, clampWidth]);
        }
        //combination of nut inset and bolt shank holes
        union() {
            //move the nut pocket to the center of the nut block bottom face
            translate([clampInnerDia/2 + clampWallThick + blockWidth/2 - boltShankDia/2, -nutInset/2 - blockGapThick - nutBlockHt + nutInset, clampWidth/2]) {
                //generate and orient nut pocket so flat sides are parallel to block sides
                rotate([90, 0, 0]) {
                    nutPocket();
                }
            }
            
            //generate bolt shank hole, and move it to the center of the nut block top/bottom faces
            translate([clampInnerDia/2 + clampWallThick + blockWidth/2 - boltShankDia/2, -blockGapThick - nutBlockHt/2, clampWidth/2]) {
                rotate([90, 0, 0]) {
                    cylinder(d=boltShankDia, h=nutBlockHt, center=true);
                }
            }
        }
    }
}

//generate the bolt block - this is both the block for the bolt, as well as the point to which the arm will attach
module boltBlock() {
    //bolt block minus the bolt head pocket and the bolt shank
    difference() {
        //the bolt block itself
        translate([clampInnerDia/2, 0, 0]) {
            cube([blockWidth + clampWallThick, armHt, clampWidth]);
        }
        //combination of the bolt head pocket and bolt shank
        union() {
            //generate and move the bolt head pocket to the top surface of the bolt block
            translate([clampInnerDia/2 + clampWallThick + blockWidth/2 - boltShankDia/2, boltHeadInset/2 + armHt - boltHeadInset, clampWidth/2]) {
                rotate([90, 0, 0]) {
                    cylinder(d=boltHeadDia, h=boltHeadInset, center=true);
                }
            }
            
            //generate bolt shank hole, and move it to the center of the bolt block top/bottom faces
            translate([clampInnerDia/2 + clampWallThick + blockWidth/2 - boltShankDia/2, armHt/2, clampWidth/2]) {
                rotate([90, 0, 0]) {
                    cylinder(d=boltShankDia, h=armHt, center=true);
                }
           }
        }
    }
}

//generate the arm - it will attach at the top, outside edge of the bolt block, at the specified angle, and any gap resulting from the angle will be filled in
module arm() {
    //union the arm and the gap filling geometry
    union() {
        //move the rotated arm to top, outer edge of the bolt block
        translate([clampInnerDia/2 + clampWallThick + blockWidth, armHt, 0]) {
            //rotate the arm to the desired angle
            rotate([0, 0, armAngle]) {
                //the arm itself
                translate([0, -armHt, 0]) {
                    cube([armLen, armHt, clampWidth]);
                }
            }
        }
        
        //fill in the gap, resulting from any specified angle between the arm and the bolt block
        // (do this by just creating 3 small geometries at each corner of the gap, and then hull them together
        hull() {
            //small rectangle sitting at the lower, outside corner of the bolt block, running from top to bottom (as arm sits on plane)
            translate([clampInnerDia/2 + clampWallThick + blockWidth, 0, 0]) {
                cube([.1, .1, clampWidth]);
            }
            //small rectangle sitting at the lower, inner corner of the arm, running from top to bottom (as arm sits on plane)
            //roate and translate it the same way that the arm was, so it ends up in right place
            translate([clampInnerDia/2 + clampWallThick + blockWidth, armHt, 0]) {
                rotate([0, 0, armAngle]) {
                    translate([-.1, -armHt, 0]) {
                        cube([.1, .1, clampWidth]);
                    }
                }
            }
            //cmall cylinder, sitting at joint of bolt block and arm, recessed so as not to protrude above top of bolt block and arm
            translate([clampInnerDia/2 + clampWallThick + blockWidth, armHt - .05, clampWidth/2]) {
                cylinder(d=.1, h=clampWidth, center=true);
            }
        }
    }
}


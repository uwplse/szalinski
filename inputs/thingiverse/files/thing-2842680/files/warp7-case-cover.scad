
coverWidth=42;
coverHeight=42;
coverDepth=10;
caseDepth=7.5;

coverBoardWidth=38.8;
coverBoardHeight=38.8;
coverBoardDepth=8;
caseBoardDepth=5.5;
floatStickDepth = 3.5;

powerHoleR = 2.9;
powerHoleShift = 4.5;

usbHoleHeight = 3.8;
usbHoleWidth= 9.8;
usbHoleShift = 11;
usbHoleZShift = 5;
usbCaseHoleShift = 11;
usbCaseHoleZShift = 2.75;

buttonHoleWidth = 3.0;
buttonHoleHeight = 2.0;
buttonHoleShift = [1.8, 18.5, 33.6];
buttonHoleZShift = 2.5;

mikroBUSHeight = 22.05;
mikroBUSWidth = 3.3;
mikroBUSXShift = 4.2;
mikroBUSXShiftAdd = 22.5;
mikroBUSYShift = 5.5;

cameraHoleR = 3.65;
cameraHoleXShift=0.5;
cameraHoleYShift=0.5;

cpuHoleWidth = 12.5;
cpuHoleHeight = 12.5;
cpuHoleX = 10.5;
cpuHoleY = 12.7;

part = "both"; // [cover:cover only,case:case only,both:cover and case]

module obj0x01 () {
}

caseWidth = coverWidth;
caseHeight = coverHeight;
caseBoardWidth = coverBoardWidth;
caseBoardHeight = coverBoardHeight;
usbHoleZShiftLeft = max(coverDepth-usbHoleZShift-usbHoleHeight, 0);
buttonHoleZShiftLeft = max(coverDepth-buttonHoleZShift-buttonHoleHeight, 0);

module cover() {
    union() {
        difference() {
            cube([coverWidth,coverHeight,coverDepth]);
            translate([(coverWidth-coverBoardWidth)/2, (coverHeight-coverBoardHeight)/2, coverDepth-coverBoardDepth]) {
                cube([coverBoardWidth, coverBoardHeight, coverBoardDepth+1]);
            }
            // power hole
            translate([(coverWidth-coverBoardWidth)/2+coverBoardWidth-1, (coverHeight-coverBoardHeight)/2+coverBoardHeight-powerHoleShift, coverDepth]) {
                rotate([0,90,0]) {
                    cylinder(r=powerHoleR, h=(coverWidth-coverBoardWidth)/2+2, $fn=getFN(powerHoleR));
                }
            }
            // usb
            translate([(coverWidth-coverBoardWidth)/2+coverBoardWidth-usbHoleShift,-1,coverDepth-usbHoleZShift]) {
                cube([usbHoleWidth, coverHeight-coverBoardHeight+2, usbHoleHeight+usbHoleZShiftLeft+1]);
            }
            // buttons
            for (i = buttonHoleShift) {
                translate([-1, (coverHeight-coverBoardHeight)/2+i, coverDepth-buttonHoleZShift]) {
                    cube([(coverWidth-coverBoardWidth)/2+2,buttonHoleWidth, buttonHoleHeight+buttonHoleZShiftLeft+1]);
                }
            }
            // mikroBUS
            translate([(coverWidth-coverBoardWidth)/2+mikroBUSXShift, (coverHeight-coverBoardHeight)/2+coverBoardHeight-mikroBUSHeight-mikroBUSYShift, -1]) {
                cube([mikroBUSWidth,mikroBUSHeight, coverDepth-coverBoardDepth+2]);
            }
            translate([(coverWidth-coverBoardWidth)/2+mikroBUSXShift+mikroBUSXShiftAdd, (coverHeight-coverBoardHeight)/2+coverBoardHeight-mikroBUSHeight-mikroBUSYShift, -1]) {
                cube([mikroBUSWidth,mikroBUSHeight, coverDepth-coverBoardDepth+2]);
            }
            // latch
            translate([(coverWidth-coverBoardWidth)/4,(coverHeight-coverBoardHeight)/4,coverDepth-1]) {
                cube([(coverWidth+coverBoardWidth)/2, (coverHeight+coverBoardHeight)/2, 1+1]);
            }
        }
        translate([(coverWidth-coverBoardWidth)/2, (coverHeight-coverBoardHeight)/2+coverBoardHeight-2, 0]) {
            cube([2,2,coverDepth-floatStickDepth]);
        }
        translate([(coverWidth-coverBoardWidth)/2+coverBoardWidth-2, (coverHeight-coverBoardHeight)/2+coverBoardHeight-2, 0]) {
            cube([2,2,coverDepth-floatStickDepth]);
        }
        translate([(coverWidth-coverBoardWidth)/2+coverBoardWidth/3, (coverHeight-coverBoardHeight)/2, 0]) {
            cube([2,2,coverDepth-floatStickDepth]);
        }
    }
}
module case() {
    union() {
        difference() {
            union() {
                cube([caseWidth,caseHeight,caseDepth]);
                // latch
                translate([(caseWidth-caseBoardWidth)/4,(caseHeight-caseBoardHeight)/4,0]) {
                    cube([(caseWidth+caseBoardWidth)/2, (caseHeight+caseBoardHeight)/2, caseDepth+1]);
                }
            }
            translate([(caseWidth-caseBoardWidth)/2, (caseHeight-caseBoardHeight)/2, caseDepth-caseBoardDepth]) {
                cube([caseBoardWidth, caseBoardHeight, caseBoardDepth+2]);
            }
            // power hole
            translate([-1, (caseHeight-caseBoardHeight)/2+caseBoardHeight-powerHoleShift, caseDepth]) {
                rotate([0,90,0]) {
                    cylinder(r=powerHoleR, h=(caseWidth-caseBoardWidth)/2+2, $fn=getFN(powerHoleR));
                }
            }
            // camera hole
            translate([(caseWidth-caseBoardWidth)/2+caseBoardWidth-cameraHoleR-cameraHoleXShift,(caseHeight-caseBoardHeight)/2+cameraHoleR+cameraHoleYShift,-1]) {
                cylinder(r=cameraHoleR, h=caseDepth-caseBoardDepth+2, $fn=getFN(cameraHoleR));
            }
            // usb
            translate([(caseWidth-caseBoardWidth)/2+caseBoardWidth-usbCaseHoleShift,(caseHeight-caseBoardHeight)/2+caseBoardHeight-1,caseDepth-usbCaseHoleZShift]) {
                cube([usbHoleWidth, caseHeight-caseBoardHeight+2, usbHoleHeight]);
            }
            // cpu
            translate([(caseWidth-caseBoardWidth)/2+caseBoardWidth-cpuHoleWidth-cpuHoleX,(caseHeight-caseBoardHeight)/2+cpuHoleY,-1]) {
                cube([cpuHoleWidth, cpuHoleHeight, caseDepth-caseBoardDepth+2]);
            }
        }
        for (i= [cpuHoleWidth/4 : cpuHoleWidth/4 : cpuHoleWidth*4/5]) {
            translate([(caseWidth-caseBoardWidth)/2+caseBoardWidth-cpuHoleWidth-cpuHoleX-0.4+i, (caseHeight-caseBoardHeight)/2+cpuHoleY-0.1, 0]) {
                cube([0.8, cpuHoleHeight+0.2, 0.6]);
            }
        }
        for (i= [cpuHoleHeight/4 : cpuHoleHeight/4 : cpuHoleHeight*4/5]) {
            translate([(caseWidth-caseBoardWidth)/2+caseBoardWidth-cpuHoleWidth-cpuHoleX-0.1, (caseHeight-caseBoardHeight)/2+cpuHoleY-0.4+i, 0]) {
                cube([cpuHoleWidth+0.2, 0.8, 0.6]);
            }
        }
    }    
}

if (part == "cover") {
    cover();
} else if (part == "case") {
    case();
} else {
    translate([-coverWidth-5,0,0]) {
        cover();
    }
    case();
}

/**
 * getFN() - get $fn by computing the r and err.
 *
 * We don't need to set $fn to 100 always. Instead, we calculate
 * the distance between the polygon and the circle. Make sure the
 * maximum distance between the polygon and the circle is less
 * than err.
 *
 * Mathmatical induction as following:
 *  theta = 360/fn/2
 *  err = r - r cos (theta)
 *   =>
 * err = r(1-cos(360/fn/2))
 * err/r = 1-cos(360/fn/2)
 * cos(360/fn/2) = 1-err/r
 * 180/fn = acos(1-err/r)
 * fn = 180.0/acos(1-err/r)
 *
 * @param r the radius
 * @param err the error between the circle and the polygon
 * @return the minimum $fn that can be used. We restrict the return value to be 10 <= $fn <= 100 to make openscad happy.
 */
function getFN(r, err=0.05) = max(min(ceil(180.0/acos(1-err/r)),100),10);

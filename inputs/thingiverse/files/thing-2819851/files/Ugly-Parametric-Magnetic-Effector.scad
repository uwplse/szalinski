// Rod's Universal [aka Ugly] Magnetic Effector
//
// Highly parametric effector design with optional features
//
// Distributed under the terms of the Creative Commons
// Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) license
// https://creativecommons.org/licenses/by-sa/3.0/

// Select optional features here....
makeSensorMount = false; // mount for inductive sensor
makeWireTieDown = false; // loop for zip-tieing wires to top of effector
makeSupports = true; // support cylinders to obviate slicer supports
recycleNum = 0; // display recycling logo with specified number:
                // 0 = omit recycling symbol
                // 1 = PET/PETG
                // 9 = ABS (according to some sources)
                // 7 = all other plastics

// Select which major components to build....
makeEffector = 1;
makeLock = 1;
makeCentrifugalFanShroud = 1;
makeBoxFanShroud = 0;

// Options for the hot end....
// NOTE: Two hotends are defined via included files. To use a
// predefined hot end, uncomment one of the below lines (remove
// the leading "//" characters) and comment out the ones you
// don't want to use. To modify a configuration, edit its file
// or copy it to another file, modify it, and include it below....
include <e3dv6.scad>
//include <hexagon.scad>
//include <hexagon-clone.scad>

// Base effector parameters....
// NOTE: Reducing baseLength reduces the tip-to-ball distance,
// which increases stability. Likewise, increasing ballDistance
// increases stability. Beyond a point, though, these changes
// produce an unusable effector because of part overlap. Also,
// increasing baseLength produces thicker parts, which can
// improve rigidity.
thickness = 6; // thickness of main body
topThickness = 3; // thickness of the top of the effector's "roof"
baseLength = 51; // size of each side of the base triangle
ballDistance = 51; // distance between ball mounts
baseAltitude = sqrt(pow(baseLength, 2) - pow(baseLength/2, 2));
triangleCenter = baseLength / sqrt(3) / 2;

// Variables relating to the placement of the mount for the
// inductive bed-height sensor....
sensorDiameter = 13.2;
sensorBrimDiameter = 20;
sensorXPos = sin(60) * -(triangleCenter + ((sensorBrimDiameter+sensorDiameter)/4));
sensorYPos = cos(60) * (triangleCenter + ((sensorBrimDiameter+sensorDiameter)/4));

// Options affecting magnetic balls and their mounts....
studBaseAngle = 35; // Angle of the ball mounts
studBaseHeight = 15; // Height of the ball mounts
ballDiameter = 14; // Diameter of the ball mounts
holeDiameter = 3.25; // Diameter of the stud hole
//nutDiameter = 7.5; // Diameter of the nut hole
nutDepth = 11; // Depth of the nut hole (from base that's partially removed)

// Uncomment & set below line to override option from hotend file....
//heFanSize = 30; // Hot end fan size
heFanMountThickness = 5; // Thickness of MOUNT for hot end fan
fanHoleOffset = 3; // Offset of screw holes for hot end fan
fanScrewDepth = 5; // Minimum depth of fan screw holes
columnDiameter = 6;
columnDistance = hotEndDiameter/2 + columnDiameter/2;
sideColumnX = sin(60) * columnDistance;
sideColumnY = sqrt(pow(columnDistance, 2) - pow(sideColumnX, 2));

// Variables related to the part cooling fan duct....
torusRadius = 4; // radius of the circle that's extruded into the fan duct
partFanDuctRadius = hotEndDiameter/2 + torusRadius+4; // extruded radius
centrifugalFanHeight = 50;
centrifugalFanWidth = 15.1;
centrifugalFanMountDepth = 15;
centrifugalFanScrewY = 6; // distance from top fan screw hole to vertical alignment
centrifugalFanScrewZ = 48; // distance from top fan screw hole to base
boxFanDuctWidth = 18;
boxFanDuctDepth = 15;
boxFanWidth = 40;
boxFanMountDepth = 12;
boxFanExtraClearance = 6; // extra vertical height to clear hotend
fanMountWidth = 28;
fanShellThickness = 2.2;
fanAttachmentHeight = hotEndHeatBlock - 2; // fan duct 2mm above tip
fanBlowerHeight = 12; // height at which fan mount deepens

// Variables related to screws....

// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 7.25; //6.1 for 1515
m3_nut_radius = m3_nut_od/2 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

$fn=32;

// ============================================================
//
// Main section; build everything....
//
// ============================================================

if (makeEffector)
    effector();
if (makeLock)
    translate([(baseLength + 10) * makeEffector, 0, 0])
        lock();
if (makeCentrifugalFanShroud)
    translate([(baseLength + 10) * makeEffector + ((sideColumnX*2)+10)*makeLock,0,0])
        centrifugalFan();
if (makeBoxFanShroud)
    translate([(baseLength + 10) * makeEffector + ((sideColumnX*2)+10)*makeLock + (partFanDuctRadius*2 + 10) * makeCentrifugalFanShroud,0,0])
        boxFan();

//translate([0, 100, 0]) fanMount(40, 50, 5, 35, 35, true);

// ============================================================
//
// Miscellaneous support modules....
//
// ============================================================

use <recycling_symbol.scad>

module write(mytext, h) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = h) {
		text(mytext, size = 5, font = "Arial", halign = "center", valign = "center", $fn = 32);
	}
}

module recycleLogo(height) {
    recycling_symbol("", 10, height, $fn=40);
    write(str(recycleNum), height);
}

module fanScrewHoles(width, height, depth, screwSpacing) {
    xLeftScrew = (width - screwSpacing) / 2;
    xRightScrew = width - xLeftScrew;
    zBottomScrew = (height - screwSpacing) / 2;
    zTopScrew = height - zBottomScrew;

    translate([xLeftScrew, depth+1, zTopScrew]) rotate([90, 0, 0])
        cylinder(r=m3_radius, h=depth+2);
    translate([xLeftScrew, depth+1, zBottomScrew]) rotate([90, 0, 0])
        cylinder(r=m3_radius, h=depth+2);
    translate([xRightScrew, depth+1, zTopScrew]) rotate([90, 0, 0])
        cylinder(r=m3_radius, h=depth+2);
    translate([xRightScrew, depth+1, zBottomScrew]) rotate([90, 0, 0])
        cylinder(r=m3_radius, h=depth+2);
} // fanScrewHoles()

module fanMount(width, height, depth, diam, screwSpacing, rounded) {
    xLeftScrew = (width - screwSpacing) / 2;
    xRightScrew = width - xLeftScrew;
    zBottomScrew = (height - screwSpacing) / 2;
    zTopScrew = height - zBottomScrew;
    difference() {
        if (rounded)
            roundedCube(width, depth, height, 2);
        else
            cube([width, depth, height]);
        fanScrewHoles(width, height, depth, screwSpacing);
        translate([width/2, depth+1, height/2]) rotate([90,0,0]) 
            cylinder(d=diam, h=depth+2);
    }
} // fanMount()

module roundedCube(x, y, z, r) {
    hull() {
        translate([r, r, r]) sphere(r=r);
        translate([x-r, r, r]) sphere(r=r);
        translate([r, y-r, r]) sphere(r=r);
        translate([x-r, y-r, r]) sphere(r=r);
        translate([r, r, z-r]) sphere(r=r);
        translate([x-r, r, z-r]) sphere(r=r);
        translate([r, y-r, z-r]) sphere(r=r);
        translate([x-r, y-r, z-r]) sphere(r=r);
    }
}

// Create half a torus.
// revRadius = radius of the whole torus
// cirRadius = radius of circle that's extruded into the torus
// hullIt = false to create a torus from a circle; true to use a
//          hull of two circles
// fn = $fn
module halfTorus(revRadius, cirRadius, hullIt, fn) {
    $fn=fn;
    xLimit = revRadius + cirRadius;
    difference() {
        rotate_extrude(convexity = 10) translate([revRadius, 0, 0]) {
            if (hullIt) {
                hull() {
                    translate([-cirRadius*1.5, -cirRadius*3/4]) circle(r=cirRadius/4);
                    circle(r = cirRadius);
                }
            } else {
                circle(r = cirRadius);
            }
        }
        translate([-xLimit, -xLimit, -cirRadius*1.5])
            cube([xLimit*2, xLimit, cirRadius*3]);
    }
} // halfTorus()

// Build a triangular piece with rounded edges. This module is used
// as the basis for both the lock/nut and the top of the effector.
module hotEndCap(high, raised) {
    translate([0, 0, raised])  hull() {
        linear_extrude(height = high) polygon(points = [[sideColumnX, -sideColumnY], [-sideColumnX, -sideColumnY], [0, columnDistance]]);
        translate([0, columnDistance, 0])
            cylinder(d=columnDiameter, h=high);
        translate([-sideColumnX, -sideColumnY, 0])
            cylinder(d=columnDiameter, h=high);
        translate([sideColumnX, -sideColumnY, 0])
            cylinder(d=columnDiameter, h=high);
    }
} // hotEndCap()

// ============================================================
//
// Part-cooling fan duct and fan mount
//
// ============================================================

// Structure with which fan shroud mounts to effector
module fanMountArm() {
    mountThickness = 3;
    difference() {
        translate([fanMountWidth/2,mountThickness,2]) rotate([90,0,0]) hull() {
            cylinder(r=2, h=mountThickness);
            translate([-(fanMountWidth)/2, fanAttachmentHeight, 0])
                cylinder(r=2, h=mountThickness);
            translate([(fanMountWidth)/2, fanAttachmentHeight, 0])
                cylinder(r=2, h=mountThickness);
            cylinder(r=2, h=mountThickness);
        }
        translate([m3_radius, mountThickness+1, fanAttachmentHeight+m3_radius]) rotate([90,0,0])
            #cylinder(r=m3_radius, h=mountThickness+2);
        translate([fanMountWidth-m3_radius, mountThickness+1, fanAttachmentHeight+m3_radius]) rotate([90,0,0])
            #cylinder(r=m3_radius, h=mountThickness+2);
    }
} // fanMountArm()

// Create a right-angle wedge with the specified dimensions
module raWedge(width, depth, height) {
    translate([width, 0, 0]) rotate([90,0,-90]) linear_extrude(width)
        polygon(points=[[0, 0], [0, height], [depth, 0]]);
} // raWedge()

// Create vertical mounting structure for centrifugal part-cooling
// fan....
module partFanMount() {
    fanPositionX = -(centrifugalFanWidth+fanShellThickness*2)/2;
    fanPositionY = partFanDuctRadius-torusRadius/2;
    partWidth = centrifugalFanWidth+2*fanShellThickness;

    difference() {
        union() {
            cube([partWidth,centrifugalFanMountDepth,centrifugalFanHeight+2*fanShellThickness]);
            translate([partWidth/2-fanMountWidth/2,0,0])
                fanMountArm();
            translate([0,0,fanShellThickness+1])
                raWedge(partWidth, torusRadius, fanBlowerHeight-fanShellThickness-1);
            if (recycleNum>0)
                translate([-fanPositionX,1,fanAttachmentHeight+15]) rotate([90,0,0])
                    recycleLogo(2);
        }
        // Cut a hole for air flow into the toroidal duct
        translate([-1,0,torusRadius]) rotate([0,90,0])
            cylinder(r=torusRadius-1.5, h=partWidth+2);
        // holes for mounting screw....
        translate([-1,centrifugalFanScrewY,centrifugalFanScrewZ+fanShellThickness]) rotate([0,90,0])
            cylinder(r=m3_radius*1.2, h=partWidth+2);
    }
} // partFanMount()

module fanDuctHole(angle) {
    translate([0,0,-(hotEndHeatBlock-fanAttachmentHeight)]) 
    rotate([0,78,angle]) 
        #cylinder(r=1.3,h=partFanDuctRadius);
} // fanDuctHole()

// Create the half-toroid portion of the fan duct
module partFanDuct() {
    fanPositionX = -(centrifugalFanWidth+fanShellThickness*2)/2;
    fanPositionY = partFanDuctRadius-torusRadius/2;
    trim = 1;
    difference() {
        union() {
            translate([0,0,torusRadius])
                halfTorus(partFanDuctRadius, torusRadius, true, 90);
            translate([partFanDuctRadius, 0, torusRadius]) hull() {
                sphere(torusRadius);
                translate([-torusRadius*1.5, 0, -torusRadius*3/4]) sphere(torusRadius/4);
            }
            translate([-partFanDuctRadius, 0, torusRadius]) hull() {
                sphere(torusRadius);
                translate([torusRadius*1.5, 0, -torusRadius*3/4]) sphere(torusRadius/4);
            }
        }
        translate([0,0,torusRadius])
            halfTorus(partFanDuctRadius, torusRadius-1.5, true, 32);
        translate([-partFanDuctRadius-torusRadius,-torusRadius,-trim]) 
            cube([partFanDuctRadius*2+torusRadius*2,partFanDuctRadius+torusRadius+centrifugalFanMountDepth+fanShellThickness, trim]);
        //vent ports cutout.
        for (a =[9:18:180]) {   
            fanDuctHole(a);
        } // for()
    } // difference()
} // partFanDuct();

// Build the entire fan assembly -- centrifugal fan type
module centrifugalFan() {
    difference() {
        union () {
            rotate([0,0,-30]) partFanDuct();
            translate([-(centrifugalFanWidth/2+fanShellThickness), partFanDuctRadius-torusRadius/2, 0])
                partFanMount();
            translate([-fanMountWidth/8,partFanDuctRadius-torusRadius/2,0])
                cube([fanMountWidth/4,centrifugalFanMountDepth,1]);
        }
        translate([-(centrifugalFanWidth/2), partFanDuctRadius-torusRadius/2+fanShellThickness, fanShellThickness])
            cube([centrifugalFanWidth, centrifugalFanMountDepth, centrifugalFanHeight+fanShellThickness+1]);
        translate([-centrifugalFanWidth/2,partFanDuctRadius+fanShellThickness,fanShellThickness])
            raWedge(centrifugalFanWidth, torusRadius+3, fanBlowerHeight);
    }
} // centrifugalFan()

// The vertical duct to hold the box fan and direct its airflow.
// Note: Called once to create a solid duct and again to hollow
// it out
module verticalDuct(bottomWidth, topWidth, depth, height, shrink) {
    cube([bottomWidth-shrink, depth-shrink, height-shrink]);
    translate([-topWidth/2+bottomWidth/2,0,height-topWidth])
        cube([topWidth-shrink, boxFanMountDepth-shrink, topWidth-shrink]);
} // verticalDuct()

// Build the entire fan assembly -- box fan type
// NOTE: Work in progress. Unusable as-is, since it blocks access
// to the hot end's feeder tube.
module boxFan() {
    boxFanDuctHeight = hotEndHeight+hotEndHeatBlock+boxFanWidth + boxFanExtraClearance;
    difference() {
        union() {
            rotate([0,0,-30]) partFanDuct();
            translate([-fanMountWidth/2,partFanDuctRadius-torusRadius/2,0])
                fanMountArm();
            translate([-boxFanDuctWidth/2, partFanDuctRadius-torusRadius/2, 0])
                verticalDuct(boxFanDuctWidth, boxFanWidth, boxFanDuctDepth, boxFanDuctHeight, 0);
            translate([-boxFanWidth/2, partFanDuctRadius-torusRadius/2-boxFanMountDepth, boxFanDuctHeight-boxFanWidth])
                fanMount(boxFanWidth, boxFanWidth, boxFanMountDepth, boxFanWidth-2, boxFanWidth-fanHoleOffset*2, false);
        }
        translate([-boxFanDuctWidth/2+fanShellThickness, partFanDuctRadius-torusRadius/2+fanShellThickness, fanShellThickness])
            #verticalDuct(boxFanDuctWidth, boxFanWidth, boxFanDuctDepth, boxFanDuctHeight, fanShellThickness*2);
        translate([0, partFanDuctRadius-torusRadius/2+fanShellThickness, boxFanDuctHeight-boxFanWidth/2]) rotate([90,0,0])
            cylinder(d=boxFanWidth-2, h=boxFanMountDepth+fanShellThickness+2);
    }
} // boxFan()

// ============================================================
//
// The effector as a whole (base plus cap)
//
// ============================================================

// Main section of the design. This creates the base, adds ball mounts,
// the hot end top, the part cooling fan duct, and the bed leveling
// sensor mount. It then drills holes for studs and for the hot end
// itself.
module effector() {
    fanHeight=max(heFanSize, hotEndHeight)/2;
    difference() {
        union() {
            base(thickness);
            ballMounts(studBaseAngle);
            rotate([0, 0, -120]) ballMounts(studBaseAngle);
            rotate([0, 0, 120]) ballMounts(studBaseAngle);
            hotEndTop();
            if (makeSensorMount)
                inductiveSensorMount();
        }
        studHoles(studBaseAngle);
        rotate([0, 0, -120]) studHoles(studBaseAngle);
        rotate([0, 0, 120]) studHoles(studBaseAngle);
        hotEndHole();
        rotate([0,0,120]) fanMountHoles();
        // Clean up the fan's airflow path....
        rotate([90,0,0]) translate([0, fanHeight, -1])
          cylinder(d=heFanSize - 3, h=hotEndDiameter/2 + 12);
        if (recycleNum>0)
            translate([0,18.5,2]) rotate([180,0,180])
                #recycleLogo(3);
        // Ensure fan screw holes are deep enough....
        translate([-heFanSize/2,-(hotEndDiameter/2 + heFanMountThickness),fanHeight-heFanSize/2])
            fanScrewHoles(heFanSize, heFanSize, fanScrewDepth,heFanSize-fanHoleOffset*2);
        }
//        rotate([90,0,0]) translate([
    if (makeSupports)
        capSupport();
} // effector()

// Screw holes for mounting the fan shroud
module fanMountHoles() {
    translate([-(fanMountWidth/2-m3_radius), -triangleCenter+5, thickness/2]) rotate([90,0,0])
        #cylinder(r=m3_radius, h=6);
    translate([fanMountWidth/2-m3_radius, -triangleCenter+5, thickness/2]) rotate([90,0,0])
        #cylinder(r=m3_radius, h=6);
} // fanMountHoles()

// ============================================================
//
// Cap for holding the top of the hot end and its cooling fan
//
// ============================================================

// Create a cylinder just a bit below the hot end cap, so obviate
// the need for slicer supports....
module capSupport() {
    midwayD = (hotEndDiameter + hotEndNeckMaxDiameter)/2;
    difference() {
        cylinder(d=hotEndNeckMaxDiameter+0.5, h=hotEndHeight-topThickness-0.3);
        cylinder(d=hotEndNeckMaxDiameter, h=hotEndHeight+hotEndHeight-topThickness+1);
    }
    difference() {
        cylinder(d=midwayD, h=hotEndHeight-topThickness-0.3);
        cylinder(d=midwayD-0.5, h=hotEndHeight-topThickness+1);
    }
} // capSupport()

// Build a mount and shroud for the hot end cooling fan. This module
// identifies whether the fan or the hot end mounting area is bigger
// and creates a mounting space to match the biggest of these, then
// cuts out holes for both airflow and mounting screws.
module hotEndFanShroud() {
    fanShroudX=max(heFanSize, sideColumnX * 2);
    fanShroudZ=max(heFanSize, hotEndHeight);
    difference() {
        union() {
            translate([-heFanSize/2, -(hotEndDiameter/2 + heFanMountThickness), 0])
                fanMount(fanShroudX, fanShroudZ, heFanMountThickness+hotEndDiameter/2, heFanSize - 3, heFanSize-fanHoleOffset*2, true);
            if (makeWireTieDown)
                translate([0, -((hotEndDiameter/2+2)), fanShroudZ-1]) rotate([90,0,0]) halfTorus(fanShroudX/3, 2, false, 64);
        }
        translate([-fanShroudX/2, -sideColumnY-columnDiameter/2, hotEndHeight])
            cube([fanShroudX, fanShroudX/2, topThickness+hotEndNeckHeight]);
    }
} // hotEndFanShroud

// This module creates the structure that links the effector's base to the
// mounting groove on the hot end. It calls hotEndFanShroud() and hotEndCap()
// to create the "back" where the fan mounts and the top, and also creates
// three columns to support the top. (Two columns are likely to be at least
// partially embedded in the fan shroud.) It then creates holes for the hot
// end itself and for screws to be used to lock the locking nut in place.
module hotEndTop() {
    difference() {
        union() {
            hotEndFanShroud();
            hotEndCap(topThickness, hotEndHeight-topThickness);
            translate([0, columnDistance, 0])
                cylinder(d=columnDiameter, h=hotEndHeight);
            translate([sideColumnX, -sideColumnY, 0])
                cylinder(d=columnDiameter, h=hotEndHeight);
            translate([-sideColumnX, -sideColumnY, 0])
                cylinder(d=columnDiameter, h=hotEndHeight);
        }
        // Make a hole for the top of the hot end....
//        translate([0, 0, topThickness])
            #cylinder(d=hotEndNeckMaxDiameter, h=hotEndHeight+thickness, $fn=64);
        // Makes holes for screws to hold the triangular cap in place....
        translate([0, columnDistance, hotEndHeight-thickness-hotEndNeckHeight+1])
            #cylinder(r=m3_radius, h=hotEndNeckHeight+6);
        translate([sideColumnX, -sideColumnY, hotEndHeight-thickness-hotEndNeckHeight+1]) 
            #cylinder(r=m3_radius, h=hotEndNeckHeight+6);
        translate([-sideColumnX, -sideColumnY, hotEndHeight-thickness-hotEndNeckHeight+1]) 
            #cylinder(r=m3_radius, h=hotEndNeckHeight+6);
    }
} // module hotEndTop();

module hotEndHole() {
    translate([0,0,-1])
        #cylinder(h=hotEndHeight-topThickness+1, d=hotEndDiameter);
}

module inductiveSensorMount() {
    difference() {
        translate([sensorXPos, sensorYPos, 0])
            cylinder(d=sensorBrimDiameter, h=thickness);
        translate([sensorXPos, sensorYPos, -1])
            cylinder(d=sensorDiameter, h=thickness+2, $fn=64);
    }
} // inductiveSensorMount();

// ============================================================
//
// The effector's base
//
// ============================================================

module base(thick) {
    translate([0, -triangleCenter, 0])
        linear_extrude(height = thick)
        polygon(points = [[baseLength/2, 0],
                          [-baseLength/2, 0],
                          [0, baseAltitude]]);
} // base

module studHoles(angle) {
    lowerIt=sin(angle) * (ballDiameter/2);
    translate([-ballDistance/2, -triangleCenter, -lowerIt]) rotate([angle, 0, 0])
        cylinder(h=studBaseHeight + 1, r=m3_radius);
    translate([ballDistance/2, -triangleCenter, -lowerIt]) rotate([angle, 0, 0])
        cylinder(h=studBaseHeight + 1, r=m3_radius);
    translate([-ballDistance/2, -triangleCenter, -lowerIt]) rotate([angle, 0, 0])
        cylinder(h=nutDepth, r=m3_nut_radius, $fn=6);
    translate([ballDistance/2, -triangleCenter, -lowerIt]) rotate([angle, 0, 0])
        cylinder(h=nutDepth, r=m3_nut_radius, $fn=6);
} // studHoles()

// Create a right triangle
module taper(size, high) {
    linear_extrude(height = high)
        polygon(points = [[0, 0], [size, -size], [size, 0]]);
} // taper()

// Create angled cylinders to which magballs are mounted
module ballMounts(angle) {
    tsize=ballDiameter*2/3;
    lowerIt=sin(angle) * (ballDiameter/2);
    cutHeight=lowerIt*2;
    cutDiameter=ballDiameter*2;
    translate([0, -triangleCenter, 0]) difference() {
        union() {
            translate([-ballDistance/2, 0, -lowerIt])
                rotate([angle, 0, 0])
                cylinder(h=studBaseHeight, d=ballDiameter);
            translate([ballDistance/2, 0, -lowerIt])
                rotate([angle, 0, 0])
                cylinder(h=studBaseHeight, d=ballDiameter);
            translate([ballDistance/2-tsize, 0, 0])
                taper(tsize, thickness);
            translate([-(ballDistance/2-tsize), 0, 0])
                mirror([1,0,0])
                taper(tsize, thickness);
        }
        translate([-ballDistance/2, 0, -cutHeight])
            cylinder(h=cutHeight, d=cutDiameter);
        translate([ballDistance/2, 0, -cutHeight])
            cylinder(h=cutHeight, d=cutDiameter);
    }
};

// ============================================================
//
// Triangular lock/nut for holding the hot end in place
//
// ============================================================

// Triangular lock/nut for holding the hot end in place.
module lock() {
    cutoutHeight = hotEndNeckHeight+2;
    difference() {
        hotEndCap(hotEndNeckHeight, 0);
        translate([0, 0, -1])
            #cylinder(d=hotEndNeckDiameter, h=cutoutHeight);
        translate([-hotEndNeckDiameter/2, -hotEndNeckDiameter, -1])
            #cube([hotEndNeckDiameter, hotEndNeckDiameter, cutoutHeight]);
        // Three screw holes....
        translate([0, columnDistance, -1])
            #cylinder(r=m3_radius, h=cutoutHeight);
        translate([sideColumnX, -sideColumnY, -1])
            #cylinder(r=m3_radius, h=cutoutHeight);
        translate([-sideColumnX, -sideColumnY, -1])
            #cylinder(r=m3_radius, h=cutoutHeight);
    }
} // lock()

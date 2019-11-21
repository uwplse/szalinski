/* [Main Parameters] */

// Diameter of inner compartment
compartmentDiameter = 40;

// Height of inner compartment
compartmentHeight = 70;

// Number of rotating rings
numRings = 5;

// Labels on rings, also determines number of positions
positionLabelsStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

// Customizer part
part = "innershell"; // [innershell:Inner Shell, outershell:Outer Shell, ring:Ring, lockring:Lock Ring, endcap:End Cap, ringseparatortool:Ring Separator Tool]

/* [Hidden] */

positionLabels = [ for (i = [0 : len(positionLabelsStr) - 1]) positionLabelsStr[i] ];


// Polygon is centered on origin, with "first" point along X axis
module RegularPolygon(numCorners, outerRadius, faceOnXAxis=false) {
    points = [
        for (pointNum = [0 : numCorners - 1])
            [cos(pointNum / numCorners * 360) * outerRadius, sin(pointNum / numCorners * 360) * outerRadius]
    ];
    if (faceOnXAxis)
        rotate([0, 0, 360/numCorners/2])
            polygon(points);
    else
        polygon(points);
};

// Returns multipler to get inner radius (closest distance to origin) from a regular polygon with outer radius of 1
function regularPolygonInnerRadiusMultiplier(numCorners) =
    let (pt = ([1, 0] + [cos(1 / numCorners * 360), sin(1 / numCorners * 360)]) / 2)
        sqrt(pt[0]*pt[0] + pt[1]*pt[1]);

// width is gap width of slot (Y axis)
module LockRingFinger(width, innerRadius, outerRadius, height, spanAngle) {
    rotate([0, 0, spanAngle/2])
        linear_extrude(height=height, twist=spanAngle, slices=height*10)
            translate([innerRadius, -width/2])
                square([outerRadius - innerRadius, width]);
};

// Mark on the shell bases pointing to the "solution" line
module ShellBaseLineMark(radius, height, numPositions, lineWidth=0.4, depth=0.5) {
    // chevron projected around cylinder
    
    spanAngle = 360/numPositions*0.75;
    translate([0, 0, height])
        mirror([0, 0, 1])
            union() {
                // first line
                linear_extrude(height, twist=spanAngle, slices=height/0.2)
                    translate([radius-depth, -lineWidth/2])
                        square([depth, lineWidth]);
                // second line
                linear_extrude(height, twist=-spanAngle, slices=height/0.2)
                    translate([radius-depth, -lineWidth/2])
                        square([depth, lineWidth]);
            };
};

module LabelRingKey(radius, height) {
    cylinder(r=radius, h=height-2*radius, center=true, $fn=10);
    for (z = [height/2-radius, -height/2+radius])
        translate([0, 0, z])
            sphere(r=radius, $fn=10);
};

//LabelRingKey(1, 4);

//ShellBaseLineMark(radius=20, height=7, numPositions=26);
// From http://forum.openscad.org/rotate-extrude-angle-always-360-td19035.html

module rotate_extrude2(angle=360, convexity=2, size=1000) {

  module angle_cut(angle=90,size=1000) {
    x = size*cos(angle/2);
    y = size*sin(angle/2);
    translate([0,0,-size]) 
      linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
  }

  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation

  if (angleSupport || angle == 360) {
    rotate_extrude(angle=angle,convexity=convexity)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}

/*
// Main parameters
compartmentDiameter = 40;
compartmentHeight = 30;
numRings = 2;
positionLabels = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z"
];
//positionLabels = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" ];
*/

numPositions = len(positionLabels);

ringRotateClearance = 0.2; // used for a couple of different clearances relating to Z spacing of rings rotating next to each other

// Lock ring
lockRingHeightClearance = ringRotateClearance;
lockRingHeight = max(compartmentDiameter/10, 3 + lockRingHeightClearance);
//lockRingHeightClearance = max(0.1 * numRings, 0.35); // clearance for rings to rotate against each other, in addition to ring height clearance
lockRingActualHeight = lockRingHeight - lockRingHeightClearance;
lockRingFingerAngles = [60, 180, 300];
lockRingFingerWidth = compartmentDiameter * 0.075;
lockRingSlotWidthClearance = 0.6;
//lockRingDetentOsProtrusion = 0.3; // amount lock ring detents protrude into the outer shell

// Inner shell
isInnerRadius = compartmentDiameter / 2;
isThick = max(compartmentDiameter/20, 2);
isOuterRadius = isInnerRadius + isThick;
isInnerHeight = compartmentHeight;
isBaseThick = 3;
isOuterHeight = isInnerHeight + isBaseThick;
isProngSpanAngle = 10; // angular width of the lock prongs
isProngOffsetZ = -((numRings + 1) * ringRotateClearance); // vertical clearance between each ring and the prongs below it in locked position

// Outer shell
isOsClearance = 0.3; // Clearance on radius
osInnerRadius = isOuterRadius + isOsClearance;
osThick = max(compartmentDiameter/20, min(compartmentHeight/15, 3.2), 2);
osOuterRadius = osInnerRadius + osThick;
osInnerHeight = isInnerHeight;
osBaseThick = isBaseThick + lockRingHeight;
osOuterHeight = osInnerHeight + osBaseThick;
osSlotClearance = 0.3; // Clearance on each side of the fins to the outer shell slots
osSlotSpanAngle = isProngSpanAngle + 360 * osSlotClearance / (2 * PI * osInnerRadius) * 2;

lockRingSpanAngle = lockRingHeight / (2 * PI * osOuterRadius) * 360;

// Rings
ringSpacing = (isInnerHeight - lockRingHeight) / numRings;
osRingClearance = 0.3;
osProngProtrusion = compartmentDiameter * 0.0675 + osRingClearance; // Amount lock prongs protrude from the OD of the outer shell
isProngProtrusion = isOsClearance + osThick + osProngProtrusion; // amount the lock prongs extend from the OD of the inner shell cylinder
prongHeight = osProngProtrusion + 1; // total height of lock prongs, at the OD of the outer shell
ringInnerRadius = osOuterRadius + osRingClearance;
ringProngEndClearance = 0.3; // Clearance between the end of the prongs and the ring
ringProngCoverThick = min(max(compartmentDiameter / 20, 1), 3);
ringMinThick = osProngProtrusion + ringProngCoverThick + ringProngEndClearance;
ringOuterMinRadius = ringInnerRadius + ringMinThick;
ringOuterRadius = ringOuterMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
ringHeightClearance = ringRotateClearance;
ringHeight = ringSpacing - ringHeightClearance;
ringSlotClearance = 0.5;
ringSlotSpanAngle = isProngSpanAngle + 360 * ringSlotClearance / (2 * PI * ringInnerRadius) * 2;
prongCoverHeightClearance = 0.6; // amount shells will open before prongs engage on rings
lockSlotOuterRadius = osOuterRadius + osProngProtrusion + ringProngEndClearance; // outer radius of slots for lock prongs
falseLockSlotDepth = 0.3; // depth of false lock slots to make cracking more difficult
prongCoverHeight = prongHeight - isProngOffsetZ + prongCoverHeightClearance;

// Detents
detentCutoutDepthClearance = 0.25;
detentCutoutHeightClearance = 0.2;
detentDepth = 0.85;  // radius of detent cylindrical depressions
detentArm1Angle = 90; // Angle of the part of the arm that actually contacts the detent
detentArm2Angle = (numPositions % 2 == 0) ? detentArm1Angle + 180 : detentArm1Angle + 180 - (360 / numPositions / 2); 
detentArmThick = 1.5;
detentArmLength = min(10, ringInnerRadius * 1.3);
detentArmHeightMin = 1; // minimum amount of surface of lock prongs in contact with rings
minLockProngEngagement = min(1, osProngProtrusion - 2*osRingClearance);
detentArmHeightMax = ringHeight - prongCoverHeight - detentArmThick - detentDepth - detentCutoutDepthClearance - detentCutoutHeightClearance + (osProngProtrusion - 2*osRingClearance) + minLockProngEngagement;
// detentArmHeightIdeal = ringOuterRadius * 0.1; // depends on radius, so as torque increases, resistance linearly increases
detentArmHeightIdeal = (ringOuterRadius + 35) * 0.0375;
detentArmHeight = max(detentArmHeightMin, min(detentArmHeightMax, detentArmHeightIdeal));

// Label rings
labelRingRingClearanceMax = 0.3; // clearance tapers to allow for easier press fit
labelRingRingClearanceMin = 0.2;
labelRingMinThick = max(compartmentDiameter / 20, 1);
labelRingHeight = ringHeight;
labelRingInnerHeight = labelRingHeight * 0.8; // thickness/height tapers to prevent label rings from slipping vertically
labelRingInnerMinRadius = ringOuterMinRadius + labelRingRingClearanceMin;
labelRingInnerRadius = labelRingInnerMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
labelRingInnerBufferMinRadius = max(labelRingInnerMinRadius, ringOuterRadius + osRingClearance + labelRingRingClearanceMax); // inner radius on the top and bottom of label ring to prevent engaging adjacent rings if they slide
labelRingInnerBufferRadius = labelRingInnerBufferMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
labelRingInnerBufferHeight = labelRingHeight / 6;
labelRingContactHeight = labelRingHeight / 3; // amount of label ring in contact with ring (tapering from clearanceMax to clearanceMin)
labelRingOuterMinRadius = max(labelRingInnerMinRadius, labelRingInnerBufferMinRadius) + labelRingMinThick;
labelRingOuterRadius = labelRingOuterMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
labelRingKeyRadius = labelRingRingClearanceMax + 0.1;
labelRingKeyHeight = max(labelRingHeight / 5, labelRingKeyRadius * 2);
labelDepth = 0.5;
labelRingReverseLabelOrder = true;
labelRingReverseLabelDirection = false;
labelRingEmbossLabels = false;

// Spacer ring
// This part is entirely optional and usually not needed.  If there's extra slack for the
// rings on the outer shell, it can be measured and a spacer ring can be printed
// to take up the slack.
spacerRingHeight = 1.0;

osBaseRadius = labelRingOuterMinRadius;
//lockRingDetentRadius = lockRingDetentOsProtrusion + osRingClearance;
lockRingDetentRadius = detentDepth;

lockRingPinAngles = lockRingFingerAngles;
lockRingPinRadius = (osBaseRadius - ringInnerRadius) / 4;
lockRingPinX = (osBaseRadius + ringInnerRadius) / 2;
lockRingPinClearance = 0.3;
lockRingPinHeight = lockRingActualHeight * 0.9;

topMarkerDotRadius = 0.5;
topMarkerDotDepth = 0.4;

// Misc
latchAngles = [ 0, 180+30, 180-40 ];
falseLockSlotAngles = [ for (a = latchAngles) a + 360/numPositions*floor(numPositions/2) ];

// System
$fa = 2;
$fs = 1;

module InnerShell() {
    // Hollow cylinder
    rotate_extrude()
        translate([isInnerRadius, isBaseThick])
            square([isThick, isInnerHeight]);

    // Base/cap
    difference() {
        cylinder(h=isBaseThick, r=osBaseRadius);
        // Indexing mark
        ShellBaseLineMark(radius=osBaseRadius, height=isBaseThick+lockRingHeight, numPositions=numPositions);
    };
        
    // Side ridges
    sideRidgeProtrusion = isOsClearance + osThick; // how far the ridges protrude from the outer edge of the main cylinder
    module sideRidge() {
        rotate([0, 0, -isProngSpanAngle/2])
            rotate_extrude2(angle=isProngSpanAngle)
                translate([isInnerRadius, 0])
                    square([isOsClearance + osThick + isThick, isInnerHeight]);
    };
    difference() {
        // Ridges
        for (ang = latchAngles)
            rotate([0, 0, ang])
                translate([0, 0, isBaseThick])
                    sideRidge();
        // Detents in ridges
        for (ang = [-detentArm1Angle : 360 / numPositions : -detentArm1Angle + 360])
            rotate([0, 0, ang])
                translate([isOuterRadius+sideRidgeProtrusion, 0, isBaseThick])
                    cylinder(r=detentDepth, h=1000, $fn=20);
    };
    
        
    // Side prongs
    module prong() {
        // module produces a single prong, at the correct X offset, centered on the X axis, with a bottom Z of 0
        protrusion = isProngProtrusion - sideRidgeProtrusion;
        height = prongHeight;
        angle = isProngSpanAngle;
        rotate([0, 0, -angle/2])
            rotate_extrude2(angle=angle)
                translate([isOuterRadius, 0])
                    polygon([
                        [0, -sideRidgeProtrusion],
                        [sideRidgeProtrusion, 0],
                        [isProngProtrusion, protrusion],
                        [isProngProtrusion, height],
                        [0, height]
                    ]);
    };
    
    for (ang = latchAngles)
        rotate([0, 0, ang])
            for (z = [isInnerHeight + isBaseThick - prongHeight : -ringSpacing : isBaseThick + lockRingHeight])
                translate([0, 0, z + isProngOffsetZ])
                    prong();
            
    // Pins that interlock with lock ring
    // Pin holes that lock with inner shell
    for (ang = lockRingPinAngles)
        rotate([0, 0, ang])
            translate([lockRingPinX, 0, isBaseThick])
                cylinder(r=lockRingPinRadius, h=lockRingPinHeight);
};


module OuterShell() {
    lockRingSlotHeight = lockRingActualHeight;
    module LockRingSlot() {
        LockRingFinger(
            width=lockRingFingerWidth+lockRingSlotWidthClearance,
            innerRadius=osInnerRadius * 0.9,
            outerRadius=osOuterRadius * 1.1,
            height=lockRingSlotHeight,
            spanAngle=-lockRingSpanAngle
        );
    };
    
    difference() {
        union() {
            difference() {
                // Hollow cylinder
                rotate_extrude2()
                    translate([osInnerRadius, osBaseThick])
                        square([osThick, osInnerHeight]);

                // Detents
                for (ang = [detentArm1Angle : 360 / numPositions : detentArm1Angle + 360])
                    rotate([0, 0, ang])
                        translate([osOuterRadius, 0, osBaseThick])
                            cylinder(r=detentDepth, h=1000, $fn=20);
            };
            
            // Add chamfer at bottom (fits into chamfered prong cover on ring)
            difference() {
                translate([0, 0, osBaseThick])
                    cylinder(r1=osOuterRadius+osProngProtrusion, r2=osInnerRadius, h=osOuterRadius+osProngProtrusion-osInnerRadius);
                cylinder(r=osInnerRadius, h=1000);
            };
        };
        
        // Slots
        // angles are mirrored because this is in opposing direction to other parts
        for (ang = latchAngles)
            rotate([0, 0, -osSlotSpanAngle/2 + -ang])
                rotate_extrude2(angle=osSlotSpanAngle)
                    translate([0, osBaseThick])
                        square([1000, 1000]);
        
        // Lock ring slots
        for (ang = lockRingFingerAngles)
            translate([0, 0, osInnerHeight + osBaseThick - lockRingSlotHeight])
                rotate([0, 0, -ang])
                    LockRingSlot();
    };
    
    // Base
    difference() {
        // Base cylinder
        cylinder(h=osBaseThick, r=osBaseRadius);
        
        // Circle around base for symmetry with lock ring separation point
        circHeight = 0.3;
        circDepth = 0.3;
        translate([0, 0, isBaseThick-circHeight/2])
            difference() {
                cylinder(r=osBaseRadius, h=circHeight);
                cylinder(r=osBaseRadius-circDepth, h=circHeight);
            };
            
        // Indexing mark
        ShellBaseLineMark(radius=osBaseRadius, height=osBaseThick, numPositions=numPositions);
    };
};


module Ring() {
    detentArmSpanAngle = detentArmLength / (2 * PI * ringInnerRadius) * 360;
    detentKeySpanAngle = detentDepth * 2 / (2 * PI * ringInnerRadius) * 360;
    
    module DetentArm() {
        // Generates detent arm such that detent cylinder is centered on X axis
        detentArmInnerRadius = ringInnerRadius;
        detentArmOuterRadius = detentArmInnerRadius + detentArmThick;
        // Arm
        difference() {
            rotate([0, 0, -detentArmSpanAngle + detentKeySpanAngle/2])
                rotate_extrude2(angle=detentArmSpanAngle)
                    translate([detentArmInnerRadius, 0])
                        square([detentArmThick, detentArmHeight]);
            // Chamfer the end
            linear_extrude(1000)
                polygon([
                    [detentArmOuterRadius, 0],
                    [0, detentArmOuterRadius],
                    [detentArmOuterRadius, detentArmOuterRadius]
                ]);
        };
        // Detent key (cylinder)
        intersection() {
            translate([detentArmInnerRadius, 0, 0])
                cylinder(r=detentDepth, h=detentArmHeight, $fn=20);
            // Clip off any part that extends beyond the detent arm
            cylinder(r=detentArmOuterRadius, h=detentArmHeight);
        };
    };
    
    module DetentArmCutout() {
        cutoutSpanClearanceLength = 1;
        cutoutDepthClearance = detentCutoutDepthClearance;
        cutoutHeightClearance = detentCutoutHeightClearance;
        cutoutSpanClearanceAngle = cutoutSpanClearanceLength / (2 * PI * ringInnerRadius) * 360;
        cutoutSpanAngle = detentArmSpanAngle + cutoutSpanClearanceAngle;
        cutoutDepth = detentArmThick + detentDepth + cutoutDepthClearance;
        cutoutHeight = detentArmHeight + cutoutHeightClearance;
        rotate([0, 0, -detentArmSpanAngle + detentKeySpanAngle/2])
            rotate_extrude2(angle=cutoutSpanAngle)
                polygon([
                    [0, 0],
                    [ringInnerRadius + cutoutDepth, 0],
                    [ringInnerRadius + cutoutDepth, cutoutHeight],
                    [0, cutoutHeight + ringInnerRadius + cutoutDepth]
                ]);
    };
    
    module LockProngSlots(angles) {
        for (ang = angles)
            rotate([0, 0, -ringSlotSpanAngle/2 + ang])
                rotate_extrude2(angle=ringSlotSpanAngle)
                    square([lockSlotOuterRadius, 1000]);
    };
    
    module ProngCoverCutout(zOffset=0) {
        prongCoverInnerRadius = ringOuterMinRadius - ringProngCoverThick;
        translate([0, 0, ringHeight - prongCoverHeight + zOffset])
            difference() {
                cylinder(r=prongCoverInnerRadius, h=prongCoverHeight+1000);
                // wedge shape
                rotate_extrude()
                    polygon([
                        [ringInnerRadius, 0],
                        [prongCoverInnerRadius, 0],
                        [prongCoverInnerRadius, prongCoverInnerRadius - ringInnerRadius]
                    ]);
            };
    };
    
    difference() {
        // Main shape of ring
        linear_extrude(ringHeight)
            difference() {
                // Outer polygon, rotated such that a face is centered on the X axis
                RegularPolygon(numCorners=numPositions, outerRadius=ringOuterRadius, faceOnXAxis=true);
                // Center cavity
                circle(r=ringInnerRadius);
            };
        
        // Slots for lock prongs
        LockProngSlots(latchAngles);
        
        // Cutout for prong cover
        ProngCoverCutout();
        
        // False lock slots
        intersection() {
            // Slots
            LockProngSlots(falseLockSlotAngles);
            // Thin-walled cone
            difference() {
                ProngCoverCutout(-falseLockSlotDepth);
                ProngCoverCutout();
            };
        };
        
        // Cutouts for detent arms
        rotate([0, 0, -detentArm1Angle])
            DetentArmCutout();
        rotate([0, 0, -detentArm2Angle])
            mirror([0, 1, 0])
                DetentArmCutout();
        
        // Sockets for label ring to snap into
        for (ang = [0 : 360/numPositions : 360])
            rotate([0, 0, ang])
                translate([ringOuterMinRadius, 0, ringHeight/2])
                    LabelRingKey(labelRingKeyRadius, labelRingKeyHeight);
        
        // Circle to label primary position
        circThickness = 0.4;
        circDepth = 0.5;
        circRadius = 2 * PI * ringOuterMinRadius / numPositions / 2 * 0.85;
        translate([ringOuterMinRadius, 0, ringHeight/2])
            rotate([0, 90])
                difference() {
                    cylinder(r=circRadius, h=circDepth*2, center=true);
                    cylinder(r=circRadius-circThickness, h=circDepth*2, center=true);
                };
        
        // Top marker dot
        translate([ringOuterMinRadius-ringProngCoverThick/2, 0, ringHeight-topMarkerDotDepth])
            cylinder(r=topMarkerDotRadius, h=topMarkerDotDepth);
    };
    
    // Detent arms
    rotate([0, 0, -detentArm1Angle])
        DetentArm();
    rotate([0, 0, -detentArm2Angle])
        mirror([0, 1, 0])
            DetentArm();
};


module LockRing() {
    difference() {
        union() {
            // Hollow cylinder
            difference() {
                cylinder(r=osBaseRadius, h=lockRingActualHeight);
                cylinder(r=ringInnerRadius, h=lockRingActualHeight);
            };
            
            // Inner detent cylinders
            // Only spans 2/3 of lock ring height to allow screw to get started
            // Then tapered along the next third
            difference() {
                // Cylinders
                for (ang = [-detentArm1Angle : 360 / numPositions : -detentArm1Angle + 360])
                    rotate([0, 0, ang])
                        translate([ringInnerRadius, 0, 0])
                            cylinder(r=lockRingDetentRadius, h=lockRingActualHeight * (2/3), $fn=20);
                
                // Cone to taper the detents
                translate([0, 0, lockRingActualHeight * (1/3)])
                    cylinder(r1=ringInnerRadius-detentDepth, r2=ringInnerRadius, h=lockRingActualHeight/3);
            };
            
            // Lock fingers
             for (ang = lockRingFingerAngles)
                rotate([0, 0, ang])
                    LockRingFinger(
                        width=lockRingFingerWidth,
                        innerRadius=osInnerRadius,
                        outerRadius=(ringInnerRadius+osBaseRadius)/2,
                        height=lockRingActualHeight,
                        spanAngle=-lockRingSpanAngle
                    );
        };
        
        // Slots for lock prongs
        // Add slightly more clearance because these don't actually need to block the fins
        slotSpanAngle = ringSlotSpanAngle * 1.3;
        for (ang = latchAngles)
            rotate([0, 0, -slotSpanAngle/2 + ang])
                rotate_extrude2(angle=slotSpanAngle)
                    square([lockSlotOuterRadius, 1000]);
        
        // Pin holes that lock with inner shell
        for (ang = lockRingPinAngles)
            rotate([0, 0, ang])
                translate([lockRingPinX, 0, 0])
                    cylinder(r=lockRingPinRadius+lockRingPinClearance, h=1000);
        
        // Top marker dot
        translate([(osBaseRadius+lockSlotOuterRadius)/2, 0, lockRingActualHeight-topMarkerDotDepth])
            cylinder(r=topMarkerDotRadius, h=topMarkerDotDepth);
        
        // Indexing mark
        translate([0, 0, -isBaseThick-lockRingHeight+lockRingActualHeight])
            ShellBaseLineMark(radius=osBaseRadius, height=isBaseThick+lockRingHeight, numPositions=numPositions);
    };
};


module LabelRing() {
    
    module Labels() {
        reverseOrder = labelRingReverseLabelOrder;
        reverseDirection = labelRingReverseLabelDirection;
        labelSize = 2 * PI * labelRingOuterMinRadius / numPositions / 2;
        for (labelNum = [0 : numPositions - 1])
            rotate([0, 0, (reverseOrder ? 1 : -1) * (reverseDirection ? -1 : 1) * labelNum * 360/numPositions])
                translate([labelRingOuterMinRadius, 0, labelRingHeight/2])
                    rotate([reverseOrder ? 180 : 0, 0, 0])
                        rotate([0, 90, 0])
                            linear_extrude(labelDepth*2, center=true)
                                text(text=positionLabels[labelNum], size=labelSize, halign="center", valign="center");
    };
    
    difference() {
        // Outer polygon
        linear_extrude(labelRingHeight)
            RegularPolygon(numCorners=numPositions, outerRadius=labelRingOuterRadius, faceOnXAxis=true);
        
        // Buffer cutouts
        // Small offsets here are to work around some kind of openscad bug that adds a very thin solid layer at certain height values
        for (z = [-1 + 0.01, labelRingHeight-labelRingInnerBufferHeight - 0.01])
            translate([0, 0, z])
                linear_extrude(labelRingInnerBufferHeight+1)
                    RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerBufferRadius, faceOnXAxis=true);
        
        // Bottom buffer taper (for easier printing)
        bufferTaperHeight = (labelRingHeight - 2*labelRingInnerBufferHeight - labelRingContactHeight) / 2;
        bufferTaperScale = labelRingInnerRadius / labelRingInnerBufferRadius;
        translate([0, 0, labelRingInnerBufferHeight])
            linear_extrude(bufferTaperHeight, scale=bufferTaperScale)
                RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerBufferRadius, faceOnXAxis=true);
        
        // Top buffer taper (just for symmetry)
        topBufferTaperMinRadius = (ringOuterMinRadius + labelRingRingClearanceMax) / regularPolygonInnerRadiusMultiplier(numPositions);
        topBufferTaperScale = labelRingInnerBufferRadius / topBufferTaperMinRadius;
        translate([0, 0, labelRingInnerBufferHeight + bufferTaperHeight + labelRingContactHeight])
            linear_extrude(bufferTaperHeight, scale=topBufferTaperScale)
                RegularPolygon(numCorners=numPositions, outerRadius=topBufferTaperMinRadius, faceOnXAxis=true);
        
        // Internal (contact) taper from min clearance (at bottom) to max clearance
        contactScale = topBufferTaperMinRadius / labelRingInnerRadius;
        translate([0, 0, labelRingInnerBufferHeight + bufferTaperHeight])
            linear_extrude(labelRingContactHeight, scale=contactScale)
                RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerRadius, faceOnXAxis=true);
                
        // Labels
        if (!labelRingEmbossLabels)
            Labels();
        
        // Top marker dot
        translate([(labelRingOuterMinRadius+labelRingInnerBufferMinRadius)/2, 0, labelRingHeight-topMarkerDotDepth])
            cylinder(r=topMarkerDotRadius, h=topMarkerDotDepth);
    };
    
    if (labelRingEmbossLabels)
        Labels();
    
    // Key spheres/cylinders
    for (ang = [0 : 360/numPositions : 360])
        rotate([0, 0, ang])
            translate([ringOuterMinRadius + labelRingRingClearanceMax, 0, labelRingHeight/2])
                LabelRingKey(labelRingKeyRadius, labelRingKeyHeight);
};


module EndCap() {
    baseRadius = osBaseRadius;
    baseThick = 1;
    
    // Base
    translate([0, 0, -baseThick])
        cylinder(r=baseRadius, h=baseThick);
    
    // Twisty design thing
    numLobes = 5;
    lobeRadius = baseRadius / 2;
    
    module Thingy2D(initialTwist=0, initialScale=1) {
        scale([initialScale, initialScale, 0])
            rotate([0, 0, -initialTwist])
            for (ang = [0 : 360/numLobes : 359])
                rotate([0, 0, ang])
                    translate([baseRadius-lobeRadius, 0, 0])
                        circle(r=lobeRadius);
    };
    
    extrudeHeight = baseRadius * 0.75;
    twist = 650/numLobes;
    scale = 0.35;
    linear_extrude(extrudeHeight, twist=twist, scale=scale)
        Thingy2D();
    
    // Cone at bottom
    cylinder(r1=baseRadius, r2=baseRadius*0.25, h=extrudeHeight*0.75);
    
    // Short extrusion at top
    /*translate([0, 0, extrudeHeight])
        linear_extrude(extrudeHeight/4, twist=twist/5, scale=0)
            Thingy2D(twist, scale);*/
    
    // Sphere at top
    difference() {
        translate([0, 0, extrudeHeight*1.1])
            sphere(r=baseRadius*0.5);
        translate([0, 0, -500])
            cube([1000, 1000, 1000], center=true);
    };
};


module RingSeparatorTool() {
    
    module LabelRingSupport() {
        
        outerRingGuideHeight = 1;
        outerRingGuideClearance = 0.3;
        outerRingGuideThick = 2;
        
        difference() {
            // Outer polygon
            linear_extrude(ringHeight + outerRingGuideHeight)
                RegularPolygon(numCorners=numPositions, outerRadius=labelRingOuterRadius+outerRingGuideClearance+outerRingGuideThick, faceOnXAxis=true);
            
            // Cutout for label ring
            translate([0, 0, ringHeight])
                linear_extrude(1000)
                    RegularPolygon(numCorners=numPositions, outerRadius=labelRingOuterRadius+outerRingGuideClearance, faceOnXAxis=true);
            
            // Inner cutout for ring
            linear_extrude(1000)
                    RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerBufferRadius, faceOnXAxis=true);
        };
        
    };
    
    module RingPusher() {
        
        clearance = 0.5;
        outerRadius = ringOuterMinRadius - ringProngCoverThick - clearance;
        baseHeight = ringHeight + prongCoverHeight + 1;
        chamferSize = outerRadius - ringInnerRadius;
        
        cylinder(r=outerRadius, h=baseHeight);
        translate([0, 0, baseHeight])
            cylinder(r1=outerRadius, r2=outerRadius-chamferSize, h=chamferSize);
        
    };
    
    LabelRingSupport();
    RingPusher();
    
};

module print_part() {
	if (part == "innershell") InnerShell();
	else if (part == "outershell") OuterShell();
	else if (part == "ring") {
		Ring();
		LabelRing();
	} else if (part == "lockring") LockRing();
	else if (part == "endcap") EndCap();
	else if (part == "ringseparatortool") RingSeparatorTool();
};

print_part();


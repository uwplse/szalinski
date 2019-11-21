/* [Main] */

// Size of ball bearing
ballDiameter = 19.05;
ballRadius = ballDiameter / 2;

// Size of chair leg rod
rodDiameter = 14.5;
rodRadius = rodDiameter / 2;

// Angle of chair leg to vertical
rodAngle = 18;

/* [Advanced] */

// Length of chair leg that extends into the support
rodSupportLength = 30;

// How much smaller the socket opening is than the ball bearing
socketOverhangDist = 0.05;

// How thick the shell of the ball socket is
socketShellThick = 4;

// How thick the rod support cylinder should be
rodSupportThick = 3.5;

// Extra material to add at the bottom of the rod support
rodSupportBottomThick = 6;

// Clearance between the socket and ball
socketBallClearance = 0.5;

// Clearance between the rod support and the rod
rodSupportClearance = 0.25;

// Distance between inner support rings and rod
rodSupportRingClearance = -0.25;

// Number of support rings
rodSupportRingCount = 3;

// Extra height for each support ring
rodSupportRingHeight = 0.15;

// Include fingers at the top that prevent rod from rotating
includeLockFingers = false;

// Length of fingers at top that press against the rod to prevent it from rotating
lockFingerLength = 10;

// Clearance between the rod and lock fingers (should be negative to force the fingers to flex)
lockFingerClearance = -1.5;

// Thickness of the lock fingers
lockFingerThick = 1;

// How many fingers
numLockFingers = 10;

// Gap between each finger
lockFingerSeparation = 1;


/* [Hidden] */

socketInnerRadius = ballRadius + socketBallClearance;
socketOuterRadius = socketInnerRadius + socketShellThick;

overhangRadius = ballRadius - socketOverhangDist;
overhangCutoffZ = sqrt(pow(socketInnerRadius, 2) - pow(overhangRadius, 2));

rodSupportInnerRadius = rodRadius + rodSupportClearance;
rodSupportOuterRadius = rodSupportInnerRadius + rodSupportThick;

topCutoutRadius = min(socketInnerRadius/4, rodSupportInnerRadius/2);

lockFingerConeThick = rodSupportThick;

$fa = 4;
$fs = 0.25;

rotate([0, 180 - rodAngle, 0])
    ChairLegRoller();

module ChairLegRoller() {

    difference() {
        union() {
            // Socket
            difference() {
                // Shell
                sphere(r=socketOuterRadius);
                // Inner cutout
                sphere(r=socketInnerRadius);
                // Remove small cylindrical section at the top of socket to prevent clearance issues
                // if filament sags a little while bridging across the inner top of the socket.
                cylinder(r=topCutoutRadius, h=(socketInnerRadius+socketOuterRadius)/2);
            };

            // Rod support
            rotate([0, rodAngle, 0])
                union() {
                    translate([0, 0, socketOuterRadius])
                        difference() {
                            // Support outer shell, plus bottom
                            cylinder(r=rodSupportOuterRadius, h=rodSupportLength + rodSupportBottomThick);
                            // Support inner cutout
                            translate([0, 0, rodSupportBottomThick])
                                cylinder(r=rodSupportInnerRadius, h=rodSupportLength);
                        };
                    // Gap between bottom of rod support and socket
                    difference() {
                        cylinder(r=rodSupportOuterRadius, h=socketOuterRadius);
                        sphere(r=socketOuterRadius - 0.5);
                    };
                    // Remove stress point between socket and rod support
                    extraSupportHeight = socketOuterRadius + rodSupportLength / 2;
                    difference() {
                        cylinder(r1=socketOuterRadius, r2=rodSupportOuterRadius, h=extraSupportHeight);
                        sphere(r=socketOuterRadius);
                        translate([0, 0, socketOuterRadius])
                            cylinder(r=rodSupportOuterRadius, h=rodSupportLength+rodSupportBottomThick);
                    };
                    // Support rings
                    ringSpacing = rodSupportLength / (rodSupportRingCount + 1);
                    ringWidth = rodSupportInnerRadius - rodRadius - rodSupportRingClearance;
                    for (ringNum = [1:rodSupportRingCount])
                        translate([0, 0, socketOuterRadius + rodSupportBottomThick + ringNum * ringSpacing])
                            difference() {
                                rotate_extrude()
                                    translate([-rodSupportInnerRadius, 0])
                                        polygon([
                                            [0, -rodSupportRingHeight],
                                            [ringWidth, -rodSupportRingHeight],
                                            [ringWidth, 0],
                                            [0, ringWidth]
                                        ]);
                                for (a = [45, -45])
                                    rotate([0, 0, a])
                                        cube([rodSupportInnerRadius / 3, 1000, 1000], center=true);
                            };
                    // Lock fingers
                    if (includeLockFingers) {
                        lockFingerConeUpperOuterRadius = rodRadius + lockFingerClearance + lockFingerLength + lockFingerConeThick;
                        lockFingerConeHeight = lockFingerConeUpperOuterRadius-rodSupportOuterRadius;
                        lockFingerConeUpperInnerRadius = lockFingerConeUpperOuterRadius - lockFingerConeThick;
                        translate([0, 0, socketOuterRadius + rodSupportLength + rodSupportBottomThick])
                            union() {
                                // Cone
                                difference() {
                                    cylinder(r1=rodSupportOuterRadius, r2=lockFingerConeUpperOuterRadius, h=lockFingerConeHeight);
                                    cylinder(r1=rodSupportInnerRadius, r2=lockFingerConeUpperInnerRadius, h=lockFingerConeHeight);
                                };
                                // Fingers
                                translate([0, 0, lockFingerConeHeight - lockFingerThick])
                                    difference() {
                                        cylinder(r=lockFingerConeUpperInnerRadius, h=lockFingerThick);
                                        cylinder(r=rodRadius + lockFingerClearance, h=lockFingerThick);
                                        for (angle = [0:360/numLockFingers:359])
                                            rotate([0, 0, angle])
                                                translate([0, -lockFingerSeparation/2, 0])
                                                    cube([lockFingerConeUpperInnerRadius, lockFingerSeparation, lockFingerThick]);
                                    };
                            };
                    };
                };
        };
        // Cut off bottom of sphere
        // Done here instead of above in case rod support extends below the cutoff line
        translate([0, 0, -500 - overhangCutoffZ])
            cube([1000, 1000, 1000], center=true);
    };
};


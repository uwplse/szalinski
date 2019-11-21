// Nerf rail adapter for vacuum cleaner hoses. Use wisely.
// Copyright 2019 Ben Kelley
// This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/

// Size of the tube it should fit around. This fits my Dyson nicely. You want a pretty exact fit for it to stay on the hose.
TubeDiameter=60; //[20:100]

// How far around the tube the clip stretches.
TubeDegrees=240; // [180:359]

// The width of the clip that goes around the hose.
ClipWidth=10; //[5:20]
// The thickness of the clip that goes around the hose. If you make it too thick it won't flex enough to fit.
ClipThickness=5; //[3:10]

// How long the entire rail is. You can make this shorter or longer to suit, but edit the number and size of bumps to match.
RailLength=110; //[50:200]

// The height of the thinner part of the rail. If you make this smaller than 4 then attachments will not fit on the rail, but you can make it thicker.
RailHeight=4;

// The width of the thinner part of the rail. If you make this wider than 12.5 then attachments will not fit on the rail, but you can make it thinner.
RailBaseWidth=12.5;

// How much overhang on each side for the top flange of the rail. The final width will be RailBaseWidth + 2 x RailWidthOverhang.
RailWidthOverhang=1.75;

// How thick is the top flange of the rail. Keep this at 1.5 to fit Nerf attachments.
RailOverhangHeight=1.5;

// How high are the bumps on the top of the rail. Keep this at 1.5 or below to fit Nerf attachments.
RailBumpHeight=1.5;

// How wide are the bumps on the top of the rail.
RailBumpWidth=4;

// How long are the bumps on the top of the rail.
RailBumpLength=12;
// How much space between the bumps on the top of the rail.
InterBumpSpacing=8;

// How many bumps to make on each side of the rail.
NumberRailBumps=5;

// For the notch where the clip slots into the rail, how thick is the top of the notch.
NotchTopHeight=1.5;
// For the notch where the clip slots into the rail, how wide is the top of the notch.
NotchTopWidth=8;
// For the notch where the clip slots into the rail, how thick is the base of the notch.
NotchBaseThickness=4;
// For the notch where the clip slots into the rail, how high above the clip does the notch sit. You can adust this to make the rail sit higer or lower on the vacuum tube.
NotchBaseHeightAboveRing=10;

// How much tolerance on the dimensions of the notch. If this were 0 the parts would need to be an exact fit. At 0.25, the parts woulnd't fit on my printer, but at 0.4 they are tight.
NotchTolerance = 0.4;

translate([RailLength * -0.5 + 10, TubeDiameter / 2 + NotchBaseHeightAboveRing + ClipThickness + NotchTopHeight + 5, 0]) {
    rail();
}
clips();


module rail() {
    difference() {
        union() {
            cube(size=[RailLength, RailBaseWidth, RailHeight]);
            translate([0, -RailWidthOverhang, RailHeight]) {
                cube(size=[RailLength, RailBaseWidth + (RailWidthOverhang * 2), RailOverhangHeight]);
            }
            railTopBumps();
            translate([ClipWidth, -RailWidthOverhang, 0]) {
                railStop();
            }
            translate([ClipWidth, RailBaseWidth, 0]) {
                railStop();
            }
        }
        translate([0, 0, 0]) {
            railNotch();
        }
        translate([RailLength - ClipWidth, 0, 0]) {
            railNotch();
        }
    }
}

module railStop() {
    cube(size=[2, RailWidthOverhang, RailHeight]);
}

module railNotch() {
    translate([0, (RailBaseWidth - (NotchTopWidth + NotchTolerance)) / 2, 0]) {
        union() {
            translate([0, (NotchTopWidth - (NotchBaseThickness + 0)) / 2, 0]) {
                cube(size=[ClipWidth, NotchBaseThickness + NotchTolerance, 2]);
            }
            translate([0, 0, 2]) {
                cube(size=[ClipWidth, NotchTopWidth + NotchTolerance, NotchTopHeight + NotchTolerance]);
            }
        }
    }
}

module railTopBumps() {
    translate([0, -RailWidthOverhang, RailHeight + RailOverhangHeight]) {
        for(i=[0:1:NumberRailBumps - 1]) {
            translate([i * (RailBumpLength + InterBumpSpacing), 0, 0]) {
                railTopBump();
                translate([0, RailBaseWidth + (2 * RailWidthOverhang) - RailBumpWidth, 0]) {
                    railTopBump();
                }
            }
        }
    }
}

module railTopBump() {
    cube(size=[RailBumpLength, RailBumpWidth, RailBumpHeight]);
}

module clips() {
    clip();
    translate([20, 5, 0]) {
        rotate([180, 180, 0]) {
            clip();
        }
    }
}

module clip() {
    union() {
        ring();
        notch();
    }
}

module ring() {
    // TODO Rotate incorrect?
    rotate([0, 0, (TubeDegrees - 180) / -2]) {
    rotate_extrude(angle=240, convexity = 5, $fn=100) {
        translate([TubeDiameter / 2, 0, 0]) {
            square(size=[ClipThickness, ClipWidth]);
        }
    }
    }
}

module notch() {
    translate([(NotchBaseThickness - NotchTolerance)/ -2, (TubeDiameter / 2) + ClipThickness - 0.5, 0]) {
        union() {
            cube(size=[NotchBaseThickness - NotchTolerance, NotchBaseHeightAboveRing + 0.5, ClipWidth]);
            translate([(NotchTopWidth - NotchBaseThickness) / -2, NotchBaseHeightAboveRing + 0.5, 0]) {
                cube(size=[NotchTopWidth - NotchTolerance, NotchTopHeight - NotchTolerance, ClipWidth]);
            }
        }        
    }
}
// What to generate
Generate=0; // [0:Both, 1:Pole, 2:Clip]

// Minimum angle of rounded edges
$fa = 0.01;

// Minimum length of rounded edges
$fs = 0.01;

// Height of the pole
poleHeight = 20;

// Diameter of the pole
poleDiameter = 8;

// Size of the notch
notchSize = 2;

// Fillet of the notch (both inner and outer)
notchFillet = .1;

// Height of the clip
clipHeight = 10;

// Width of the clip
clipWidth = 4;

// Ratio (0-1) of the slot for the clip.
clipOpeningRatio = .9;

// Length of the clip's handle
clipHandleLength = 10;

// width of the clip's handle
clipHandleWidth = 5;

// Length of the grip on the handle of the clip
clipHandleGripLength = 3;

// Depth of the grip on the handle of the clip
clipHandleGripDepth = 1;

// Tolerance between pole and clip. (The clip is modified, not the pole)
clipTolerance = 0.1;

// Fillet on the clips edges
clipFillet = .5;

// End Params


if (Generate == 0 || Generate ==2)
color("white")
drainClip3d();

if (Generate == 0 || Generate ==1)
color("green")
pole3d();


/////
innerDia = poleDiameter + clipTolerance * 2;
outerDia = innerDia + clipWidth;

module pole3d() {
    linear_extrude(poleHeight)
    pole2d();
}
    
module pole2d() {
    fillet(notchFillet)
    rounding(notchFillet)
    union() {
        circle(d = poleDiameter);
        translate([-poleDiameter/2, 0, 0])
        square([notchSize, notchSize], true);
    }
}

module drainClip3d() {
    linear_extrude(clipHeight)
    drainClip2d();
}

module drainClip2d() {    
    difference() {
        fillet(clipFillet)
        rounding(clipFillet)
        difference() {    
            union() {
                handle();
                circle(d=outerDia);
            }
            
            translate([0, -clipOpeningRatio * innerDia / 2])
            square([outerDia/2, clipOpeningRatio * innerDia]);
        }
        
        offset(delta = clipTolerance)
        pole2d();
    }
}


module handle() {    
    difference() {        
        translate([-outerDia/2 - clipHandleLength, -clipHandleWidth/2])
        square([clipHandleLength + outerDia/2, clipHandleWidth]);
        
        handleInset();
        
        mirror([0, 1])
        handleInset();
    }
}

module handleInset() {
    translate([-outerDia/2 - clipHandleLength / 2, -clipHandleWidth/2])
    scale([clipHandleGripLength / clipHandleGripDepth, 1, 1])
    circle(r = clipHandleGripDepth);
}

// Helpers
module inset(d) {
    inverse() offset(r=d) inverse() children(0);
}

module fillet(r) {
    inset(d=r) offset(delta=r) children(0);
}

module rounding(r) {
    offset(r = r) offset(delta = -r) children(0);
}

module inverse() {
    difference() {
		square(1e5,center=true);
		children(0);
    }
}
includeBottom = 1; // [1:yes, 0:no]
includeTop = 1; // [1:yes, 0:no]
innerLength = 80;
extraWidth = 15;
sideWall = 1.5;
topWall = 1.6;
bottomWall = 2;
bottomScrewLength = 8;
topScrewLength = 5.7;
screwDiameter = 2.12;
screwHeadDiameter = 4.11;
thinPillarDiameter = 5.5;
fatPillarDiameter = 9;
stm32Width = 24.35;
stm32Length = 57.2;
tolerance = 0.2;
pcbThickness = 1.25;
bottomOverlap = 4;
topUnderlap = 4.8;
stm32ScrewYSpacing=18.8;
stm32ScrewXSpacing=52;
stm32ScrewOffset=2.4;
cableDiameter=3.7;
topOffset = 4.8;
topScrewX1 = 6;
topScrewXSpacing = 54.66;
buttonHoleDiameter = 4.9;
button1OffsetFromHole = 12.7;
button2OffsetFromHole = 5.78;
ledHoleDiameter = 4;
led1XOffsetFromButton1 = 10.16;
led1YOffsetFromButton1 = 1.27;
ledSpacing = 5.08;
pcbToPCBSpacing = 12;
usbPortWidth = 10;
usbPortHeight = 4.5;

module end_of_parameters_dummy() {}

//use <roundedsquare.scad>;
module roundedSquare(size=[10,10], radius=1, center=false, $fn=16) {
    size1 = (size+0==size) ? [size,size] : size;
    if (radius <= 0) {
        square(size1, center=center);
    }
    else {
        translate(center ? -size1/2 : [0,0])
        hull() {
            translate([radius,radius]) circle(r=radius);
            translate([size1[0]-radius,radius]) circle(r=radius);
            translate([size1[0]-radius,size1[1]-radius]) circle(r=radius);
            translate([radius,size1[1]-radius]) circle(r=radius);
        }
    }
}

module roundedOpenTopBox(size=[10,10,10], radius=2, wall=1, solid=false) {
    render(convexity=2)
    difference() {
        linear_extrude(height=size[2]) roundedSquare(size=[size[0],size[1]], radius=radius);
        if (!solid) {
            translate([0,0,wall])
            linear_extrude(height=size[2]-wall)
            translate([wall,wall]) roundedSquare(size=[size[0]-2*wall,size[1]-2*wall], radius=radius-wall);
        }
    }
}


module dummy() {}

$fn = 32;
nudge = 0.001;

innerWidth = extraWidth+stm32Width+fatPillarDiameter*2;
bottomOffset = bottomScrewLength-pcbThickness;
bottomHeight = bottomWall+bottomOffset+pcbThickness;
bottomFatPillarLength = bottomHeight+bottomOverlap;
topHeight = topWall + topOffset + pcbThickness + max(topUnderlap,pcbToPCBSpacing);
topFatPillarLength = topHeight-topUnderlap;

fatPillarLocations = [
    [-sideWall+fatPillarDiameter/2,-sideWall+fatPillarDiameter/2,0],
    [-sideWall+fatPillarDiameter/2,innerWidth+sideWall-fatPillarDiameter/2,0],
    [innerLength+sideWall-fatPillarDiameter/2,-sideWall+fatPillarDiameter/2,0],
    [innerLength+sideWall-fatPillarDiameter/2,innerWidth+sideWall-fatPillarDiameter/2,0]
];
stm32ScrewX1 = stm32ScrewOffset;
stm32ScrewY1 = fatPillarLocations[0][1]+fatPillarDiameter/2+thinPillarDiameter/2;
topScrewY = innerWidth-stm32ScrewY1-stm32ScrewYSpacing/2;
bottomThinPillarLocations = [
    [stm32ScrewX1,stm32ScrewY1,0],
    [stm32ScrewX1+stm32ScrewXSpacing,stm32ScrewY1,0],
    [stm32ScrewX1,stm32ScrewY1+stm32ScrewYSpacing,0],
    [stm32ScrewX1+stm32ScrewXSpacing,stm32ScrewY1+stm32ScrewYSpacing,0] ];


module base(inset=0) {
    translate([-sideWall+inset,-sideWall+inset])
    roundedSquare([innerLength+2*sideWall-2*inset,innerWidth+2*sideWall-2*inset], radius=fatPillarDiameter/2-inset);
}

module sideWalls() {
    difference() {
        base();
        base(inset=sideWall);
    }
}

module tweakedSideWalls() {
    difference() {
        base(inset=-sideWall);
        base(inset=sideWall+tolerance);
    }
}

module fatPillar(hole=false,bottom=true) {
    fatPillarLength = bottom?bottomFatPillarLength:topFatPillarLength;
    if (!hole)
        cylinder(d=fatPillarDiameter,fatPillarLength);
    else {
        if (bottom)
            cylinder(d=screwHeadDiameter+2*tolerance,h=fatPillarLength-(bottom?bottomWall:topWall));
        cylinder(d=screwDiameter+2*tolerance,h=fatPillarLength+nudge);
    }
}

module thinPillar(hole=false,height=10) {
    if (!hole)
        cylinder(d=thinPillarDiameter,h=height);
    else {
        cylinder(d=screwDiameter+2*tolerance,h=height);
    }
}



module bottom() {
    render(convexity=2)
    difference() {
        union() {
            linear_extrude(height=bottomWall+nudge) base();
            for (p=fatPillarLocations)
                translate(p) fatPillar();
            linear_extrude(height=bottomHeight+nudge) sideWalls();
            for (p=bottomThinPillarLocations)
                translate(p) thinPillar(height=bottomWall+bottomOffset);
            translate([innerLength-2*sideWall,stm32ScrewY1+stm32ScrewYSpacing/2-cableDiameter*1.5,0]) cube([2*sideWall+nudge,3*cableDiameter,bottomHeight]);
        }
        for (p=fatPillarLocations)
            translate(p) fatPillar(hole=true);
        translate([0,0,bottomHeight]) linear_extrude(height=bottomOverlap+nudge) tweakedSideWalls();
        for (p=bottomThinPillarLocations)
            translate([0,0,bottomWall]) translate(p) thinPillar(hole=true,height=bottomHeight+nudge);
       translate([innerLength-2*sideWall,stm32ScrewY1+stm32ScrewYSpacing/2,bottomHeight]) rotate([0,90,0]) cylinder(d=cableDiameter,h=3*sideWall+2*nudge);
    }
}

module top() {
    render(convexity=2)
    difference() {
        union() {
            linear_extrude(height=topWall+nudge) base();
            for (p=fatPillarLocations)
                translate(p) fatPillar(bottom=false);
            linear_extrude(height=topHeight+nudge) sideWalls();
            translate([topScrewX1,topScrewY,0])
                thinPillar(height=topWall+topOffset);
            translate([topScrewX1+topScrewXSpacing,topScrewY,0])
                thinPillar(height=topWall+topOffset);
            translate([innerLength-2*sideWall,innerWidth-(stm32ScrewY1+stm32ScrewYSpacing/2)-cableDiameter*1.5,0]) cube([2*sideWall+nudge,3*cableDiameter,topHeight]);
        }
        for (p=fatPillarLocations)
            translate([0,0,topWall]) translate(p) fatPillar(hole=true,bottom=false);
            translate([topScrewX1,topScrewY,0.5])
                thinPillar(height=topWall+topOffset,hole=true);
            translate([topScrewX1+topScrewXSpacing,topScrewY,0.5])
                thinPillar(height=topWall+topOffset,hole=true);

    y0=innerWidth-(stm32ScrewY1+stm32ScrewYSpacing/2);
       translate([innerLength-2*sideWall,y0,topHeight]) rotate([0,90,0]) cylinder(d=cableDiameter,h=3*sideWall+2*nudge);
        translate([-sideWall-nudge,y0-usbPortWidth/2,topHeight-usbPortHeight]) cube([sideWall+2*nudge,usbPortWidth,usbPortHeight+nudge]);
        translate([-sideWall*0.25-tolerance,y0-(stm32Width+2*tolerance)/2,topHeight-pcbThickness-tolerance]) cube([sideWall*0.25+tolerance+nudge,stm32Width+2*tolerance,pcbThickness+tolerance+nudge]);
        translate([topScrewX1+button1OffsetFromHole,topScrewY,-nudge]) cylinder(d=buttonHoleDiameter,h=topWall+2*nudge);
        translate([topScrewX1+topScrewXSpacing-button2OffsetFromHole,topScrewY,-nudge]) cylinder(d=buttonHoleDiameter,h=topWall+2*nudge);
        for(i=[0:3]) translate([topScrewX1+button1OffsetFromHole+led1XOffsetFromButton1+i*ledSpacing,topScrewY+led1YOffsetFromButton1,-nudge]) cylinder(d=ledHoleDiameter,h=topWall+2*nudge);
//        translate([fatPillarDiameter-sideWall+ventMargin,-sideWall-nudge,topWall+ventMargin]) vent(innerLength+2*sideWall-2*ventMargin,ventMargin,sideWall+2*nudge);
//        translate([fatPillarDiameter-sideWall+ventMargin,innerWidth-nudge,topWall+ventMargin]) vent(innerLength+2*sideWall-2*ventMargin,ventMargin,sideWall+2*nudge);
    }
}

if (includeBottom)
    bottom();
if (includeTop)
    translate([0,innerWidth+sideWall+8,0])
    top();

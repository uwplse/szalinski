frameOffsetHeight = 10; //Distance between the frame pipe and the lock
framePipeDiameter = 15; //Diameter of the frame pipe

notchDiameter = 10; // Notch diameter. 0 to disable
notchHeight = 3; // Height of the notch (shortest distance to the pipe)

recessCenterLength = 23; //The length of the recess
recessThreadWidth = 5.1; //The thread width of the bolt (+tolerance)
recessHeadWidth = 7.95; //Shortest width of the hex bolt head
recessHeadHeight = 4; //hex bolt head height

tieWrapWidth = 5.5; //Width of the gutter(s) for the tiewrap(s)
tieWrapHeight = 2; //Height of the gutter(s) for the tiewrap(s)

render() {
    $fn=80;
    difference() {
        baseBlock();
        recess();
        if(useNotch()) {
            notch();
        }
    }
}

function useNotch() = notchDiameter > 0 && notchHeight > 0;

module notch() {
    translate([0,0,frameBorderOffset()-notchHeight])
    cylinder(h=calculateBaseHeight(), d=notchDiameter);
}

module recess() {
    module recessThread() {
        cylinder(h=calculateBaseHeight(),d=recessThreadWidth);
    }

    function calculateHeadDiameter() = recessHeadWidth / sqrt(3) * 2;
    
    module recessHead() {
        translate([0,0,frameBorderOffset()-recessHeadHeight]) 
            cylinder(h=calculateBaseHeight(), d=calculateHeadDiameter(), $fn=6);
    }
    
    hull() {
        recessThread();
        translate([recessCenterLength, 0, 0]) recessThread();
    }
    
    hull() {
        translate([useNotch() ? notchDiameter/2 + calculateHeadDiameter() /2 : 0,0,0]) recessHead();
        translate([recessCenterLength, 0, 0]) recessHead();
    }
}

module baseBlock() {
    module baseCylinder() {
        cylinder(h=calculateBaseHeight()-framePipeDiameter/5, d=framePipeDiameter);
    }
    
    tieWrapMargin=2;
    
    module tieWrapGutter() {
        translate([recessThreadWidth/2 + tieWrapMargin,-framePipeDiameter/2,0])
            difference() {
                cube([tieWrapWidth, framePipeDiameter+2, tieWrapHeight * 2]);
                hull() {
                    translate([0,tieWrapHeight,tieWrapHeight * 2]) rotate([0,90,0]) cylinder(h=tieWrapWidth, r=tieWrapHeight);
                    translate([0,framePipeDiameter-tieWrapHeight,tieWrapHeight * 2]) rotate([0,90,0]) cylinder(h=tieWrapWidth, r=tieWrapHeight);
                }
            }
    }
    
    function tieWrapExtraLength() = recessThreadWidth/2 + tieWrapWidth + tieWrapMargin;
    
    function baseCenterLength() = recessCenterLength + (tieWrapExtraLength() * (useNotch() ? 1 : 2));
    
    difference() {
        translate([(useNotch() ? 0 : -tieWrapExtraLength()),0,0])
            difference() {
                hull() {
                    baseCylinder();
                    translate([baseCenterLength(), 0, 0])
                        baseCylinder();
                }

                translate([-framePipeDiameter/2, 0, calculateBaseHeight()]) 
                    rotate([0,90,0])
                        cylinder(h=baseCenterLength()+framePipeDiameter, d=framePipeDiameter);
            }
    
        translate([recessCenterLength,0,0]) tieWrapGutter();
        if(!useNotch()) {
            rotate([0,0,180]) tieWrapGutter();
        }
    }
}

function frameBorderOffset() = calculateBaseHeight()-(framePipeDiameter/2);


function calculateBaseHeight() = framePipeDiameter/2+frameOffsetHeight;
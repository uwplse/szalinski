/*  junction box for dome surveillance cameras 
    Russell Salerno 2017-05-27
    
    2017-06-23 updated to support tapered box
*/

test=false;         // true prints a thin slice to verify diameter and cam mount hole alignment
testSlice = 1;      // thickness of the test slice

// overall dimensions
baseDia2 = 120;     // top of base that mates to camera
taperAmt = 3.5;       // amt added to bottom of base for tapered look
baseDia1 = baseDia2 + taperAmt;  // bottom of base
baseHeight = 35;
baseThickness = 4;

// center hole for cables
wireHoleDia = 1.25*25.4;

// configuration of the mounting holes
mountHoleDia = 4.0;
numMountHoles = 4;
mountHoleRadius = 35;

// configuration of the camera mounting holes
camHoleDia = 3.0;
numCamPosts = 4;
camPostRadius = 49;       // Grandstream GXV3610
//camPostRadius = 47;     // Generic Chinese dome camera
camPostWall = 4;
camPostAngle=135;

$fn=360;                   // increase for better resolution

module base() {
    difference() {
        baseExterior();
        baseInterior();
        cylinder(d=wireHoleDia, h=baseThickness, center=false);
        mountingHoles();
    }
}

module baseExterior() {
    cylinder(d1=baseDia1, d2=baseDia2, h=baseHeight, center=false);
}

module baseInterior() {
    translate([0,0,baseThickness]) cylinder(d1=baseDia1-2*baseThickness, d2=baseDia2-2*baseThickness, h=baseHeight-baseThickness, center=false);
}

module mountingHoles() {
    for (i=[0:numMountHoles-1])
        rotate([0,0,i*360/numMountHoles]) translate([mountHoleRadius,0,0]) cylinder(d=mountHoleDia, h=baseThickness, center=false);
}

module cameraPosts() {
    // the following forms the 'triangle' camera mount buttresses
    l3=(((baseDia1-baseThickness)/2)*(sin(180-camPostAngle-(asin((sin(camPostAngle)*camPostRadius)/((baseDia1-baseThickness)/2))))))/sin(camPostAngle);
    xOffset=cos(180-camPostAngle)*l3;
    yOffset=sin(180-camPostAngle)*l3;
    
    for (i=[0:numCamPosts-1])
        rotate([0,0,360/numCamPosts/2+i*360/numCamPosts]) translate([camPostRadius,0,0]) {
            difference() {
                linear_extrude(baseHeight) hull () {
                    circle(d=camHoleDia+camPostWall*2);
                    translate([xOffset,yOffset,0]) circle(d=baseThickness);
                    translate([-(camPostRadius-((baseDia1-baseThickness)/2)),0,0]) circle(d=baseThickness);
                    translate([xOffset,-yOffset,0]) circle(d=baseThickness);
                }
                translate([0,0,baseThickness]) cylinder(d=camHoleDia, h=baseHeight-baseThickness, center=false);
            }
        }
}

module domecambox() {
    union() {
        base();
        intersection() {
            baseInterior();
            cameraPosts();
        }
    }
}

if (test) {
    translate([0,0,-baseHeight+testSlice]) difference() {
        domecambox();
        translate([0,0,-testSlice]) cylinder(d=baseDia1+1, h=baseHeight, center=false); 
    }
}
else {
   domecambox();
} 
/* [Basic] */
// Horizontal Distance of the outer holes, measured from center of hole
outerHorizontalDistance = 91; // [0:500]
// Vertical Distance of the outer holes, measured from center of hole
outerVerticalDistance = 86; // [0:500]

// Horizontal Distance of the inner holes, measured from center of hole
innerHorizontalDistance = 67; // [0:500]
// Vertical Distance of the inner holes, measured from center of hole
innerVerticalDistance = 128; // [0:500]

// Diameter of the screw used for the outer hole
outerScrewDiameter = 3; // [1:10]
// Diameter of the screw used for the inner hole
innerScrewDiameter = 3; // [1:10]

// Height of the distancers for the outer hole
outerDistanceHeight = 2; // [1:20]
// Height of the distancers for the inner hole
innerDistanceHeight = 10; // [1:20]

// Height of the struts
strutHeight = 2; // [1:20]

// Strut mode
strutMode = 0; // [0: simple, 1: complex, 2: both]

/* [Expert] */
// X Offset of the Top Left outer hole
outerTLOffsetX = 0; // [-500:500]
// Y Offset of the Top Left outer hole
outerTLOffsetY = 0; // [-500:500]
// X Offset of the Top Right outer hole
outerTROffsetX = 0; // [-500:500]
// Y Offset of the Top Right outer hole
outerTROffsetY = 0; // [-500:500]
// X Offset of the Bottom Left outer hole
outerBLOffsetX = 0; // [-500:500]
// Y Offset of the Bottom Left outer hole
outerBLOffsetY = 0; // [-500:500]
// X Offset of the Bottom Right outer hole
outerBROffsetX = 0; // [-500:500]
// Y Offset of the Bottom Right outer hole
outerBROffsetY = 0; // [-500:500]

// X Offset of the Top Left inner hole
innerTLOffsetX = 0; // [-500:500]
// Y Offset of the Top Left inner hole
innerTLOffsetY = 0; // [-500:500]
// X Offset of the Top Right inner hole
innerTROffsetX = 0; // [-500:500]
// Y Offset of the Top Right inner hole
innerTROffsetY = 0; // [-500:500]
// X Offset of the Bottom Left inner hole
innerBLOffsetX = 0; // [-500:500]
// Y Offset of the Bottom Left inner hole
innerBLOffsetY = 0; // [-500:500]
// X Offset of the Bottom Right inner hole (-32 for a RUMBA board)
innerBROffsetX = 0;  // [-500:500]
// Y Offset of the Bottom Right inner hole
innerBROffsetY = 0; // [-500:500]

module screwHole(outerRadius, innerRadius, height){
    difference(){
        cylinder(r=outerRadius,h=height);
        translate([0,0,-1]){
            cylinder(r=innerRadius,h=height+2);
        }
    }
}

function outerHoleTL() = [-outerHorizontalDistance/2+outerTLOffsetX,outerVerticalDistance/2+outerTLOffsetY,0];
function outerHoleTR() = [outerHorizontalDistance/2+outerTROffsetX,outerVerticalDistance/2+outerTROffsetY,0];
function outerHoleBL() = [-outerHorizontalDistance/2+outerBLOffsetX,-outerVerticalDistance/2+outerBLOffsetY,0];
function outerHoleBR() = [outerHorizontalDistance/2+outerBROffsetX,-outerVerticalDistance/2+outerBROffsetY,0];

module outerHoles(){
    translate(outerHoleTL())
        screwHole(outerScrewDiameter,outerScrewDiameter/2,outerDistanceHeight);
    translate(outerHoleTR())
        screwHole(outerScrewDiameter,outerScrewDiameter/2,outerDistanceHeight);
    translate(outerHoleBL())
        screwHole(outerScrewDiameter,outerScrewDiameter/2,outerDistanceHeight);
    translate(outerHoleBR())
        screwHole(outerScrewDiameter,outerScrewDiameter/2,outerDistanceHeight);
}

function innerHoleTL() = [-innerHorizontalDistance/2+innerTLOffsetX,innerVerticalDistance/2+innerTLOffsetY,0];
function innerHoleTR() = [innerHorizontalDistance/2+innerTROffsetX,innerVerticalDistance/2+innerTROffsetY,0];
function innerHoleBL() = [-innerHorizontalDistance/2+innerBLOffsetX,-innerVerticalDistance/2+innerBLOffsetY,0];
function innerHoleBR() = [innerHorizontalDistance/2+innerBROffsetX,-innerVerticalDistance/2+innerBROffsetY,0];

module innerHoles(){
    translate(innerHoleTL())
        screwHole(innerScrewDiameter,innerScrewDiameter/2,innerDistanceHeight);
    translate(innerHoleTR())
        screwHole(innerScrewDiameter,innerScrewDiameter/2,innerDistanceHeight);
    translate(innerHoleBL())
        screwHole(innerScrewDiameter,innerScrewDiameter/2,innerDistanceHeight);
    translate(innerHoleBR())
        screwHole(innerScrewDiameter,innerScrewDiameter/2,innerDistanceHeight);
}

module strutsInner(){
    translate(innerHoleTL()+[0,-innerScrewDiameter,0])
        difference(){
            cube(size=[innerHorizontalDistance,innerScrewDiameter*2,strutHeight]);
            union(){
                translate([0,innerScrewDiameter,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
                translate([innerHorizontalDistance-innerTROffsetX,innerScrewDiameter,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
            }
        }

    translate(innerHoleBL()+[-innerScrewDiameter,0,0])
        difference(){
            cube(size=[innerScrewDiameter*2,innerVerticalDistance,strutHeight]);
            union(){
                translate([innerScrewDiameter,0,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
                translate([innerScrewDiameter,innerVerticalDistance,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
            }
        }

    translate(innerHoleBL()+[0,-innerScrewDiameter,0])
        difference(){
            cube(size=[innerHorizontalDistance+innerBROffsetX,innerScrewDiameter*2,strutHeight]);
            union(){
                translate([0,innerScrewDiameter,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
                translate([innerHorizontalDistance+innerBROffsetX,innerScrewDiameter,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
            }
        }

    translate(innerHoleBR()+[-innerScrewDiameter,0,0])
        difference(){
            cube(size=[innerScrewDiameter*2,innerVerticalDistance,strutHeight]);
            union(){
                translate([innerScrewDiameter,0,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
                translate([innerScrewDiameter,innerVerticalDistance,-1])
                    cylinder(r=innerScrewDiameter/2,h=strutHeight+2);
            }
        }
}

module strutsOuter(){
    translate(outerHoleTL()+[0,-outerScrewDiameter,0])
        difference(){
            cube(size=[outerHorizontalDistance,outerScrewDiameter*2,strutHeight]);
            union(){
                translate([0,outerScrewDiameter,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
                translate([outerHorizontalDistance-outerTROffsetX,outerScrewDiameter,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
            }
        }

    translate(outerHoleBL()+[-outerScrewDiameter,0,0])
        difference(){
            cube(size=[outerScrewDiameter*2,outerVerticalDistance,strutHeight]);
            union(){
                translate([outerScrewDiameter,0,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
                translate([outerScrewDiameter,outerVerticalDistance,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
            }
        }

    translate(outerHoleBL()+[0,-outerScrewDiameter,0])
        difference(){
            cube(size=[outerHorizontalDistance+outerBROffsetX,outerScrewDiameter*2,strutHeight]);
            union(){
                translate([0,outerScrewDiameter,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
                translate([outerHorizontalDistance+outerBROffsetX,outerScrewDiameter,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
            }
        }

    translate(outerHoleBR()+[-outerScrewDiameter,0,0])
        difference(){
            cube(size=[outerScrewDiameter*2,outerVerticalDistance,strutHeight]);
            union(){
                translate([outerScrewDiameter,0,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
                translate([outerScrewDiameter,outerVerticalDistance,-1])
                    cylinder(r=outerScrewDiameter/2,h=strutHeight+2);
            }
        }
}
module complexStrut(src, dst, srcxoff, srcyoff, dstxoff, dstyoff, srcHole, dstHole){
    CubePoints = [
        src + [srcxoff,-srcyoff,0],
        src + [-srcxoff,srcyoff,0],
        dst + [-dstxoff,dstyoff,0],
        dst + [dstxoff,-dstyoff,0],
        src + [srcxoff,-srcyoff,strutHeight],
        src + [-srcxoff,srcyoff,strutHeight],
        dst + [-dstxoff,dstyoff,strutHeight],
        dst + [dstxoff,-dstyoff,strutHeight]
    ];
    CubeFaces = [
        [0,1,2,3], // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3] // left
    ];
    difference(){
        polyhedron(CubePoints, CubeFaces);
        union(){
            translate(src+[0,0,-1])
                cylinder(r=srcHole,h=strutHeight+2);
            translate(dst+[0,0,-1])
                cylinder(r=dstHole,h=strutHeight+2);
        }
    }
}
module struts(){
    if (strutMode == 0 || strutMode == 2){
        strutsInner();
        strutsOuter();
    }
    if (strutMode == 1 || strutMode == 2){
        for(src = [ innerHoleTR(), innerHoleTL(), innerHoleBR(), innerHoleBL()]){
            for (dst = [outerHoleTR(), outerHoleTL(), outerHoleBR(), outerHoleBL()]){
                complexStrut(src, dst,
                    (src[0] < dst[0] ? -1 : 1) * innerScrewDiameter/2,
                    (src[1] < dst[1] ? -1 : 1) * innerScrewDiameter/2,
                    (src[0] < dst[0] ? -1 : 1) * outerScrewDiameter/2,
                    (src[1] < dst[1] ? -1 : 1) * outerScrewDiameter/2,
                    innerScrewDiameter, outerScrewDiameter
                );
            }
        }
    }
}
outerHoles();
innerHoles();
struts();
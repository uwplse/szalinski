// Just for presentation purposes
showClosed = 2; // [0:Split, 1:Closed, 2:Open]

// Show parts
showParts = 0; // [0:All, 1:Base, 2:Lid]


/* [Box dimensions] */

// Outer box width
boxWidth = 150;

// Outer box depth
boxDepth = 60;

// Outer total box height
boxHeight = 40;

// Lid height
lidHeight = 10; // [6:100]

// Radius for rounded corners
corner = 5; // [1:40]


/* [Box setup] */
// Number of vertical spaces
numSeparatorsX = 5; // [1:20]

// Width of horizontal container
horSepWidth = 25; // [1:20]

// Outer wall thickness
wallThickness = 1.4;

// Tolerance
tolerance = 0.2;


/* [Text] */
// Text on base (empty to remove)
textBase = "Here";

// Base text size
textBaseSize = 15; // [3:50]

// Text on lid (empty to remove)
textLid = "Your Text";

// Lid text size
textLidSize = 20; // [3:50]


/* [Hinge configuration] */
// Hinge Radius
hingeRad=3;

// Hinge Length
hingeLength=10; // [5:50]

// Hinge barrette radius
hingeBar=1.2;

// Hinge separation from box body
hingeSep=2; // [0:5]

/* [Hidden] */
wt = wallThickness;
m=2+corner;
hingeTolerance=0.5;
sep = hingeSep;
$fn=60;

il=5;
iw=wt/2-tolerance;
internalWall = 1;

box();

module box() {
    if( showParts != 2 || showClosed ==1) {
        boxBase();
        separators(numSeparatorsX, horSepWidth, boxWidth, boxDepth, boxHeight-wt-1);
    }
    if (showClosed == 1 ) {
        %translate([0, 0, boxHeight]) rotate(a=[180, 0, 0]) boxLid();
    }
    else if (showClosed == 2) {
        boxBase();
        translate([0, boxDepth/2+4*hingeRad, boxDepth+hingeRad+sep]) rotate(a=[90, 0, 0]) boxLid();
    }
    else {
        if (showParts != 1) translate([boxWidth + 5, 0, 0]) boxLid();
    }
}


module separators (nx, sizeHor, sizeX, sizeY, height) {
    xS = sizeX / nx;
    union(){
        if ( nx > 1) {
            for ( a = [0 : nx-2] ) {
                translate([-sizeX/2+xS*(a+1), -sizeHor/2, 0])
                    linear_extrude(height=height)
                    square([internalWall, sizeY-sizeHor-2*wt], center = true);
            }
        }
        
        translate([0, sizeY/2-sizeHor, 0])
                    linear_extrude(height=height)
                    square([sizeX-2*wt, internalWall], center = true);
    }

}

module boxBase() {
    difference(){
        union(){
            
            roundedCube(boxWidth, boxDepth, boxHeight-lidHeight, corner);
            hingeLow(hingeRad, hingeLength);
            translate([0, 0, boxHeight-lidHeight]) roundedCube(boxWidth-2*(wt-iw), boxDepth-2*(wt-iw), il, corner);
        }

        translate([0, -boxDepth/2-1, boxHeight-lidHeight-5]) closeInsert();
        translate([0, 0, wt]) roundedCube(boxWidth-2*wt, boxDepth-2*wt, boxHeight+il, corner);
        translate([0, -boxDepth/2+0.5, (boxHeight-lidHeight)/2]) rotate(a=[90, 0, 0]) linear_extrude(height=2) text(textBase, valign="center", halign="center", font="Arial", size=textBaseSize);
        }
}


module boxLid() {
    closeTab();
    difference() {
        union () {
            roundedCube(boxWidth, boxDepth, lidHeight, corner);
            hingeUp(hingeRad, hingeLength);
        }
            
        translate([0, 0, lidHeight-il]) roundedCube(boxWidth-2*iw, boxDepth-2*iw, il+1, corner);
        translate([0, 0, wt]) roundedCube(boxWidth-2*wt, boxDepth-2*wt, boxHeight, corner);
        translate([0, 0, 0.5]) rotate(a=[180, 0, 0]) linear_extrude(height=2) text(textLid, valign="center", halign="center", font="Arial", size=textLidSize);
    } 
}

module closeTab() {
    translate([-5, boxDepth/2+1, lidHeight-5]) {
    rotate(a=[180, 0, 0]) rotate(a=[0, 90, 0]) linear_extrude(height=10) polygon(points=[[10, 0], [8, 2], [8, 1], [-1, 1], [0, 0]]);
    }
}

module closeInsert() {
    translate([-15/2, 0, 0.5])
    cube([15, 3, 2]);
}


module hingeUp(hingeRad, hingeLength) {
    rotate(a=[0, 0, 180])
    translate([-boxWidth/2, boxDepth/2, lidHeight])
    rotate(a=[0, 90, 0])
    difference() {
        union() {
        
        if ((hingeLength+hingeTolerance)*6+2*m<boxWidth) {
            translate([0, 0, m+hingeLength+hingeTolerance]) hingeSupport(hingeRad, hingeLength);
            translate([0, 0, boxWidth-2*hingeLength-hingeTolerance-m]) hingeSupport(hingeRad, hingeLength);
            }
        else {
            translate([0, 0, m+hingeLength+hingeTolerance]) hingeSupport(hingeRad, boxWidth-2*m-2*hingeLength-2);
        }
    }
        translate([0, sep+hingeRad, -1]) cylinder(r=hingeBar, h=boxWidth+2);
    }
}

module hingeLow(hingeRad, hingeLength) {
    translate([-boxWidth/2, boxDepth/2, boxHeight-lidHeight])
    rotate(a=[0, 90, 0])
    difference() {
        union() {
        translate([0, 0, m]) hingeSupport(hingeRad, hingeLength);
        if ((hingeLength+hingeTolerance)*6+2*m<boxWidth) {
            translate([0, 0, hingeLength*2+2*hingeTolerance+m]) hingeSupport(hingeRad, hingeLength);
            translate([0, 0, boxWidth-hingeLength*3-2*hingeTolerance-m]) hingeSupport(hingeRad, hingeLength);
        }
        translate([0, 0, boxWidth-hingeLength-m]) hingeSupport(hingeRad, hingeLength);
        }
        translate([0, sep+hingeRad, -1]) cylinder(r=hingeBar, h=boxWidth+2);
    }
}

module hingeSupport(hingeRad, hingeLength) {
    translate([0, sep+hingeRad, 0]) {
/*    cylinder(r=hingeRad, h=hingeLength); 
    difference() {
        translate([0, -hingeRad-sep, 0] ) cube([hingeRad*2, hingeRad+1+sep, hingeLength]);
        translate([hingeRad*2, -sep, -1] ) cylinder(r=hingeRad, h=hingeLength+2); 
        translate([hingeRad, hingeRad/2-sep-2, -1] ) cube([hingeRad*2, hingeRad+1+sep, hingeLength+2]);
    }}*/
        cylinder(r=hingeRad, h=hingeLength);
        difference() {
translate([0, -(hingeRad+sep), 0]) cube([2*hingeRad+sep, sep+hingeRad, hingeLength]);

translate([hingeRad*2+sep, 0, -1]) cylinder(r=hingeRad+sep, h=hingeLength+2);
}
    }
}


module roundedCube (w, d, h, r) {
    hull() {
        translate([-w/2+r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([-w/2+r, d/2-r, 0]) cylinder(r=r, h=h);    
        translate([w/2-r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([w/2-r, d/2-r, 0]) cylinder(r=r, h=h);
    }
}
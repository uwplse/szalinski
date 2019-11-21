// Outer box width
outerWidth = 15;

// Outer box depth
outerDepth = 30;

// Outer total box height
outerHeight = 32;

// Lid height
lidHeight = 10;

// Number of vertical spaces
numSeparatorsX = 1; // [1:20]

// Number of horizontal spaces
numSeparatorsY = 1; // [1:20]

// Outer wall thickness
outerWallThickness = 1.4;

// Show parts
showParts = 0; // [0:All, 1:Base, 2:Lid]

// Tolerance
tolerance = 0.1;

/* [Hidden] */
wt = outerWallThickness;
boxWidth = outerWidth-2*wt;
boxDepth = outerDepth-2*wt;
boxHeight = outerHeight;

$fn=60;
il=9;
iw=wt/2-tolerance;

if (showParts != 2) {
translate([-boxWidth/2-5, 0, 0]) {
    box_base(boxWidth, boxDepth, boxHeight, lidHeight);
    separators(numSeparatorsX, numSeparatorsY , boxWidth, boxDepth, boxHeight-lidHeight+il-1);
}
}

if (showParts != 1) {
translate([boxWidth/2+5, 0, 0])
box_lid(boxWidth, boxDepth, lidHeight);
}

module separators (nx, ny, sizeX, sizeY, height) {
    xS = sizeX / nx;
    yS = sizeY / ny;
    union(){
        if ( nx > 1) {
            for ( a = [0 : nx-2] ) {
                translate([-sizeX/2+xS*(a+1), 0, 0])
                    linear_extrude(height=height)
                    square([iw, sizeY], center = true);
            }
        }
        if ( ny > 1) {
            for ( b = [0 : ny-2] ) {
                translate([0, -sizeY/2+yS*(b+1), 0])
                    linear_extrude(height=height)
                    square([sizeY, iw], center = true);
            }
        }
    }

}


module box_lid (width, depth, height) {
    difference() {
        
        linear_extrude(height=height) {
        offset(wt)
        square([width, depth], center = true);
        }
    
        union() {
            translate([0, 0, height-il])
            linear_extrude(height=il+1) {
            offset(wt)
             square([width-2*iw, depth-2*iw], center = true);
            }

            translate([0, 0, wt])
            linear_extrude(height=height-wt+1) {
            offset(wt)
             square([width-2*wt, depth-2*wt], center = true);
            }
        }
    }    
}

module box_base(width, depth, height, lid) {
    difference(){
        union(){
            linear_extrude(height=height-lid) {
            offset(wt)
            square([width, depth], center = true);
            }

            linear_extrude(height=height-lid+il-1)
            offset(wt)
            square([width-2*wt+2*iw, depth-2*wt+2*iw], center = true);
        }

        translate([0, 0, wt])
        linear_extrude(height=height-lid+il)
        offset(wt)
        square([width-2*wt, depth-2*wt], center = true);
    }
}
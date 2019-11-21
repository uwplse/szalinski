// Select parts to show
showParts = 0; // [0:All, 1:Base, 2:Lid]

// Bottle Width (add spacers at your convinience)
bottleSupportWidth = 25;

// Bottle Depth (add spacers at your convinience)
bottleSupportDepth= 25;

// Bottle support height
bottleHeight = 40;

// Number of columns
numColumns = 4; // [1:20]

// Number of rows
numRows = 2; // [1:20]

// Add drills to save material and printing time
saveMat = 1; // [0:No, 1:Yes]

// Depth for brush container (width equals total box width
brushDepth = 15; // [1:50]

//Height for brush container
brushHeight = 15; 

// Number of containers for brushes
numBrushes = 1;

// Include lid
lid = 0; // [0:No, 1:Yes])

// Total case support (base + lid)
totalHeight = 90;

/* [Hidden] */
outerWall = 1;
innerWall = 1;

lidWall = 2.4;

totalWidth = (bottleSupportWidth+innerWall)*numColumns+2*outerWall;
totalDepth = (bottleSupportDepth+innerWall)*numRows+2*outerWall;

totalBrushDepth = (brushDepth+innerWall)*numBrushes+2*outerWall;

lidSupport = 10;

$fn=60;
il=1;

if (showParts != 2) {
translate([0, totalBrushDepth/2, 0])
difference() {
union() {
base(totalWidth, totalDepth, bottleHeight);
separators(numColumns, numRows, totalWidth-2*outerWall, totalDepth-2*outerWall, bottleHeight);
translate([0, -totalDepth/2-totalBrushDepth/2+outerWall, 0]) {
base(totalWidth, totalBrushDepth, brushHeight);
separators(1, numBrushes, totalWidth-2*outerWall, totalBrushDepth-2*outerWall, brushHeight);
}
}

if (saveMat == 1) {
holesX(numColumns, numRows, totalWidth-2*outerWall, totalDepth-2*outerWall, bottleHeight);
}
}
if (lid == 1) {
//translate([0, -totalBrushDepth/2, 0])
base(totalWidth+lidWall*2, totalDepth+lidWall*2+totalBrushDepth-2*outerWall, lidSupport, lidWall);
}
}

if (lid == 1) {
if (showParts != 1 ) {    
translate([totalWidth + 10, 0, 0])
base(totalWidth+lidWall*2, totalDepth+lidWall*2+totalBrushDepth-2*outerWall, totalHeight-lidSupport, lidWall-il);
}
}

module base (width, depth, height, wall=outerWall) {
    difference () {
        translate ([-width/2, -depth/2, 0])
        cube([width, depth, height]);
        translate ([-width/2+wall, -depth/2+wall, wall])
        cube([width-2*wall, depth-2*wall, height]);
    }
}

module holesX (nx, ny, sizeX, sizeY, sizeZ) {
    xS = sizeX / nx;
    yS = sizeY / ny;
    rH = yS/2-4;
    translate([0, sizeY/2+yS/2, rH+5])
    union(){
        if ( nx > 0) {
            for ( a = [0 : ny-1] ) {
                hull() {
                translate([0, -yS*(a+1), 0])
                    rotate(a=[0, 90, 0])
                    cylinder(r=rH, h=sizeX+5, center=true);
                translate([0, -yS*(a+1), sizeZ-2*rH-10])
                    rotate(a=[0, 90, 0])
                    cylinder(r=rH, h=sizeX+5, center=true);
                }
            }
        }        
    }

}


module separators (nx, ny, sizeX, sizeY, sizeZ) {
    xS = sizeX / nx;
    yS = sizeY / ny;
    union(){
        if ( nx > 1) {
            for ( a = [0 : nx-2] ) {
                translate([-sizeX/2+xS*(a+1), 0, 0])
                    linear_extrude(height=sizeZ)
                    square([innerWall, sizeY], center = true);
            }
        }
        if ( ny > 1) {
            for ( b = [0 : ny-2] ) {
                translate([0, -sizeY/2+yS*(b+1), 0])
                    linear_extrude(height=sizeZ)
                    square([sizeX, innerWall], center = true);
            }
        }
    }

}




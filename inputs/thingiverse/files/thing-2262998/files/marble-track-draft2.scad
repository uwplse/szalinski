// *** Written by Chris Dearner ***
// Please see my thingiverse page for license details
// Second draft: 21 Apr 2017
// Improved customizability & moved
// the pieces closer together in the sets
WIDTH = 20;         //20 by default
HEIGHT = WIDTH;     //If they're not equal, some things break.
CONNECTORWIDTH = 2; //2mm works well for me
CONNECTORLENGTH = 4;//4mm works well for me
TOLERANCE = .25;    //Added to female connectors 
                    //(the negative space)
                    //Can't be bigger than 1mm
                    //.25mm works well for me
//HEIGHT = 20;      //Open tracks are half-height
                    //My default height is 20
                    //which makes the "unit" of the track
                    // a nice 20x20x20 cube
STOLERANCE = .2;    //supports seem to need a slightly lower tolerance
SDEPTH = HEIGHT / 2;// = HEIGHT / 2 by default
SWIDTH = 3;         //width of support legs (in the X direction)
                    //3mm is what I use
DIAMETER = 12;      //12mm works for 3/8" bearings
TRACKUNIT = 20;     //Standard unit length for track (20 by default)


//Uncomment the following to generate a good-sized track
//set that takes up two prusa i3 build plates:
//translate([-(6*WIDTH + 2*CONNECTORLENGTH + 24), CONNECTORLENGTH, 0]) trackSet1();
//trackSet2();

oneOfEach();
//------------- MODULES BELOW ---------------------------
//The basic pieces are contained in the following modules:
// straightTrack(length), straightTrackff(length)
// downReversePiece(), downForwardPiece()
// support(), tallSupport(), marble()
// 90turnPiece(), 180turnWithTolerance(),
// dropTube(), endPiece(sphereDiameter)
// --------------------------------------------------
// trackSet1() and trackSet2() together give you
// a good starting set, and should print as-is on
// a prusa i3 clone (build area of around 180x180mm).
// oneOfEach() generates one of each piece in the set,
// and works well if you want to remix this with custom
// sizes or whatever.

module oneOfEach() {
    //Straight pieces
    translate([0, 0, 0]) straightTrack(TRACKUNIT);
    translate([0, TRACKUNIT + CONNECTORLENGTH + 4, 0]) straightTrack(2*TRACKUNIT);
    translate([0, TRACKUNIT * 3 + 2*CONNECTORLENGTH + 8, 0]) straightTrack(4*TRACKUNIT);
    
    //Straight w/ff connectors
    translate([WIDTH + 4, 0, 0]) straightTrackff(TRACKUNIT);
    translate([WIDTH + 4, TRACKUNIT + 4, 0]) straightTrackff(TRACKUNIT * 2);
    translate([WIDTH + 4, TRACKUNIT * 3 + 8, 0]) straightTrackff(TRACKUNIT * 4);
    
    //Drop pieces
    translate([WIDTH*2 + 8, 0, WIDTH]) rotate([-90, 0, 0]) downReversePiece();
    translate([WIDTH * 2 + 8, WIDTH * 2 + 4 + CONNECTORLENGTH, 0]) downForwardPiece();
    
    //Launcher
    translate([WIDTH * 2 + 8, WIDTH * 3 + 2* CONNECTORLENGTH + 8, 0]) dropTube();
    
    //End piece, turns
    translate([WIDTH * 3 + 12, 0, 0]) endPiece();
    translate([WIDTH * 3 + 12 + CONNECTORLENGTH, WIDTH + CONNECTORLENGTH  + 4, 0]) 90turnPiece();
    translate([WIDTH * 3 + 12 + CONNECTORLENGTH, WIDTH * 3 + CONNECTORLENGTH * 2 + 8, 0]) rotate([0, 0, -90]) 180turnWithTolerance();
    
    //Marble
    translate([WIDTH * 3 + 12 + CONNECTORLENGTH, WIDTH * 4 + CONNECTORLENGTH * 2 + 12, 0]) marble();
    
    //supports
    translate([WIDTH * 4 + 16 + 2* CONNECTORLENGTH, 0, 0]) rotate([-90, 0, 0]) support();
    
    translate([WIDTH * 4 + 16 + 2* CONNECTORLENGTH, WIDTH*1.5 + 4, 0]) rotate([-90, 0, 0]) tallSupport();
}
module trackSet1() {
for (x=[0, WIDTH + 4, 2*WIDTH + 8, 3*WIDTH + 12]) {
    translate([x, 0, 0]) straightTrack(TRACKUNIT);
    translate([x, TRACKUNIT + CONNECTORLENGTH + 4, 0]) straightTrack(2*TRACKUNIT);
    translate([x, TRACKUNIT * 3 + 2*CONNECTORLENGTH + 8, 0]) straightTrack(4*TRACKUNIT);
}
for (x = [4*WIDTH + 16 + CONNECTORLENGTH, 5*WIDTH + 20 + 2* CONNECTORLENGTH]) {
    translate([x, 0, 0]) 90turnPiece();
    translate([x, WIDTH + CONNECTORLENGTH + 4, 0]) 90turnPiece();
    translate([x, 2*WIDTH + 2*CONNECTORLENGTH + 8, 0]) straightTrackff(TRACKUNIT);
    translate([x, 2*WIDTH + TRACKUNIT + 2*CONNECTORLENGTH + 12, 0]) straightTrackff(TRACKUNIT);
    
}


translate([5*WIDTH + 16 + CONNECTORLENGTH, 2* WIDTH + 2*TRACKUNIT + CONNECTORLENGTH * 3 + 16, 0]) 180turnWithTolerance();
translate([5*WIDTH + 16 + CONNECTORLENGTH, 3* WIDTH + 2*TRACKUNIT + CONNECTORLENGTH * 4 + 20, 0]) 180turnWithTolerance();
}
module trackSet2() {
//First column of  supports
for (y=[0, HEIGHT*1.5 + 4, HEIGHT*3 + 8, HEIGHT*4.5 + 12]) {
translate([0, y, 0])
translate([SWIDTH, 0, SDEPTH]) rotate ([-90, 0, 0]) support();
}
//Fifth support in second column

translate([WIDTH + 2*SWIDTH + SWIDTH, HEIGHT * 5 + 8, 0]) translate([SWIDTH, 0, SDEPTH]) rotate ([-90, 0, 0]) support();

//tall supports in second column
for (y = [0, HEIGHT * 2.5 + 4]) {
    translate([WIDTH + 2*SWIDTH, y, 0])
    translate([SWIDTH*2, 0, SDEPTH]) rotate ([-90, 0, 0]) tallSupport();
}
//Drop pieces in third column
for (y=[0, (HEIGHT * 2 + 4)]) translate([WIDTH * 2 + SWIDTH * 6 + 4, y, WIDTH]) rotate([-90, 0, 0]) downReversePiece();
for (y=[4*HEIGHT + 8 + CONNECTORLENGTH, 4*HEIGHT + 12 + 2*CONNECTORLENGTH + WIDTH]) translate([WIDTH * 2 + SWIDTH * 6 + 4, y, 0]) downForwardPiece();
    
//Fifth column
translate([WIDTH * 3 + SWIDTH * 5 + 12 + CONNECTORLENGTH, CONNECTORLENGTH, 0]) endPiece();
for (y=[WIDTH + 2*CONNECTORLENGTH + 4, 2*WIDTH + 3*CONNECTORLENGTH + 8]) translate([WIDTH * 3 + SWIDTH * 5 + 12 + CONNECTORLENGTH, y, 0]) 90turnPiece();
translate([WIDTH * 3 + SWIDTH * 5 + 12 + CONNECTORLENGTH, 3*WIDTH + 4*CONNECTORLENGTH + 12, 0]) dropTube();


for (y=[0, TRACKUNIT + 4]) translate([WIDTH * 4 + SWIDTH * 5 + 16 + CONNECTORLENGTH, y, 0]) straightTrackff(TRACKUNIT);
for (y=[2*TRACKUNIT + 8 + CONNECTORLENGTH, 4*TRACKUNIT + 12 + 2* CONNECTORLENGTH]) translate([WIDTH * 4 + SWIDTH * 5 + 16 + CONNECTORLENGTH, y, 0]) straightTrack(2*TRACKUNIT);
    
//Sixth column (new to second draft!)
for (y=[0, 4 + TRACKUNIT * 2, 8 + TRACKUNIT * 4,]) {
    translate([WIDTH * 5 + SWIDTH * 5 + 20 + CONNECTORLENGTH, y, 0]) straightTrackff(2 * TRACKUNIT);
}
}


module tallSupport() {
for (x=[0, WIDTH + STOLERANCE*2 + SWIDTH]) {
    translate([x, 0, 0]) cube([SWIDTH, SDEPTH, HEIGHT*2.5]);
}
translate([SWIDTH, 0, (HEIGHT * 2) - SWIDTH]) cube([WIDTH + STOLERANCE*2, SDEPTH, SWIDTH]);
}
module marble(marbRadius = (DIAMETER - 2) / 2) {
    translate([marbRadius, marbRadius, marbRadius]) sphere(r=marbRadius, $fn=100);
}
module endPiece(sphereRadius = DIAMETER / 2 + 2) {
difference() {
cube([WIDTH, WIDTH, HEIGHT/2]);
translate([WIDTH/2, WIDTH/2, HEIGHT/2]) sphere(sphereRadius);
    translate([WIDTH/2,WIDTH/2, HEIGHT/2]) 
    rotate([90,0,0]) 
cylinder(r1=DIAMETER/2, r2=DIAMETER/2,h=WIDTH/2 + 1, $fn = 50);
}
translate([0,-CONNECTORLENGTH, 0]) connectorm();
translate([(WIDTH - CONNECTORWIDTH), -CONNECTORLENGTH, 0]) connectorm();
}

module downReversePiece() {
halfDown();
difference() {
translate([0, WIDTH, HEIGHT]) rotate([90, 0, 0]) halfDown();
translate([-2 + TOLERANCE, -1, HEIGHT*1.5]) connectorf();
translate([-2 +TOLERANCE,-1, HEIGHT])connectorf();
translate([WIDTH - TOLERANCE - CONNECTORWIDTH, -1, HEIGHT*1.5]) connectorf();
translate([WIDTH - TOLERANCE - CONNECTORWIDTH, -1, HEIGHT])connectorf();
}
translate([0, -CONNECTORLENGTH, 0]) connectorm();
translate([0, -CONNECTORLENGTH, HEIGHT/2]) connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, 0])connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, HEIGHT/2])connectorm();
}
module downForwardPiece() {
halfDown();
difference() {
translate([WIDTH, 0, HEIGHT]) rotate([90, 0, 180]) halfDown();
translate([-2 + TOLERANCE, WIDTH - CONNECTORLENGTH -1, HEIGHT*1.5]) connectorf();
translate([-2 +TOLERANCE, WIDTH - CONNECTORLENGTH -1, HEIGHT])connectorf();
translate([WIDTH - TOLERANCE - CONNECTORWIDTH, WIDTH - CONNECTORLENGTH -1, HEIGHT*1.5]) connectorf();
translate([WIDTH - TOLERANCE - CONNECTORWIDTH, WIDTH - CONNECTORLENGTH -1, HEIGHT])connectorf();
}
translate([0, -CONNECTORLENGTH, 0]) connectorm();
translate([0, -CONNECTORLENGTH, HEIGHT/2]) connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, 0])connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, HEIGHT/2])connectorm();
}

module straightDownHalf() {
    difference() {
    halfDown();
                translate([0, 0, HEIGHT]) rotate([270, 0, 0]) {
        translate([-2+TOLERANCE, -CONNECTORLENGTH+3, -2]) connectorf();
    translate([WIDTH - CONNECTORWIDTH - TOLERANCE , -CONNECTORLENGTH+3, -2]) connectorf();
    }
}
    translate([0, -CONNECTORLENGTH, 0]) connectorm();
    translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, 0]) connectorm();
    translate([0, HEIGHT/2, HEIGHT]) rotate([270, 0, 0]) {
        translate([0, -CONNECTORLENGTH, 0]) connectorm();
    translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, 0]) connectorm();
    }


}
 
module halfDown() {
intersection() {
    downTube();
    cube([WIDTH, WIDTH, HEIGHT]);
}
}

module 90turnPiece() {
90turn();
rotate([0, 0, 90]) connectorm();
rotate([0, 0, 90]) translate([WIDTH-CONNECTORWIDTH, 0, 0]) connectorm();
}

module support() {
for (x=[0, WIDTH + STOLERANCE*2 + SWIDTH]) {
    translate([x, 0, 0]) cube([SWIDTH, SDEPTH, HEIGHT*1.5]);
}
translate([SWIDTH, 0, (HEIGHT) - SWIDTH]) cube([WIDTH + STOLERANCE*2, SDEPTH, SWIDTH]);
}
module dropTube() {
rotate([0,0,90])
difference() {
rotate([0, 0, -90]) cube([WIDTH, HEIGHT*3, HEIGHT*3]);
translate([0, 1, HEIGHT*3])rotate([90, 0, 0]) cylinder(r1=HEIGHT*2, r2=HEIGHT*2, h=WIDTH+2);
    translate([0, 0, HEIGHT*3])
rotate([90, 90, 0])
    rotate_extrude()
    translate([HEIGHT*2, 0, 0])
    translate([HEIGHT/2, WIDTH/2, 0]) circle(r=DIAMETER/2);
    
}

translate([0, -CONNECTORLENGTH, 0]) connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, 0]) connectorm();
translate([0, -CONNECTORLENGTH, HEIGHT/2]) connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, HEIGHT/2]) connectorm();
}
//translate([0, 0, 48])
//rotate([90, 90, 0])
//intersection() {
//rotate_extrude()
//translate([32, 0, 0])
//difference() {
//square([HEIGHT, WIDTH]);
//translate([HEIGHT/2, WIDTH/2, 0]) circle(r=DIAMETER/2);
//}
//translate([0, -0, 0])cube([100, 100, 100]);
//}

module 180turn() {
    90turn();
    mirror([90, 0, 0]) 90turn();
}
module 180turnWithTolerance() {
    
    module 90turnWithTolerance() {
    90turn();
    difference() {
    translate([-TOLERANCE, 0, 0])
    cube([TOLERANCE+.1, WIDTH, HEIGHT/2]);
    translate([-TOLERANCE-.1, WIDTH/2, HEIGHT/2])
    rotate([0, 90, 0]) cylinder(r1 = DIAMETER/2, r2=DIAMETER/2, h=TOLERANCE+.3, $fn=50);
    
    
    }
    }
    90turnWithTolerance();
    translate([-TOLERANCE*2, 0, 0]) mirror([90, 0, 0]) 90turnWithTolerance();
    translate([-CONNECTORWIDTH/2, -CONNECTORLENGTH, 0]) connectorm();
}
module 90turn() {
    difference() {
    90degree();
    translate([-1, -1-CONNECTORLENGTH, HEIGHT/2]) cube([WIDTH+2, WIDTH+2+CONNECTORLENGTH, (HEIGHT/2) +2]);
    }
}
module straightTrack(length = 40) { //Straight tracks are half-height
difference() {
difference() {
cube([WIDTH,length, HEIGHT/2]);
translate([WIDTH/2,length+1, HEIGHT/2]) 
rotate([90,0,0]) 
cylinder(r1=DIAMETER/2, r2=DIAMETER/2,h=length+2, $fn = 50);
}    
translate([-2+TOLERANCE, length-CONNECTORLENGTH-1, -1]) connectorf();
translate([WIDTH-CONNECTORWIDTH-TOLERANCE, length-CONNECTORLENGTH-1, -1]) connectorf();

}
//Male Connectors
translate([0,-CONNECTORLENGTH, 0]) connectorm();
translate([(WIDTH - CONNECTORWIDTH), -CONNECTORLENGTH, 0]) connectorm();
}
module straightTrackff(length = 40) { //Straight tracks are half-height
difference() {
difference() {
cube([WIDTH,length, HEIGHT/2]);
translate([WIDTH/2,length+1, HEIGHT/2]) 
rotate([90,0,0]) 
cylinder(r1=DIAMETER/2, r2=DIAMETER/2,h=length+2, $fn = 50);
}    
translate([-2+TOLERANCE, length-CONNECTORLENGTH-1, -1]) connectorf();
translate([WIDTH-CONNECTORWIDTH-TOLERANCE, length-CONNECTORLENGTH-1, -1]) connectorf();
translate([-2+TOLERANCE, -1, -1]) connectorf();
translate([WIDTH-CONNECTORWIDTH-TOLERANCE, -1, -1]) connectorf();
}

}

module 90degree(length = 32, connectors = 1) {
    difference() {
    cube([WIDTH, WIDTH, HEIGHT]);
        translate([0, 0, ((HEIGHT-DIAMETER)/2)]) {
    translate([0, 0, DIAMETER/2])
    rotate_extrude() translate([WIDTH/2, 0, 0])circle(DIAMETER/2, $fn=50);
        }
    }
    if (connectors) {
    translate([0,-CONNECTORLENGTH, 0]) connectorm();
translate([(WIDTH - CONNECTORWIDTH), -CONNECTORLENGTH, 0]) connectorm();
    }
    //This adds a little width so you can have F connectors
    //Or anyway, it was supposed to
    //But that messed up the rotation?  And I'm bad at 
    //thinking in 3D
    
    //on turns
    //difference() {
    //translate([0, -CONNECTORLENGTH, 0])
    //cube([WIDTH, CONNECTORLENGTH, HEIGHT]);
    //translate([WIDTH/2,CONNECTORLENGTH-3, HEIGHT/2])
    //rotate ([90, 0, 0]) 
    //    cylinder(r1 = DIAMETER/2, r2 = DIAMETER/2, h=CONNECTORLENGTH+2, $fn=50);
    //}
}

module downTube() {
difference() {
    cube([WIDTH,WIDTH,2*HEIGHT]);
    translate([WIDTH/2,0,HEIGHT])
rotate([0, 90, 0])
rotate_extrude(convexity = 10, $fn=50)
translate([HEIGHT/2, 0, 0])
circle(r = DIAMETER/2, $fn=50);
}
translate([0, -CONNECTORLENGTH, 0]) connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, 0]) connectorm();
translate([0, -CONNECTORLENGTH, HEIGHT]) connectorm();
translate([WIDTH - CONNECTORWIDTH, -CONNECTORLENGTH, HEIGHT]) connectorm();
}

module connectorm() {
    cube([CONNECTORWIDTH, CONNECTORLENGTH, HEIGHT/2]);
}
module connectorf() {
    cube ([CONNECTORWIDTH + 2, CONNECTORLENGTH + 2, HEIGHT/2+2]);
}
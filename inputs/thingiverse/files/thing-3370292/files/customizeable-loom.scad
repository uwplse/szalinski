//Author M. Dietz http://www.dietzm.de
//to render with F5, edit openscad preferences to allow more than 2000 objects

// Modified Jan 2019 by Richard Bateman to make customizeable

// Height of the loom
height=20;

// Width of the loom (default 100)
width=100;

// Length of the loom (default 180)
length=180;

// Thickness of the supports in mm (default 4mm)
supportThickness=4;

// The number of supports besides the end pieces to add
supports=0;

// Width of the sides (default 12)
sideWidth=12;

// What to show/render
show="all"; // [all:All parts, loom:Just the loom, kamm:Just the kamm, nadel:Just the nadel]


// [Hidden]

yarnInset=15;
yarnCount=(width-yarnInset) / 7.9 + 0.5;



$fn=90;

if (show == "all") {
    translate([0,40,0]) loom();
    translate([0,20,0]) kamm();
    nadel();
}
else if (show == "loom") {
    loom();
}
else if (show == "kamm") {
    kamm();
}
else if (show == "nadel") {
    nadel();
}

module loom(){
    difference() {
        union() {
            difference(){
                cube([width, length, height]);
                translate([supportThickness,sideWidth,-0.1]) cube([width - supportThickness*2, length-sideWidth*2, height]);

                for (i = [1:yarnCount]){
                    #translate([i*7.9+1,-1,height-5]) cube([2,length+3,5.5]);
                }
                translate([0,length-1,0]) cube([width,5,height-2]);
                translate([0,-4,0]) cube([width,5,height-2]);
            }
            if (supports > 0) {
                for (i = [1:supports]) {
                    pieceSize = width / (supports+1);
                    curPiece = pieceSize * i - supportThickness/2;
                    //echo("Current piece:", curPiece);
                    translate([curPiece, 5, 0]) cube([supportThickness, length-10, supportThickness]);
                }
            }
        }
        translate([-1,length/2, height]) rotate([0,90,0])
            linear_extrude(height=width+2) resize([height*1.25, length-sideWidth*2]) circle(d=length-sideWidth*2);
   }
}

kammWidth = yarnCount*7.9 - 6.5;

module kamm(){
    difference(){
        minkowski() {
            cube([kammWidth, 15, 3]);
            cylinder(r=2,h=1);
        }
        for (i = [1:yarnCount]) {
            #translate([i*7.9-6.5,-3,-0.1]) cube([2.5,10,5]);
        }
    }
}

module nadel(){
    difference() {
        hull() {
            translate([0,5,0])  cylinder(r=1,h=1);
            translate([50,0,0]) cube([41,10,2]);
            translate([95,5,0])  cylinder(r=5,h=2);
        }
        hull(){
            translate([89,5,-0.1])  cylinder(r=3.5,h=2.5);
            translate([83,5,-0.1])  cylinder(r=3.5,h=2.5);
        }
    }
}
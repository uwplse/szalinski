/* dial.scad
 *
 * Copyright (C) Robert B. Ross, 2014
 *
 * This software is released under the Creative Commons
 * Attribution-ShareAlike 4.0 International Public License.
 *
 * Spiff Sans code from Stuart P. Bentley <stuart@testtrack4.com>, downloaded 
 * 9/26/2014, released under the Creative Commons - Public Domain Dedication
 * license.
 *
 * TODO:
 *
 */

/* [Global] */

Maneuver_1 = "1L"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_2 = "1R"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_3 = "2L"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_4 = "2l"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_5 = "2S"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_6 = "2r"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_7 = "2R"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_8 = "3L"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_9 = "3l"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_10 = "3S"; //[0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_11 = "3r"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_12 = "3R"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_13 = "3K"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_14 = "4S"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_15 = "5S"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]
Maneuver_16 = "5K"; // [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2S: 2 Straight, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3S: 3 Straight, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn ]

part = "bottom"; // [bottom, top, pin]

/* [Hidden] */

$fn=120;
extRad = 20; // in mm
outerPostRad = 4;
innerPostRad = 2;
myScale=1.1;

/* MakerBot scheme for creating multiple STLs involves a "part" variable. */
if (1) {
    if (part == "bottom")   { scale([myScale,myScale,1]) dialBottom(); }
    else if (part == "top") { scale([myScale,myScale,1]) dialTop(); }
    else if (part == "pin") { scale([myScale,myScale,1]) pin(); }
}
else {
    /* cut-away view */
    difference() {
	union() {
	    dialBottom();
	    rotate([0,0,360/16*8]) translate([0,0,5.4]) rotate([180,0,0]) dialTop();
	    translate([0,0,6.5]) rotate([180,0,0]) pin();
	}
	translate([0,-40,-0.01]) cube([40,40,40], center=false);	
    }
}

/******** DIAL MODULES ********/

module dialBottom() {
    difference() {
	union() {
	    cylinder(r=extRad,h=3);
	    cylinder(r=outerPostRad, h=5.2);
	}
	translate([0,0,2]) cylinder(r=innerPostRad, h=7);
	translate([-0.2,0,3]) cube([0.4, outerPostRad+0.01, 7+0.01]);
    }
    translate([0,0,1]) maneuvers();
}

module dialTop() {
    difference() {
	union() {
	    cylinder(r=extRad,h=2.3);
	}
	union() {
	    translate([0,0,-0.01]) cylinder(r=outerPostRad, h=7);
	    translate([0,0,1.2]) cylinder(r=extRad - 2, h=1.21);
	    translate([0,7,-0.01]) linear_extrude(height=3.02)
		polygon(points = [[-2,0], [-4,11], [4,11], [2,0]],
			paths = [[0,1,2,3,0]]);
	}
    }
}

module pin() {
    pinSlop = 0.15; // pin won't actually fit if precisely same diameter as hole.

    cylinder(r=outerPostRad+2, h=1);
    cylinder(r=innerPostRad - pinSlop, h=4);
}

/******** MANEUVER MODULES ********/

module maneuvers() {
    mArray = [ Maneuver_1, Maneuver_2, Maneuver_3, Maneuver_4, Maneuver_5,
	       Maneuver_6, Maneuver_7, Maneuver_8, Maneuver_9, Maneuver_10,
	       Maneuver_11, Maneuver_12, Maneuver_13, Maneuver_14,
	       Maneuver_15, Maneuver_16];
    for (i=[0:15]) {
	rotate([0,0,-1* 360/16*i]) maneuver(mArray[i]);
    }
}

module maneuver(m) {
    // translate([-1.3,9,0]) scale([0.5,0.5,3]) drawtext(m[0]);
    translate([-1.3,8.5,1.5]) scale([0.4,0.4,1]) linear_extrude(height=1.5)
	write(m[0]);

    translate([0,-1,0]) {
	if (m[1] == "L") {
	    mirror([1,0,0]) rightTurnIcon();
	}
	else if (m[1] == "l") {
	    mirror([1,0,0]) rightBankIcon();
	}
	else if (m[1] == "S") {
	    straightIcon();
	}
	else if (m[1] == "X") {
	    stopIcon();
	}
	else if (m[1] == "r") {
	    rightBankIcon();
	}
	else if (m[1] == "R") {
	    rightTurnIcon();
	}
	else if (m[1] == "K") {
	    kTurnIcon();
	}
    }
}

/******** ARROW MODULES ********/

module straightIcon() {
    straightPoints = [[-0.8,0], [-0.8,3], [-1.6,3], [0,4.6],
		      [1.6,3], [0.8,3], [0.8,0]];
    straightPath = [[0,1,2,3,4,5,6,0]];

    translate([0,14,0]) linear_extrude(height=3) {
	polygon(points=straightPoints, paths = straightPath);
    }
}

module stopIcon() {
    stopPoints = [[-0.6,1], [-0.6,2.2], [0.6,2.2], [0.6,1]];
    stopPath   = [[0,1,2,3,0]];

    translate([0,14,0]) linear_extrude(height=3) {
	scale([1.5,1.5,0]) polygon(points=stopPoints, paths=stopPath);
    }
}

module rightTurnIcon() {
    rightTurnPoints = [[-2, 0], [-2,3.6], [0,3.6], [0,4.4],
		       [1.4,3], [0,1.6], [0,2.4], [-0.6,2.4], [-0.6,0]];
    rightTurnPath = [[0,1,2,3,4,5,6,7,8]];
 
     translate([0.4,14,0]) linear_extrude(height=3) {
	polygon(points=rightTurnPoints, paths=rightTurnPath);
    }
}
    
module rightBankIcon() {
    rightBankPoints = [[-1.6,0], [-1.6,2.4], [-0.8,3.2], [-1.6,4], [1.2,4],
		       [1.2,1.2], [0.4,2], [-0.2,1.6], [-0.2,0]];
    rightBankPath   = [[0,1,2,3,4,5,6,7,8,0]];

    translate([0.4,14,0]) linear_extrude(height=3) {
	polygon(points=rightBankPoints, paths=rightBankPath);
    }
}

module kTurnIcon() {
    kTurnPoints = [[-0.8,0], [-0.8,4], [2.4,4], [2.4,2], [3.2,2],[2,1.0],
		   [0.8,2], [1.6,2], [1.6,3.2], [0.4,3.2], [0.4,0]];
    kTurnPath   = [[0,1,2,3,4,5,6,7,8,9,10,0]];
    translate([-0.8,14,0]) linear_extrude(height=3) {
	polygon(points=kTurnPoints, paths=kTurnPath);
    }
}

/******** BEGIN SPIFF SANS MODULES ********/


// Spiff Sans
// Author: Stuart P. Bentley <stuart@testtrack4.com>
// Version: 2.1.0

spiffsans = [
  ["",10,[[[0,5],[5,0],[10,5],[5,10],[4.5,8],[5.5,8],[6.75,6.75],[6.75,5.75],[5.5,4.5],[5.5,3.75],[4.5,3.75],[4.5,4.75],[5.75,6],[5.75,6.5],[5.25,7],[4.75,7],[4.25,6.5],[4.25,6],[3.25,6],[3.25,6.75],[4.5,3],[5.5,3],[5.5,2],[4.5,2]],[[0,1,2,3],[4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19],[20,21,22,23]]]],
  ["0",6,[[[5,0],[1,0],[0,2],[0,8],[1,10],[5,10],[6,8],[6,2],[2,8],[2,5],[4,8],[2,2],[4,2],[4,5]],[[0,1,2,3,4,5,6,7],[8,9,10],[11,12,13]]]],
  ["1",5,[[[0,0],[0,2],[2,2],[2,7],[0,7],[2,10],[4,10],[4,2],[5,2],[5,0]],[[0,1,2,3,4,5,6,7,8,9]]]],
  ["2",6,[[[0,0],[0,2],[4,6],[4,8],[2,8],[2,6],[0,6],[0,8],[1,10],[5,10],[6,8],[6,5.5],[2.5,2],[6,2],[6,0]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]]],
  ["3",6,[[[1,0],[0,2],[0,4],[2,4],[2,2],[4,2],[4,4],[3,4],[3,6],[4,6],[4,8],[2,8],[2,6],[0,6],[0,8],[1,10],[5,10],[6,8],[6,6],[5.5,5],[6,4],[6,2],[5,0]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]]]],
  ["4",6,[[[4,0],[4,4],[0,4],[0,10],[2,10],[2,6],[4,6],[4,10],[6,10],[6,0]],[[0,1,2,3,4,5,6,7,8,9]]]],
  ["5",6,[[[0,0],[0,2],[4,2],[4.5,3],[4,4],[0,4],[0,10],[6,10],[6,8],[2,8],[2,6],[5,6],[6,4],[6,2],[5,0]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]]],
  ["6",6,[[[1,0],[0,2],[0,8],[1,10],[5,10],[5.5,8],[2,8],[2,6],[5,6],[6,4],[6,2],[5,0],[2,2],[4,2],[4,4],[2,4]],[[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15]]]],
  ["7",5,[[[1,0],[1,3],[3,8],[0,8],[0,10],[5,10],[5,8],[3,3],[3,0]],[[0,1,2,3,4,5,6,7,8]]]],
  ["8",6,[[[1,0],[0,2],[0,4],[0.5,5],[0,6],[0,8],[1,10],[5,10],[6,8],[6,6],[5.5,5],[6,4],[6,2],[5,0],[2,6],[4,6],[4,8],[2,8],[2,2],[4,2],[4,4],[2,4]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13],[14,15,16,17],[18,19,20,21]]]],
  ["9",6,[[[1,0],[0,2],[4,2],[4,4],[1,4],[0,6],[0,8],[1,10],[5,10],[6,8],[6,2],[5,0],[2,6],[4,6],[4,8],[2,8]],[[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15]]]]
];

module write(string,font=spiffsans,spacing=1,i=0) {
  if (i < len(string)) {
    assign(charindex = search(string[i],font,1)[0])
    
    // If the character is in the font
    if (charindex != undef) {
      assign(glyph = font[charindex][2])
      if (glyph){
        polygon(points=glyph[0], paths=glyph[1]);
      }
      translate([font[charindex][1] + spacing, 0, 0])
        write(string, font, spacing, i=i+1);
    } else {
      assign(glyph = font[0][2])
      if (glyph){
        polygon(points=glyph[0], paths=glyph[1]);
      }
      translate([font[0][1] + spacing,0,0])
        write(string, font, spacing, i=i+1);
    }
  }
}

/******** END SPIFF SANS MODULES ********/

/*
 * Local variables:
 *  mode: C
 *  c-indent-level: 4
 *  c-basic-offset: 4
 * End:
 *
 * vim: ts=8 sts=4 sw=4 expandtab
 */

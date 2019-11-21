/* dial insert 1.0
    Derivative work by
    Edwin Edgerly, 2019
    Derivative from https://www.thingiverse.com/thing:1513653
    
   I modified the code to generate a dial insert that can be used with any of the dials used to hold the standard cardboard inserts.
   
   I made a number of the parameters into variables to make for easy tweaking.
   
 * dialV2.scad
 *
 * Copyright (C) Robert B. Ross, 2014
 *
 * Version 2.0 adjustments by Ludwig W. Wall, 2016
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

// Leave last ones empty: "" and the script will adapt to the number of maneuvers (min 12, up to 20)
// Number = distance, letter = maneuver. 
// X=Stop, L=left turn, l=left Bank, lS=left Segnor's Loop, LT=left Tallon Roll, S=straight, RT=right Tallon Roll, rS=right Segnor's Loop, r=right Bank, R=right turn. 
// All maneuvers:
// [0X: Stop, 1L: 1 Left Turn, 1l: 1 Left Bank, 1S: 1 Straight, 1r: 1 Right Bank, 1R: 1 Right Turn, 1K: 1 K-Turn, 2L: 2 Left Turn, 2l: 2 Left Bank, 2lS: 2 Left Segnor's Loop, 2S: 2 Straight, 2rS: 2 Right Segnor's Loop, 2r: 2 Right Bank, 2R: 2 Right Turn, 2K: 2 K-Turn, 3L: 3 Left Turn, 3l: 3 Left Bank, 3lT: 3 Left Tallon Roll, 3S: 3 Straight, 3rT: 3 Right Tallon Roll, 3r: 3 Right Bank, 3R: 3 Right Turn, 3K: 3 K-Turn, 4S: 4 Straight, 4K: 4 K-Turn, 5S: 5 Straight, 5K: 5 K-Turn]



// Mods to use:
use <text_on.scad>


Maneuver_1 = "1L"; 
Maneuver_2 = "1R"; 
Maneuver_3 = "2L"; 
Maneuver_4 = "2l"; 
Maneuver_5 = "2S"; 
Maneuver_6 = "2r"; 
Maneuver_7 = "2R"; 
Maneuver_8 = "3lS"; 
Maneuver_9 = "3L"; 
Maneuver_10 = "3l";
Maneuver_11 = "3S"; 
Maneuver_12 = "3r"; 
Maneuver_13 = "3R"; 
Maneuver_14 = "3rS"; 
Maneuver_15 = "4S"; 
Maneuver_16 = "4K"; 
Maneuver_17 = "5S"; 
Maneuver_18 = ""; 
Maneuver_19 = ""; 
Maneuver_20 = ""; 


/* [Hidden] */

$fn=120;
extRad = 22; // in mm
HoleRad = 4.1;
ArrowRad = 17;
NumberRad = 11;
BaseThick = 1;
TextThick =1;
Hub = "yes"; //yes or no
HubWidth = 4;
HubHeight = 1;
ring = "yes"; //yes or no
RingWidth = 1.2;
RingHeight = 1;

    { scale([1,1,1]) dial(); }
     

/******** DIAL MODULE ********/

module dial() {
    difference() {
	    cylinder(r=extRad,h=BaseThick);
	    cylinder(r=HoleRad, h=BaseThick); 
	};    
    }

    translate([0,0,BaseThick]) maneuvers();
    if (Hub == "yes" ) {translate([0,0,BaseThick]) centerhub() ;}
    if (ring == "yes" ) {translate([0,0,BaseThick]) outerring() ;}
    
/******** Hub Module ***************/
 
module centerhub() {
    difference() {
	    cylinder(r=HoleRad+HubWidth,h=HubHeight);
	    cylinder(r=HoleRad, h=HubHeight); 
	};  
}

/******** Ring Module ***************/
 
module outerring() {
    difference() {
	    cylinder(r=extRad,h=
        ringHeight);
	    cylinder(r=extRad-RingWidth, h=RingHeight); 
	};  
}

/******** MANEUVER MODULES ********/

module maneuvers() {
    mArray = [ Maneuver_1, Maneuver_2, Maneuver_3, Maneuver_4, Maneuver_5,
	       Maneuver_6, Maneuver_7, Maneuver_8, Maneuver_9, Maneuver_10,
	       Maneuver_11, Maneuver_12, Maneuver_13, Maneuver_14,
	       Maneuver_15, Maneuver_16, Maneuver_17, Maneuver_18, Maneuver_19, Maneuver_20];
    
    lessManeuvers = (Maneuver_13 == "") ? (8) : ((Maneuver_14 == "") ? (7) : ((Maneuver_15 == "") ? (6) : ((Maneuver_16 == "") ? (5) : ((Maneuver_17 == "") ? (4) : ((Maneuver_18 == "") ? (3) : ((Maneuver_19 == "") ? (2) : ((Maneuver_20 == "") ? (1) : (0))))))));
    
    echo(lessManeuvers=lessManeuvers);
    
    for (i=[0:len(mArray)-1-lessManeuvers]) {
	rotate([0,0,-1* 360/(len(mArray)-lessManeuvers)*i]) maneuver(mArray[i]);
    }
}

module maneuver(m) {
    translate([-1.3,NumberRad,0]) scale([0.4,0.4,1]) linear_extrude(height=TextThick)
	write(m[0]);

    translate([0,-1,0]) {
    if (m[2] == "S") {
        if (m[1] == "r") {
            rightSLoopIcon();

        } else if (m[1] == "l") {
            mirror([1,0,0]) rightSLoopIcon();
        }
	}
    else if (m[2] == "T") {
        if (m[1] == "R") {
            rightTalonIcon();
        } else if (m[1] == "L") {
            mirror([1,0,0]) rightTalonIcon();
        }
	}
	else if (m[1] == "L") {
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

    translate([0,ArrowRad,0]) linear_extrude(height=TextThick) {
	polygon(points=straightPoints, paths = straightPath);
    }
}

module stopIcon() {
    stopPoints = [[-0.6,1], [-0.6,2.2], [0.6,2.2], [0.6,1]];
    stopPath   = [[0,1,2,3,0]];

    translate([0,ArrowRad,0]) linear_extrude(height=TextThick) {
	scale([1.5,1.5,0]) polygon(points=stopPoints, paths=stopPath);
    }
}

module rightTurnIcon() {
    rightTurnPoints = [[-2, 0], [-2,3.6], [0,3.6], [0,4.4],
		       [1.4,3], [0,1.6], [0,2.4], [-0.6,2.4], [-0.6,0]];
    rightTurnPath = [[0,1,2,3,4,5,6,7,8]];
 
     translate([0.4,ArrowRad,0]) linear_extrude(height=TextThick) {
	polygon(points=rightTurnPoints, paths=rightTurnPath);
    }
}
    
module rightBankIcon() {
    rightBankPoints = [[-1.6,0],[-1.58,2.2],[-1.57,2.4],[-1.56,2.5],[-1.55,2.6],[-1.52,2.7],[-1.48,2.8],[-1.42,2.9],[-1.35,3],[-1.24,3.1],[-1.10,3.2],[-0.9,3.3], [0.4-0.2,2+0.5],[0.4-0.34,2+0.4],[0.4-0.45,2+0.3],[0.4-0.52,2+0.2],[0.4-0.58,2+0.1],[0.4-0.62,2-0],[0.4-0.65,2-0.1],[0.4-0.66,2-0.2],[0.4-0.67,2-0.3],[0.4-0.68,2-0.4], [-0.28,0]];
    rightBankArrowPoints = [[-1.5,3.9], [0.7,3.9],[0.7,1.7]];

    translate([0.4,ArrowRad,0]) linear_extrude(height=TextThick) {
        polygon(points=rightBankPoints);
        polygon(points=rightBankArrowPoints);
    }
}

module rightTalonIcon() {
    
    rightTalonPoints = [[-0.8,0], [-0.8,4], [2.4,2.8], [2.4,2], [3.2,2],[2,1.0],
		   [0.8,2], [1.6,2], [1.6,2.8], [0.4,3.2], [0.4,0], [2.4,4], [2.4,3.2]];
    rightTalonPath = [[2,3,4,5,6,7,8],[10,0,1,11,12,9]];
 
    translate([-0.8,ArrowRad,0]) linear_extrude(height=TextThick) {
        polygon(points=rightTalonPoints, paths=rightTalonPath);
    }
}

module rightSLoopIcon() {
    
    rightSLoopPoints = [[-1.6,-0.8],[-1.58,2.2],[-1.57,2.4],[-1.56,2.5],[-1.55,2.6],[-1.52,2.7],[-1.48,2.8],[-1.42,2.9],[-1.35,3],[-1.24,3.1],[-1.10,3.2],[-0.35,3.55], [0.8-0.2,2.1+0.55],[0.4-0.34,2+0.4],[0.4-0.45,2+0.3],[0.4-0.52,2+0.2],[0.4-0.58,2+0.1],[0.4-0.62,2-0],[0.4-0.65,2-0.1],[0.4-0.66,2-0.2],[0.4-0.67,2-0.3],[0.4-0.68,2-0.4], [-0.28,-0.8]];
    rightSLoopArrowPoints = [[-1.4,3.1], [-1.4,1.7],[0,1.7]];

    
    translate([0.4,ArrowRad,0]) linear_extrude(height=TextThick) {
        translate([-0.2,0.8,0])
        polygon(points=rightSLoopPoints);
        scale([1.3,1.5,0])
        translate([1.8,-0.8,0])
        polygon(points=rightSLoopArrowPoints);
        rotate(45,[0,0,1])
        scale([1.4,1,0])
        translate([1.6,0.2,0])
        polygon(points=[[1,0],[1,1],[0,1],[0,0]]);
    }
}

module kTurnIcon() {
    kTurnPoints = [[-0.8,0], [-0.8,3.75], [-0.55,4], [2.4-0.25,4], [2.4,4-0.25], [2.4,2], [3.2,2],[2,1.0],
		   [0.8,2], [1.6,2], [1.6,3.2-0.25], [1.6-0.25,3.2], [0.4+0.25,3.2], [0.4,3.2-0.25], [0.4,0]];
    translate([-0.8,ArrowRad,0]) linear_extrude(height=TextThick) {
	scale([1.2,1,0])
    polygon(points=kTurnPoints);
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

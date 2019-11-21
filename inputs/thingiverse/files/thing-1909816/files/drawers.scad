/*

Customizable drawer box
Tom Bull
from a model by Gian Pablo Villamil
November 2016

*/

use <write/Write.scad>;

/* [Basic] */

// How many drawers from bottom to top?
NUM_DRAWERS_HIGH = 5;
// How many drawers from left to right?
NUM_DRAWERS_WIDE = 3;
// How high?
CABINET_HEIGHT = 151;
// How deep?
CABINET_DEPTH_INC_HANDLES = 165;
// How wide?
CABINET_WIDTH = 260;
// Number of sections from front to back
NUM_SECTIONS_DEEP = 2;
// Number of sections from left to right
NUM_SECTIONS_WIDE = 2;
// Which part to create
part = "drawer"; // [drawer:Drawer, cabinet:Cabinet]

/* [Advanced] */

// Handle depth
HANDLE_DEPTH = 12;
// Handle height
HANDLE_HEIGHT = 15;
// Handle width
HANDLE_WIDTH = 60;

// Corner radius
DRAWER_CORNER_RAD = 2;

// Clearance
CLEARANCE = 0.6;
// Wall thickness
WALL_THICKNESS = 1.6;
// Floor thickness
FLOOR_THICKNESS = 1.6;
// Divider thickness
DIVIDER_THICKNESS = 0.8;
// Rounded fillets
FILLETS = true; // [true:enabled, false:disabled]



/* [Hidden] */

$fn = 32;
NOFILLETS = !FILLETS;
INNER_FILLET = DRAWER_CORNER_RAD-(WALL_THICKNESS/1.25);
DRAWER_HOLE_WIDTH = (CABINET_WIDTH - (1+NUM_DRAWERS_WIDE)*WALL_THICKNESS) / NUM_DRAWERS_WIDE;
DRAWER_WIDTH = DRAWER_HOLE_WIDTH - 2*CLEARANCE;
DRAWER_INNER_WIDTH = DRAWER_WIDTH - 2*WALL_THICKNESS;
NUM_DIVIDERS_WIDE = NUM_SECTIONS_WIDE-1;
SECTION_INNER_WIDTH = (DRAWER_INNER_WIDTH - NUM_DIVIDERS_WIDE*DIVIDER_THICKNESS) / NUM_SECTIONS_WIDE;
DRAWER_HOLE_HEIGHT = (CABINET_HEIGHT - (1+NUM_DRAWERS_HIGH)*FLOOR_THICKNESS) / NUM_DRAWERS_HIGH;
DRAWER_HEIGHT = DRAWER_HOLE_HEIGHT - 2*CLEARANCE;
CABINET_DEPTH = CABINET_DEPTH_INC_HANDLES - HANDLE_DEPTH;
DRAWER_HOLE_DEPTH = CABINET_DEPTH - WALL_THICKNESS;
DRAWER_DEPTH = DRAWER_HOLE_DEPTH - CLEARANCE;
DRAWER_INNER_DEPTH = DRAWER_DEPTH - 2*WALL_THICKNESS;
NUM_DIVIDERS_DEEP = NUM_SECTIONS_DEEP-1;
SECTION_INNER_DEPTH = (DRAWER_INNER_DEPTH - NUM_DIVIDERS_DEEP*DIVIDER_THICKNESS) / NUM_SECTIONS_DEEP;
HANDLE_EXTENDED_DEPTH = HANDLE_DEPTH + 2*DRAWER_CORNER_RAD;
HANDLE_INNER_WIDTH = HANDLE_WIDTH - 2*WALL_THICKNESS;
HANDLE_INNER_HEIGHT = HANDLE_HEIGHT - FLOOR_THICKNESS;
HANDLE_INNER_DEPTH = HANDLE_DEPTH - WALL_THICKNESS;

//
print_part();

module print_part() {
	if (part == "drawer") {
		drawer();
	} else {
		cabinet();
	}
}


module cabinet() {
	difference () {
		cube([CABINET_WIDTH, CABINET_DEPTH, CABINET_HEIGHT]);
		for (i=[0:NUM_DRAWERS_WIDE-1]) {
			for (j=[0:NUM_DRAWERS_HIGH-1]) {
				translate([WALL_THICKNESS+i*(DRAWER_HOLE_WIDTH+WALL_THICKNESS),-WALL_THICKNESS,j*(DRAWER_HOLE_HEIGHT+FLOOR_THICKNESS)+FLOOR_THICKNESS])
				cube([DRAWER_HOLE_WIDTH,DRAWER_HOLE_DEPTH,DRAWER_HOLE_HEIGHT]);
			}
		}
	}
};

module drawer() {
	difference() {
		drawerbase();
		for (i=[0:NUM_SECTIONS_WIDE-1]) {
			for (j=[0:NUM_SECTIONS_DEEP-1]) {
				translate([	-DRAWER_WIDTH/2+SECTION_INNER_WIDTH/2+WALL_THICKNESS+i*(SECTION_INNER_WIDTH+DIVIDER_THICKNESS),
										-DRAWER_DEPTH/2+SECTION_INNER_DEPTH/2+WALL_THICKNESS+j*(SECTION_INNER_DEPTH+DIVIDER_THICKNESS),
										FLOOR_THICKNESS+DRAWER_CORNER_RAD/2])
					roundedBox([SECTION_INNER_WIDTH,SECTION_INNER_DEPTH,DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
			}
		}
}};

module drawerbase() {
	union() {
		difference() {
			translate([0,0,DRAWER_CORNER_RAD/2])
				roundedBox([DRAWER_WIDTH,DRAWER_DEPTH,DRAWER_HEIGHT+DRAWER_CORNER_RAD],DRAWER_CORNER_RAD,NOFILLETS);
			translate([0,0,DRAWER_HEIGHT])
				cube([DRAWER_HOLE_WIDTH, DRAWER_HOLE_DEPTH,DRAWER_HEIGHT],center=true);
		}
		translate([-HANDLE_WIDTH/2,-DRAWER_DEPTH/2-HANDLE_DEPTH,-DRAWER_HEIGHT/2])
			handle();
	};
};

module handle() {

	difference() {
		HandlePoints = [
			[0,							0,											0],
			[HANDLE_WIDTH,	0,											0],
			[HANDLE_WIDTH, 	HANDLE_EXTENDED_DEPTH, 	0],
			[0, 						HANDLE_EXTENDED_DEPTH, 	0],
			[0, 						HANDLE_DEPTH, 					HANDLE_HEIGHT],
			[HANDLE_WIDTH, 	HANDLE_DEPTH, 					HANDLE_HEIGHT],
			[HANDLE_WIDTH, 	HANDLE_EXTENDED_DEPTH, 	HANDLE_HEIGHT],
			[0, 						HANDLE_EXTENDED_DEPTH,	HANDLE_HEIGHT]
		];
		HandleFaces = [
			[0,1,2,3],  // bottom
		  [4,5,1,0],  // front
		  [7,6,5,4],  // top
		  [5,6,2,1],  // right
		  [6,7,3,2],  // back
		  [7,4,0,3]		// left
		];
		HandleInnerPoints = [
			[0,										0,									0],
			[HANDLE_INNER_WIDTH,	0,									0],
			[HANDLE_INNER_WIDTH, 	HANDLE_INNER_DEPTH, 0],
			[0, 									HANDLE_INNER_DEPTH, 0],
			[0, 									HANDLE_INNER_DEPTH, HANDLE_INNER_HEIGHT],
			[HANDLE_INNER_WIDTH, 	HANDLE_INNER_DEPTH, HANDLE_INNER_HEIGHT]
		];
		HandleInnerFaces = [
			[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]
		];
		polyhedron(HandlePoints, HandleFaces);
		translate([WALL_THICKNESS, WALL_THICKNESS, 0])
			polyhedron(HandleInnerPoints, HandleInnerFaces);
	};
};

// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: BSD

// roundedBox([width, height, depth], float radius, bool sidesonly);

// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);

// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}

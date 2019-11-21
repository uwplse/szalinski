/*

Customizable drawer box
Gian Pablo Villamil
August 4, 2014

v1 first iteration
v2 added drawer handle
v3 added full fillets, tweaked wall thickness and corner handling
v4 added text label
v5 added hex patterning on the sides
v6 added dimple stop to drawers and box

Antonio Drusin
January 24, 2017
v7 added multiple columns of drawers, multi spaces in drawer

*/

use<write.scad>; // I cannot get the text to work. IDK

/* [General] */

// Which one would you like to see?
part = "drawerbox"; // [drawer: drawer, drawerbox:drawer housing]

/* [General Size] */
// How many drawers horizontally?
NUM_DRAWERS_W = 2;
// How many drawers vertically?
NUM_DRAWERS_H = 5;

/* [Drawer Compartments] */
// How many compartments across the width?
NUM_SPACES_W = 4;
// How many compartments across the depth?
NUM_SPACES_H = 1;

/* [Drawer Dimensions] */
// How high is a drawer?
DRAWER_HEIGHT = 15;
// How deep is a drawer?
DRAWER_DEPTH = 70;
// How wide is a drawer?
DRAWER_WIDTH = 60;

/* [Special] */
// Do you want mouse ears to attach this drawer to a wall?
SCREW_PADS = 0;  // [0:No, 1:Yes]
MOUSE_EARS = (SCREW_PADS==1)? true:false;

/* [Pattern] */
// Do you want a hexagonal pattern on the box?
HEXAGONAL_PATTERN = 1; // [0:No, 1:Yes]
WITH_PATTERN = (HEXAGONAL_PATTERN==1)?true:false;
// Pattern inner diameter
PATTERN_INNER_DIAMETER = 6 ;
PATTERN_SPACING = 1.2;
dia = PATTERN_INNER_DIAMETER + (PATTERN_SPACING * 2);
hoff = PATTERN_INNER_DIAMETER+PATTERN_SPACING;
voff = sqrt(pow(hoff,2)-pow(hoff/2,2));

/* [Handle] */
// How deep is the drawer's handle?
HANDLE_SIZE = 10;
// How wide is the drawer's handle?
HANDLE_WIDTH = 15;


/* [Advanced] */

// Corner radius?
DRAWER_CORNER_RAD = 2;
// Clearance for sliding drawers in
CLEARANCE = 0.25;
// Separator wall thickness, Make this a multiple of your nozzle size.
DRAWER_SEPARATOR_THICK = 0.4;
// Wall thickness
WALL_THICK = 0.8;
// Floor thickness
FLOOR_THICK = 0.8;
// Rounded fillets?
ROUNDED_FILLETS = 1; // [0:No, 1:Yes]
FILLETS = (ROUNDED_FILLETS==1)?true:false;


/* [Hidden] */
// Label on the drawer
MESSAGE = "";
// Text height
TEXT_HEIGHT = 6;

$fn = 32;
NOFILLETS = !FILLETS;
WALL_WIDTH = WALL_THICK + 0.001; // Hack to trick Makerware into making the right number of filament widths
INNER_FILLET = DRAWER_CORNER_RAD-(WALL_WIDTH/1.25);

BOX_HEIGHT = NUM_DRAWERS_H*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH;
BOX_WIDTH = NUM_DRAWERS_W*(DRAWER_WIDTH+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH;
BOX_DEPTH = DRAWER_DEPTH+CLEARANCE+WALL_WIDTH;

thick = WALL_THICK + 0.2;
bumprad = 1;

earthick = 0.6;
earrad = 10;

compartment_width = ((DRAWER_WIDTH - 2*WALL_THICK) - (DRAWER_SEPARATOR_THICK * (NUM_SPACES_W - 1))) / NUM_SPACES_W;
compartment_height = ((DRAWER_DEPTH - 2*WALL_THICK) - (DRAWER_SEPARATOR_THICK * (NUM_SPACES_H - 1))) / NUM_SPACES_H;

//  
print_part();

module print_part() {
	if (part == "drawer") {
		drawer();
	} else {
		drawerbox();
	}
}


module drawerbox() {
	translate([-BOX_WIDTH/2,-BOX_DEPTH/2,0])
	union () {
		difference () {
			cube([BOX_WIDTH,BOX_DEPTH,BOX_HEIGHT]);
            for (x=[0:NUM_DRAWERS_W-1]) {
                for (i=[0:NUM_DRAWERS_H-1]) {
                    translate([x*(DRAWER_WIDTH+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH,-1,
                    i*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH])
                    cube([DRAWER_WIDTH+CLEARANCE*2,DRAWER_DEPTH+CLEARANCE+1,DRAWER_HEIGHT+CLEARANCE*2]);
                }
            }
        
        if ( WITH_PATTERN ) {    
            translate([0,BOX_DEPTH+0.1,0])
            holes(BOX_WIDTH,BOX_HEIGHT);
            rotate([0,0,90]) 
                translate([hoff/2,0.1,0]) 
                holes(BOX_DEPTH,BOX_HEIGHT);
            rotate([0,0,90]) 
                translate([hoff/2,-BOX_WIDTH+WALL_WIDTH+0.1,0]) 
                holes(BOX_DEPTH,BOX_HEIGHT);
		}
    }
        
        
        for (x=[0:NUM_DRAWERS_W-1]) {
            for (i=[0:NUM_DRAWERS_H-1]) {
                translate([x*(DRAWER_WIDTH+CLEARANCE*2+WALL_WIDTH)+DRAWER_WIDTH/2+ WALL_WIDTH,
                DRAWER_CORNER_RAD*2,
                i*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH-0.1])
                {
                    scale([1,1,0.9]) half_sphere(bumprad);
                //    translate([0,0,DRAWER_HEIGHT+CLEARANCE*2+0.2]) rotate([180,0,0])
                 //   scale([1,1,0.9]) half_sphere(bumprad);
                }
            }
        }
        
        // mouse ears
        if ( MOUSE_EARS ) {
            translate([-earrad/2,BOX_DEPTH,-earrad/2]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
            translate([BOX_WIDTH+earrad/2,BOX_DEPTH,-earrad/2]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
            translate([-earrad/2,BOX_DEPTH,BOX_HEIGHT+earrad/2]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
            translate([BOX_WIDTH+earrad/2,BOX_DEPTH,BOX_HEIGHT+earrad/2]) rotate([90,0,0]) cylinder(r=earrad,earthick);
        }

	}
};

module drawer() {
	difference() {
		drawerbase();        
        
        for (x=[0:NUM_SPACES_W-1]) {
            for (y=[0:NUM_SPACES_H-1]) {
                //translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),DRAWER_DEPTH/4-WALL_WIDTH/4,FLOOR_THICK+DRAWER_CORNER_RAD/2]) 
                translate([
                    DRAWER_WIDTH/2 + (-x-0.5) * compartment_width - x * DRAWER_SEPARATOR_THICK - WALL_WIDTH,
                    DRAWER_DEPTH/2 + (-y-0.5) * compartment_height - y * DRAWER_SEPARATOR_THICK - WALL_WIDTH,
                    FLOOR_THICK+DRAWER_CORNER_RAD/2])
                    roundedBox([ 
                        compartment_width ,
                        compartment_height ,
                        DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET, NOFILLETS);                
            }
        }        
        

}};

module drawerbase() {
	union() {
		difference() {
			translate([0,0,DRAWER_CORNER_RAD/2]) roundedBox([DRAWER_WIDTH,DRAWER_DEPTH,DRAWER_HEIGHT+DRAWER_CORNER_RAD],DRAWER_CORNER_RAD,NOFILLETS);
			translate([0,0,DRAWER_HEIGHT]) cube([DRAWER_WIDTH+1, DRAWER_DEPTH+1,DRAWER_HEIGHT],center=true);
			translate([0,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1.]) sphere(bumprad);
			translate([0,DRAWER_DEPTH/2-DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1.]) sphere(bumprad);
		}
	translate([0,-DRAWER_DEPTH/2,-DRAWER_HEIGHT/2+FLOOR_THICK]) 
	handle();
	
	translate([-DRAWER_WIDTH/2+DRAWER_CORNER_RAD,-DRAWER_DEPTH/2+0.5,-DRAWER_HEIGHT/4+DRAWER_CORNER_RAD/2]) rotate([90,0,0]) 
	write(MESSAGE,h=TEXT_HEIGHT,font="Orbitron.dxf");
	};
};

module handle() {

	difference() {
		roundedBox([HANDLE_WIDTH,HANDLE_SIZE*2,FLOOR_THICK*2],2,true);
		translate([0,HANDLE_SIZE,0]) cube([HANDLE_WIDTH+1,HANDLE_SIZE*2,FLOOR_THICK*2+4],center=true);
	};
	
	difference() { 
		translate([0,-DRAWER_CORNER_RAD/2,FLOOR_THICK+DRAWER_CORNER_RAD/2]) {
			cube([HANDLE_WIDTH,DRAWER_CORNER_RAD,DRAWER_CORNER_RAD],center=true);
        }
		translate([-HANDLE_WIDTH/2 -1,-DRAWER_CORNER_RAD,FLOOR_THICK+DRAWER_CORNER_RAD]) rotate([0,90,0])  
			cylinder(h=HANDLE_WIDTH+2,r=DRAWER_CORNER_RAD);
		};
                
    difference() { 
		translate([-HANDLE_WIDTH/2,0,-FLOOR_THICK]) {
			cube([HANDLE_WIDTH,DRAWER_CORNER_RAD,DRAWER_CORNER_RAD],center=false);
        }
		translate([-HANDLE_WIDTH/2 -1,DRAWER_CORNER_RAD,-FLOOR_THICK+DRAWER_CORNER_RAD]) rotate([0,90,0])  
			cylinder(h=HANDLE_WIDTH+2,r=DRAWER_CORNER_RAD);
		};
                        
};

module holes(width,height) {
	cols = width / hoff - DRAWER_CORNER_RAD;
	rows = height / voff - DRAWER_CORNER_RAD;

	translate([hoff*1.3,0,voff*2])
	for (i=[0:rows-1]) {
		for (j=[0:cols-1]){
			translate([j*hoff+i%2*(hoff/2),0,i*voff])
			rotate([90,90,0]) rotate([0,0,0]) cylinder(h=thick,r=PATTERN_INNER_DIAMETER/2,$fn=6);
		}
	}
}

module half_sphere(rad) {
	difference() {
		sphere(rad);
		translate([-rad,-rad,-rad])
		cube([rad*2,rad*2,rad]);
	}
}

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



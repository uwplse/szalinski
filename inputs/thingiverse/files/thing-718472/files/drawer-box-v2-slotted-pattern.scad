/* [BASIC] */
// Which one would you like to see?
part = "drawerbox"; // [drawer1:1 section drawer,drawer2:2 section drawer,drawer3:3 section drawer, drawer4:4 section drawer, drawerbox:drawer housing]

// Clearance
CLEARANCE = 0.5;

// Wall thickness
WALL_THICK = 4;

// Floor thickness
FLOOR_THICK = 4;

// Rounded fillets?
FILLETS = true;
/* [DRAWERS] */
// How many drawers?
NUM_DRAWERS = 3;

// How high?
DRAWER_HEIGHT = 20;

// How deep?
DRAWER_DEPTH = 62;

// How wide?
DRAWER_WIDTH = 84;

// Corner radius?
DRAWER_CORNER_RAD = 2;

// Handle size?
HANDLE_SIZE = 10;

/* [TEXT] */
// Label on the drawer
MESSAGE = "TEXT";

// Text font
TEXT_FONT = "Archivo Black";

// Text height
TEXT_HEIGHT = 6;

// Text spacing
TEXT_SPACING = 1;

// Shift text to the right (negative goes left)
TEXT_SHIFT_RIGHT = 0;

//Shift text up
TEXT_SHIFT_UP = 4;

// Embossed?
EMBOSSED = "yes"; // [yes,no]

/* [Hidden] */
india = 6 ;
spacing = 1.2;
dia = india + (spacing * 2);

hoff = india+spacing;
voff = sqrt(pow(hoff,2)-pow(hoff/2,2));
$fn = 32;
NOFILLETS = !FILLETS;
WALL_WIDTH = WALL_THICK + 0.001; // Hack to trick Makerware into making the right number of filament widths
INNER_FILLET = DRAWER_CORNER_RAD-(WALL_WIDTH/1.25);

BOX_HEIGHT = NUM_DRAWERS*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH;
BOX_WIDTH = DRAWER_WIDTH+CLEARANCE*2+WALL_WIDTH*2;
BOX_DEPTH = DRAWER_DEPTH+CLEARANCE+WALL_WIDTH;

thick = WALL_THICK + 0.2;
bumprad = 1.5;

earthick = 0.6;
earrad = 10 ; 

print_part();

module print_part() {
	if (part == "drawer1") {
		drawer1();
	} else if (part == "drawer2") {
		drawer2();
	} else if (part == "drawer3") {
		drawer3();
	} else if (part == "drawer4") {
		drawer4();
	} else {
		rotate([270,0,0])
		drawerbox();
	}
}


module drawerbox() {
	translate([-BOX_WIDTH/2,-BOX_DEPTH/2,0])
	union () {
		difference () {
			cube([BOX_WIDTH,BOX_DEPTH,BOX_HEIGHT]);
			for (i=[0:NUM_DRAWERS-1]) {
				translate([WALL_WIDTH,-1,i*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH]){
					cube([DRAWER_WIDTH+CLEARANCE*2,DRAWER_DEPTH+CLEARANCE+1,DRAWER_HEIGHT+CLEARANCE*2]);
					rotate([0,90,0])
						hull() {
   			   		translate([-DRAWER_HEIGHT/2-CLEARANCE,DRAWER_HEIGHT/2+WALL_THICK/2,-WALL_THICK-CLEARANCE*2])cylinder(h=WALL_THICK*2+DRAWER_WIDTH+CLEARANCE*2+WALL_THICK/2,r=DRAWER_HEIGHT/2*.7);
							translate([-DRAWER_HEIGHT/2-CLEARANCE,DRAWER_DEPTH-DRAWER_HEIGHT/2+WALL_THICK,-WALL_THICK-CLEARANCE*2])cylinder(h=WALL_THICK*2+DRAWER_WIDTH+CLEARANCE*2+WALL_THICK/2,r=DRAWER_HEIGHT/2*.7);
						}
					translate([0,DRAWER_DEPTH+WALL_THICK+CLEARANCE,0])
					rotate([90,90,0]){
						hull() {
							translate([-DRAWER_HEIGHT/2-CLEARANCE,DRAWER_HEIGHT/2,-FLOOR_THICK-CLEARANCE*2])cylinder(h=FLOOR_THICK*2+DRAWER_WIDTH+CLEARANCE*2+2,r=DRAWER_HEIGHT/2*.7);
							translate([-DRAWER_HEIGHT/2-CLEARANCE,DRAWER_WIDTH-DRAWER_HEIGHT/2+CLEARANCE*2,-FLOOR_THICK-CLEARANCE*2])cylinder(h=FLOOR_THICK*2+DRAWER_WIDTH+CLEARANCE*2+2,r=DRAWER_HEIGHT/2*.7);
						}
					}
				}
			}
		}
		for (i=[0:NUM_DRAWERS-1]) {
			translate([BOX_WIDTH/4,DRAWER_CORNER_RAD*2,i*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH-0.1])
			{
				scale([1,1,0.9]) half_sphere(bumprad);
			}
			translate([BOX_WIDTH/4*3,DRAWER_CORNER_RAD*2,i*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH-0.1])
			{
				scale([1,1,0.9]) half_sphere(bumprad);
			}
		}

// mouse ears
translate([-earrad/2+4,BOX_DEPTH,-earrad/2+4]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
translate([BOX_WIDTH+earrad/2-4,BOX_DEPTH,-earrad/2+4]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
translate([-earrad/2+4,BOX_DEPTH,BOX_HEIGHT+earrad/2-4]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
translate([BOX_WIDTH+earrad/2-4,BOX_DEPTH,BOX_HEIGHT+earrad/2-4]) rotate([90,0,0]) cylinder(r=earrad,earthick);

	}
};

module drawer1() {
	difference() {
		drawerbase();
		 translate([0,0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH-(WALL_WIDTH*2),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
	}	
};

module drawer2() {
	difference() {
		drawerbase();
		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
}
};

module drawer3() {
	difference() {
		drawerbase();
		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);

		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,DRAWER_DEPTH/4-WALL_WIDTH/4,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);


		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,-(DRAWER_DEPTH/4-WALL_WIDTH/4),FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
}

};

module drawer4() {
	difference() {
		drawerbase();
		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),DRAWER_DEPTH/4-WALL_WIDTH/4,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);

		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),-(DRAWER_DEPTH/4-WALL_WIDTH/4),FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);

		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,DRAWER_DEPTH/4-WALL_WIDTH/4,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);


		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,-(DRAWER_DEPTH/4-WALL_WIDTH/4),FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
}};

module drawer6() {};

module drawerbase() {
	union() {
		difference() {
			translate([0,0,DRAWER_CORNER_RAD/2]) roundedBox([DRAWER_WIDTH,DRAWER_DEPTH,DRAWER_HEIGHT+DRAWER_CORNER_RAD],DRAWER_CORNER_RAD,NOFILLETS);
			translate([0,0,DRAWER_HEIGHT]) cube([DRAWER_WIDTH+1, DRAWER_DEPTH+1,DRAWER_HEIGHT],center=true);
			translate([BOX_WIDTH/4,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) sphere(bumprad);
			translate([BOX_WIDTH/4,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2+bumprad*3,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) sphere(bumprad);
			translate([BOX_WIDTH/4,DRAWER_DEPTH/2-DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) sphere(bumprad);
			translate([-BOX_WIDTH/4,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) sphere(bumprad);
			translate([-BOX_WIDTH/4,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2+bumprad*3,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) sphere(bumprad);
			translate([-BOX_WIDTH/4,DRAWER_DEPTH/2-DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) sphere(bumprad);

			//slots added
			translate([BOX_WIDTH/4,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2+bumprad*3,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) rotate([-90,0,0]) cylinder(h = DRAWER_DEPTH/2, r=bumprad);
			translate([BOX_WIDTH/4,DRAWER_DEPTH/2-DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) rotate([90,0,0]) cylinder(h = DRAWER_DEPTH/2, r=bumprad);
			translate([-BOX_WIDTH/4,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2+bumprad*3,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) rotate([-90,0,0]) cylinder(h = DRAWER_DEPTH/2, r=bumprad);
			translate([-BOX_WIDTH/4,DRAWER_DEPTH/2-DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1]) rotate([90,0,0]) cylinder(h = DRAWER_DEPTH/2, r=bumprad);

		if(EMBOSSED == "yes") {
			translate([TEXT_SHIFT_RIGHT,-DRAWER_DEPTH/2+WALL_WIDTH/4,TEXT_SHIFT_UP]) rotate([90,0,0])linear_extrude(WALL_WIDTH/2) text(MESSAGE,font=TEXT_FONT,size=TEXT_HEIGHT,spacing=TEXT_SPACING,valign="center",halign="center");
			}
		}
	translate([0,-DRAWER_DEPTH/2,-DRAWER_HEIGHT/2+FLOOR_THICK]) 
	handle();

	if(EMBOSSED == "no") {
		translate([TEXT_SHIFT_RIGHT,-DRAWER_DEPTH/2+WALL_WIDTH/4,TEXT_SHIFT_UP]) rotate([90,0,0])linear_extrude(WALL_WIDTH/2) text(MESSAGE,font=TEXT_FONT,size=TEXT_HEIGHT,spacing=TEXT_SPACING,valign="center",halign="center");
		}
	};
};

module handle() {

	difference() {
		roundedBox([DRAWER_WIDTH/4,HANDLE_SIZE*2,FLOOR_THICK*2],2,true);
		translate([0,HANDLE_SIZE,0]) cube([DRAWER_WIDTH/4+1,HANDLE_SIZE*2,FLOOR_THICK*2+1],center=true);
	};
	
	difference() { 
		translate([0,-DRAWER_CORNER_RAD/2,FLOOR_THICK+DRAWER_CORNER_RAD/2]) 
			cube([DRAWER_WIDTH/4,DRAWER_CORNER_RAD,DRAWER_CORNER_RAD],center=true);
		translate([-DRAWER_WIDTH/8-1,-DRAWER_CORNER_RAD,FLOOR_THICK+DRAWER_CORNER_RAD]) rotate([0,90,0])  
			cylinder(h=DRAWER_WIDTH/4+2,r=DRAWER_CORNER_RAD);
		};

	difference() { 
		translate([-DRAWER_WIDTH/8,0,-FLOOR_THICK]) 
			cube([DRAWER_WIDTH/4,DRAWER_CORNER_RAD,DRAWER_CORNER_RAD],center=false);
		translate([-DRAWER_WIDTH/8-1,DRAWER_CORNER_RAD,-FLOOR_THICK+DRAWER_CORNER_RAD]) rotate([0,90,0])  
			cylinder(h=DRAWER_WIDTH/4+2,r=DRAWER_CORNER_RAD);
		};
};

module holes(width,height) {
	cols = width / hoff - DRAWER_CORNER_RAD;
	rows = height / voff - DRAWER_CORNER_RAD;

	translate([hoff*1.3,0,voff*2])
	for (i=[0:rows-1]) {
		for (j=[0:cols-1]){
			translate([j*hoff+i%2*(hoff/2),0,i*voff])
			rotate([90,90,0]) rotate([0,0,0]) cylinder(h=thick,r=india/2,$fn=6);
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

function even(i)=i-floor(i/2)==i/2;

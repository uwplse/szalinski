$fs=0.5;
$fa=6;

// Build Type
BUILD_TYPE = "complex_circle"; // [base,simple_circle,complex_circle,circle_inlay,test]

// Height of M3 Screw Head (for inlay)
M3_HEAD_HEIGHT = 2.6;
// Diameter of M3 Screw Head (for inlay)
M3_HEAD_DIA = 6;
// Diameter of M3 Hole(for groove)
M3_HOLE_DIA = 3.8;
// Diameter of M3 Tap Hole (for inlay)
M3_TAP_DIA = 2.8;

// Diameter of Cutting Bit
CUTTING_DIA = 12;

// Outer Diameter of Router Base
OUTER_DIA = 145;
// Diameter of Router Base Cutout
INNER_DIA = 30;
// Width of Router Base Cutout
INNER_WIDTH = 85;
// Height of Router Base
BASE_HEIGHT = 110;

// Router Base Thickness (for complex_circle, ensure this is more than thickness of inlay)
BASE_THICKNESS = 6; 

// X Distance of Mounting Holes in Router Base
HOLES_X_DIST = 106;
// Y Distance of Mounting Holes in Router Base
HOLES_Y_DIST = 56;
// Diameter of Mounting Holes in Router Base
HOLES_DIA = 5.6;

// Inlay Thickness (has to be larger than M3_HEAD_HEIGHT)
INLAY_THICKNESS = 4;
// Inlay Width
INLAY_WIDTH = M3_HEAD_DIA * 2;
// Inlay Groove
INLAY_GROOVE = M3_HOLE_DIA;
// Inlay Length
INLAY_LENGTH = 45;
// Inlay Scale (shrink inlay a bit to make it fit into base)
INLAY_SCALE = 0.95;

// List of Circle Diameters (for complex circle, only the max value is relevant)
CIRCLES = [76, 110, 130, 250];

echo("I_W:",INLAY_SCALE*INLAY_WIDTH);
echo("I_T:",INLAY_SCALE*INLAY_THICKNESS);

// Width of Circle Cut Base Extension
EXTENSION_WIDTH = 50;

// List of Mounting Holes X Coordinates
X_POS = [ - HOLES_X_DIST/2, HOLES_X_DIST/2 ];
// List of Mounting Holes Y Coordinates
Y_POS = [ - HOLES_Y_DIST/2, HOLES_Y_DIST/2 ];

CENTER_HOLE_DIA = M3_TAP_DIA;

// Circle Cut Base Extension Frame
EXTENSION_FRAME = 5;
EXTENSION_LENGTH = max(CIRCLES) / 2 - CUTTING_DIA/2 + EXTENSION_FRAME;

EXTENSION_WIDTH_EFFECTIVE = min(EXTENSION_WIDTH, EXTENSION_LENGTH);

echo("EXT:",EXTENSION_LENGTH);
echo("EXT_W:", EXTENSION_WIDTH_EFFECTIVE);


module hole()
{
  circle(d=HOLES_DIA, center=true);
}

module all_holes() {
  for (x=X_POS, y=Y_POS) {
      translate([x,y,0]) hole();
  } 
  
  hull() {
    translate([-INNER_WIDTH/2 + INNER_DIA/2,0,0]) circle(d = INNER_DIA);
    translate([INNER_WIDTH/2 - INNER_DIA/2,0,0]) circle(d= INNER_DIA);
  }
}

module countersunk() {
  for (x=X_POS, y=Y_POS) {
      translate([x,y,0])   cylinder(r2=(HOLES_DIA/2) + BASE_THICKNESS + 1, r1=(HOLES_DIA/2), h=BASE_THICKNESS + 1);
  }
}

module base_plate() {

  difference() {
    intersection() {
      circle(d = OUTER_DIA);
      square([OUTER_DIA, BASE_HEIGHT], center=true);
    }

    all_holes();
  }
}

module circle_holes() {
  for (dia=CIRCLES) {
    translate([0, -dia/2 + CUTTING_DIA/2,0]) circle(d=CENTER_HOLE_DIA);
  
  }
}

module extension_plate() {
  
  difference() {
    union() {
      base_plate();
      hull() {
        translate([0, -EXTENSION_LENGTH + (EXTENSION_WIDTH_EFFECTIVE/2), 0]) circle(d=EXTENSION_WIDTH_EFFECTIVE);
        translate([0, -INNER_DIA/2 - 1]) square([EXTENSION_WIDTH_EFFECTIVE,1], center=true);
      }
    }
    all_holes();
  }  
  
}

module hole_template() {
  linear_extrude(height=1.8)
  difference() {
    square([HOLES_X_DIST + HOLES_DIA + 3, HOLES_Y_DIST + HOLES_DIA + 3], center=true);
    square([HOLES_X_DIST - HOLES_DIA - 3, HOLES_Y_DIST - HOLES_DIA - 3], center=true);
    all_holes();
  }
}

module groove() {
  
  translate([0,0,BASE_THICKNESS-INLAY_THICKNESS]) linear_extrude(BASE_THICKNESS)
  hull() {
    translate([0, -EXTENSION_LENGTH + EXTENSION_FRAME + (INLAY_WIDTH/2)]) circle(d=INLAY_WIDTH);
    circle(d=INLAY_WIDTH);
  }
  
  translate([0,0,-0.01]) linear_extrude(INLAY_THICKNESS)
  hull() {
    translate([0, -EXTENSION_LENGTH + EXTENSION_FRAME + (INLAY_GROOVE/2)]) 
      circle(d=INLAY_GROOVE);
    translate([0, -INNER_DIA/2 - EXTENSION_FRAME])
      circle(d=INLAY_GROOVE);
  }
  
}

module inlay() {
  
  
  
  Y_OFFSET = -INLAY_LENGTH + INLAY_WIDTH;
  
  module m3Head() {
    linear_extrude(M3_HEAD_HEIGHT)
      circle(d=M3_HEAD_DIA);
  }

  difference() {  
    linear_extrude(INLAY_SCALE*INLAY_THICKNESS) {
      difference() {
        hull() {
          circle(d=INLAY_WIDTH*INLAY_SCALE);
          translate([0,Y_OFFSET,0]) circle(d=INLAY_WIDTH*INLAY_SCALE);
        }
        circle(d=M3_TAP_DIA);
        translate([0,Y_OFFSET, 0]) circle(d=M3_TAP_DIA);    
      }  

    }
    translate([0,0,-0.01]) m3Head();
    translate([0, Y_OFFSET, INLAY_SCALE*INLAY_THICKNESS-M3_HEAD_HEIGHT+0.01]) m3Head();
    
  }
  
}



if ("test" == BUILD_TYPE) {
  hole_template();
} else if ("base" == BUILD_TYPE) {
  difference() {
    linear_extrude(height=BASE_THICKNESS)  base_plate();
    countersunk();
  }
 
} else if ("simple_circle" == BUILD_TYPE) {

  difference() {
    linear_extrude(height=BASE_THICKNESS) 
      difference() {
        extension_plate();
        circle_holes();
      }
    countersunk();
  }
} else if ("complex_circle" == BUILD_TYPE) {
  echo("BASE",BASE_THICKNESS);
  
  difference() {
    linear_extrude(height=BASE_THICKNESS) extension_plate();
    countersunk();
    groove();
  }
  
} else if ("circle_inlay") {
  
  inlay();
}


//base_plate();
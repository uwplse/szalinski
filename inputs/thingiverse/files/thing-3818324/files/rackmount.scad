 
// Select which model element to create
part = "full"; // [full:Full Rackmount Preview,left:Left Element,right:Right Element,middle:Middle Element,stabilizer:(Optional) Mount Stabilizer] 

// Number of elements your rackmount should have
R_SEGMENTS = 3;

// Length (mm) of the stabilizer (triangle) that connects bottom and front
R_STABILIZER_LENGTH = 80.0;

// Length (mm) of the bottom
R_BOTTOM_LENGTH = 150.0;

// Thickness (mm) of the bottom border
R_BOTTOM_THICKNESS_MAX = 3;
// Thickness (mm) of the bottom area
R_BOTTOM_THICKNESS_MIN = 1.2;
// Width (mm) of the bottom border
R_BOTTOM_BORDER = 5.0;

// Diameter (mm) of the front panel's holes
R_HOLE_DIA = 6.4;

// Diameter (mm) of the holes in the stabilizer to connect the elements
R_STABILIZER_HOLE_DIA = 3.2;

// Thickness (mm) of the front panel
R_PANEL_THICKNESS = 2.5;

// Panel cutout (polygon)
R_PANEL_CUTOUT = [ [5,33.3], [140.0, 33.3], [140.0, 5], [5,5]];

// X/Y positions of holes in the bottom area (looking from the top, [0,0] would be bottom left) 
R_BOTTOM_HOLES = [[15,15],[130,15]];

// Diameter of bottom holes
R_BOTTOM_HOLE_DIA = 5.3;


/* [Hidden] */

// Use cage nuts in the optional stabilizer -> REMOVED, DOESN'T WORK, NOT ENOUGH SPACE. 
// Nevertheless, I'll leave the code here because the idea itself wasn't that bad ... 
R_USE_CAGE_NUTS = false; 

//quality
$fs=0.5;
$fa=6;


// viewport parameters for animation
$vpt = [17, 2.7, -0.7];
//$vpr = [22.7, 120, 8];
$vpr = [22.7, 360*$t, 28];
$vpd = 1120;


// convert inch to mm (to use standardized 19" dimensions below)
function mm(inch) = inch * 25.4;    

// 19" rack dimensions, taken from several Wikipedia articles. 
// Unfortunately, many of them are wrong (or suffer from severe rounding/conversion errors...)
// This is hopefully correct...
R_OUTER_WIDTH = mm(19); // outer width of rack
R_MOUNT_WIDTH = mm(0.625); // width of mounting area
R_MOUNT_HEIGHT = mm(1.75); // height of 1U rack unit
R_PANEL_HEIGHT = mm(1.71875); // panel height for a 1U unit
R_INNER_WIDTH = R_OUTER_WIDTH - (2*R_MOUNT_WIDTH); // inner width 
R_HOLE_DISTANCE = mm(18.3125); // horizontal distance of mounting holes 
R_HOLE_OFFSET = (R_OUTER_WIDTH - R_HOLE_DISTANCE) / 2.0; // horizontal hole offset from the edge

// vertical distances of the 3 mounting holes from the bottom
R_HOLE_BOTTOM = mm(0.25);
R_HOLE_MID = mm(0.625) + R_HOLE_BOTTOM;
R_HOLE_TOP = mm(0.625) + R_HOLE_MID;

R_SQUARE_HOLE_WIDTH = mm(0.375); // width of square hole for cage nuts

// overlap of 3D parts to connect
R_OVERLAP = 0.01;



echo("outer",R_OUTER_WIDTH);
echo("mount",R_MOUNT_WIDTH);
echo("inner",R_INNER_WIDTH);
echo("hole distance", R_HOLE_DISTANCE);
echo("segment width", R_INNER_WIDTH / R_SEGMENTS);


// a mounting "flap" with 3 holes in it 
module mount(cage_nuts=false) {
  
  module hole(s) {
    if (s) {
      square_hole(R_SQUARE_HOLE_WIDTH);      
    } else {
      circle(d=R_HOLE_DIA);
    }
  }
  
  color("tomato")
  linear_extrude(R_PANEL_THICKNESS) {
      difference() {
        square([R_MOUNT_WIDTH + R_OVERLAP, R_PANEL_HEIGHT]);
        translate([R_HOLE_OFFSET, R_HOLE_BOTTOM]) hole(cage_nuts);
        translate([R_HOLE_OFFSET, R_HOLE_MID]) hole(cage_nuts);
        translate([R_HOLE_OFFSET, R_HOLE_TOP]) hole(cage_nuts);
      }
  }
}

// module which creates a block to reduce the amount of material used in the bottom part
module bottom_reducer() {
  W = R_INNER_WIDTH / R_SEGMENTS;
  
  W2 = (W-(3*R_BOTTOM_BORDER)) / 2;
  H2 = R_BOTTOM_LENGTH-(2*R_BOTTOM_BORDER);
  OFF = 5.0;
  W3 = W2 - 2*OFF;
  H3 = H2 - 2*OFF;
  Z = R_BOTTOM_THICKNESS_MAX - R_BOTTOM_THICKNESS_MIN + 2*R_OVERLAP;
  
  polyhedron( points = [ 
      [0, 0, 0], 
      [W2,0, 0],
      [W2,H2,0],
      [0, H2,0],
      
      [OFF, OFF, Z], 
      [OFF+W3,OFF, Z],
      [OFF+W3,OFF+H3,Z],
      [OFF, OFF+H3,Z]
  
    ], faces = [ 
      [0,1,2,3], //bottom
      [7,6,5,4], //top
      [7,4,0,3], //left
      [5,6,2,1], //right
      [7,3,2,6], //up
      [4,5,1,0]  //down
    ]);
}


// creates the bottom plate of an element
module bottom() {
  W = R_INNER_WIDTH / R_SEGMENTS; 
  
  
  translate([0,0,R_BOTTOM_LENGTH]) rotate([270,0,0]) difference() {
    cube( [W,R_BOTTOM_LENGTH, R_BOTTOM_THICKNESS_MAX] );
    union() {
      translate([R_BOTTOM_BORDER, R_BOTTOM_BORDER,-R_OVERLAP])
        bottom_reducer();
      translate([W/2 + R_BOTTOM_BORDER/2, R_BOTTOM_BORDER,-R_OVERLAP])
        bottom_reducer(); 
   
      for (hole = R_BOTTOM_HOLES) {
        translate(hole) cylinder(d=R_BOTTOM_HOLE_DIA, h=3*R_BOTTOM_THICKNESS_MAX, center=true);
      }   
      
    }
  }
}

module hole2d(d_horiz, d_vert) {
  translate([-(d_horiz-d_vert)/2.0,0,0])
  hull() 
  {
    circle(d = d_vert);
    translate([d_horiz - d_vert,0,0]) circle(d = d_vert);
  }
}

module square_hole(width) {
  D = width/5;
  O = D/2;
  W=width-O;
  translate([-width/2, -width/2,0])
  hull() {
    translate([O,0,0]) circle(D);
    translate([O,W,0]) circle(D);
    translate([W,0,0]) circle(D);
    translate([W,W,0]) circle(D);
  }
}


// create the side stabilizer with 3 connection holes
module side(long_holes=false) {
  
  horiz = long_holes ? 3*R_STABILIZER_HOLE_DIA : R_STABILIZER_HOLE_DIA;
  hole_offset = long_holes ? R_PANEL_THICKNESS : 0.0;
  vert = R_STABILIZER_HOLE_DIA;
  
  translate([R_PANEL_THICKNESS,0,R_PANEL_THICKNESS-R_OVERLAP]) rotate([0,-90,0])
    linear_extrude(R_PANEL_THICKNESS) {
      difference() {
        polygon([
          [0,0],
          [0,R_PANEL_HEIGHT],
          [R_STABILIZER_LENGTH,0]
        ]);
        union() {
          translate([R_STABILIZER_LENGTH*0.25-hole_offset, R_PANEL_HEIGHT*0.25]) hole2d(horiz,vert);
          translate([R_STABILIZER_LENGTH*0.5-hole_offset, R_PANEL_HEIGHT*0.25]) hole2d(horiz,vert);
          translate([R_STABILIZER_LENGTH*0.25-hole_offset, R_PANEL_HEIGHT*0.5]) hole2d(horiz,vert);
        }
      }
    }
}

// create one full panel (i.e. bottom, front, 2*stabilizer)
module panel(segment) {
  W = R_INNER_WIDTH / R_SEGMENTS;
    
  color([1.0/R_SEGMENTS * segment,0,0])
  translate([(segment - 1)*W,0,0]) {
    // bottom plate
    bottom();
    // left side stabilizer
    side();
    // right side stabilizer
    translate([W-R_PANEL_THICKNESS,0,0]) side();
    
    // front panel
    linear_extrude(R_PANEL_THICKNESS) {
      difference() {
        // this is the front panel itself
        square([W, R_PANEL_HEIGHT]);    
        // this is the cutout
        polygon(R_PANEL_CUTOUT);
      }
    }
  }      
}

module full_rackmount() {

  mount();
  translate([R_OUTER_WIDTH-R_MOUNT_WIDTH,0,4])
    stabilizer();
  
  translate([R_MOUNT_WIDTH,0,4])
    mirror([1,0,0]) {
      stabilizer();
    }
  

  translate([R_MOUNT_WIDTH,0,0])
    for (segment = [1:R_SEGMENTS]) {
      panel(segment);
    }

  translate([R_OUTER_WIDTH,0,0])
    mirror([1,0,0]) 
      mount();
}

module right_rackmount() {

  mount();

  translate([R_MOUNT_WIDTH,0,0])
    panel(1);
    
}

module left_rackmount() {

  translate([R_MOUNT_WIDTH,0,0])
    panel(R_SEGMENTS);
    

  translate([R_OUTER_WIDTH,0,0])
    mirror([1,0,0]) 
      mount();
}

module middle_rackmount() {
  panel(1);
}

module stabilizer() {
  module gusset() {
    rotate([90,0,0])linear_extrude(R_PANEL_THICKNESS, center=true) polygon([
          [0,0],
          [0,R_MOUNT_WIDTH*0.8],
          [R_MOUNT_WIDTH*0.8,0]
    ]);
  }
  
  translate([R_MOUNT_WIDTH,0,0]) mirror([1,0,0]) mount(R_USE_CAGE_NUTS);
  side(true);

  translate([0,(R_HOLE_MID-R_HOLE_BOTTOM)/2 + R_HOLE_BOTTOM,0]) 
    gusset();
  translate([0,(R_HOLE_TOP-R_HOLE_MID)/2 + R_HOLE_MID,0]) 
    gusset();

}

if (part == "full") {
  translate([-R_OUTER_WIDTH/2,-R_PANEL_HEIGHT/2, -R_BOTTOM_LENGTH/2])
  {
    full_rackmount();
  }
} else if (part == "right") {
  right_rackmount();
} else if (part == "left") {
  left_rackmount();
} else if (part == "middle") {
  middle_rackmount();
} else if (part == "stabilizer") {
  stabilizer();
}





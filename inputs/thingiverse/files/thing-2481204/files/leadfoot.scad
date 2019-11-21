// Lead Foot PCB enclosure
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)
//
// The bottom of the box is hollow. It's filled with sand to make
// it heavy and stable.

/*[PCB Dimensions]*/
pcb_width = 80;                 // [5:160]
pcb_depth = 50;                 // [5:100]
pcb_thickness = 1.6;            // [0.8:0.1:2.0]
pcb_corner_radius = 3;          // [0:0.1:10]

/*[Case]*/
case_thickness = 1.6;           // [1:0.1:5]
// round or right-angled corners
case_with_radius = 1;           // [0:no, 1:yes]
// Size of "lead foot" (space for ballast)
lead_foot_height = 8;           // [2.5:0.1:20]
ledger_width = 3.5;             // [0:0.1:5] 
with_right_and_left_ledger = 1; // [0:no, 1:yes]
with_front_and_rear_ledger = 1; // [0:no, 1:yes]

/*[Mounting Holes]*/
mounting_holes = 1;             // [0:none, 1:drilled, 2:pegs]
// distance from edge of pcb
mounting_hole_distance = 3.5;   // [1:0.1:10]
// distance between pcb and "floor"
spacer_height = 2;              // [0:0.1:10]
spacer_diam = 6;                // [0:0.1:10]
drill_diam = 2.8;               // [0:0.1:3.5]
// Holes for threaded nuts on the bottom
with_hex_nut = 1;               // [0:no, 1:yes]
// distance between flats (5mm for M2.5 nut, 6.35mm=1/4" for UNC 4-40)
hex_wrench_size = 5;            // [3:0.1:10]

//
// This is what we build...
//

CustomizableLeadFootCase();

//
// This is how it's done...
//

/*[Hidden]*/
tol = 0.1;      // tolerance, 0.1mm is a tight fit
eps = 0.001;
infinity = 1/0;

hex_nut_outer_diam = hex_wrench_size*2/sqrt(3);  // diameter of circumcircle

// case
floor_thickness = (lead_foot_height==0)? 0 : 0.8;
drilled_mounting_holes = 1;
mounting_pegs = 2;
sane_spacer_diam = (mounting_holes==drilled_mounting_holes && spacer_diam <= drill_diam)?
                      0 : spacer_diam;
sane_spacer_height = (sane_spacer_diam>0)? spacer_height : 0;
case_height = case_thickness + lead_foot_height + floor_thickness 
             + sane_spacer_height + pcb_thickness + tol;
case_corner_radius = (case_with_radius==0)? 0 : pcb_corner_radius + case_thickness;


// CustomizableLeadFootCase
//
// Adds spacers to a BasicLeadFootCase

module CustomizableLeadFootCase() {
  // (x0, y0) is at lower left mounting hole
  x0 = pcb_width/2 - mounting_hole_distance;
  y0 = pcb_depth/2 - mounting_hole_distance;
  board_z = case_height - pcb_thickness - tol;
  floor_z = board_z - sane_spacer_height;
        
  difference() {
    union() {
      BasicLeadFootCase();
      
      // spacers
      if (sane_spacer_height > 0) {                    
        for (x = [x0, -x0], y = [y0, -y0])
          translate([x, y, 0]) {
            // actual spacer
            cylinder(d=spacer_diam, h=board_z, $fn=30);
          }
      }      
      
      // walls around hex nut
      if (with_hex_nut && hex_wrench_size > 0) {
        hex_diam = hex_nut_outer_diam + 2*tol + 2*case_thickness;
        for (x = [x0, -x0], y = [y0, -y0])
          translate([x, y, 0])
            cylinder(d=hex_diam, h=floor_z, $fn=6);
      }      
    }
    
    if (mounting_holes==drilled_mounting_holes && drill_diam > 0) {
      for (x = [x0, -x0], y = [y0, -y0])
        translate([x, y, 0]) {
          cylinder(d=drill_diam, h=case_height, $fn=30);
          
          if (with_hex_nut==1) {
            // hole for hex nut
            cylinder(d=hex_nut_outer_diam + 2*tol, h=floor_z - case_thickness, $fn=6);
          }
        }
    }
  }
  
  if (mounting_holes==mounting_pegs && drill_diam > 4*tol) {
    for (x = [x0, -x0], y = [y0, -y0])
      translate([x, y, board_z]) {
        cylinder(d=drill_diam - 2*tol, h=pcb_thickness, $fn=20);
        translate([0,0,pcb_thickness])
          cylinder(d1=drill_diam - 2*tol, d2=drill_diam - 4*tol, h=2*tol, $fn=20);
      }
  }
}

// BasicLeadFootCase
//
// BasicCase with an empty space for sand/ballast, a support structure, a logo on the side
// and a plug

module BasicLeadFootCase() {
  // cutout for PCB 
  w = pcb_width + 2*tol;
  d = pcb_depth + 2*tol;
  h = pcb_thickness + tol;

  thick_wall = 4;
  smallest_useful_space = 2.5; // don't want smaller empty space

  difference() {
    BasicCase();
    
    // any space left for sand/ballast?
    if (lead_foot_height >= smallest_useful_space 
      && pcb_width > 2*thick_wall 
      && pcb_depth > 2*thick_wall) {
      translate([0, 0, case_thickness]) {
        // hollow interior
        round_box(pcb_width + 2*case_thickness - 2*thick_wall, 
                   pcb_depth + 2*case_thickness - 2*thick_wall, 
                   lead_foot_height, 
                   pcb_corner_radius);
        
        // round hole (where the sand goes)
        translate([0, 0, lead_foot_height/2])
          rotate([0, 90])
            cylinder(d=lead_foot_height, h=w + case_thickness, $fn=30);        
      }
    
      // logo on the side
      text_size = min(0.8*case_height, 0.6*pcb_width);
      text_thickness = 1;
      if (text_size >= 4)
        translate([-0.8*text_size, -d/2-case_thickness+text_thickness, (case_height - text_size)/2])
          rotate([90, 0])
            linear_extrude(height=text_thickness)
              text("Pb'", size=text_size);
    }
  }
  
  if (lead_foot_height >= smallest_useful_space) {
    // build support needed
    support_forest(w + 2*case_thickness - 2*thick_wall, 
                   d + 2*case_thickness - 2*thick_wall, 
                   lead_foot_height+case_thickness, 
                   grid=5);
    
    // ...and a plug for the hole
    some_space = 2;
    translate([w/2 + case_thickness + lead_foot_height/2 + some_space, 0])
      cylinder(d1=lead_foot_height - 1*tol, d2=lead_foot_height - 3*tol, h = case_thickness, $fn=30);
  }
}

// BasicCase
//
// case with rounded corners, a ledger and stand-off between PCB and "floor"

module BasicCase() {
  // cutout for PCB 
  w = pcb_width + 2*tol;
  d = pcb_depth + 2*tol;
  h = pcb_thickness + tol;

  difference() {
    // actual case
    round_box(w + 2*case_thickness,
               d + 2*case_thickness,
               case_height,
               case_corner_radius);
    
    // cutout for PCB
    translate([0, 0, case_height-h])
      round_box(w, d, h, pcb_corner_radius);

    // space between pcb and floor (as specified by spacer_height)
    sane_ledger_width = (with_right_and_left_ledger || with_front_and_rear_ledger)?
      ledger_width : 0;
    w_less_ledger = w-2*sane_ledger_width;
    d_less_ledger = d-2*sane_ledger_width;
    h_less_ledger = case_height-sane_spacer_height-h; 

    translate([0, 0, h_less_ledger]) {      
      round_box(w_less_ledger, d_less_ledger, case_height, pcb_corner_radius - sane_ledger_width);
      
      if (!with_right_and_left_ledger && sane_ledger_width > 0) {
        translate([-w/2, -d_less_ledger/2])
          cube([w, d_less_ledger, case_height]);
      }
      
      if (!with_front_and_rear_ledger && sane_ledger_width > 0) {
        translate([-w_less_ledger/2, -d/2])
          cube([w_less_ledger, d, case_height]);
      }
    }
  }
}

// round_box
//
// dimensions width x depth x height
// radius is the corner radius

module round_box(width, depth, height, radius) {
  x0 = width/2 - radius;
  y0 = depth/2 - radius;

  if (radius > 0) {
    for (x = [-x0,+x0], y=[-y0, y0])
      translate([x,y])
        cylinder(r=radius, h=height, $fn=30);
    translate([-x0, -depth/2])
      cube([2*x0, depth, height]);
    translate([-width/2, -y0])
      cube([width, 2*y0, height]);
  }
  else
    translate([-width/2, -depth/2]) 
      cube([width, depth, height]);
}

// direction(n) direction of the tree branches
//
// +1 for even n, -1 for odd n. 
function direction(n) = (n == 2*floor(n/2))? +1 : -1;

// length(n) length of the tree branches
//
// Returns 2**(k+1) - 1, where 2**k is the greatest power of two of which n is a multiple
// For instance
// length(1) = 1,  power of two 1 = 2**0, so k=0 and 2**(k+1) - 1 = 1
// length(2) = 3,  k = 1
// length(3) = 1,  k = 0
// length(4) = 7,  k = 2
//
// length(0) is unbounded, generalized for negative numbers: length(-n) = length(1-n)
// so length(-1) is unbounded, length(-2) = 1, length(-3) = 3 and so on.

function length_helper(n, d) = (n == 0 || n == -1)? infinity
                                                     : (let (n_2 = floor(n/2), d_2 = direction(n_2))
                                                       (d == d_2)? 1 + 2*length_helper(n_2, d_2)
                                                                   : 1);

function length(n) = length_helper(n, direction(n));

// support_forest
//
// Creates a branching support structure ("forest of trees").
// [width, depth, height]  specifies the dimension of the support structure
//                          supporting walls and a floor is assumed
// grid                     specifies spacing of leaves
// thickness                thickness of branches

module support_forest(width, depth, height, grid, thickness=1.15) {
  C = floor(width/grid/2 - 0.5);
  R = floor(depth/grid/2 - 0.5);
  
  if (C > 0 && R > 0) {
    height_grid = grid/sqrt(2);
    extraLength = thickness/sqrt(2);  // to make a flat cut at top and bottom
    maxLength = height/height_grid + extraLength;
    
    intersection() {
      // bounding cube
      translate([-width/2, -depth/2, 0])
        cube([width, depth, height]);
      
      // the actual forest
      translate([0, 0, height]) {
        for (r = [-R-1:R], c = [-C-1:C]) {
          x = grid*(c+0.5);
          y = grid*(r+0.5);
          dx = direction(c);
          dy = direction(r);
          l = min(length(c), length(r), maxLength)*grid;
          //echo("(x,y) = (", x, ",", y, ")");
          //echo("direction(",c,",",r,") = (", direction(c), ",", direction(r), ")");
          //echo("length(",c,",",r,") = ",l);
          
          // translate top of branch to [x, y, z] and rotate it according to [dx, dy]
          // the branches vary in length and either terminate at the bottom of the bounding cube
          // or at a joining branch, which is longer.
          translate([x, y, 0])
            rotate(a=45, v=[dy, -dx, 0])
              translate([-thickness/2, -thickness/2, -l])
                cube([thickness, thickness, l+extraLength]);
        }
      }
    }
  }
}

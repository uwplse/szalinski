
// Door bolt hole height; must be a tight fit
bolt_hole_height = 26.75;
// Door bolt hole width; must be a tight fit
bolt_hole_width = 14.5;
// Door bolt hole depth
bolt_hole_depth = 21;

// Door bolt hole corner radius
bolt_hole_corner_radius = 2.75;

// Door stopper tongue length; must be long enough so gap between door and frame is sufficiently large
tongue_length = 34;
// Door stopper tongue thickness; must be thick enough so door is blocked and doesn't slide past tongue
tongue_thickness = 8;

// Pull handle inset (determines handle width = bolt hole width - 2 * inset)
handle_inset = 2.25;
// Pull handle length
handle_length = 15;
// Whether to include a hole (for a strap to hang from door when not inserted) or not
handle_hole = true;


/* [Hidden] */

// Door tongue inset dimensions
h = bolt_hole_height;
w = bolt_hole_width;
d = bolt_hole_depth;

rad = bolt_hole_corner_radius;

// Door parameters
l = tongue_length;
thk = tongue_thickness;

// Handle parameters
h_inset = handle_inset;
h_d = handle_length;
hole_r = 3/2;
hole = handle_hole;

h_w = w - 2*h_inset;  // must be <= w
h_or = 3;  // outer corner rounding radius
h_ir = 3;  // inner rounding radius
h_rim = 3; // finger notch rim

$fn=18;

// ****  FROM lib/util.scad
module roundedCube4(dim, r, center=false) {
  width = dim[0];
  height = dim[1];
  depth = dim[2];
  centerx = (center[0] == undef ? center : center[0]);
  centery = (center[1] == undef ? center : center[1]);
  centerz = (center[2] == undef ? center : center[2]);
  translate([centerx ? -width/2 : 0, centery ? -height/2 : 0, centerz ? -depth/2 : 0]) union() {
    translate([0, r, 0]) cube([width, height-2*r, depth]);
    translate([r, 0, 0]) cube([width-2*r, height, depth]);
    for (xy = [[r, r],
               [r, height-r],
               [width-r, r],
               [width-r, height-r]]) {
      translate([xy[0], xy[1], 0]) cylinder(r = r, h = depth);
    }
  }
}

// TODO FIXME: dim[2] is not obeyed and top is filleted when dim[2] is >r but <2*r, because corner sphere diameter exceeds height  (should be a half-sphere, in principle)
module roundedCube6(dim, r, center=false) {
  width = dim[0];
  height = dim[1];
  depth = dim[2];
  centerx = (center[0] == undef ? center : center[0]);
  centery = (center[1] == undef ? center : center[1]);
  centerz = (center[2] == undef ? center : center[2]);
  translate([r - (centerx ? width/2 : 0), r - (centery ? height/2 : 0), r - (centerz ? depth/2 : 0)]) hull() {
    // Edges
    translate([0, 0, 0]) rotate([-90, 0, 0]) cylinder(h = height-2*r,r = r);
    translate([width-2*r, 0, 0]) rotate([-90, 0, 0]) cylinder(h = height-2*r,r = r);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = width-2*r, r = r);
    translate([0, height-2*r, 0]) rotate([0, 90, 0]) cylinder(h = width-2*r, r = r);
    translate([0, 0, 0]) cylinder(h = depth-r, r = r);
    translate([width-2*r, 0, 0]) cylinder(h = depth-r, r = r);
    translate([0, height-2*r, 0]) cylinder(h = depth-r, r = r);
    translate([width-2*r, height-2*r, 0]) cylinder(h = depth-r, r = r);

    // Corners
    translate([0,0,0]) sphere(r);
    translate([width-2*r, 0, 0]) sphere(r);
    translate([0, height-2*r, 0]) sphere(r);
    translate([width-2*r, height-2*r, 0]) sphere(r);
  }
}

//  *****  END FROM lib/util.scad

rotate([0, -90, 0]) union() {
  roundedCube4([h, w, d+thk], r=rad);
  roundedCube4([h, w+l, thk], r=rad);
  translate([0, (w-h_w)/2, -h_d]) difference() {
    roundedCube6([h, h_w, h_d+thk], r=h_or);
    translate([h_rim, h_rim, h_rim]) rotate([90, 0, 0]) roundedCube6([h-2*h_rim, h_d-h_rim, 2*h_rim], r=h_ir);
    translate([h_rim, h_w-h_rim, h_d]) rotate([-90, 0, 0]) roundedCube6([h-2*h_rim, h_d-h_rim, 2*h_rim], r=h_ir);  
    if (hole) {
      translate([h-h_rim-h_ir, -1, h_rim+h_ir]) rotate([-90, 0, 0]) cylinder(r=hole_r, h=h_w+2);
    } 
  }
}


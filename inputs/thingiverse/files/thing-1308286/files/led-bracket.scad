//------------------------------------------------------------------
/*

LED Rope Light Bracket

*/
//------------------------------------------------------------------
/* [Global] */

/*[General]*/
internal_length = 13.6;
internal_height = 7;
bracket_width = 8;
wall_thickness = 3;
bracket_length = 36;
hole_diameter = 2;

/* [Hidden] */
//------------------------------------------------------------------
// Set the scaling value to compensate for print shrinkage

scale = 1/0.995; // ABS ~0.5% shrinkage
//scale = 1/0.998; // PLA ~0.2% shrinkage

function dim(x) = scale * x;

//------------------------------------------------------------------
// control the number of facets on cylinders

facet_epsilon = 0.01;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

// small tweak to avoid differencing artifacts
epsilon = 0.05;


//------------------------------------------------------------------
// derived values

internal_l = dim(internal_length);
internal_h = dim(internal_height);
bracket_w = dim(bracket_width);
bracket_l = dim(bracket_length);
wall_t = dim(wall_thickness);
hole_r = dim(hole_diameter/2);

//------------------------------------------------------------------
// rounded/filleted edges

module outset(d=1) {
  minkowski() {
    circle(r=d, $fn=facets(d));
    children(0);
  }
}

module inset(d=1) {
  render() inverse() outset(d=d) inverse() children(0);
}

module inverse() {
  difference() {
    square(1e5, center=true);
    children(0);
  }
}

module rounded(r=1) {
  outset(d=r) inset(d=r) children(0);
}

module filleted(r=1) {
  inset(d=r) render() outset(d=r) children(0);
}

//------------------------------------------------------------------

module hole() {
  translate([0,-epsilon,bracket_w/2]) rotate([-90,0,0]) {
    cylinder(r=hole_r, h=wall_t + (2 * epsilon), $fn=facets(hole_r));
  }
}

module holes() {
  d = ((bracket_l + internal_l) / 4) + (wall_t / 2);
  translate([d,0,0]) hole();
  translate([-d,0,0]) hole();
}

module bracket() {
  points = [
    [internal_l/2, internal_h],
    [internal_l/2, 0],
    [bracket_l/2, 0],
    [bracket_l/2, wall_t],
    [internal_l/2 + wall_t, wall_t],
    [internal_l/2 + wall_t, internal_h + wall_t],
    [-internal_l/2 - wall_t, internal_h + wall_t],
    [-internal_l/2 - wall_t, wall_t],
    [-bracket_l/2, wall_t],
    [-bracket_l/2, 0],
    [-internal_l/2, 0],
    [-internal_l/2, internal_h],
  ];
  linear_extrude(height=bracket_w, convexity=2) {
    filleted(0.25 * wall_t) rounded(0.25 * wall_t) polygon(points=points);
  }
}

difference() {
  bracket();
  holes();
}

//------------------------------------------------------------------

//------------------------------------------------------------------
/*

Throat plate for Bandsaw

By default this script replaces the plastic throat plate for a
Powermatic 14" Bandsaw Model PWBS-14CS.

Parameters can be changed to match other bandsaws.

*/
//------------------------------------------------------------------
// Parameters

plate_diameter = 69.1;
plate_height = 4.0;
throat_width = 6.0;
throat_length = 54.0;
pin_diameter = 3.0;
pin_spacing = 64.0;
pin_height = 2.0;
with_holes = 1;
hole_diameter = 6.0;
hole_spacing = 12.0;

//------------------------------------------------------------------
// Set the scaling value to compensate for print shrinkage

scale = 1/0.995; // ABS ~0.5% shrinkage
//scale = 1/0.998; // PLA ~0.2% shrinkage

function dim(x) = scale * x;

//------------------------------------------------------------------
// derived values

plate_r = dim(plate_diameter) / 2;
plate_h = dim(plate_height);

pin_r = dim(pin_diameter) / 2;
pin_h = dim(pin_height);
pin_d = dim(pin_spacing)/2;

throat_d = dim(throat_width)/2;
throat_l = dim(throat_length);

hole_r = dim(hole_diameter)/2;
hole_d = dim(hole_spacing);

//------------------------------------------------------------------

// control the number of facets on cylinders
facet_epsilon = 0.01;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

//------------------------------------------------------------------

// small tweak to avoid differencing artifacts
epsilon = 0.05;

//------------------------------------------------------------------

module pin(x) {
  translate([x,0,0]) {
    cylinder(h=pin_h + epsilon, r=pin_r, $fn=facets(pin_r));
  }
}

module pins() {
  translate([0,0,plate_h - epsilon]) {
    pin(pin_d);
    pin(-pin_d);
  }
}

module throat() {
  translate([0,throat_l - plate_r - epsilon,0]) {
    rotate([90,0,0]) {
      linear_extrude(height = throat_l) {
        points = [
          [throat_d, -epsilon],
          [-throat_d, - epsilon],
          [-throat_d - plate_h, plate_h + epsilon],
          [throat_d + plate_h, plate_h + epsilon],
        ];
        polygon(points, convexity = 2);
      }
    }
  }
}

module hole(x,y) {
  translate([x,y, -epsilon]) {
    cylinder(h=plate_h + 2 * epsilon, r=hole_r, $fn=facets(hole_r));
  }
}

module holes() {
  hole(0,throat_l/2);
  posn = [
    [1,0],[1,1],[1,2],[1,-1],[1,-2],
    [-1,0],[-1,1],[-1,2],[-1,-1],[-1,-2],
    [2,0],[2,1],[2,-1],
    [-2,0],[-2,1],[-2,-1],
  ];
  for (x = posn) {
    hole(x[0] * hole_d, x[1] * hole_d);
  }
}

module plate() {
  difference() {
    union() {
      cylinder(h=plate_h, r=plate_r, $fn=facets(plate_r));
      pins();
    }
    union() {
      throat();
      if (with_holes != 0) {
        holes();
      }
    }
  }
}

plate();

//------------------------------------------------------------------




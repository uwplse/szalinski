// outer diameter
d1 = 63.4;
// diameter of hole
d2 = 10.9;
// height
h  = 20;

// number of spokes [ 0 for solid. ]
n_spokes = 3;

// width of the inner and outer rings
w_rings  = 3;

// width of a spoke
w_spoke  = 2; 

// radius for spoke corners
r_spoke  = 6;

// openscad smallest angle size
$fa = 1;
// openscad smallest segment size.
$fs = 1;


module spokes() {
  A = 360/n_spokes;
  w = w_spoke + r_spoke*2;

  for (a = [0:A:360]) {
    rotate(a) translate([0,-w/2]) square([d1,w]);
  }
}

module spoked() {
  linear_extrude(h)
  difference() { 
    o_rings = r_spoke*2 + w_rings *2;
    circle(d=d1);
    offset(r_spoke) {
    difference() { 
      circle(d=d1-r_spoke*2 - w_rings*2);
      spokes();
      circle(d=d2 + w_rings*2 + r_spoke*2);
    }
    }
    circle(d=d2);
  }
}


module solid() {
  linear_extrude(h)
    difference() {
      circle(d=d1);
      circle(d=d2);
  }
}

if (n_spokes == 0) { 
  solid();
} else {
  spoked();
}

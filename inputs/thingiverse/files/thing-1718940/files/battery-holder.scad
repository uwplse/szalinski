//------------------------------------------------------------------
/*

Battery Holder

2 x 3000 mAh 7.2V battery packs
See- http://www.tenergy.com, Item #11204-01

*/
//------------------------------------------------------------------
/* [Global] */

/*[General]*/
box_h = 34;
box_w = 49; // 2 batteries side by side
box_l = 136; // slightly longer to allow diagonal insertion
connector_d = 15; // hole for tamiya connector pass-thru
connector_z = 23; // z position of connector hole

/*[Preferences]*/
wall_t = 3; // wall thickness
wall_r = 1.5; // wall corner rounding
foot_inset = 6; // foot inset
foot_r = 5; // foot rounding
foot_h = 3; // foot height
foot_l = 12; // foot length
foot_hole_d = 3; // hole diameter for mounting foot
hole_to_edge = 6;

/* [Hidden] */
//------------------------------------------------------------------

// small tweak to avoid differencing artifacts
epsilon = 0.05;

// control the number of facets on cylinders
facet_epsilon = 0.03;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

// rounded polygons
module rounded(r=1) {
  offset(r=r, $fn=facets(r)) offset(r=-r, $fn=facets(r)) children(0);
}

// filleted polygons
module filleted(r=1) {
  offset(r=-r, $fn=facets(r)) render() offset(r=r, $fn=facets(r)) children(0);
}

//------------------------------------------------------------------

module wall_2d(t) {
  wall = 2 * t;
  p = [
    [0,0],
    [box_l + wall,0],
    [box_l + wall,box_w + wall],
    [0,box_w + wall],
  ];
  polygon(points=p);
}

module wall() {
  linear_extrude(height=box_h + epsilon, convexity = 2) difference() {
    translate([-wall_t, -wall_t]) rounded(wall_r) wall_2d(wall_t);
    rounded(wall_r) wall_2d(0);
  }
}

//------------------------------------------------------------------

module foot_2d() {
  x = 2 * (wall_t + foot_l);
  y = 2 * wall_t;
  p = [
    [0,0],
    [box_l + x,0],
    [box_l + x, box_w + y],
    [0,box_w + y],
  ];
  polygon(points=p);
}

module foot() {
  linear_extrude(height=foot_h) difference() {
    translate([-foot_l - wall_t, -wall_t]) rounded(foot_r) foot_2d();
    translate([foot_inset, foot_inset]) rounded(foot_r) wall_2d(-foot_inset);
  }
}

//------------------------------------------------------------------

module connector_hole() {
  h = wall_t + (2 * epsilon);
  r = connector_d / 2;
  cylinder(h=h, r=r, $fn=facets(r));
}

module connector_holes() {
  d = box_w / 2;
  yofs = d / 2;
  zofs = foot_h + connector_z;
  translate([epsilon,0,zofs]) rotate([0,-90,0]) translate([0,yofs,0]) {
    connector_hole();
    translate([0,d,0]) connector_hole();
  }
}

//------------------------------------------------------------------

module hole_countersunk(
  length,
  radius,
) {
  l = length;
  r = radius;
  if (r > l) {
    points = [
      [0, 0],
      [(2 * r) - l, 0],
      [2 * r, l],
      [0, l]
    ];
    rotate_extrude($fn=facets(r)) polygon(points=points);
  } else {
    points = [
      [0, 0],
      [r, 0],
      [r, l - r],
      [2 * r, l],
      [0, l]
    ];
    rotate_extrude($fn=facets(r)) polygon(points=points);
  }
}

module foot_holes() {
  l = foot_h + (2 * epsilon);
  r = foot_hole_d / 2;
  x = box_l + 2 * (wall_t + foot_l - hole_to_edge);
  y = box_w + 2 * (wall_t - hole_to_edge);
  xofs = foot_l - hole_to_edge + wall_t;
  yofs = hole_to_edge - wall_t;
  translate([-xofs, yofs,-epsilon]) {
    translate([0,0]) hole_countersunk(l,r);
    translate([x,0]) hole_countersunk(l,r);
    translate([0,y]) hole_countersunk(l,r);
    translate([x,y]) hole_countersunk(l,r);
  }
}

//------------------------------------------------------------------

module holder() {
  difference() {
    union() {
      foot();
      translate([0,0,foot_h - epsilon]) wall();
    }
    union() {
      connector_holes();
      foot_holes();
    }
  }
}

holder();

//------------------------------------------------------------------


//------------------------------------------------------------------
/*

4 Pillar PCB Mount

*/
//------------------------------------------------------------------
/* [Global] */

/*[General]*/
mount_width = 39.69;
mount_length = 44.45;
mount_height = 15;
mount_base_z = 3;
mount_hole_diameter = 3;
pillar_diameter = 6.5;
pillar_hole_diameter = 2;

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
// Mounting pillar with support webs

// single web
module pillar_web(
  web_height,
  web_radius,
  web_width
) {
  h = web_height;
  r = web_radius;
  w = web_width;
  points = [
    [0,0],
    [r,0],
    [0,h],
  ];
  rotate([90,0,0]) translate([0,0,-w/2]) linear_extrude(height=w) polygon(points=points);
}

// multiple webs
module pillar_webs(
  number_webs,
  web_height,
  web_radius,
  web_width
) {
  theta = 360 / number_webs;
  for (i = [1:number_webs]) {
    rotate([0,0,i * theta]) pillar_web(web_height, web_radius, web_width);
  }
}

// pillar
module pillar(
  pillar_height,
  pillar_radius
) {
  h = pillar_height;
  r = pillar_radius;
  cylinder(h=h, r=r, $fn=facets(r));
}

module pillar_hole(
  pillar_height,
  hole_depth,
  hole_radius
) {
  h = hole_depth + epsilon;
  r = hole_radius;
  z_ofs = pillar_height - hole_depth;
  translate([0,0,z_ofs]) cylinder(h=h, r=r, $fn=facets(r));
}

// pillar with webs
module webbed_pillar(
  pillar_height,
  pillar_radius,
  hole_depth,
  hole_radius,
  number_webs,
  web_height,
  web_radius,
  web_width,
) {
  intersection () {
    difference() {
      union() {
        pillar(pillar_height, pillar_radius);
        pillar_webs(number_webs, web_height, web_radius, web_width);
      }
      pillar_hole(pillar_height, hole_depth, hole_radius);
    }
    // Cut off any part of the webs that protrude from the
    // top of the pillar.
    cylinder(r = web_radius * 2, h = pillar_height);
  }
}

//------------------------------------------------------------------

// countersunk hole
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

//------------------------------------------------------------------

module mount_pillar() {
  z = mount_height - mount_base_z + epsilon;
  z_ofs = mount_base_z - epsilon;
  translate([0,0,z_ofs]) webbed_pillar(
    pillar_height = z,
    pillar_radius = pillar_diameter / 2,
    hole_depth = mount_height / 2,
    hole_radius = pillar_hole_diameter / 2,
    number_webs = 4,
    web_height = mount_height / 1.2,
    web_radius = pillar_diameter / 1.2,
    web_width = 2
  );
}

module pcb_mount_hole() {
  h = mount_base_z + (2 * epsilon);
  r = mount_hole_diameter / 2;
  translate([0,0,-epsilon])hole_countersunk(h, r);
}

module mount_base_2d() {
  w = mount_width;
  l = mount_length;
  points = [
    [0,0],
    [w,0],
    [w,l],
    [0,l],
  ];
  polygon(points=points);
}

//------------------------------------------------------------------

module pcb_mount_base() {
  r0 = pillar_diameter;
  r1 = r0 / 2.0;
  h = mount_base_z;
  linear_extrude(height = h) difference() {
    offset(r=r0, $fn=facets(r0)) mount_base_2d();
    rounded(r=r1) offset(r=-r1, $fn=facets(r1)) mount_base_2d();
  }
}

module pcb_mount_pillars() {
  w = mount_width;
  l = mount_length;
  translate([0,0]) mount_pillar();
  translate([w,0]) mount_pillar();
  translate([0,l]) mount_pillar();
  translate([w,l]) mount_pillar();
}

module pcb_mount_holes() {
  w = mount_width;
  l = mount_length;
  ofs = pillar_diameter / 4.5;
  y_mid = l/2;
  x_mid = w/2;
  translate([-ofs,y_mid]) pcb_mount_hole();
  translate([w+ofs, y_mid]) pcb_mount_hole();
  translate([x_mid,-ofs]) pcb_mount_hole();
  translate([x_mid,l+ofs]) pcb_mount_hole();
}

//------------------------------------------------------------------

module pcb_mount() {
  difference() {
    union() {
      pcb_mount_base();
      pcb_mount_pillars();
    }
    pcb_mount_holes();
  }
}

pcb_mount();

//------------------------------------------------------------------

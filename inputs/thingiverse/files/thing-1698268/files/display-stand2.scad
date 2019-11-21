//------------------------------------------------------------------
/*

Simple Display Stand for Rasberry Pi 7" Display

Similar to: http://www.thingiverse.com/thing:1021025

But:

1) OpenSCAD.
2) Allow the usb power port to be at the bottom (normal display orientation).
3) Provide mounting holes on the foot.
4) Variable thickness display supports to accomodate various M3 screw lengths.
5) Added webbing for better strength.
6) Adjustable foot size for better free-standing stability.

*/
//------------------------------------------------------------------
/* [Global] */

/*[General]*/
display_angle = 15;

/*[Base]*/
base_height = 8;
base_length = 160;
base_width = 100;
base_mount_hole_diameter = 4;
base_hole_rounding = 10;
base_mount_hole_posn = 0.8; // [0:0.05:1]
foot_sizex = 15;
foot_sizey = 30;

/*[Supports]*/
support_posn = 0.75; // [0:0.05:1]
support_height = 120;
support_thickness = 5;
support_hole2edge = 8;

/*[Webs]*/
web_thickness = 7;
web_radius = 10;

/* [Hidden] */
//------------------------------------------------------------------
// utility functions

// scaling
pla_shrink = 1/0.999; //~0.1%
abs_shrink = 1/0.995; //~0.5%
function scale(x) = pla_shrink * x;

// small tweak to avoid differencing artifacts
epsilon = 0.05;

// control the number of facets on cylinders
facet_epsilon = 0.05;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

// rounded/filleted edges
module inverse() {
  difference() {
    square(1e5, center=true);
    children(0);
  }
}
module rounded(r=1) {
  offset(r=r, $fn=facets(r)) offset(r=-r, $fn=facets(r)) children(0);
}
module filleted(r=1) {
  offset(r=-r, $fn=facets(r)) render() offset(r=r, $fn=facets(r)) children(0);
}

//------------------------------------------------------------------

// 4 x M3 mounting holes on display
mount_hole_w = scale(126.20);
mount_hole_h = scale(65.65);
display_mhr = scale(3.9/2);

// derived values
base_h = scale(base_height);
base_w = scale(base_width);
base_l = scale(base_length);
base_hr = scale(base_hole_rounding);
base_mhr = scale(base_mount_hole_diameter/2);

foot_sx = scale(foot_sizex);

support_h = scale(support_height);
support_t = scale(support_thickness);
support_h2e = scale(support_hole2edge);

web_t = scale(web_thickness);
web_r = scale(web_radius);

support_face_w = support_h2e + ((base_l - mount_hole_w) / 2);
foot_sy = max(support_face_w, scale(foot_sizey));

//------------------------------------------------------------------
// general screw hole: length, radius, style

module hole(l, r, style) {
  if (style == "countersunk") {
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
  } else {
    // plain hole
    cylinder(h=l, r=r, $fn=facets(r));
  }
}

//------------------------------------------------------------------

module base_2d(h, w) {
  delta = h * tan(display_angle);
  points = [
    [0, 0],
    [0, h],
    [w - delta, h],
    [w, 0],
  ];
  polygon(points=points);
}

module support_2d(t) {
  d0 = support_h * tan(display_angle);
  d1 = t * cos(display_angle);
  x0 = base_w * support_posn;
  points = [
    [x0, 0],
    [x0 - d1, 0],
    [x0 - d1 - d0, support_h],
    [x0 - d0, support_h],
  ];
  polygon(points=points);
}

//------------------------------------------------------------------
// web

module web_profile() {
  filleted(r=web_r) union() {
    support_2d(support_t + web_t);
    base_2d(base_h + web_t, base_w * support_posn);
  }
}

module web_right() {
  linear_extrude(height=support_t) web_profile();
}

module web_left() {
  translate([0,0,base_l - support_t]) web_right();
}

module web() {
  web_left();
  web_right();
}

//------------------------------------------------------------------
// base

module base_body_profile() {
  base_2d(base_h, base_w);
}

module base_hole_profile() {
  sx = base_w - (2 * foot_sx);
  sy = base_l - (2 * foot_sy);
  rounded(r=base_hr) square(size=[sx, sy]);
}

module base() {
  h = base_h + (2 * epsilon);
  difference() {
    linear_extrude(height=base_l) base_body_profile();
    translate([foot_sx,base_h + epsilon,foot_sy]) rotate([90,0,0]) linear_extrude(height=h) base_hole_profile();
  }
}

module base_mount_hole() {
  l = base_h + (2 * epsilon);
  translate([0,-epsilon,0]) rotate([-90,0,0]) hole(l=l, r=base_mhr, style="countersunk");
}

module base_mount_holes() {
  z0 = (foot_sy + support_t) / 2;
  z1 = base_l - z0;
  x0 = foot_sx / 2;
  x1 = x0 + (base_mount_hole_posn * base_w);
  union() {
    translate([x0,0,z0]) base_mount_hole();
    translate([x0,0,z1]) base_mount_hole();
    translate([x1,0,z0]) base_mount_hole();
    translate([x1,0,z1]) base_mount_hole();
  }
}

//------------------------------------------------------------------
// supports

module support_profile() {
  filleted(r=web_r) union() {
    base_2d(base_h, base_w);
    support_2d(support_t);
  }
}

module support_right() {
  linear_extrude(height=support_face_w) support_profile();
}

module support_left() {
  translate([0,0,base_l - support_face_w]) support_right();
}

module support() {
  support_left();
  support_right();
}

module display_mount_hole() {
  l = support_t + (2 * epsilon);
  rotate([0,90,0]) hole(l=l, r=display_mhr, style = "plain");
}

module display_mount_holes() {
  dx0 = base_w * support_posn;
  dx = support_t + epsilon;
  dy = (support_h / cos(display_angle)) - mount_hole_h - support_h2e;
  dz = (base_l - mount_hole_w) / 2;
  translate([dx0, 0,0]) rotate([0,0,display_angle]) translate([-dx,dy,dz]) union() {
    dx = mount_hole_w;
    dy = mount_hole_h;
    translate([0,0,0]) display_mount_hole();
    translate([0,dy,0]) display_mount_hole();
    translate([0,dy,dx]) display_mount_hole();
    translate([0,0,dx]) display_mount_hole();
  }
}

//------------------------------------------------------------------

module display_stand() {
  difference() {
    union() {
      base();
      support();
      web();
    }
    union() {
      base_mount_holes();
      display_mount_holes();
    }
  }
}

rotate([90,0,0]) display_stand();

//------------------------------------------------------------------


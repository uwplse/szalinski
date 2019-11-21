//------------------------------------------------------------------
/*

Angle Brackets

*/
//------------------------------------------------------------------
/* [Global] */

/*[General]*/
bracket_angle = 123;
bracket_length = 30;
wall_thickness = 3;

/*[Arm1]*/
arm1_length = 60;
arm1_holes = 2;
arm1_hole_style = "countersunk"; // [plain,countersunk]
arm1_hole_diameter = 3;
arm1_hole_spacing = 0.6; // [0:0.05:1]
arm1_hole_position = 0.85; // [0:0.05:1]
arm1_hole_elongation = 1.0;

/*[Arm2]*/
arm2_length = 19;
arm2_holes = 0;
arm2_hole_style = "countersunk"; // [plain,countersunk]
arm2_hole_diameter = 4.8;
arm2_hole_spacing = 0.4; // [0:0.05:1]
arm2_hole_position = 0.7; // [0:0.05:1]
arm2_hole_elongation = 0.0;

/*[Webs]*/
number_of_webs = 0;
web_size = 0.5; // [0:0.05:1]
web_spacing = 0.25; // [0:0.05:1]

/*[Hooks]*/
number_of_hooks = 2;
hook_size = 0.7; // [0:0.05:1] Relative to arm2 size
hook_width = wall_thickness * 2.5;
hook_spacing = 0.25; // [0:0.05:1]
hook_opening_size = 5.3;

/*[Fillets]*/
fillet_factor = 2.0;
rounding_factor = 0.2; // [0:0.05:1]

/* [Hidden] */
//------------------------------------------------------------------
// Set the scaling value to compensate for print shrinkage

//scale = 1/0.995; // ABS ~0.5% shrinkage
scale = 1/0.998; // PLA ~0.2% shrinkage

function dim(x) = scale * x;

//------------------------------------------------------------------
// derived values

bracket_l = dim(bracket_length);
arm1 = dim(arm1_length);
arm2 = dim(arm2_length);
wall_t = dim(wall_thickness);
arm1_hole_r = dim(arm1_hole_diameter/2);
arm2_hole_r = dim(arm2_hole_diameter/2);

//------------------------------------------------------------------
// control the number of facets on cylinders

facet_epsilon = 0.01;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

// small tweak to avoid differencing artifacts
epsilon = 0.05;

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

module hole(r, style) {
  if (style == "countersunk") {
    if (r > wall_t) {
      points = [
        [0,0],
        [(2 * r) - wall_t, 0],
        [2 * r, wall_t + (2 * epsilon)],
        [0, wall_t + (2 * epsilon)]
      ];
      rotate_extrude($fn=facets(r)) polygon(points = points);
    } else {
      points = [
        [0,0],
        [r, 0],
        [r, wall_t - r],
        [2 * r, wall_t + (2 * epsilon)],
        [0, wall_t + (2 * epsilon)]
      ];
      rotate_extrude($fn=facets(r)) polygon(points = points);
    }
  } else {
    // plain hole
    cylinder(h=wall_t + (2 * epsilon), r = r, $fn=facets(r));
  }
}

module hole_set(n, r, k, e, style) {
  space = bracket_l/(n - 1 + (2 * k));
  for (i = [1:n]) {
    translate([(k + i - 1) * space, 0, -epsilon]) {
      if (e != 0) {
        hull() {
          translate([0, e * r, 0]) hole(r, style);
          hole(r, style);
        }
      } else {
        hole(r, style);
      }
    }
  }
}

module holes() {
  if (arm1_holes > 0) {
    translate([arm1_hole_position * arm1,0,0]) rotate([-90,-90,0]) {
      hole_set(arm1_holes, arm1_hole_r, arm1_hole_spacing, -arm1_hole_elongation, arm1_hole_style);
    }
  }
  if (arm2_holes > 0) {
    d = arm2_hole_position * arm2;
    c = cos(bracket_angle);
    s = sin(bracket_angle);
    translate([d * c, d * s, 0]) rotate([0,-90,90+bracket_angle]) {
      hole_set(arm2_holes, arm2_hole_r, arm2_hole_spacing, arm2_hole_elongation, arm2_hole_style);
    }
  }
}

module web_profile() {
  c = cos(bracket_angle);
  s = sin(bracket_angle);
  d1 = arm1 * (1-web_size);
  d2 = arm2 * (1-web_size);
  wt = wall_t - epsilon;
  points = [
    [(c + 1) * wt/s, wt],
    [(c * arm2) + (s * wt) - (c * d2), (s * arm2) - (c * wt) - (s * d2)],
    [arm1 - d1, wt],
  ];
  polygon(points=points, convexity=2);
}

module web() {
  linear_extrude(height=wall_t, convexity=2) web_profile();
}

module hook_profile() {
  c = cos(bracket_angle);
  s = sin(bracket_angle);
  cn = cos(bracket_angle - 90);
  sn = sin(bracket_angle - 90);
  d1 = arm1 * (1-hook_size);
  d2 = arm2 * (1-hook_size);
  wt = wall_t - epsilon;
  hook_arm = hook_opening_size + wt;
  points = [
    [c * arm2 + s * wt + cn * hook_arm - wt, wall_t],
    [s * wt + 1.5 * hook_arm, (1 - 2 * rounding_factor) * wall_t],
    [(c * arm2 * hook_size) + (s * wt) + (cn * hook_arm), (s * arm2 * hook_size) - (c * wt) + (sn * hook_arm)],
    [(c * arm2 * hook_size) + (s * wt) + (cn * hook_opening_size), (s * arm2 * hook_size) - (c * wt) + (sn * hook_opening_size)],
    [(c * arm2 * 0.2) + (s * wt) + (cn * hook_opening_size),
      (s * arm2 * 0.2) - (c * wt) + (sn * hook_opening_size)],
    [(c * arm2 * 0.2) + (s * wt),
      (s * arm2 * 0.2) - (c * wt)],
  ];
  rounded(rounding_factor * wall_t) polygon(points=points, convexity=2);
}

module hook() {
  linear_extrude(height=hook_width, convexity=2) hook_profile();
}

module hooks() {
  space = (bracket_l - (number_of_hooks * hook_width)) / (number_of_hooks - 1 + (2 * web_spacing));
  for (i = [1:number_of_hooks]) {
    translate([0, 0, (hook_spacing * space) + (i - 1) * (space + hook_width)]) hook();
  }
}

module webs() {
  space = (bracket_l - (number_of_webs * wall_t)) / (number_of_webs - 1 + (2 * web_spacing)  );
  for (i = [1:number_of_webs]) {
    translate([0, 0, (web_spacing * space) + (i - 1) * (space + wall_t)]) web();
  }
}

module bracket_profile() {
  c = cos(bracket_angle);
  s = sin(bracket_angle);

  points = [
    [arm1, wall_t],
    [arm1, 0],
    [-wall_t, 0],
    [-wall_t, wall_t],
    [c * arm2, s * arm2],
    [(c * arm2) + (s * wall_t), (s * arm2) - (c * wall_t)],
    [(c + 1) * wall_t/s, wall_t],
  ];
  rounded(rounding_factor * wall_t) filleted(fillet_factor * wall_t) polygon(points=points);
}

module bracket() {
  difference() {
    union() {
      linear_extrude(height=bracket_l, convexity=2) bracket_profile();
      if (number_of_webs > 0) {
        webs();
      }
      hooks();
    }
    holes();
  }
}

translate([-arm1/2,bracket_l / 2,0]) rotate([90,0,0]) bracket();

//------------------------------------------------------------------

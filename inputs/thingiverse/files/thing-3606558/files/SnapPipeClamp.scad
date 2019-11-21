// Target Diameter
clamp_target_diameter = 20.0; //[20:0.1:40]
// Closeness
clamp_closeness = 1.0; //[0:0.01:1]
// Thickness
clamp_thickness = 1.0; //[0:0.01:1]
// Width
clamp_width = 1.0; //[0:0.01:1]

///////////////
/* Utilities */
///////////////

function solve_quad_positive(a, b, c) = (- b + sqrt(b * b - 4.0 * a * c)) / (2.0 * a);
function solve_quad_negative(a, b, c) = (- b - sqrt(b * b - 4.0 * a * c)) / (2.0 * a);
function sqr(x) = x * x;
function len(x, y) = sqrt(sqr(x) + sqr(y));

module prism(s, theta1, theta2, h) {
	linear_extrude(height = h, center = true) {
		polygon(points = [[0.0, 0.0], [s * cos(theta1), s * sin(theta1)], [s * cos(theta2), s * sin(theta2)]], paths=[[0, 1, 2]]);
	}
}

module cylindrical_fillet(x, s, r) {
	rot = s ? 0.0 : 180.0;
	translate(x) rotate(rot, [1.0, 0.0, 0.0]) {
		cylinder(r1 = r + 0.90 * r, r2 = r, h = 0.45 * r, center = false);
		cylinder(r1 = r + 0.45 * r, r2 = r, h = 0.90 * r, center = false);
	}
}

module cylinder_with_fillets(x, r, h, tol) {
	translate(x) {
		cylindrical_fillet([0.0, 0.0, - 0.5 * h], true, r + tol * 1.4142 * 0.5);
		cylindrical_fillet([0.0, 0.0, + 0.5 * h], false, r + tol * 1.4142 * 0.5);
		cylinder(r = r + tol, h = h, center = true);
	}
}

//////////////////////
/* Basic parameters */
//////////////////////

x = [clamp_target_diameter, clamp_closeness, clamp_thickness, clamp_width];
inDia = x[0] * 0.9;
opLoc = 0.7 + (x[1] - 0.5) * 0.4;
thick = 1.20 + inDia * 0.10 * (0.2 + x[2] * 0.8);
depth = 8.0 + inDia * (0.1 + x[3] * 0.5);

///////////////
/* Utilities */
///////////////

function f_1(a, b, r1, r2) = - sqr(a) - sqr(b) - 2.0 * r1 * r2 - sqr(r2);
function f_2(a, b) = 4.0 * (sqr(a) + sqr(b));
function f_3(a, c) = 4.0 * a * c;
function f_4(b, c, r1, r2) = sqr(c) - 4.0 * sqr(b) * sqr(r1 + r2);
function solve_tangent_circle_center(p, r1, r2) = solve_quad_positive(f_2(p[0], p[1]), f_3(p[0], f_1(p[0], p[1], r1, r2)), f_4(p[1], f_1(p[0], p[1], r1, r2), r1, r2));

/////////////////////////
/* Internal parameters */
/////////////////////////

t = thick;
l = 0.15 * inDia;
d = depth;
a = 0.5 * inDia * opLoc;
r1 = 0.5 * inDia;
r2 = r1 + t;
y1 = - a;
x1 = sqrt(sqr(r1) - sqr(y1));
x4 = x1 + t;
x3 = x1;
x2 = x4;
y2 = - sqrt(sqr(r2) - sqr(x2));
y4 = y2 - l;
y3 = y4;
x5 = solve_tangent_circle_center([x4, y4], r1, r2);

y5 = - sqrt(sqr(r1 + r2) - sqr(x5));
r4 = len(x5 - x3, y5 - y3);
r3 = r2;
x6 = solve_tangent_circle_center([x3, y3], r3, r1);
y6 = - sqrt(sqr(r3 + r1) - sqr(x6));
r6 = len(x6 - x1, y6 - y1);
theta1 = acos(- x5 / len(x5, y5));
theta2 = acos(- (x5 - x3) / len(x5 - x3, y5 - y3));
theta3 = acos(- x6 / len(x6, y6));
theta4 = acos(- (x6 - x3) / len(x6 - x3, y6 - y3));

///////////
/* Misc. */
///////////

$fn = 120;
e = 0.1;
i = 1000.0;

/////////////
/* Modules */
/////////////

module base() {
  difference() {
    difference() {
      union() {
        cylinder(r = r2, h = d, center = true);
        translate([0.0, 0.5 * y4, 0.0]) cube(size = [x4 * 2.0, - y4, d], center = true);
      }
      cylinder(r = r1, h = d + e, center = true);
    }
    translate([0.0, 0.5 * (y3 - i), 0.0]) cube(size = [x3 * 2.0, - y3 + i, d + e], center = true);
  }
}

module out(s) {
  scale([s, 1.0, 1.0]) {
    intersection() {
      difference() {
        translate([x5, y5, 0.0]) cylinder(r = r4, h = d, center = true);
        translate([x5, y5, 0.0]) cylinder(r = r1, h = d + e, center = true);
      }
      translate([x5, y5, 0.0]) prism(i, theta1, theta2, d);
    }
  }
}

module in(s) {
  scale([s, 1.0, 1.0]) {
    intersection() {
      difference() {
        translate([x6, y6, 0.0]) cylinder(r = r6 + e, h = d + e, center = true);
        translate([x6, y6, 0.0]) cylinder(r = r3, h = d + 2.0 * e, center = true);
      }
      translate([x6, y6, 0.0]) prism(i, theta3, theta4, d + e);
    }
  }
}

module snap_pipe_clamp() {
  difference() {
    union() {
      base();
      out(1.0);
      out(-1.0);
    }
    union() {
      in(1.0);
      in(-1.0);
      translate([0.0, y4 - i / 2.0, 0.0]) cube(size = [i, i, d + e], center = true);
    }
  }
}

snap_pipe_clamp();
// preview[view:east, tilt:top]

// Target Diameter
clamp_target_diameter = 40.0; //[20:0.1:40]
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

/////////////////////////
/* Internal parameters */
/////////////////////////

x = [clamp_target_diameter, clamp_thickness, clamp_width];
r_i = x[0] * 0.5;
a = 2.0 + (x[0] / 30.0) * 1.2 + 2.0 * 0.4 * (x[1] - 0.5);
t = 4.5 + 2.0 * 1.0 * (x[2] - 0.5);
tol = 0.02 * 25.4;
g = 60.0;
c = 3.0;
r_1 = r_i;
r_2 = r_i + a;
r_3 = r_i + 2.0 * a;
w = 3.0 * t + 2.0 * tol;
tt0 = tan(g + 15.0 + 90.0);
A0 = 1.0 + sqr(tt0);
B0 = - 2.0 * a * tt0;
C0 = sqr(a) - sqr(r_2);
x0 = solve_quad_negative(A0, B0, C0);
y0 = tt0 * x0;
tt1 = tan(75.0 + c);
A1 = 1.0 + sqr(tt1);
B1 = - 2.0 * a * tt1;
C1 = sqr(a) - sqr(r_2);
x1 = solve_quad_positive(A1, B1, C1);
y1 = tt1 * x1;
tt2 = tan(75.0);
A2 = 1.0 + sqr(tt2);
B2 = - 2.0 * a * tt2;
C2 = sqr(a) - sqr(r_2);
x2 = solve_quad_positive(A2, B2, C2);
y2 = tt2 * x2;

///////////
/* Misc. */
///////////

$fn = 120;
eps = 0.010;
inf = 500.0;

/////////////
/* Modules */
/////////////

module x_neg() {
translate([- inf / 2.0, 0.0, 0.0]) cube(size=inf, center=true);
}

module x_pos() {
translate([+ inf / 2.0, 0.0, 0.0]) cube(size=inf, center=true);
}

module ring() {
module uni() {
intersection() {
difference() {
translate([0.0, a, 0.0]) cylinder(r = r_3, h = w, center = true);
union() {
cylinder(r = r_1, h = w + eps, center = true);
negative();
}
}
x_neg();
}
ring_pos();
claw();
}

module negative() {
r = inf;
linear_extrude(height = w + eps, center = true, convexity = 5) {
polygon(points = [[0.0, 0.0], [eps, r], [- r * sin(g), r * cos(g)]], paths = [[0, 1, 2]]);
}
}

module cut() {
r = inf;
prism(r, 60.0, 120.0 + g + 15.0, t + 2.0 * tol);
}

module claw() {
intersection() {
difference () {
translate([0.0, r_1 + 0.5 * 3.0 * a, 0.0]) cube(size=[3.0 * a, 3.0 * a, w], center=true);
union() {
translate([0.0, r_1 + 0.5 * 3.0 * a + 0.5 * a, 0.0]) cylinder(r = a, h = w + eps, center = true);
translate([0.0, r_i + 3.0 * a, 0.0]) cube(size=[0.8 * a, 0.8 * a, w + eps], center=true);
}
}
x_neg();
}
}

module pipe() {
h = t + 2.0 * tol;
cylinder_with_fillets([x0, y0, 0.0], 0.5 * a, h + eps, 0.0);
}

module ring_pos() {
intersection() {
difference() {
cylinder(r = r_2, h = w, center = true);
cylinder(r = r_1, h = w + eps, center = true);
}
x_pos();
}
}

difference() {
uni();
cut();
}
pipe();
}

module lever() {
r = inf;
module pos() {
translate([0.0, r_2 + a, 0.0]) cylinder(r = a, h = w, center = true);
intersection() {
difference() {
translate([0.0, a, 0.0]) cylinder(r = r_3, h = w, center = true);
cylinder(r = r_2, h = w + eps, center = true);
}
prism(r, -45.0, 90.0, w + eps);
}
}

module neg() {
r = inf;
prism(r, 60.0, 120.0, t + 2.0 * tol);
}

module pipe() {
h = t + 2.0 * tol;
cylinder_with_fillets([x2, y2, 0.0], 0.5 * a, h + eps, 0.0);
}

difference() {
pos();
neg();
}
pipe();
}

module link() {
r = inf;

module circles_pos() {
translate([x1, y1, 0.0]) cylinder(r = a + tol, h = t, center = true);
translate([x0, y0, 0.0]) cylinder(r = a + tol, h = t, center = true);
}
module base () {
intersection() {
difference() {
translate([0.0, a, 0.0]) cylinder(r = r_3 + tol, h = t, center = true);
translate([0.0, a, 0.0]) cylinder(r = r_i - tol, h = t + eps, center = true);
}
prism(r, 75.0 + c, g + 105.0, t + eps);
}
}
module circles_neg() {
h = t + 2.0 * tol;
cylinder_with_fillets([x1, y1, 0.0], 0.5 * a, h, tol);
cylinder_with_fillets([x0, y0, 0.0], 0.5 * a, h, tol);
}

difference() {
union () {
circles_pos();
base();
}
circles_neg();
}
}

module cam_clamp() {
ring();
translate([x0, y0, 0.0]) rotate(45.0, [0.0, 0.0, 1.0]) translate([-x0, -y0, 0.0]) union () {
link();
rotate(c, [0.0, 0.0, 1.0]) translate([x2, y2, 0.0]) rotate(30.0, [0.0, 0.0, 1.0]) translate([- x2, - y2, 0.0]) lever();
}
}

cam_clamp();
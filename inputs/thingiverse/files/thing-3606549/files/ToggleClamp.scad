// Which one would you like to see?
part = "first"; // [first:Clamp Only,second:Padding Only,both:Clamp and Padding]

// Target Space
clamp_target_space = 20.0; //[20:0.1:40]
// Target Angle
clamp_target_angle = 30.0; //[0:0.1:30]
// Area Factor
clamp_area_factor = 1.0; //[0:0.01:1]

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

x = [clamp_target_space, clamp_target_angle, clamp_area_factor];
target_space = x[0];
target_angle = x[1];
area_factor = x[2];
rubber_thickness = 0.125 * 25.4;
tol = 0.5;
angle = 2.5;
arm_length = 55.0 + 2.0 * 5.0 * (area_factor - 0.5);
depth = 10.0 + 2.0 * 3.0 * (area_factor - 0.5);
w = 10.0 + 2.0 * 3.0 * (x[2] - 0.5);
alpha = arm_length - 0.5 * w;
beta = alpha - 0.5 * w;
gamma = beta * tan(target_angle);
space = target_space - 0.060 * 25.4 + 2.0 * rubber_thickness + gamma;
overcenter = 0.25 * 25.4;
piv_dia = 0.5 * w;
h1 = overcenter;
h2 = h1 + 0.5 * w;
pivot_space = h2 + 0.5 * w;
base1y = space + 0.5 * w;
base2y = base1y + pivot_space;
top_depth = 3.0 * depth + 2.0 * tol;
L = len(0.5 * arm_length, h1);
cylinder_radius = piv_dia * 0.5 - tol;

///////////
/* Misc. */
///////////

inf = 1000.0;
ep = 0.030;
$fn = 60;

/////////////
/* Modules */
/////////////

module base()
{
a = arm_length;
y1 = base1y;
y2 = base2y;
d = depth;
r = cylinder_radius;

module positive() {
tmp = (a + w / 2) / 2 - w / 2;
translate([tmp, 0.0, 0.0]) cube(size=[a + w / 2.0, w, top_depth], center=true);
translate([0, -w/2-y2/2,0]) cube(size=[w, y2 + ep, d], center=true);
translate([0, -y2-w/2, 0]) cylinder(r=w/2, h=d, center=true);
}

module negative() {
cylinder_with_fillets([0,-y2-w/2,0], r, d + 2.0 * tol, tol);
cylinder_with_fillets([0,-y1-w/2,0], r, d + 2.0 * tol, tol);
}

module anglePart() {
eps = 1e-5;
linear_extrude(height = top_depth, center = true, convexity = 5) {
polygon(points = [[0.5 * w - eps, - 0.5 * w + eps], [a, - 0.5 * w + eps], [0.5 * w - eps, - 0.5 * w - tan(target_angle) * (a - 0.5 * w)]], paths = [[0, 1, 2]]);
}
}

module f() {
difference() {
translate([0.0, - w / 2.0 - d / 2.0, d]) cube(size=[w, d + ep, d + ep], center=true);
translate([0.0, - w / 2.0 - d, 1.5 * d]) rotate(90.0, [0.0, 1.0, 0.0]) cylinder(r=d, h=w+ep,center=true);
}
difference() {
translate([0.0, - w / 2.0 - d / 2.0, - d]) cube(size=[w, d + ep, d + ep], center=true);
translate([0.0, - w / 2.0 - d, - 1.5 * d]) rotate(90.0, [0.0, 1.0, 0.0]) cylinder(r=d, h=w+ep,center=true);
}
}

difference() {
positive();
negative();
}
f();
if (target_angle > 1e-04) anglePart();
}

module arm()
{
l = arm_length;
d = depth;

module p1() {
cylinder(r=w/2,h=top_depth,center=true);
translate([l/2+0.25*w,0,0]) cube(size=[l+0.5*w,w,top_depth],center=true);
translate([l,-pivot_space/2,0]) cube(size=[w, pivot_space,top_depth],center=true);
translate([l,-pivot_space,0]) cylinder(r=w/2,h=top_depth,center=true);
}

module p2() {
tmp1 = d+2*tol;
tmp2 = (pivot_space-w/2)*2;
cube(size=[w*2,inf,tmp1],center=true);
translate([0,-pivot_space,0]) cube(size=[inf,tmp2-ep,tmp1],center=true);
}

module p3() {
r = cylinder_radius;
cylinder_with_fillets([0.0, 0.0, 0.0], r, d + 2.0 * tol + ep, 0.0);
cylinder_with_fillets([l,-pivot_space,0], r, d + 2.0 * tol + ep, 0.0);
}

module prism() {
x1 = w;
x2 = arm_length + 0.5 * w;
dy = tan(angle) * (arm_length - 0.5 * w);
linear_extrude(height = top_depth, center = true)
polygon(points=[[x1, 0.5 * w], [x2, 0.5 * w], [x2, 0.5 * w + dy]]);
}

difference() { p1(); p2(); }
p3();
prism();
}

module lever()
{
d = top_depth;

module p1() {
tmp = h2 + w;
cylinder(r=w/2,h=d,center=true);
translate([0.5*L,0,0]) cube(size=[L,w,d],center=true);
translate([L,0,0]) cylinder(r=w/2,h=d,center=true);
translate([L,-tmp/2,0]) cube(size=[w,tmp,d],center=true);
translate([L,-tmp,0]) cylinder(r=w/2,h=d,center=true);
translate([1.5*L,-tmp,0]) cube(size=[L,w,d],center=true);
translate([2.0*L,-tmp,0]) cylinder(r=w/2,h=d,center=true);
}

module p2() {
cube(size=[inf,h2*2,depth+2*tol],center=true);
}

module p3() {
cylinder_with_fillets([0.0, 0.0, 0.0], cylinder_radius, depth + 2.0 * tol + ep, 0.0);
cylinder_with_fillets([ L, 0.0, 0.0], cylinder_radius, depth + 2.0 * tol + ep, 0.0);
}

difference() { p1(); p2(); }
p3();
}

module link()
{
module p1() {
cylinder(r=w/2,h=depth,center=true);
translate([L/2,0,0]) cube(size=[L,w,depth],center=true);
translate([L,0,0]) cylinder(r=w/2,h=depth,center=true);
}

module p2() {
cylinder_with_fillets([0, 0, 0], cylinder_radius, depth + 2.0 * tol, tol);
cylinder_with_fillets([L, 0, 0], cylinder_radius, depth + 2.0 * tol, tol);
}

difference() { p1(); p2(); }
}

module rubber_top()
{
length = (arm_length - 0.5 * w) / cos(target_angle);
cube(size=[top_depth, rubber_thickness, length], center=true);
}

module rubber_bottom()
{
length = (1.0 / cos(angle)) * (arm_length - 0.5 * w);
cube(size=[top_depth, rubber_thickness, length], center=true);
}

module assemble()
{
t = space;
x = - w / 2.0;
y1 = w/2 + t/2;
y2 = -w/2 - t/2;
y3 = -base2y+t/2;
q = + acos(arm_length / (2.0 * L)); // positive: open, negative: close
translate([x, y1, 0]) base();
translate([x, y2, 0]) arm();
translate([x, y3, 0]) rotate(- q, [0.0, 0.0, 1.0]) lever();
translate([x + arm_length, y3, 0]) rotate(180.0 + q, [0.0, 0.0, 1.0]) link();
}

module rubbers()
{
{
p1_y = - 0.5 * space;
p1_z = - w + 0.5 * w;
p2_y = p1_y + tan(angle) * (arm_length - 0.5 * w);
p2_z = - arm_length;
pc_y = (p1_y + p2_y) * 0.5;
pc_z = (p1_z + p2_z) * 0.5;
translate([0.0, pc_y, pc_z]) rotate(angle, [1.0, 0.0, 0.0]) translate([0.0, 0.5 * rubber_thickness, 0.0]) rubber_bottom();
}
{
l = (arm_length - 0.5 * w) / cos(target_angle);
y1 = space * 0.5;
z1 = - (arm_length - 0.5 * w);
y2 = y1 - l * sin(target_angle);
translate([0.0, (y1 + y2) * 0.5, 0.5 * z1]) rotate(target_angle, [1.0, 0.0, 0.0]) translate([0.0, - 0.5 * rubber_thickness, 0.0]) rubber_top();
}
}

module toggle_clamp_hard() {
translate([0.0, 0.5 * gamma, 0.5 * w]) rotate(90.0, [0.0, 1.0, 0.0]) assemble();
}

module toggle_clamp_soft() {
translate([0.0, 0.5 * gamma, 0.5 * w]) rubbers();
}

module print_part() {
    if (part == "first") {
        toggle_clamp_hard();
    } else if (part == "second") {
        toggle_clamp_soft();
    } else if (part == "both") {
        toggle_clamp_hard();
        toggle_clamp_soft();
    }
}

print_part();
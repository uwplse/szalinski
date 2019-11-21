/* [Global] */

/* [Bottle] */

// Bottle Diameter
b_diameter  = 73.025; // [73:100]

// Bottle Cage Height
b_height = 95; // [90:120]

// Bottle Strength
b_strength  = 5.5; // [5:10]

// Base Width
b_baseWidth = 2; // [1:3]

/* [Tubes] */

// Front Tube Diameter
t_front = 38; // [25:60]

// Handlebars diameter
t_handleBar = 22.2; // [20:30]

// Vertical Tube Holder Width
s_width = 27; // [27:30]

// Vertical Tube Holder Thickness
s_thickness = 9; // [7:12]

// Vertical Tube Holder Height
s_stand = 85; // [85:120]

/* [Hidden] */
r_bottle_i  =  b_diameter + 1.5;
f_bottle    =  b_strength;
z_base      =  b_baseWidth;
r_bottle_o  = r_bottle_i + f_bottle;
r_ftube     =  t_front;

h_bottle   =  b_height;
r_bolt_3mm =   3.3;
r_bolt_6mm =   5.3;
z_bolt_i   =  20;
r_bolt_o   =   5.8;
z_bolt_o   =   2.1;
z_nut_3mm  =   5.75;
z_nut_6mm  =   11.5;

h_bolts   =  64;
h_bolt1   =  10;
h_bolt2   =  h_bolt1 + h_bolts;

x_hole3   =  10;

y_stand   =  s_width;
x_stand   =  s_thickness;
z_stand   =  s_stand;

r_tube_o  =  t_handleBar;
xf_bottle =   0.75;

fudge     =   0.01;

fn1       =  36;
fn2       =  72;
fn3       = 180;

// fn1       =  10;
// fn2       =  18;
// fn3       =  36;

module bottle() {
  difference() {
    linear_extrude(height = h_bottle, $fn = fn3) circle(r=r_bottle_o / 2, $fn = fn2);
    translate([0, 0, z_base]) linear_extrude(height = h_bottle - z_base + fudge, $fn = fn2) circle(r=r_bottle_i / 2, $fn = fn3);
  }
}

module hole6mm() {
  linear_extrude(height=z_bolt_i + z_bolt_o, $fn = fn1) circle(r=r_bolt_6mm / 2);
  linear_extrude(height=z_bolt_o, $fn = fn1) circle(r=z_nut_6mm / 2);
}

module nut3mm() {
  translate([0, 0, -1 * z_bolt_o]) linear_extrude(height=z_bolt_o * 2, $fn = 6) circle(r=z_nut_3mm / 2);
}

module hole3mm() {
  linear_extrude(height=z_bolt_i + z_bolt_o, $fn = fn1) circle(r=r_bolt_3mm / 2);
  nut3mm();
}

module base_holder() {
  cube([x_stand, y_stand, z_stand]);
  translate([r_bottle_o / 2 + x_stand - f_bottle * xf_bottle, y_stand / 2, 0]) bottle();
}

module cage() {
  difference() {
    base_holder();
    translate([x_stand + 10 * fudge, y_stand / 2, h_bolt1]) rotate([0,90,180]) hole6mm();
    translate([x_stand + 10 * fudge, y_stand / 2, h_bolt2]) rotate([0,90,180]) hole6mm();

    translate([r_bottle_o / 2 + x_stand - f_bottle * xf_bottle, y_stand / 2, 0]) sphere(r = r_bottle_i / 3, $fn = fn3);

    translate([-1 * x_stand, y_stand * 2 - fudge, h_bottle / 2]) rotate([90, 90, 0]) cylinder(r1 = r_tube_o / 2, r2 = r_tube_o / 2, h = y_stand * 3, $fn = fn1);

    translate([0, -100, z_stand * 0.975]) rotate([0, -5, 0]) cube([200, 200, 200]);

    translate([x_stand + f_bottle / 10, y_stand / 2 - x_hole3, h_bottle / 2 - r_tube_o / 1.5]) rotate([0,90,180]) hole3mm();
    translate([x_stand + f_bottle / 10, y_stand / 2 - x_hole3, h_bottle / 2 + r_tube_o / 1.5]) rotate([0,90,180]) hole3mm();
    translate([x_stand + f_bottle / 10, y_stand / 2 + x_hole3, h_bottle / 2 - r_tube_o / 1.5]) rotate([0,90,180]) hole3mm();
    translate([x_stand + f_bottle / 10, y_stand / 2 + x_hole3, h_bottle / 2 + r_tube_o / 1.5]) rotate([0,90,180]) hole3mm();

    hull() {
      translate([x_stand + f_bottle / 10, y_stand / 2 - x_hole3, h_bottle / 2 - r_tube_o / 1.5]) rotate([0,90,180]) nut3mm();
      translate([x_stand + f_bottle / 10, y_stand / 2 - x_hole3, h_bottle / 2 + r_tube_o / 1.5]) rotate([0,90,180]) nut3mm();
    }

    hull() {
      translate([x_stand + f_bottle / 10, y_stand / 2 + x_hole3, h_bottle / 2 - r_tube_o / 1.5]) rotate([0,90,180]) nut3mm();
      translate([x_stand + f_bottle / 10, y_stand / 2 + x_hole3, h_bottle / 2 + r_tube_o / 1.5]) rotate([0,90,180]) nut3mm();
    }

    translate([x_stand / 4 - r_ftube / 2, y_stand / 2, -1 * fudge]) cylinder(r1 = r_ftube / 2, r2 = r_ftube / 2, h = z_stand + fudge, $fn = fn3);

    for (z = [h_bottle / 5 : h_bottle / 4 : h_bottle / 5 * 4]) {
     for (a = [0:45:90]) {
      translate([r_bottle_o / 2 + x_stand, y_stand / 2, z]) rotate([145 - a, 80, 0]) cylinder(r1 = r_bottle_i / 10, r2 = r_bottle_i / 10, h = r_bottle_i, $fn = fn3);
      translate([r_bottle_o / 2 + x_stand, y_stand / 2, z]) rotate([-55 - a, 80, 0]) cylinder(r1 = r_bottle_i / 10, r2 = r_bottle_i / 10, h = r_bottle_i, $fn = fn3);
     }
     translate([r_bottle_o / 2 + x_stand, y_stand / 2, z]) rotate([0, 80, 0]) cylinder(r1 = r_bottle_i / 10, r2 = r_bottle_i / 10, h = r_bottle_i, $fn = fn3);
    }
  }
}

module print_part() {
  rotate([0,0,-90]) cage();
}

print_part();



$fn = 50 * 1;

// Draw corner piece
draw_corner_piece = "yes"; // [yes, no]

// Draw end stop
draw_end_stop = "yes"; // [yes, no]

// Draw straight stop
draw_straight_piece = "yes"; // [yes, no]


module roundedRect(size, radius) {
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z)
  hull() {
  translate([radius, radius, 0])
  circle(r=radius);

  translate([x - radius, radius, 0])
  circle(r=radius);

  translate([x - radius, y - radius, 0])
  circle(r=radius);

  translate([radius, y - radius, 0])
  circle(r=radius);
  }
}

module part() {
  difference() {
    translate([0, 0, 5])
      cube([12.3, 6.3, 30], center=true);
    translate([0, 3.3/2+0.1, 5])
      cube([8, 3, 30.1], center=true);
    translate([0, 0, -10+3/2])
      cube([8, 6.3+1, 3.01], center=true);
    translate([12.3/2 - 1.3/2 - 1.8, -6.3/2+0.5/2, 3+5])
      cube([1.3, 0.5 + 0.1, 25], center=true);
    translate([-12.3/2 + 1.3/2 + 1.8, -6.3/2+0.5/2, 3+5])
      cube([1.3, 0.5 + 0.1, 25], center=true);
  }
  translate([-5.8/2, -4.4, -5])
    cube([5.8, 1.4, 25]); 
}

module part_with_hole() {
  difference() {
    part();
  translate([0, 10, 10])
  rotate([90, 0, 0])
    cylinder(r=4/2, h=20);
  }
}

module corner() {
  part_with_hole();
  translate([0,-6.9,-6.9])
    rotate([-90, 0, 180]) part_with_hole();
}

module straight() {
  difference() {
    part_with_hole();
    translate([-10, -10, -12])
      cube([20, 20, 12]);
    // The straight part is a little slimmer, as to make it easier to move
    // the aluminium piece.
    translate([-10, 3.2-0.6, -1])
      cube([20, 20, 40]);
  }
}

module end_stop() {
  difference() {
    part_with_hole();
    translate([-10, -10, -12])
      cube([20, 20, 12]);
    // The straight part is a little slimmer, as to make it easier to move
    // the aluminium piece.
    translate([-10, 3.2-0.6, -1])
      cube([20, 20, 40]);
  }
  translate([-7.5,-4.4,0])
    roundedRect([15,8.5,3], radius=1);
}



if (draw_corner_piece=="yes") {
  translate([-15, 2, 0])
    rotate([0, 0, 90])
      corner();
}
if (draw_straight_piece=="yes") {
  translate([15, 0, 0])
    straight();
}
if (draw_end_stop=="yes") {
  end_stop();
}



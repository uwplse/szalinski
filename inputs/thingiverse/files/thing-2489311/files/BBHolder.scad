Baoding_balls_diameter = 42;  // diameters of balls
Max_Height = 10;   // maximum height at center part
Distance = 2;         // Distanceance of balls
$fn = 64;

bbRadius = Baoding_balls_diameter / 2;

difference() {
  mount();
  translate([0, 0, bbRadius - 0.1]) balls();
}

module mount() {
  cylinder(r = 2 * bbRadius / 3, h = Max_Height);
  translate([Baoding_balls_diameter + Distance, 0, 0]) cylinder(r = 2 * bbRadius / 3, h = Max_Height);
  translate([0, -bbRadius / 6, 0]) cube([2 * bbRadius, bbRadius / 3, Max_Height]);
}

module balls() {
  ball();
  translate([Baoding_balls_diameter + Distance, 0, 0]) ball();
}

module ball() {
  sphere(r = bbRadius);
}

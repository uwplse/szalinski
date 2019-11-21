/* [Global] */

// Type of the grid
type = "arc";   // [arc:Arched grid,circ:Circular grid,rect:Rectangular grid]

wall = 2;
width = 100;
depth = 80;

legH = 15;

/* [Hidden] */

gridWCount = width / 10;
gridDCount = depth / 20;
$fn = 64;

// preview[view:south west, tilt:bottom]

module leg(type) {
  if (type == "rect") {
    cube([wall * 3, wall * 3, legH + wall]);
  } else {
    intersection() {
      $fn = 64;
      cylinder(h = legH, r = 3 * wall);
      cube([wall * 4, wall * 4, legH + wall]);
    }
  }
}
module arc() {
  arcW = (width - wall) / gridWCount - wall;
  for (i = [1: gridWCount * sqrt(2)]) {
    difference() {
      cylinder(h = wall, r = i * (arcW + wall) +  wall);
      translate([0, 0, -0.1]) cylinder(h = wall + 0.2, r = i * (arcW + wall));
    }
    translate([width, 0, 0])
      difference() {
        cylinder(h = wall, r = i * (arcW + wall) +  wall);
        translate([0, 0, -0.1]) cylinder(h = wall + 0.2, r = i * (arcW + wall));
    }
  }
}

module circ() {
  circCount = gridWCount / 2;
  circR = (width - wall) / circCount - wall;
  for (i = [1: circCount + 2]) {
    for (j = [1: circCount + 2]) {
      translate([(i - 1) * (circR + wall) + wall / 2, (j - 1) * (circR + wall) + wall / 2, -0.1])
        difference() {
          cylinder(h = wall, r = circR + wall);
          translate([0, 0, -0.1]) cylinder(h = wall + 0.2, r = circR);
        }
    }
  }
}

module rect() {
  gridW = (width - wall) / gridWCount - wall;
  gridD = (depth - wall) / gridDCount - wall;
  for (i = [1 : gridWCount]) {
    translate([i * (gridW + wall), 0, 0])
      cube([wall, depth, wall]);
  }
  for (j = [1 : gridDCount]) {
    translate([0, j * (gridD + wall), 0])
      cube([width, wall, wall]);
  }
}


module rack(type) {
  // legs
  translate([0, 0, 0]) leg(type);
  translate([width, 0, 0]) rotate([0, 0, 90]) leg(type);
  translate([width, depth, 0]) rotate([0, 0, 180]) leg(type);
  translate([0, depth, 0]) rotate([0, 0, 270]) leg(type);
  // plate
  difference() {
    cube([width, depth, wall]);
    translate([wall, wall, -0.1]) cube([width - 2 * wall, depth - 2 * wall, wall + 0.2]);
  }
  intersection() {
    cube([width, depth, wall]);
    if (type == "arc") {
      arc();
    } else if (type == "circ") {
      circ();
    } else {
      rect();
    }
  } 
}

color("white")
rack(type);


// - Half of the width of the inside of the cup (mm)
cupRadius=50; // [1:999]
// - Dpeth of the inside (mm)
cupDepth=90; // [1:999]
// - The width of the arm of the couch (mm)
handleDepth=105; //[1:999]
// - How thick to make the cup holder wall (mm)
wallThickness=5; // [.01:999]
// - How thick to make the handle wall (mm)
handleThickness=5; // [.01:999]
// - How long to make the clip (mm)
clipLength=30; // [1:999]
// - The angle of the clip (mm)
clipAngle=5; // [1:89]

/* [Hidden] */
$fn=50;

module inner_cup() {
  translate([0, 0, wallThickness]) {
      // plus one for preview
      cylinder(cupDepth +  1, cupRadius, cupRadius);
  }
}

module cup_holder() {
  difference() {
    outer_cupDepth=cupDepth + wallThickness;
    outer_cupRadius=cupRadius + wallThickness;
    cylinder(outer_cupDepth, outer_cupRadius, outer_cupRadius);

    inner_cup();
  }
}

module handle() {
    difference() {
      translate([-cupRadius/4, 0, cupDepth]) {
        cube([cupRadius/2, handleDepth + cupRadius + wallThickness, handleThickness]);
      }

      inner_cup();
    }
}

module clip() {
  translate([-cupRadius/4, handleDepth + cupRadius + wallThickness, cupDepth]) {
    rotate([- clipAngle - 180 , 0, 0]) {
      cube([cupRadius/2, handleThickness, clipLength]);
    }
  }
}

union() {
  cup_holder();
  handle();
  clip();
}


$fn = 37;
pick_length = 16;
tip_radius = 2;
hold_radius = 11;

module pick() {
  hull() {
    translate([0,0,0.0]) cylinder(r=tip_radius,h=0.5);
    translate([pick_length,0,0]) cylinder(r=hold_radius,h=0.5);
  }
}

difference() {
  pick();

  // Now decorate the pick with some features.
  
  
  translate([pick_length,0,]) {
    for (angle = [0:60:300]) {
      ;
    }
  } 
}
$fn=48;
// how much tenting you want
tilt = 15;
// how round the corners are
corner_roundness = 7.25;
// width of the entire base top
width = 161.75;
// height of the entire base top
height = 138.15;
// how tall the shortest part of the tenting will be - 0 doesn't have enough
// room for the screws
lift=5;

// radius of screw holes
screw_hole_radius = 3.3;

// which side to render;
$side = "left"; // [left, right]

 module tent() {
     intersection() {
      rotate ([180,0-tilt,0]) {
        // this allows us to rotate on the furthest edge of the model, allowing
        // for a range of tilts
        translate([width/2,0,0]){
        difference () {
           base();
           // we need to flip the base upside down so it extrudes downwards,
           // but the screws are not symmetrical - so this corrects
           rotate([-180,0,0]) {
             screw_holes();
           }
           middle_cube();
         }
       }
     }
       // cuts off tenting at the bottom
       translate([width/2,0,0]) envelope();
     }
   }

module base() {
  translate([0,0,-lift]) {
    linear_extrude(height=150) { // this extrudes down, so it just always needs to get to the bottom
      offset(r=corner_roundness) {
        square([width - corner_roundness*2, height - corner_roundness*2], center=true);
      }
    }
  }
}

module screw_holes() {
  screw_hole_positions = [
    [74.80,63.5,0],
    [21.33,65.30,0],
    [23.62-15.75,-64.23,0],
    [-73.2,63.5,0],
    [-73.2,-60.59],
  ];

  for(screw_hole_position = screw_hole_positions) {
    translate(screw_hole_position) {
      cylinder (h=150, r=screw_hole_radius, center=true);
    }
  }
}

module envelope() {
  translate ([0,0,125]) {
    cube([width * 2, height * 2, 250], center=true);
  }
}

module side_cube() {
  translate ([-105.833333333,0,0]) {
    scale(0.28) {
      //%cube([700, 700, 150], center=true);
    }
  }
}

module middle_cube() {
  cube([133, 118,250], center=true);
}

module right() {
  translate([width/2, 0,0]) mirror([1, 0, 0]) tent();
}

module left() {
  translate([-width/2, 0,0]) mirror([0, 0, 0]) tent();
}

if ($side == "left") {
  left();
} else {
  right();
}

// Everything is in mm.
size = 30;
height = 10;
thickness = .5;
roundness = 5;
$fs = 0.01;
// Create a square with round edges,
// rounding may not exceed one half size.
module round_square(size_, round_) {
  half_round = round_ / 2;
  centering = (-(size_ - (round_ * 2)) / 2);
  // Centering.
  translate([centering, centering]) {
    // Rounding step.
    minkowski() {
      circle(round_, center = true);
      // Compensate for the rounding, and draw the square.
      adjusted_size = size_ - (round_ * 2);
      square([adjusted_size, adjusted_size]);
    }
  }
}

// Extrude the round wall.
linear_extrude(height) {
  difference() {
    // Create a outline of the round shape.
    round_square(size, roundness);
    // One third of thickness is used as a fudge value, to hopefully
    // make the width of the wall more consistant
    offset(-thickness){
      round_square(size, roundness);
    }
  }
}


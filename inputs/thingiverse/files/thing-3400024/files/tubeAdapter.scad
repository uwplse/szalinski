////////////////////////////////////////////////////////////////
// PARAMETERS //////////////////////////////////////////////////


smallExtDiam = 6; // Small part exterior diameter in millimeters
smallLength = 16; // Length of the small side in millimeters

bigExtDiam = 9; // Big part exterior diameter in millimeters
bigLength = 20; // Length of the big side in millimeters

holeDiameterDifference = 2; // Hole diameter difference with small part exterior diameter

stepCount = 4; // Number of steps on each side
stepDiamIncrease = 1; // diameter increase in millimiters

tubeAdapter(smallExtDiam, smallLength, bigExtDiam, bigLength);

module tubeAdapter(smallExtDiam, smallLength, bigExtDiam, bigLength) {
  difference() {
    union() {
      oneSide(bigExtDiam, bigLength);
      translate([0, 0, smallLength + bigLength]) {
        rotate([180, 0, 0]) {
        color("red")
          oneSide(smallExtDiam, smallLength);
        }
      }
    }
    translate([0, 0, -1])
      cylinder(d = smallExtDiam - holeDiameterDifference, h=smallLength + bigLength + 2, $fn=50);
  }
}

module oneSide(diam, length) {
  stepZ = length/stepCount;
  for (step = [0 : stepCount - 1]) {
    translate([0, 0, step * stepZ]) {
      cylinder(d1 = diam, d2 = diam + stepDiamIncrease, h = stepZ, $fn=60);
    }
  }

}
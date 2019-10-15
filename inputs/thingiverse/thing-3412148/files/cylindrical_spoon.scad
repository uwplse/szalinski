//
// Parametric Cylindrical Measuring Spoon, v1.0, (c) by Abdelmadjid Hammou
// Remixed from: Parametric Metric Measuring Spoon V1.1 (c) by FMMT666(ASkr) (www.askrprojects.net)
//
// Licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
//
// You should have received a copy of the license along with this
// work. If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
//

// Volume of the spoon (mL)
volume =           5.0;
// Internal height of the spoon (mm)
bowlHeight =      10.0;
// Length of the grip (mm)
gripLength =      50.0;
// Width of the grip (mm) (0 = auto)
gripWidth =        0.0;
// Wall and grip thickness (mm)
thickness =        1.5;
// Include grip (useful for testing the size of the bowl with much faster prints)
GRIP =            true;    // [true, false]

/*[hidden]*/
CP   = 75; // arc resolution ($fn)
rad  = sqrt( (volume * 1000) / (PI * bowlHeight) );
rado = rad + thickness;
gripW = (gripWidth == 0) ? rado : gripWidth;

Spoon();

module Spoon() {
  // join bowl and grip
  union() {
    Bowl();
    if(GRIP)
      Grip();
  }
}

module Bowl() {
  difference() {
    cylinder(r = rado, h = bowlHeight + thickness, $fn = CP );
    translate([0, 0, thickness])
      cylinder(r = rad, h = bowlHeight + 1, $fn = CP );
  }
}

module Grip() {
  union() {
    // round end of the grip
    translate([ gripLength + rado, 0, 0])
      cylinder( r = gripW/2, h = thickness, $fn = CP );

    // the grip's body
    translate([0, -gripW/2, 0])
      cube([gripLength + rado, gripW, thickness]);
  }
}



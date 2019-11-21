//!OpenSCAD

// Diameter of container
JarDiameter = 40; // [20:60]

// Pitch of 48 for 40 mm jar
// Pitch of 39 for 30 mm jar
// 48 for 40 mm jar or 39 for 30 mm jar works well
Pitch = 48; // [30:80]

// Total number of jars
Number_Jars = 2; // [1:40]

//Height of flange that attaches to pegboard
FlangeHeight = 10; // [10:30]

// Do you want pegs? 
WantPegs =  "yes"; // [yes,no]

// Look at the model after rendering. You may want to add or subtract a peg
TweakPegs = 0; // [-1,0,+1]

module MakeHolder() {
  // The depth as a function of the jar diameter
  DepthCarrier = JarDiameter / 2 + 2;
  // Calculate the number of peg holes that the carrier stradles
  NumberPegs = floor((Number_Jars * Pitch) / 25.41) + TweakPegs;
  // Calculate the difference in length between the carrier and the number of pegs so we can centre the peg holes on the back
  DifferenceInLength = (Number_Jars * Pitch + 2) - NumberPegs * 25.41;
  // The carrier with Number Holes in it
  difference() {
    union(){
      // The carrier to which we will add the pegs and subtract the holes
      color([0.93,0,0]) {
        hull(){
          // The carrier is the slanted piece with a horizontal ledge this is the high back 10 mm high
          translate([(-1 - Pitch / 2), DepthCarrier, 0]){
            cube([(Number_Jars * Pitch + 2), 6, FlangeHeight], center=false);
          }
          // And this is the front piece just 3mm high
          translate([(-1 - Pitch / 2), -4, 0]){
            cube([(Number_Jars * Pitch + 2), 1, 3], center=false);
          }
        }
      }
      // The pegs for the pegboard to keep it aligned
      if (WantPegs == "yes") {
        rotate([90, 0, 0]){
          for (j = [0 : abs(1) : NumberPegs]) {
            translate([(j * 25.41 - (Pitch / 2 - DifferenceInLength / 2)), 2.5, ((0 - DepthCarrier) - 7)]){
              cylinder(r1=2.5, r2=2.5, h=5, center=false);
            }
          }

        }
      }

    }

    // The holes subtracted
    for (i = [0 : abs(1) : Number_Jars - 1]) {
      union(){
        // The hole for container
        translate([(i * Pitch), (JarDiameter * 0.09), 0]){
          cylinder(r1=(JarDiameter / 2), r2=(JarDiameter / 2), h=FlangeHeight, center=false);
        }
        // The screw holes for fastening to pegboard
        translate([(i * Pitch), (DepthCarrier + 0.5), (FlangeHeight / 2)]){
          color([1,0.8,0]) {
            rotate([270, 0, 0]){
              {
                $fn=20;    //set sides to 20
                // #6 wood screw with countersink head
                union(){
                  cylinder(r1=3.5, r2=1.5, h=2, center=false);
                  cylinder(r1=1.5, r2=1.5, h=10, center=false);
                }
              }
            }
          }
        }
      }
    }

  }
}

MakeHolder();
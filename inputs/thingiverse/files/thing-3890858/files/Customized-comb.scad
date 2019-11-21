// ---- Dimensions

// Length of comb
length = 100;

// Height of comb
height = 32;

//Thickness of comb
thickness = 2.8;

// Number of teeth
numberOfTeeth = 30;

// Width of tooth
toothWidth = 1; //[0.5:0.1:3]

// Angle of tooth edge
toothCutAngle = 40; //[10:1:90]

// Handle height, expressed as a perentage (out of 100%) of overall height
handle_height=30; //[1:0.5:50]

// Side thickness, expressed as a perentage (out of 100%) of overall width
side_width=3.5; //[1:0.5:10]

// ---- Calculations

handleHeight= height*handle_height/100;
side = length * side_width/100;

workingWidth = length - 2 * side;
// workingWidth = numberOfTeeth * toothWidth + (numberOfTeeth + 1) * toothGap
toothGap = (workingWidth - numberOfTeeth * toothWidth) / (numberOfTeeth + 1);
toothStep = toothGap + toothWidth;

echo("workingWidth=", workingWidth, "toothWidth=", toothWidth, "toothGap=", toothGap, "toothStep=", toothStep);

// ---- Assemble

$fs = toothWidth / 10;

module base() {
  // cube with rounded corners
  hull() {
    translate([thickness / 2, 0, thickness / 2])
    cube(size = [height - thickness, thickness, length - thickness]);

    translate([thickness / 2, thickness / 2, thickness / 2])
    sphere(r = thickness / 2);

    translate([thickness / 2, thickness / 2, length - thickness / 2])
    sphere(r = thickness / 2);

    translate([height - thickness / 2, thickness / 2, length - thickness / 2])
    sphere(r = thickness / 2);

    translate([height - thickness / 2, thickness / 2, thickness / 2])
    sphere(r = thickness / 2);
  }
}

difference() {
  base();

  // cut teeth out
  for (i = [0 : numberOfTeeth]) {
    translate([-1, -100, side + i * toothStep])
    cube(size = [1 + height - handleHeight, 200, toothGap]);
  }

  // "sharpen" teeth
  translate([0, thickness / 2, -1])
  rotate(a=90-toothCutAngle / 2 + 180, v=[0, 0, 1])
  cube(size = [1000, 1000, length + 2]);

  translate([0, thickness / 2, -1])
  rotate(a=toothCutAngle / 2, v=[0, 0, 1])
  cube(size = [1000, 1000, length + 2]);
}

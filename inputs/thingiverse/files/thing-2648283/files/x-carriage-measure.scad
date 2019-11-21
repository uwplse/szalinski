/*Customizer Variables*/

/*[All]*/

// Diameter of rods (mm)
rodDiameter = 8.0; // [4:20]

// Spacing between rods (mm)
rodSpacing = 36.5; // [20:0.5:80]

/*[Hidden]*/

// Total depth (mm)
depth = 7.5;

// Thickness of mount around holes (mm)
mountThickness = 5.0;

// Thickness of body between holes (mm)
bodyThickness = 2.5;

// Cutout percent (0-1)
cutoutPercent = 0.4;

$fn=50;

//
// Code
//
module mount() {
  difference() {
    difference() {
      circle(d=rodDiameter + mountThickness);
      circle(d=rodDiameter);
    }

    cutoutWidth = (rodDiameter + mountThickness) * cutoutPercent;
    cutoutLength = rodDiameter + mountThickness;
    translate([(-rodDiameter+mountThickness)/2 - (rodDiameter+mountThickness)*cutoutPercent, -cutoutLength/2])
    square([cutoutWidth, cutoutLength]);
  };
}

module body() {
  length = rodSpacing;
  square([bodyThickness, length], true);
}

module label() {
  label=str(rodDiameter," - ", rodSpacing);

  translate([(bodyThickness/2)-0.5, 0, depth/2])
  rotate([90, 0, 90])
  linear_extrude(1)
  text(label, size=5, halign="center", valign="center");
}

module measurer() {
  holeDistance = rodSpacing + (rodDiameter);

  difference() {
    linear_extrude(depth) {
      body();
      translate([0, -holeDistance/2])
      mount();
      translate([0, holeDistance/2])
      mount();
    }
    label();
  }
}

measurer();


// height of clamp
clampHeight=10; // [10:0.2:50]

// width of clamp
clampWidth=30; // [20:50]

// depth of clamp
clampDepth=4; // [1.5:0.1:8]

// angle of clamp
clampAngle=8; // [0:0.1:20]

// hole diameter
holeDiameter=7; // [5:0.1:9]

// table offset
tableRiseOffset=3.2;

// material support height
materialSupportHeight=3.2;

/* hidden */
module hiden() {}
holeDiaMultiplier=3;
$fn = 50;

module bottomPlate() {
  difference() {
    union() {
      cube ([holeDiameter*holeDiaMultiplier,clampWidth,clampDepth]); 
      translate ([holeDiameter*holeDiaMultiplier, 0, 0]) cube ([materialSupportHeight,clampWidth,tableRiseOffset]);
    }
    translate([holeDiameter+clampDepth/4, clampWidth/2, -0.1]) cylinder (d=holeDiameter,h=clampDepth+0.2);
  }
}

module enforcement() {
  rotate([90,0,0])
  linear_extrude (height=clampDepth)
  polygon (points=[[0,0],[holeDiameter*holeDiaMultiplier-clampDepth/2,0],[holeDiameter*holeDiaMultiplier-clampDepth/2, clampHeight-clampDepth-0.5]]);   
}

module verticalPlate() {
  rotate ([0,clampAngle,0]) cube ([clampDepth,clampWidth,clampHeight-clampDepth]);
}

module clamp() {
  union() {
    bottomPlate();
    translate([holeDiameter*holeDiaMultiplier-clampDepth,0,clampDepth]) verticalPlate();
    enfOff=clampWidth-holeDiameter;
    translate([0,clampDepth+enfOff,clampDepth]) enforcement();
    translate([0,clampWidth-enfOff,clampDepth]) enforcement();
  }
}

clamp();

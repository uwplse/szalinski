//  SCAD Mesh File
//  D. Scott Nettleton
//  Weight
//  This mesh is for use with the OpenSCAD

use <write/Write.scad>

exportMode = 0;  // [0:Preview,1:Handle,2:Weight]

// Density in kg/m^3
fillMaterial = 1500;  //  [1000:Water,1500:Sand,7000:Pennies,8400:Lead Shot]

// Convert units if neccessary
weightUnit = 2.20462;  //  [1:Kilograms,2.20462:Pounds]

// Total weight in given units
weight = 10;  //  [1:50]

weightType = 2;  //  [2:Dumbell,1:Kettle]

if (exportMode == 0) { // Preview Mode
  if (weightType == 2) { // Dumbell
    translate([68,0,weightRadius*13.377])
    rotate(a=-90, v=[0,1,0]) {
      union() {
        drawBarbell();
        drawWeightContainer();
        translate([0,0,150])
          rotate(a=180, v=[0,1,0])
            drawWeightContainer();
      }
    }
  }
  else { // Kettle
    translate([0,0,volumeDepth*10+8]) {
      drawKettleHandle();
      drawWeightContainer();
    }
  }
}
else if (exportMode == 1) { //  Handle
  if (weightType == 2) { // Dumbell
    translate([68,0,weightRadius*12+7])
    rotate(a=-90, v=[0,1,0]) {
      drawBarbell();
    }
  }
  else { // Kettle
    drawKettleHandle();
  }
}
else if (exportMode == 2) { //  Weight
    translate([0,0,volumeDepth*10+8]) {
      drawWeightContainer();
    }
}

module drawBarbell() {
  union() {
    translate([0,0,150])
      rotate(a=180,v=[0,1,0])
        drawBarbellCap();
    translate([0,0,17])
      cylinder(h=116, r1=12.5, r2=12.5, center=false, $fn=16);
    drawBarbellCap();
  }
}

weightRadius = 6.5;  // 6.5 cm
collarVolume = 3.14159*(weightRadius*0.9)*(weightRadius*0.9)*4;
targetVolume = ((weight/weightUnit/weightType)/fillMaterial)*1000000 - collarVolume;  //cubic centimeters
volumeDepth = targetVolume/147.875;

module drawKettleHandle() {
  difference() {
    union() {
      translate([weightRadius*5, 0, 18]) {
        rotate(a=20, v=[0,1,0])
        union() {
          sphere(r=12.5, center=true, $fn=32);
          cylinder(h=80, r1=12.5, r2=12.5, center=false, $fn=32);
          translate([0,0,80])
            sphere(r=12.5, center=true, $fn=32);
          translate([0,0,80])
            rotate(a=-110, v=[0,1,0])
              cylinder(h=122, r1=12.5, r2=12.5, center=false, $fn=32);
        }
      }
      translate([-weightRadius*5, 0, 18]) {
        rotate(a=-20, v=[0,1,0])
        union() {
          sphere(r=12.5, center=true, $fn=32);
          cylinder(h=80, r1=12.5, r2=12.5, center=false, $fn=32);
          translate([0,0,80])
            sphere(r=12.5, center=true, $fn=32);
        }
      }
    }
    cube(size=[weightRadius*20, weightRadius*20, 30], center=true);
  }
  drawBarbellCap();
}

module drawBarbellCap() {
  difference() {
    cylinder(h=18, r1=weightRadius*12+7, r2=weightRadius*12+7, center=false, $fn=32);
    drawThreads(15, weightRadius*12, 3, 0.15, 1);
  }
}

module drawWeightContainer() {
  text = str(weight/weightType, (weightUnit == 1) ? " kg" : " lbs");
  translate([0,0,-volumeDepth*10-5+3])
  union() {
    difference() {
      drawWeight();
      translate([0,0,-3]) {
        mirror([1,0,0]) {
          write(text, t=2, h=weightRadius*3.5, font="write/orbitron.dxf", center=true);
          translate([0,-weightRadius*4, 0]) {
            if (fillMaterial == 1000) {
              write("Fill With Water", t=2, h=weightRadius*1.5, font="write/Letters.dxf", center=true);
            }
            else if (fillMaterial == 1500) {
              write("Fill With Sand", t=2, h=weightRadius*1.5, font="write/Letters.dxf", center=true);
            }
            else if (fillMaterial == 7000) {
              write("Fill With Pennies", t=2, h=weightRadius*1.5, font="write/Letters.dxf", center=true);
            }
            else if (fillMaterial == 8400) {
              write("Fill With Shot", t=2, h=weightRadius*1.5, font="write/Letters.dxf", center=true);
            }
          }
        }
      }
    }
    difference() {
      translate([0,0,volumeDepth*10+1.5])
        drawThreads(15, weightRadius*12, 3, 0.15, 1);
      drawCollar();
    }
  }
}

module drawThreads(length, radius, threadDepth, tpm, leftRight = 0) {
  if (exportMode > 0) {
    mirror([leftRight,0,0])
  	linear_extrude(height=length, twist=360*length*tpm, center=false, $fn=32)
  	  translate([threadDepth,0,0])
  	    circle(r=radius-threadDepth);
  }
}

module drawCollar() {
  if (exportMode > 0) {
    translate([0,0,volumeDepth*10+1.25])
      cylinder(h=46,r1=weightRadius*9,r2=weightRadius*9, $fn=32);
  }
}

module drawWeight() {
  polyhedron(
  points=[
    [-5.491517066955566*weightRadius,13.255526542663574*weightRadius,-3],
    [-5.5304107666015625*weightRadius,13.376564979553223*weightRadius,3.9257373809814453],
    [5.509345054626465*weightRadius,13.248157501220703*weightRadius,-3],
    [5.548361301422119*weightRadius,13.369129180908203*weightRadius,3.9257373809814453],
    [13.282904624938965*weightRadius,5.479954719543457*weightRadius,-3],
    [13.37697982788086*weightRadius,5.529995918273926*weightRadius,3.9257373809814453],
    [13.275522232055664*weightRadius,-5.498571395874023*weightRadius,-3],
    [13.36954402923584*weightRadius,-5.548775672912598*weightRadius,3.9257373809814453],
    [5.491516590118408*weightRadius,-13.256356239318848*weightRadius,-3],
    [5.530409812927246*weightRadius,-13.377394676208496*weightRadius,3.9257373809814453],
    [-5.50934362411499*weightRadius,-13.248984336853027*weightRadius,-3],
    [-5.54836368560791*weightRadius,-13.36995792388916*weightRadius,3.9257373809814453],
    [-13.282904624938965*weightRadius,-5.4807844161987305*weightRadius,-3],
    [-13.37697982788086*weightRadius,-5.530825138092041*weightRadius,3.9257373809814453],
    [-13.275521278381348*weightRadius,5.497743606567383*weightRadius,-3],
    [-13.369544982910156*weightRadius,5.547945976257324*weightRadius,3.9257373809814453],
    [-5.5304107666015625*weightRadius,13.376564979553223*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [5.548361301422119*weightRadius,13.369129180908203*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [13.37697982788086*weightRadius,5.529995918273926*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [13.36954402923584*weightRadius,-5.548775672912598*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [5.530409812927246*weightRadius,-13.377394676208496*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [-5.54836368560791*weightRadius,-13.36995792388916*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [-13.37697982788086*weightRadius,-5.530825138092041*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [-13.369544982910156*weightRadius,5.547945976257324*weightRadius,8.43543815612793+(volumeDepth-1)*10],
    [-5.466272354125977*weightRadius,13.194588661193848*weightRadius,12.0+(volumeDepth-1)*10],
    [5.484016418457031*weightRadius,13.187253952026367*weightRadius,12.0+(volumeDepth-1)*10],
    [13.221841812133789*weightRadius,5.454761028289795*weightRadius,12.0+(volumeDepth-1)*10],
    [13.214489936828613*weightRadius,-5.473294734954834*weightRadius,12.0+(volumeDepth-1)*10],
    [5.46627140045166*weightRadius,-13.195416450500488*weightRadius,12.0+(volumeDepth-1)*10],
    [-5.484017848968506*weightRadius,-13.188077926635742*weightRadius,12.0+(volumeDepth-1)*10],
    [-13.221843719482422*weightRadius,-5.455591201782227*weightRadius,12.0+(volumeDepth-1)*10],
    [-13.214491844177246*weightRadius,5.472464561462402*weightRadius,12.0+(volumeDepth-1)*10],
    [-4.999999523162842*weightRadius,10.0*weightRadius,12.0+(volumeDepth-1)*10],
    [5.0*weightRadius,10.0*weightRadius,12.0+(volumeDepth-1)*10],
    [10.0*weightRadius,4.999999523162842*weightRadius,12.0+(volumeDepth-1)*10],
    [10.0*weightRadius,-5.0*weightRadius,12.0+(volumeDepth-1)*10],
    [4.999999046325684*weightRadius,-10.0*weightRadius,12.0+(volumeDepth-1)*10],
    [-5.0*weightRadius,-10.0*weightRadius,12.0+(volumeDepth-1)*10],
    [-10.0*weightRadius,-5.0*weightRadius,12.0+(volumeDepth-1)*10],
    [-10.0*weightRadius,5.0*weightRadius,12.0+(volumeDepth-1)*10],
    [-4.999999046325684*weightRadius,9.999998092651367*weightRadius,2.0],
    [5.0*weightRadius,10.0*weightRadius,2.0],
    [10.0*weightRadius,5.0*weightRadius,2.0],
    [9.999998092651367*weightRadius,-5.0*weightRadius,1.9999995231628418],
    [4.999999046325684*weightRadius,-10.0*weightRadius,2.0],
    [-5.0*weightRadius,-9.999998092651367*weightRadius,2.0],
    [-10.0*weightRadius,-4.999999523162842*weightRadius,1.9999995231628418],
    [-10.0*weightRadius,5.0*weightRadius,2.0]
  ],
  triangles=[
    [0,3,1],
    [2,5,3],
    [4,6,5],
    [6,8,7],
    [8,10,9],
    [10,12,11],
    [5,17,3],
    [14,1,15],
    [12,15,13],
    [0,4,2],
    [19,26,18],
    [7,18,5],
    [3,16,1],
    [9,19,7],
    [11,20,9],
    [13,21,11],
    [15,22,13],
    [1,23,15],
    [28,36,27],
    [22,29,21],
    [18,26,17],
    [21,28,20],
    [16,31,23],
    [17,24,16],
    [20,27,19],
    [23,30,22],
    [37,44,36],
    [31,39,30],
    [27,35,26],
    [30,38,29],
    [26,34,25],
    [29,37,28],
    [24,32,31],
    [25,33,24],
    [41,42,40],
    [32,47,39],
    [33,40,32],
    [36,43,35],
    [39,46,38],
    [35,43,34],
    [38,46,37],
    [34,41,33],
    [2,3,0],
    [4,5,2],
    [5,6,7],
    [7,8,9],
    [9,10,11],
    [11,12,13],
    [18,17,5],
    [0,1,14],
    [14,15,12],
    [8,6,4],
    [12,10,8],
    [14,12,0],
    [0,8,4],
    [12,8,0],
    [27,26,19],
    [19,18,7],
    [17,16,3],
    [20,19,9],
    [21,20,11],
    [22,21,13],
    [23,22,15],
    [16,23,1],
    [27,36,35],
    [30,29,22],
    [17,26,25],
    [29,28,21],
    [24,31,16],
    [25,24,17],
    [28,27,20],
    [31,30,23],
    [45,44,37],
    [30,39,38],
    [26,35,34],
    [29,38,37],
    [25,34,33],
    [28,37,36],
    [31,32,39],
    [24,33,32],
    [40,42,47],
    [47,42,46],
    [46,42,45],
    [45,42,44],
    [44,42,43],
    [40,47,32],
    [41,40,33],
    [44,43,36],
    [47,46,39],
    [34,43,42],
    [37,46,45],
    [42,41,34]
  ]);
}

//// Cura 2.7:
// Too sloppy (A)
//xAxisInsert = 19.5 / 2.0;
//yAxisInsert = 11.5 / 2.0;
//aluThickness = 1.85;

// Still just slightly too sloppy (B)
//xAxisInsert = 19.7 / 2.0;
//yAxisInsert = 11.7 / 2.0;
//aluThickness = 1.8;

// Still just slightly too tight (C)
//xAxisInsert = 19.8 / 2.0;
//yAxisInsert = 11.8 / 2.0;
//aluThickness = 1.7;

// Perfect (D)
//xAxisInsert = 19.75 / 2.0;
//yAxisInsert = 11.75 / 2.0;
//aluThickness = 1.7;

xAxisInsert = 19.75 / 2.0;
yAxisInsert = 11.75 / 2.0;

aluThickness = 1.7;
wallThickness = 2.0;

outerX = xAxisInsert + aluThickness + wallThickness;
outerY = yAxisInsert + aluThickness + wallThickness;

screwSeparation = 240.0;
aluLength = 198.0;
screwToAluEnd = (screwSeparation - aluLength) / 2.0;

insertLength = 25.0;
sleeveDepth = 10.0;
bodyLength = screwToAluEnd + sleeveDepth;

handleAngle = 20.0;
handleExtension = 60.0;

raftWidth = 4.0;
raftDepth = 4.0;
insertDepth = 5.0;

screwRadius = 2.5;
washerRadius = 6.0;
washerDepth = 3.0;

fridgeRadius = 25.0;
fridgeDepth = 9.0;

BarConnector();
rotate([0, 0, handleAngle]) translate([-handleExtension, 0, 0]) FridgeConnector();

//FridgeConnector();

//BarConnectorTest();

module BarConnectorTest() {
   raftDepth = 4.0;
   intersection() {
      translate([0, 0, raftDepth - screwToAluEnd]) BarConnector();
      translate([-50, -50, 0]) cube([100, 100, 100]);
   }
   
   Ellipse(raftDepth, xAxisInsert + aluThickness + wallThickness + raftDepth, yAxisInsert + aluThickness + wallThickness + raftDepth);
}

module FridgeConnector() {
   difference() {
      hull() {
         ProlateEllipsoid(2*outerX, 2*outerY);
         translate([handleExtension, 0, 0]) {
            ProlateEllipsoid(outerX, outerY);
         }
      }
      // Fridge body
      hull() {
         translate([0, fridgeRadius, -2*outerX]) {
            translate([-2*outerY, 0, 0]) cylinder(4 * outerX, fridgeRadius, fridgeRadius);
            translate([fridgeDepth, 0, 0]) cylinder(4 * outerX, fridgeRadius, fridgeRadius, $fn=50);
         }
      }
      // Screw hole
      rotate([90, 0, 0]) cylinder(4 * outerY, screwRadius, screwRadius, center=true, $fn=35);
      // Washer
      translate([0, washerDepth - (2 * outerY), 0]) rotate([90, 0, 0]) {
         cylinder(washerDepth, washerRadius, washerRadius);
      }
   }
}

module BarConnector() {
   // Bottom rounding
   rotate([90, 0, 0]) ProlateEllipsoid(outerX, outerY);
   // Body and sleeve
   difference() {
      Ellipse(bodyLength, xAxisInsert + aluThickness + wallThickness, yAxisInsert + aluThickness + wallThickness);
      translate([0, 0, bodyLength - sleeveDepth]) Ellipse(sleeveDepth, xAxisInsert + aluThickness, yAxisInsert + aluThickness);
   }
   // Insert
   translate([0, 0, bodyLength - sleeveDepth]) Ellipse(insertLength, xAxisInsert, yAxisInsert);
}


module Test() {
   Ellipse(raftDepth, yAxisInsert + raftWidth);
   translate([0, 0, raftDepth]) Ellipse(insertDepth, xAxisInsert, yAxisInsert);
}




module Ellipse(depth, yAxis, xAxis, yLayerHeight=0.1) {
   linear_extrude(depth) {
      scale([xAxis, yAxis, 1]) circle(1, $fn=100);
   }
}

module ProlateEllipsoid(yAxis, xAxis) {
   rotate_extrude($fn=100) {
      intersection() {
         scale([xAxis, yAxis, 1]) circle(1, $fn=100);
         translate([0, -yAxis, 0]) square([xAxis, 2 * yAxis]);
      }
   }
}


//module Ellipse(depth, xAxis, yAxis, yLayerHeight=0.1) {
//   hull() {
//      for (y = [0: 0.1: xAxis]) {
//         x = yAxis * sqrt(1 - ((y * y) / (xAxis * xAxis)));
//         translate([x, y, 0]) cylinder(depth, 0.01, 0.01);
//         translate([x, -y, 0]) cylinder(depth, 0.01, 0.01);
//         translate([-x, y, 0]) cylinder(depth, 0.01, 0.01);
//         translate([-x, -y, 0]) cylinder(depth, 0.01, 0.01);
//      }
//   }
//}

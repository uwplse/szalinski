part = "screwDriver"; //[screwDriver:Screw Driver, fitTest:Fit Test] 
/*[Screw Driver Handle]*/
//overall length
handleLength = 40;
//handle roundess
handleRoundness = 1; //[0:.25:5]
//amount to slope the edges of the tool end
workingEndSlope = 10; //[0:0.5:15]
//distance across flat portions of tools (emperically determined)
bitFlats = 6.6; //[6.3:0.01:7]
//depth of holes for bits
bitDepth = 11; 
//Depth of socket for bit holder
toolDepth = 18; 
//number of holes
bitHoles = 5; //[1, 5, 9, 13, 17] 
//wall thickness
wallThickness = 2.5; //[.5:.1:5]

/*[FitTest]*/
startFlat = 6.35; 
itterations = 7; //[1:10]
step = 0.01; 
thickness = 5;





/*[Hidden]*/
hexNumber = (bitHoles+1)/2;
handleDia = (flatToRadius(bitFlats+wallThickness)*hexNumber)*2+wallThickness/2;
//preview[tilt:bottom diagonal]

print_part();
use <../libraries/honeycomb.scad>

module handle(len = 30, handleDia = 20, curve = 1) {
  localCurve = curve <= 0 ? .0001 : curve;
  echo("mod:handle");
  hexRad = handleDia/2-curve*2 <= 0 ? .001 : handleDia/2-curve*2;
  minkowski() {
    cylinder(r = hexRad, h = len/3, $fn = 6);
    translate([hexRad, 0, 0])
      cylinder(r = localCurve, h = len/3, $fn =36);
    translate([-hexRad, 0, 0])
      cylinder(r = localCurve, h = len/3, $fn = 36);
  }
}


module endCap(len = 30, handleDia = 20, curve = 1) {
  intersection() {
    handle(len = len, handleDia = handleDia, curve = curve);
    sphere(r = handleDia/2);
  }

}

module workingEnd(len = 30, handleDia = 20, curve = 1, slope = 5) {
  intersection() {
    handle(handleDia = handleDia, len = len, curve = curve);
    cylinder(h = len*slope/100, r1 = handleDia/2*(1-slope/100), 
      r2 = handleDia/2*(1+slope/100), $fn = 36);
  }
}

function hexInradius(radius) = radius * (sqrt(3) / 2);

module fitTest(startFlat = 6.35, itterations = 5, step = .01, thickness = 5) {
  wall = 2;
  yTrans = flatToRadius(itterations*step+startFlat)*2+wall;
  
  cubeDim = [yTrans, yTrans*itterations, thickness];

  difference() {
    union() {
      translate([cubeDim[0]/-2, 0, 0])
        cube(cubeDim);
      cylinder(r = startFlat/4, h = thickness/2, $fn = 32);
    }

    for (i = [1:itterations]) {
      translate([0, (i-1)*yTrans+yTrans/2, ])
        cylinder(r = flatToRadius(startFlat+(i-1)*step), 
          h = thickness*4, center = true, $fn = 6);
        echo(str("index: ", i, "; flat distance: ", startFlat+(i-1)*step, "; radius: ", flatToRadius(startFlat+(i-1)*step)));
    }
  }
}

module screwDriver() {
  capZ = handleLength - handleDia/2;
  workingEndLen = handleLength * workingEndSlope/100;
  localHandleLen = handleLength - handleDia/2 - workingEndLen;
  bodyZ = workingEndLen;
  
  difference() {
    color("silver")
    union() {
      translate([0, 0, bodyZ])
      handle(len = localHandleLen, handleDia = handleDia, curve = handleRoundness);
      translate([0, 0, capZ])
        endCap(len = handleLength, curve = handleRoundness, handleDia = handleDia);    
      workingEnd(len = handleLength, handleDia = handleDia, 
        curve = handleRoundness, slope = workingEndSlope);
    }
    translate([0, 0, bitDepth/2])
      hexTessalation(number = hexNumber, flat = bitFlats, wall = wallThickness, 
        h = bitDepth+.01, invert = true);
    translate([0, 0, toolDepth/2])
      color("purple")
      hexTessalation(number = 1, flat = bitFlats, wall = wallThickness,
        h = toolDepth+.01, invert = true);
  }


}

//endCap(handleDia = handleDia);
//screwDriver();
//fitTest(startFlat = startFlat, itterations = itterations, step = step, thickness = thickness);

module print_part() {
  if (part == "screwDriver" ) {
    screwDriver();
  }

  if (part == "fitTest") {
    fitTest(startFlat = startFlat, itterations = itterations, step = step, thickness = thickness);
  }
}



//Tesselated Hexagons

function flatToRadius(flats) = flats/2/sin(60);


/*
  number = number of hexagons (integer)
  r1 = radius for spacing of hexagonal grid 
  r2 = radius for cutout of honeycomb
  h = height of tiles
  invert = false/true (boolean) 
    - false produces a honeycomb with radius r1 or tiles with no gaps
    - true produces tiles with radius r2 spaced on a gird equal to r1
*/

module hexRow(number = 2, r1 = 10, r2 = 0, h = 2, invert = false) {
  // range to be used in the for loop below
  range = number < 1 ? 0 : number/2-0.5;

  // curve refinement
  $fn = 6;
  for (i = [-range:range]) {
    difference() {
      //invert = true produces honeycomb, invert = true produces hexagons
      if (invert == false) {
        translate([r1*3*i, 0, 0])
          cylinder(r = r1, h = h, center = true);
      }
      if (r2 > 0) {
        //if inverting, make the cutter larger to avoid z fightingv
        cut = invert==false ? 0.01 : 0;       
        translate([r1*3*i, 0, 0])
          cylinder(r = r2, h = h+cut, center = true);
      }
    }
  }

}

/*
  draw a tessalated grid of hexagons
  n = number of hexagons across line of symetry (integer)
  flat = distance across flats for honeycomb cells
  wall = thickness of walls between each cell
  h = height 
*/

/*

  N = number of cells through the vertical line of semmetry (stacked cells)
  total rows along x axis: N * 2 - 1
  turning term: point at which number of rows stops increasing and begins alternating
  even/odd turning term: if the turning term index value is even or odd

  N = 1: [1]
  N = 3: 1, 2, [1], 2, 1
    total: 5
    turning term: 3 [1]

  N = 5: 1, 2, 3, [2, 3, 2], 3, 2, 1
    total: 9
    turning term: 4 [2] (even)

  N = 7: 1, 2, 3, 4, [3, 4, 3, 4, 3], 4, 3, 2, 1
    total: 13
    turning term: 5 [3] (odd)

  N = 9: 1, 2, 3, 4, 5, [4, 5, 4, 5, 4, 5, 4], 5, 4, 3, 2, 1 
    total: 17
    turning term: 6 [4] (even)


*/


module hexTessalation(number = 3, flat = 5, wall = 0, h = 2, invert = false) {
  r1 = flatToRadius(flat+wall); // outside hexagon
  r2 = wall <= 0 ? 0 : flatToRadius(flat); //inside hexagon
  ySpacing = flat+wall;
  yTranslate = ySpacing/2;
  total = number*2-1; // total number of rows in X dimension
  colors = ["red", "yellow", "blue"]; //array of colors to choose from 
  add=[-1, 0]; // array of values to be added depending on odd or even status of i
  
  // N mod 4 identifies odd/even turning terms
  // number%4 = 1: subtract one from even terms, add 0 to odd
  // number%4 = 3: subtract one from odd terms, add 0 to even
  add = [ ["null"], [-1, 0], ["null"], [0, -1] ];

  
  translate([0, -number/2*ySpacing+ySpacing/2, 0])
  for ( i = [1:total]) {
    //bottom 1/3
    if ( i <=ceil(number/2) ) {
      translate([0, yTranslate*i-ySpacing/2, 0])
        //choose color depending on row index
        color(colors[i%3])
        hexRow(number = i, r1 = r1, r2 = r2, h = h, invert = invert);
    }


    //middle 1/3
    if ( ceil(number/2)+1 <= i && i <=ceil(number/2)+1+number-3) {
      translate([0, yTranslate*i-ySpacing/2, 0])
        color(colors[i%3])
          //add 0 or subtract 1 
          hexRow(number = ceil(number/2)+add[number%4][i%2], 
          r1 = r1, r2 = r2, h = h, invert = invert);

    }

    if ( ceil(number/2)+1 +number-3 < i ) {
      translate([0, yTranslate*i-ySpacing/2, 0])
        color(colors[i%3])
        hexRow(number = total+1-i, 
          r1 = r1, r2 = r2, h = h, invert = invert);
    }
  }
}

//hexTessalation(number = 5, flat = 10, wall = 5, invert = false);
//hexTessalation(number = 5, flat = 10, wall = 5, invert = false);

//hexRow(3, r1 = 10, r2 = 9.9, invert = false);



//Tesselated Hexagons


//number of "stacked" cells along a line of symetry
number = 3; //[1, 3, 5, 7, 9, 13]
//distance across flat sides (inradius) 
flats = 10;
//wall thickness - set to 0 and invert to true to make touching tiles
walls = 3; 
//height of comb
height = 10; //[1:10]
//invert = false (honeycomb); invert = true (tiles)
invert = false; //[true, false]



hexTessalation(number = number, h = height, flat = flats, wall = walls, invert = invert);

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

  echo(str("total terms: ", total));
  echo(str("turning term: ", ceil(number/2)+1));

  union(){

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
//      echo("3/3", i, total+1-i);
    }
  }
  }
}

//hexTessalation(number = 5, flat = 10, wall = 5, invert = false);
//hexTessalation(number = 5, flat = 10, wall = 5, invert = false);

//hexRow(3, r1 = 10, r2 = 9.9, invert = false);



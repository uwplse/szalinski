/* ************************************************************
   * Author: Peter Oehlert
   * Copyright 2017
   * 
   * 
   * This work is licensed under a Creative Commons 
   * Attribution-NonCommercial-ShareAlike 4.0 International 
   * License.
   ***********************************************************/

Side = 18;
Wall = 1;
BottomCutout = Side*.75;

ConfigArray = [
    [true],
    [true],
    [true],
    [true],
    [true],
    [true],
    [true],
    [true],
    [true],
    [true],
];

HeightArray = [
    [75],
    [75],
    [75],
    [75],
    [75],
    [55],
    [55],
    [55],
    [40],
    [40],
];


// --------------------------------------------------------
// - Do not modify constants below this line
// --------------------------------------------------------

Cos0 = 1;
// Using degrees, PI = 180 degrees
Pi = 180;
TwoPi = 2*Pi;
Unit = TwoPi/6; // we're a hexagon

// from SOHCAHTOA, wall is the actual wall, so 
// wall/sin(Unit) is the amount of the radius different
// between the circle enclosing the outside hexagon and 
// the circle enclosing the inside hexagon
RadiusDifference = (Wall/sin(Unit));

function reverse(array) = 
    let(arrLen = len(array)-1)
    [ for (i = [0:arrLen]) array[arrLen-i] ];


// get hex polygon points, using unit circle
function rawHexPoints(side) = [
    for (idx = [0:6]) 
        side *[ cos( TwoPi/6 * idx ), sin( TwoPi/6 * idx ) ] 
];
    
 // get translation vector to originate at 0,0
 function translateRawHex(points) = [
    abs(min( [for(idx = points) idx[0]] )),
    abs(min( [for(idx = points) idx[1]] ))
];

// get hexagon points originating at 0,0
function hexPoints(side) = 
    let( points = rawHexPoints(side),
        trans = translateRawHex(points) )
    [ for (i = points) trans + i ];


// assemble a complete hex cell
module hexCell(side, height, wall, bottomCutout) {
    
    difference() {
        // get outside hex poly
        linear_extrude(height)
        polygon(hexPoints(side));
        
        // remove inner guts
        translate([RadiusDifference,wall,wall])
        linear_extrude(height-wall)
        polygon(hexPoints(side-RadiusDifference));
        
        // poke hole in the bottom
        translate([side-bottomCutout, side*sin(Unit)-bottomCutout*sin(Unit)])
        linear_extrude(height)
        polygon(hexPoints(bottomCutout));
    }
}

module honeyComb(side, wall, bottomCutout, config, heights) {
    
    

    // function of 2 right triangles, using wall as a basis
    //   the 3rd side of wall/radiusDifference becomes the 
    //   hypotenuse of a second triangle, which is used to 
    //   determine the "peak" of the hexagon
    peakSize = wall*cos(Unit)*tan(30);
    
    // get height, width, and row offsets
    objectHeight    = side*2*sin(Unit);
    columnWidth = 
        Cos0*Side + cos(Unit)*(Side-RadiusDifference)-peakSize;
    evenRowOffset = (objectHeight-Wall)/2;     
    
    // reverse arrays so visual layout of array
    //   is the same as visual layout of honeycomb
    rconfig = reverse(config);
    rheights = reverse(heights);
    
    for (row = [0:len(rconfig)])
    for (col = [0:len(rconfig[row])]) {
        
        if (rconfig[row][col]) {
            translate([
                col*columnWidth, 
                row*(objectHeight-wall)
                    + ( (0 == col%2) ? evenRowOffset : 0) 
            ])
            hexCell(side, rheights[row][col], wall, bottomCutout);
        }
    }
}

honeyComb(Side, Wall, BottomCutout, ConfigArray, HeightArray);
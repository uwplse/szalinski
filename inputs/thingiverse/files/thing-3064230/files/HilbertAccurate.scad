//Script adapted from http://thomasdiewald.com/blog/?p=561

/* [Main Parameters] */
//Make an n-th order hilbert cube
Iterations = 2;//[1:4]

//How wide the corners are
corner_size = 5;

//How far apart the corners are
gap_size = 5;

//How wide the beams are in between corners, set to 0 to have the beam size equal to the corner size
beam_size = 0;


/* [Hidden] */

//Normalize corner size above 0
real_corner_size = (corner_size > 0)? corner_size: 5;

//Normalize gap size above 0
real_gap_size = (gap_size > 0)? gap_size: real_corner_size;

//Normalize beam size above 0 and less than or equal to corner size
real_beam_size = (beam_size > 0 && beam_size <= corner_size)? beam_size: real_corner_size;

drawhilbert(real_corner_size, real_gap_size, real_beam_size, Iterations);


module drawhilbert(corner_size, gap_size, beam_size, iterations){
    //flatmult = pow(2,iterations+1);//Used in flatten function
        
    // size = pow(2,iterations) * spacing/5;//Used for consistent spacing
        
    cubes = hilbert(iterations = iterations);//Generates flat array of numbers
    
    beam_offset = [for (i=[0:2]) (corner_size - beam_size) / 2];  
            
    cubelocs = [for(i=[0:len(cubes) - 1]) getmulticoords(cubes[i], corner_size, gap_size)];
        
    for(a = [0:len(cubes)-2]){
        line(cube1=cubelocs[a],
            cube2=cubelocs[a+1],
            corner_size = corner_size,
            beam_width = beam_size,
            beam_offset = beam_offset);
    }//Goes through vector and renders cubes
}

// Render the connection between two corners
 module line(cube1,cube2, corner_size, beam_width, beam_offset){
     translate(cube1) cube(corner_size); //Generates corners
     translate(cube2) cube(corner_size);
     
    hull(){//Generates beams
        translate(cube1+ beam_offset) cube(beam_width);
        translate(cube2+ beam_offset) cube(beam_width);}
}

/*
This defines the relative locations of each corner
For example, corner 0 is the corner with small X and Z, but large Y
You will notice that this corresponds to the placement of cubes for a basic hilbert cube
So the corners of a 1st-order hilbert cube is this list in order
*/
cornerlocs = [
    [0, 1, 0],
    [0, 1, 1],
    [0, 0, 1],
    [0, 0, 0],
    [1, 0, 0],
    [1, 0, 1],
    [1, 1, 1],
    [1, 1, 0]
];

// Subtract 1 from every element of a 2d array
function sub12d(arr) = 
    [for (i = [0:len(arr)-1]) 
        [for (j = [0:len(arr[i])-1]) arr[i][j] - 1]];
            
function cat(lists) = [for(L=lists, a=L) a];
    
function getcoords(position, cornersize, gapsize)=
    position * (cornersize + gapsize);

function getmulticoords(positions, cornersize, gapsize) =
    [for(i=[0:len(positions) - 1]) getcoords(positions[i], cornersize, gapsize)];


/*
This matrix defines how smaller hilbert cubes make up larger ones
Using a 2D hilbert curve as an example

This is a first-order curve:

*-*
| |
* *

We draw this curve as a single stroke:

2-3
| |
1 4

The second order curve will look like this:

***?***
***?***
***?***
??? ???
*** ***
*** ***
*** ***

A 3x3 grouping of stars means that a smaller hilbert curve is located there
The question marks are where two smaller hilbert curves connect to each other

We know that the hilbert curve actually connects like this:

*-* *-*
| | | |
* *-* *
|     |
*-* *-*
  | |  
*-* *-*

Within each section, the stroke order goes like this:

2-3 2-3
| | | |
1 4-1 4
|     |
4-3 2-1
  | |  
1-2 3-4

BUT the stroke order of the curve as a whole looks like this if you shrink it down:

2-3
| |
1 4

So the stroke order of the 2nd and 3rd sub-hilberts is the same, but the stroke order of 1 and 4 is different. We store the difference in stroke order the following way:

Overlay the original stroke ordering over each sub-Hilbert curve like this:

2-3 2-3
| | | |
1 4-1 4
|     |
2-3 2-3
  | |  
1-4 1-4

Now, follow the original stroke ordering and you get:

1-4-3-2-1-2-3-4-1-2-3-4-3-2-1-4

Break that up into a 4x4 matrix for 
[
    [1, 4, 3, 2],
    [1, 2, 3, 4],
    [1, 2, 3, 4],
    [3, 2, 1, 4]
]

The following is the same idea in three dimensions
*/

stroke_ordering = sub12d([
    [1, 4, 5, 8, 7, 6, 3, 2],
    [1, 8, 7, 2, 3, 6, 5, 4],
    [1, 8, 7, 2, 3, 6, 5, 4],
    [3, 4, 1, 2, 7, 8, 5, 6],
    [3, 4, 1, 2, 7, 8, 5, 6],
    [5, 4, 3, 6, 7, 2, 1, 8],
    [5, 4, 3, 6, 7, 2, 1, 8],
    [7, 6, 3, 2, 1, 4, 5, 8]
]);


// Recursive function for generating a list of where cube corners should be
// Base case: generate the location that a single corner cube should be
// Recursive case: concatenate the corner cubes of sub-hilberts
// Output: a list of cube coordinates in order of drawing
// baseloc: the corner of this cube closest to the origin
// iterations: how many times to recur
// cornerlocs: for the macro hilbert cube that is being drawn, in what order should
// the corners be drawn in
function hilbert(baseloc = [0,0,0], iterations, cornerlocs = [0,1,2,3,4,5,6,7])=
    let(cubesacross = pow(2, iterations-1))
    (iterations > 0)?
        cat([
            for (i = [0:7])
                hilbert(corner(cornerlocs[i], baseloc, cubesacross),
                            iterations -1,
                            [for (j=[0:7]) 
                                cornerlocs[stroke_ordering[i][j]]
                            ])
                

        ]):[baseloc];

// Get the location of a specific corner of the cube
// cnr: The index of the corner
// baseloc: The corner closest to the origin of this hilbert cube
// cubesacross: How large of a cube are we actually drawing (a 2nd-order cube will be larger than a 1st)
function corner(cnr, baseloc, cubesacross) = 
    [for (i = [0:2]) baseloc[i] + (cornerlocs[cnr][i] * cubesacross)];



  
/***************************************************
Sierpinski Tetrahedron Generator
By Adam Anderson 

Iteratively creates the Sierpinski Tetrix using any 
starting 3D shape.
***************************************************/

//What would you like the starting shape to be?
shape = "Tetrahedron"; //["Tetrahedron":Tetrahedron, "Sphere":Sphere, "Cube":Cube]

side_length = 10;

//Controls the size of seed shapes
overlap = 1.5; //[0.5:0.5:10]

iterations = 4; //[1:8]



/* Useful_length scales the input length depending on the number
* of iterations so that the final geometry will occupy roughly the same
* volume regardless of the number of iterations.
*/
useful_length = side_length / pow(2, iterations - 1);

if(shape == "Tetrahedron") {
    Sierpinski(side_length, iterations) {
        tetrahedron(useful_length);
    }
}
else if(shape == "Sphere") {
    Sierpinski(side_length, iterations) {
        sphere(useful_length);
    }
}
else if(shape == "Cube") {
    Sierpinski(side_length, iterations) {
        cube(useful_length);
    }
}

module iterate(side = 10) {
    children(0);
    translate([side, 0, 0]) children(0);
    translate([side / 2, side * sqrt(3) / 2, 0]) children(0);
    translate([side / 2, side * sqrt(3) / 6, side * sqrt(6) / 3 ]) children(0);  
}

module tetrahedron(size) {
    polyhedron( 
        points = [ 
            [0, size * (sqrt(3) - (1 / sqrt(3))), 0], 
            [size, size * (-1 / sqrt(3)), 0], 
            [-size, size * (-1 / sqrt(3)), 0],
            [0, 0, size * 2 * sqrt(2 / 3)]
        ], 
        faces = [
            [0, 1, 3],
            [2, 3, 1], 
            [2, 0, 3],
            [2, 1, 0]
        ]
    );
}

/*
* Uses input shape to create Sierpinski Tetrix by scaling
* and translating duplicates of the original shape.
* See the iterate module for specific translation amounts.
*/
module Sierpinski(side = 10, iterations = 5) {
    if(iterations > 0) {
        iterate(side) {
            Sierpinski(side / 2, iterations - 1) {
                children(0);
            }
        }
        scale(overlap) children(0);
    }
}
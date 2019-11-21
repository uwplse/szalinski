
/* 
 * Fibonacci Flower Generation Program
 * 
 * This flower is not meant for 3D printing. If you are familiar with OpenSCAD, you can uncomment out the commented commands and stop the leaf generation
 * 
 * The flower is created with two simple shapes, a square for the petals and a kite for the leaves.
 * The flower also uses Fibonacci numbers to determine how many petals or leaves should be on each layer
 */
 
 
/* [Petals] */
// The number of layers of petals in the flower
petalMaxLayer = 4; 
// The length of the side of the square petal
petalWidth = 10; 
// The height of the square petal
petalHeight = 1; 
// The amount of Fibonacci numbers to skip
petalFibSkip = 3; 

/* [Leafs]*/
// The number of layers of leaves
leafMaxLayer = 3; 
// The height of the leaves
leafHeight = 1; 
// The amount of Fibonacci numbers to skip
leafFibSkip = 4; 

/* [Hidden] */
// A value to be used in a for loop
petalLayer = 1; 
// The coordinates of the kite that makes up the leaves
leafCords = [[0,0],[17,0],[5,7.5]]; 

// Fibonacci function
function fib(x) = x < 3 ? 1 : fib(x - 1) + fib(x - 2);

// Module for creating the petal to be used
module petal() {
    translate([-petalWidth/2,-petalWidth/2,0])cube([petalWidth,petalWidth,petalHeight]);
}

// Module for creating the leaf
module leaf(){
    linear_extrude(leafHeight) union(){
    polygon(points = leafCords);
        mirror([0,1,0]) polygon(points = leafCords);
    }
}


//difference(){
//union(){
//translate([0,0,-3])cylinder(r = 7.5, $fn = 100); // Create the center, used for 3D printing

// Create the petals
color([1,0.3,1]){ // Make them pink
for(petalLayer = [1:petalMaxLayer], j = [0:fib(petalLayer+petalFibSkip)]){
    
    rotate(j*360 / fib(petalLayer+petalFibSkip)) // Placement
    translate([petalWidth/4*petalLayer, 0, 0])
    rotate(a=-270/fib(petalLayer+1),v=[-0.25,1.5,2]) // Angle
    petal();
    
}
}
//translate([0,0,-9])cylinder(r = 25, h = 6, $fn = 100);} // Create the center


// Leaf
translate([0,0,-2]) // Move all down
color([0.2,0.5,0.2]){ // Set color to green
    for(leafLayer = [1:leafMaxLayer], j = [0:fib(leafLayer+leafFibSkip)]){
    
    rotate((j*360 / fib(leafLayer+leafFibSkip)+(180/fib(leafLayer+leafFibSkip)))) // Placement
    translate([(petalWidth/4*leafLayer)+2, 0, -leafHeight*leafLayer])
    rotate(a=-70/fib(leafLayer+leafFibSkip-1),v=[-0.25,1.5,2])
    leaf();
    }
    
}


// Parameterised Printer Calibration Cube
// Author:  Nick Wells
// Created: 11/07/2018
// Version: 1.0

// Use this cube to help you choose the optimal slicer settings.
// The cube has thin walls with holes and a bridged top.
// You will need good bridging settings and retractions to get a nice clean print.
// The cutouts in the sides will also show up any ringing usually caused by loose drive belts
// As the walls are thin it prints quickly too!

// ### ADJUSTABLE PARAMETERS ###
// Set this value to your nozzle size 
nozzle_size = 0.35; // [0.1:0.05:1.0]
// External cube dimensions
size        = 20; // [10:100]   
// Number of exterior walls
wall        = 2;  // [1:10]  
// ### END OF PARAMETERS ###


// Render the cube
MyTestCube();

// I always code this way as it makes cutting multiple holes in solid shapes much easier!
module MyTestCube()
{
  difference()
  {
    body();   // 1) Make the cube
    holes();  // 2) Cut oway the holes
  }
}



// Put code for the solid part in here
module body()
{
  cube(size,center=true);
}



// Put code for holes and removed sections in here 
module holes()
{
  // 1) Hollow out the cube
  cutout = size - nozzle_size*2*wall;
  cube(cutout,center=true);
  
  // 2) Cut the circular holes
  // Render circles with 100 segments
  $fn=100;
  rotate([90,0,0])cylinder(d=size/2,h=size+nozzle_size,center=true);
  
  // 3) Cut the triangular holes
  rotate([0,90,0])
  {
    // This is a neat little trick that renders a cylinder with 3 points making a triangle!
    $fn=3;
    cylinder(d=size/2,h=size+nozzle_size,center=true);
  }
  
  // 4) Cut the square hole
  // Heres a tip, put a # at the start of the next line and press F5 to render
  // The cube will show in red, this is a really usefull debugging tool!
  translate([0,0,-size/2])cube(size/2,center=true);
}
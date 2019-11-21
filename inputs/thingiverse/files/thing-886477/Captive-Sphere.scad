// A simple model of a sphere held captive in a cube.
$fn = 72 * 1; // Make the sphere and circles fairly smooth

// The outer dimension in millimeters of the cube and the diameter of the sphere
width = 25; // [10:150] 

// The thickness of the cube walls
thickness = 3; // [1:0.5:10]

holedia = width - thickness; // size of the circular holes on the cube's faces

difference(){
    cube(size = width, center=true); // the outer cube
    cube(size = width - thickness, center = true); // subtract a cube inside it
    cylinder(r = holedia / 2, h = width + 2, center = true); // circular holes on the top and bottom
    rotate([90, 0, 0]) cylinder(r = holedia / 2, h = width + 2, center = true); // and on the Y axis
    rotate([0, 90, 0]) cylinder(r = holedia / 2, h = width + 2, center = true); // and on the X axis
    
}
sphere(r = width / 2, center = true); // place a sphere in the center of the box
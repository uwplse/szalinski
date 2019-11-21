X=10;
Y=10;
Z=10;
cube_size = 20; // [10:Small,20:Medium,30:Large]

hole_diameter = 2.5;
hole_radius = hole_diameter/2;

// How deep should the center hole be?
hole_depth = 1; // [0,1,5,50]

show_wheels = "yes"; // [yes,no]

// How thick should the side wheels be?
wheel_thickness = 1; // [1:20]

// ignore this variable!
// foo=1;

// don't turn functions into params!
function BEZ03(u) = pow((1-u), 3);

// ignore variable values
bing = 3+4;
baz = 3 / hole_depth;
module object1(scale) {polyhedron(points = [[0, -10, 60], [0, 10, 60], [0, 10, 0], [0, -10, 0], [60, -10, 60], [60, 10, 60]], 
triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);}

resize(newsize=[X,Y,Z]) object1(1);


// Number of iterations
iterations = 3;
// Half
half = true;

module sierpinski_cube(n, cell_points, cell_faces) {
    if (n == 0) {
        scale(1.1)
        cube(size=[1,1,1], center=true);
    } else {
        union() {
            translate(pow(3, n - 1) * [0,0,-0.5])
            sierpinski_cube(n - 1, cell_points, cell_faces);
            translate(pow(3, n - 1) * [0,-0.5,0])
            sierpinski_cube(n - 1, cell_points, cell_faces);
            translate(pow(3, n - 1) * [-0.5,0,0])
            sierpinski_cube(n - 1, cell_points, cell_faces);
            translate(pow(3, n - 1) * [0,0,0.5])
            sierpinski_cube(n - 1, cell_points, cell_faces);
            translate(pow(3, n - 1) * [0,0.5,0])
            sierpinski_cube(n - 1, cell_points, cell_faces);
            translate(pow(3, n - 1) * [0.5,0,0])
            sierpinski_cube(n - 1, cell_points, cell_faces);
            for (pt = cell_points) {
                translate(pow(3, n - 1) * pt)
                sierpinski_cube(n - 1, cell_points, cell_faces);
            }
        }
    }
}

FACES = [
    [0, 1, 2, 3],
    [4, 7, 6, 5],
    [0, 4, 5, 1],
    [1, 5, 6, 2],
    [2, 6, 7, 3],
    [3, 7, 4, 0]
];
POINTS = [
    [-0.5, 0.5, -0.5],
    [0.5, 0.5, -0.5],
    [0.5, -0.5, -0.5],
    [-0.5, -0.5, -0.5],
    [-0.5, 0.5, 0.5],
    [0.5, 0.5, 0.5],
    [0.5, -0.5, 0.5],
    [-0.5, -0.5, 0.5]
];

if(half) {
    difference() {
        scale(pow(1.0/3,iterations-1))
        rotate(acos(([1,1,1]*[0,0,1])/norm([1,1,1])),cross([1,1,1],[0,0,1]))
        sierpinski_cube(iterations, POINTS, FACES);
        
        scale(5) translate([-0.5,-0.5,0]) polyhedron( points=[
            [0, 1, 0],
            [1, 1, 0],
            [1, 0, 0],
            [0, 0, 0],
            [0, 1, -1],
            [1, 1, -1],
            [1, 0, -1],
            [0, 0, -1]
        ], faces=FACES);
        
    }
} else {
    scale(pow(1.0/3,iterations-1))
    sierpinski_cube(iterations, POINTS, FACES);
}



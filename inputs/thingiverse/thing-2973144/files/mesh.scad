//Mesh generator
//2018, @cudatox
//See Thingiverse page for license terms.
// preview[tilt: top, view:north]
//Size of the holes in the mesh
HOLE_SIZE = 1;
//Width of the grid members between the holes
MESH_SIZE = 0.4;
//Thickness of the mesh
MESH_THICKNESS = 0.4;
//If this is set to true, Customizer will calculate the number of grid cells based on the provided dimensions. Set this to false to specify the number of grid cells using X_COUNT and Y_COUNT.
USE_DIMENSIONS = "Yes";// [Yes, No]
//Width of the mesh (if USE_DIMENSIONS is true). The generated mesh may be slightly larger than this value.
WIDTH = 50;
//Height of the mesh (if USE_DIMENSIONS is true). The generated mesh may be slightly larger than this value.
HEIGHT = 60;
//Number of cells in the X direction (if USE_DIMENSIONS is false)
X_COUNT = 21;
//Number of cells in the Y direction (if USE_DIMENSIONS is false)
Y_COUNT = 10;

module gen_mesh(_X_COUNT, _Y_COUNT){
    _HEIGHT =  _Y_COUNT * (HOLE_SIZE + MESH_SIZE);
    _WIDTH = _X_COUNT * (HOLE_SIZE + MESH_SIZE);

    echo(_WIDTH, _HEIGHT);

    for (x_index = [0 : _X_COUNT]){
        translate([x_index * (HOLE_SIZE+MESH_SIZE) + MESH_SIZE/2, _HEIGHT/2, 0])
            cube([MESH_SIZE, _HEIGHT, MESH_THICKNESS], true);
    }

    for (y_index = [0 : _Y_COUNT]){
        translate([_WIDTH/2 + MESH_SIZE/2, y_index * (HOLE_SIZE+MESH_SIZE), 0])
            cube([_WIDTH + MESH_SIZE, MESH_SIZE, MESH_THICKNESS], true);
    }
}

if (USE_DIMENSIONS == "Yes"){
    _X_COUNT = ceil( WIDTH / (HOLE_SIZE + MESH_SIZE));
    _Y_COUNT = ceil( HEIGHT / (HOLE_SIZE + MESH_SIZE));
    
    gen_mesh(_X_COUNT, _Y_COUNT);
    
}else{
    gen_mesh(X_COUNT, Y_COUNT);
}


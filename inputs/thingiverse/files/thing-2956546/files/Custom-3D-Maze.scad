/*
    Custom 3D Maze generator
    This is an extension of JustinSDK's "Maze generator, pure OpenSCAD"
    https://www.thingiverse.com/thing:1185425

    to convert it from 2D mazes to 3D mazes

*/
levels = 3; // [1:15]
rows = 3; // [1:15]
columns = 3; // [1:15]
wall_thickness = 1; // [0.5:0.1:8]
block_width = 10; // [1:20]
peephole = 1; // [0:none,1:circle,2:cross]
// random seed, (-1 = no seed)
seed = 0; // [-1:200]

/* [Hidden] */
PEEPHOLE_NONE = 0;
PEEPHOLE_CIRCLE = 1;
PEEPHOLE_CROSS = 2;
//
PEEPHOLE_CIRCLES = 999;

FUDGE_FACTOR = 0.01;

RANDOM_COUNT = (levels+1)*(rows+1)*(columns+1);
RANDOM_NUMBERS = (seed == -1) ? rands(0, 720, RANDOM_COUNT) : rands(0, 720, RANDOM_COUNT, seed);
;

/*
 * constants, for clearness
 *
 */
 
// random directions, for picking up a direction to visit the next block
function PERMUTATION_OF_SIX() = [
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 6, 5],
    [1, 2, 3, 5, 4, 6],
    [1, 2, 3, 5, 6, 4],
    [1, 2, 3, 6, 4, 5],
    [1, 2, 3, 6, 5, 4],
    [1, 2, 4, 3, 5, 6],
    [1, 2, 4, 3, 6, 5],
    [1, 2, 4, 5, 3, 6],
    [1, 2, 4, 5, 6, 3],
    [1, 2, 4, 6, 3, 5],
    [1, 2, 4, 6, 5, 3],
    [1, 2, 5, 3, 4, 6],
    [1, 2, 5, 3, 6, 4],
    [1, 2, 5, 4, 3, 6],
    [1, 2, 5, 4, 6, 3],
    [1, 2, 5, 6, 3, 4],
    [1, 2, 5, 6, 4, 3],
    [1, 2, 6, 3, 4, 5],
    [1, 2, 6, 3, 5, 4],
    [1, 2, 6, 4, 3, 5],
    [1, 2, 6, 4, 5, 3],
    [1, 2, 6, 5, 3, 4],
    [1, 2, 6, 5, 4, 3],
    [1, 3, 2, 4, 5, 6],
    [1, 3, 2, 4, 6, 5],
    [1, 3, 2, 5, 4, 6],
    [1, 3, 2, 5, 6, 4],
    [1, 3, 2, 6, 4, 5],
    [1, 3, 2, 6, 5, 4],
    [1, 3, 4, 2, 5, 6],
    [1, 3, 4, 2, 6, 5],
    [1, 3, 4, 5, 2, 6],
    [1, 3, 4, 5, 6, 2],
    [1, 3, 4, 6, 2, 5],
    [1, 3, 4, 6, 5, 2],
    [1, 3, 5, 2, 4, 6],
    [1, 3, 5, 2, 6, 4],
    [1, 3, 5, 4, 2, 6],
    [1, 3, 5, 4, 6, 2],
    [1, 3, 5, 6, 2, 4],
    [1, 3, 5, 6, 4, 2],
    [1, 3, 6, 2, 4, 5],
    [1, 3, 6, 2, 5, 4],
    [1, 3, 6, 4, 2, 5],
    [1, 3, 6, 4, 5, 2],
    [1, 3, 6, 5, 2, 4],
    [1, 3, 6, 5, 4, 2],
    [1, 4, 2, 3, 5, 6],
    [1, 4, 2, 3, 6, 5],
    [1, 4, 2, 5, 3, 6],
    [1, 4, 2, 5, 6, 3],
    [1, 4, 2, 6, 3, 5],
    [1, 4, 2, 6, 5, 3],
    [1, 4, 3, 2, 5, 6],
    [1, 4, 3, 2, 6, 5],
    [1, 4, 3, 5, 2, 6],
    [1, 4, 3, 5, 6, 2],
    [1, 4, 3, 6, 2, 5],
    [1, 4, 3, 6, 5, 2],
    [1, 4, 5, 2, 3, 6],
    [1, 4, 5, 2, 6, 3],
    [1, 4, 5, 3, 2, 6],
    [1, 4, 5, 3, 6, 2],
    [1, 4, 5, 6, 2, 3],
    [1, 4, 5, 6, 3, 2],
    [1, 4, 6, 2, 3, 5],
    [1, 4, 6, 2, 5, 3],
    [1, 4, 6, 3, 2, 5],
    [1, 4, 6, 3, 5, 2],
    [1, 4, 6, 5, 2, 3],
    [1, 4, 6, 5, 3, 2],
    [1, 5, 2, 3, 4, 6],
    [1, 5, 2, 3, 6, 4],
    [1, 5, 2, 4, 3, 6],
    [1, 5, 2, 4, 6, 3],
    [1, 5, 2, 6, 3, 4],
    [1, 5, 2, 6, 4, 3],
    [1, 5, 3, 2, 4, 6],
    [1, 5, 3, 2, 6, 4],
    [1, 5, 3, 4, 2, 6],
    [1, 5, 3, 4, 6, 2],
    [1, 5, 3, 6, 2, 4],
    [1, 5, 3, 6, 4, 2],
    [1, 5, 4, 2, 3, 6],
    [1, 5, 4, 2, 6, 3],
    [1, 5, 4, 3, 2, 6],
    [1, 5, 4, 3, 6, 2],
    [1, 5, 4, 6, 2, 3],
    [1, 5, 4, 6, 3, 2],
    [1, 5, 6, 2, 3, 4],
    [1, 5, 6, 2, 4, 3],
    [1, 5, 6, 3, 2, 4],
    [1, 5, 6, 3, 4, 2],
    [1, 5, 6, 4, 2, 3],
    [1, 5, 6, 4, 3, 2],
    [1, 6, 2, 3, 4, 5],
    [1, 6, 2, 3, 5, 4],
    [1, 6, 2, 4, 3, 5],
    [1, 6, 2, 4, 5, 3],
    [1, 6, 2, 5, 3, 4],
    [1, 6, 2, 5, 4, 3],
    [1, 6, 3, 2, 4, 5],
    [1, 6, 3, 2, 5, 4],
    [1, 6, 3, 4, 2, 5],
    [1, 6, 3, 4, 5, 2],
    [1, 6, 3, 5, 2, 4],
    [1, 6, 3, 5, 4, 2],
    [1, 6, 4, 2, 3, 5],
    [1, 6, 4, 2, 5, 3],
    [1, 6, 4, 3, 2, 5],
    [1, 6, 4, 3, 5, 2],
    [1, 6, 4, 5, 2, 3],
    [1, 6, 4, 5, 3, 2],
    [1, 6, 5, 2, 3, 4],
    [1, 6, 5, 2, 4, 3],
    [1, 6, 5, 3, 2, 4],
    [1, 6, 5, 3, 4, 2],
    [1, 6, 5, 4, 2, 3],
    [1, 6, 5, 4, 3, 2],
    [2, 1, 3, 4, 5, 6],
    [2, 1, 3, 4, 6, 5],
    [2, 1, 3, 5, 4, 6],
    [2, 1, 3, 5, 6, 4],
    [2, 1, 3, 6, 4, 5],
    [2, 1, 3, 6, 5, 4],
    [2, 1, 4, 3, 5, 6],
    [2, 1, 4, 3, 6, 5],
    [2, 1, 4, 5, 3, 6],
    [2, 1, 4, 5, 6, 3],
    [2, 1, 4, 6, 3, 5],
    [2, 1, 4, 6, 5, 3],
    [2, 1, 5, 3, 4, 6],
    [2, 1, 5, 3, 6, 4],
    [2, 1, 5, 4, 3, 6],
    [2, 1, 5, 4, 6, 3],
    [2, 1, 5, 6, 3, 4],
    [2, 1, 5, 6, 4, 3],
    [2, 1, 6, 3, 4, 5],
    [2, 1, 6, 3, 5, 4],
    [2, 1, 6, 4, 3, 5],
    [2, 1, 6, 4, 5, 3],
    [2, 1, 6, 5, 3, 4],
    [2, 1, 6, 5, 4, 3],
    [2, 3, 1, 4, 5, 6],
    [2, 3, 1, 4, 6, 5],
    [2, 3, 1, 5, 4, 6],
    [2, 3, 1, 5, 6, 4],
    [2, 3, 1, 6, 4, 5],
    [2, 3, 1, 6, 5, 4],
    [2, 3, 4, 1, 5, 6],
    [2, 3, 4, 1, 6, 5],
    [2, 3, 4, 5, 1, 6],
    [2, 3, 4, 5, 6, 1],
    [2, 3, 4, 6, 1, 5],
    [2, 3, 4, 6, 5, 1],
    [2, 3, 5, 1, 4, 6],
    [2, 3, 5, 1, 6, 4],
    [2, 3, 5, 4, 1, 6],
    [2, 3, 5, 4, 6, 1],
    [2, 3, 5, 6, 1, 4],
    [2, 3, 5, 6, 4, 1],
    [2, 3, 6, 1, 4, 5],
    [2, 3, 6, 1, 5, 4],
    [2, 3, 6, 4, 1, 5],
    [2, 3, 6, 4, 5, 1],
    [2, 3, 6, 5, 1, 4],
    [2, 3, 6, 5, 4, 1],
    [2, 4, 1, 3, 5, 6],
    [2, 4, 1, 3, 6, 5],
    [2, 4, 1, 5, 3, 6],
    [2, 4, 1, 5, 6, 3],
    [2, 4, 1, 6, 3, 5],
    [2, 4, 1, 6, 5, 3],
    [2, 4, 3, 1, 5, 6],
    [2, 4, 3, 1, 6, 5],
    [2, 4, 3, 5, 1, 6],
    [2, 4, 3, 5, 6, 1],
    [2, 4, 3, 6, 1, 5],
    [2, 4, 3, 6, 5, 1],
    [2, 4, 5, 1, 3, 6],
    [2, 4, 5, 1, 6, 3],
    [2, 4, 5, 3, 1, 6],
    [2, 4, 5, 3, 6, 1],
    [2, 4, 5, 6, 1, 3],
    [2, 4, 5, 6, 3, 1],
    [2, 4, 6, 1, 3, 5],
    [2, 4, 6, 1, 5, 3],
    [2, 4, 6, 3, 1, 5],
    [2, 4, 6, 3, 5, 1],
    [2, 4, 6, 5, 1, 3],
    [2, 4, 6, 5, 3, 1],
    [2, 5, 1, 3, 4, 6],
    [2, 5, 1, 3, 6, 4],
    [2, 5, 1, 4, 3, 6],
    [2, 5, 1, 4, 6, 3],
    [2, 5, 1, 6, 3, 4],
    [2, 5, 1, 6, 4, 3],
    [2, 5, 3, 1, 4, 6],
    [2, 5, 3, 1, 6, 4],
    [2, 5, 3, 4, 1, 6],
    [2, 5, 3, 4, 6, 1],
    [2, 5, 3, 6, 1, 4],
    [2, 5, 3, 6, 4, 1],
    [2, 5, 4, 1, 3, 6],
    [2, 5, 4, 1, 6, 3],
    [2, 5, 4, 3, 1, 6],
    [2, 5, 4, 3, 6, 1],
    [2, 5, 4, 6, 1, 3],
    [2, 5, 4, 6, 3, 1],
    [2, 5, 6, 1, 3, 4],
    [2, 5, 6, 1, 4, 3],
    [2, 5, 6, 3, 1, 4],
    [2, 5, 6, 3, 4, 1],
    [2, 5, 6, 4, 1, 3],
    [2, 5, 6, 4, 3, 1],
    [2, 6, 1, 3, 4, 5],
    [2, 6, 1, 3, 5, 4],
    [2, 6, 1, 4, 3, 5],
    [2, 6, 1, 4, 5, 3],
    [2, 6, 1, 5, 3, 4],
    [2, 6, 1, 5, 4, 3],
    [2, 6, 3, 1, 4, 5],
    [2, 6, 3, 1, 5, 4],
    [2, 6, 3, 4, 1, 5],
    [2, 6, 3, 4, 5, 1],
    [2, 6, 3, 5, 1, 4],
    [2, 6, 3, 5, 4, 1],
    [2, 6, 4, 1, 3, 5],
    [2, 6, 4, 1, 5, 3],
    [2, 6, 4, 3, 1, 5],
    [2, 6, 4, 3, 5, 1],
    [2, 6, 4, 5, 1, 3],
    [2, 6, 4, 5, 3, 1],
    [2, 6, 5, 1, 3, 4],
    [2, 6, 5, 1, 4, 3],
    [2, 6, 5, 3, 1, 4],
    [2, 6, 5, 3, 4, 1],
    [2, 6, 5, 4, 1, 3],
    [2, 6, 5, 4, 3, 1],
    [3, 1, 2, 4, 5, 6],
    [3, 1, 2, 4, 6, 5],
    [3, 1, 2, 5, 4, 6],
    [3, 1, 2, 5, 6, 4],
    [3, 1, 2, 6, 4, 5],
    [3, 1, 2, 6, 5, 4],
    [3, 1, 4, 2, 5, 6],
    [3, 1, 4, 2, 6, 5],
    [3, 1, 4, 5, 2, 6],
    [3, 1, 4, 5, 6, 2],
    [3, 1, 4, 6, 2, 5],
    [3, 1, 4, 6, 5, 2],
    [3, 1, 5, 2, 4, 6],
    [3, 1, 5, 2, 6, 4],
    [3, 1, 5, 4, 2, 6],
    [3, 1, 5, 4, 6, 2],
    [3, 1, 5, 6, 2, 4],
    [3, 1, 5, 6, 4, 2],
    [3, 1, 6, 2, 4, 5],
    [3, 1, 6, 2, 5, 4],
    [3, 1, 6, 4, 2, 5],
    [3, 1, 6, 4, 5, 2],
    [3, 1, 6, 5, 2, 4],
    [3, 1, 6, 5, 4, 2],
    [3, 2, 1, 4, 5, 6],
    [3, 2, 1, 4, 6, 5],
    [3, 2, 1, 5, 4, 6],
    [3, 2, 1, 5, 6, 4],
    [3, 2, 1, 6, 4, 5],
    [3, 2, 1, 6, 5, 4],
    [3, 2, 4, 1, 5, 6],
    [3, 2, 4, 1, 6, 5],
    [3, 2, 4, 5, 1, 6],
    [3, 2, 4, 5, 6, 1],
    [3, 2, 4, 6, 1, 5],
    [3, 2, 4, 6, 5, 1],
    [3, 2, 5, 1, 4, 6],
    [3, 2, 5, 1, 6, 4],
    [3, 2, 5, 4, 1, 6],
    [3, 2, 5, 4, 6, 1],
    [3, 2, 5, 6, 1, 4],
    [3, 2, 5, 6, 4, 1],
    [3, 2, 6, 1, 4, 5],
    [3, 2, 6, 1, 5, 4],
    [3, 2, 6, 4, 1, 5],
    [3, 2, 6, 4, 5, 1],
    [3, 2, 6, 5, 1, 4],
    [3, 2, 6, 5, 4, 1],
    [3, 4, 1, 2, 5, 6],
    [3, 4, 1, 2, 6, 5],
    [3, 4, 1, 5, 2, 6],
    [3, 4, 1, 5, 6, 2],
    [3, 4, 1, 6, 2, 5],
    [3, 4, 1, 6, 5, 2],
    [3, 4, 2, 1, 5, 6],
    [3, 4, 2, 1, 6, 5],
    [3, 4, 2, 5, 1, 6],
    [3, 4, 2, 5, 6, 1],
    [3, 4, 2, 6, 1, 5],
    [3, 4, 2, 6, 5, 1],
    [3, 4, 5, 1, 2, 6],
    [3, 4, 5, 1, 6, 2],
    [3, 4, 5, 2, 1, 6],
    [3, 4, 5, 2, 6, 1],
    [3, 4, 5, 6, 1, 2],
    [3, 4, 5, 6, 2, 1],
    [3, 4, 6, 1, 2, 5],
    [3, 4, 6, 1, 5, 2],
    [3, 4, 6, 2, 1, 5],
    [3, 4, 6, 2, 5, 1],
    [3, 4, 6, 5, 1, 2],
    [3, 4, 6, 5, 2, 1],
    [3, 5, 1, 2, 4, 6],
    [3, 5, 1, 2, 6, 4],
    [3, 5, 1, 4, 2, 6],
    [3, 5, 1, 4, 6, 2],
    [3, 5, 1, 6, 2, 4],
    [3, 5, 1, 6, 4, 2],
    [3, 5, 2, 1, 4, 6],
    [3, 5, 2, 1, 6, 4],
    [3, 5, 2, 4, 1, 6],
    [3, 5, 2, 4, 6, 1],
    [3, 5, 2, 6, 1, 4],
    [3, 5, 2, 6, 4, 1],
    [3, 5, 4, 1, 2, 6],
    [3, 5, 4, 1, 6, 2],
    [3, 5, 4, 2, 1, 6],
    [3, 5, 4, 2, 6, 1],
    [3, 5, 4, 6, 1, 2],
    [3, 5, 4, 6, 2, 1],
    [3, 5, 6, 1, 2, 4],
    [3, 5, 6, 1, 4, 2],
    [3, 5, 6, 2, 1, 4],
    [3, 5, 6, 2, 4, 1],
    [3, 5, 6, 4, 1, 2],
    [3, 5, 6, 4, 2, 1],
    [3, 6, 1, 2, 4, 5],
    [3, 6, 1, 2, 5, 4],
    [3, 6, 1, 4, 2, 5],
    [3, 6, 1, 4, 5, 2],
    [3, 6, 1, 5, 2, 4],
    [3, 6, 1, 5, 4, 2],
    [3, 6, 2, 1, 4, 5],
    [3, 6, 2, 1, 5, 4],
    [3, 6, 2, 4, 1, 5],
    [3, 6, 2, 4, 5, 1],
    [3, 6, 2, 5, 1, 4],
    [3, 6, 2, 5, 4, 1],
    [3, 6, 4, 1, 2, 5],
    [3, 6, 4, 1, 5, 2],
    [3, 6, 4, 2, 1, 5],
    [3, 6, 4, 2, 5, 1],
    [3, 6, 4, 5, 1, 2],
    [3, 6, 4, 5, 2, 1],
    [3, 6, 5, 1, 2, 4],
    [3, 6, 5, 1, 4, 2],
    [3, 6, 5, 2, 1, 4],
    [3, 6, 5, 2, 4, 1],
    [3, 6, 5, 4, 1, 2],
    [3, 6, 5, 4, 2, 1],
    [4, 1, 2, 3, 5, 6],
    [4, 1, 2, 3, 6, 5],
    [4, 1, 2, 5, 3, 6],
    [4, 1, 2, 5, 6, 3],
    [4, 1, 2, 6, 3, 5],
    [4, 1, 2, 6, 5, 3],
    [4, 1, 3, 2, 5, 6],
    [4, 1, 3, 2, 6, 5],
    [4, 1, 3, 5, 2, 6],
    [4, 1, 3, 5, 6, 2],
    [4, 1, 3, 6, 2, 5],
    [4, 1, 3, 6, 5, 2],
    [4, 1, 5, 2, 3, 6],
    [4, 1, 5, 2, 6, 3],
    [4, 1, 5, 3, 2, 6],
    [4, 1, 5, 3, 6, 2],
    [4, 1, 5, 6, 2, 3],
    [4, 1, 5, 6, 3, 2],
    [4, 1, 6, 2, 3, 5],
    [4, 1, 6, 2, 5, 3],
    [4, 1, 6, 3, 2, 5],
    [4, 1, 6, 3, 5, 2],
    [4, 1, 6, 5, 2, 3],
    [4, 1, 6, 5, 3, 2],
    [4, 2, 1, 3, 5, 6],
    [4, 2, 1, 3, 6, 5],
    [4, 2, 1, 5, 3, 6],
    [4, 2, 1, 5, 6, 3],
    [4, 2, 1, 6, 3, 5],
    [4, 2, 1, 6, 5, 3],
    [4, 2, 3, 1, 5, 6],
    [4, 2, 3, 1, 6, 5],
    [4, 2, 3, 5, 1, 6],
    [4, 2, 3, 5, 6, 1],
    [4, 2, 3, 6, 1, 5],
    [4, 2, 3, 6, 5, 1],
    [4, 2, 5, 1, 3, 6],
    [4, 2, 5, 1, 6, 3],
    [4, 2, 5, 3, 1, 6],
    [4, 2, 5, 3, 6, 1],
    [4, 2, 5, 6, 1, 3],
    [4, 2, 5, 6, 3, 1],
    [4, 2, 6, 1, 3, 5],
    [4, 2, 6, 1, 5, 3],
    [4, 2, 6, 3, 1, 5],
    [4, 2, 6, 3, 5, 1],
    [4, 2, 6, 5, 1, 3],
    [4, 2, 6, 5, 3, 1],
    [4, 3, 1, 2, 5, 6],
    [4, 3, 1, 2, 6, 5],
    [4, 3, 1, 5, 2, 6],
    [4, 3, 1, 5, 6, 2],
    [4, 3, 1, 6, 2, 5],
    [4, 3, 1, 6, 5, 2],
    [4, 3, 2, 1, 5, 6],
    [4, 3, 2, 1, 6, 5],
    [4, 3, 2, 5, 1, 6],
    [4, 3, 2, 5, 6, 1],
    [4, 3, 2, 6, 1, 5],
    [4, 3, 2, 6, 5, 1],
    [4, 3, 5, 1, 2, 6],
    [4, 3, 5, 1, 6, 2],
    [4, 3, 5, 2, 1, 6],
    [4, 3, 5, 2, 6, 1],
    [4, 3, 5, 6, 1, 2],
    [4, 3, 5, 6, 2, 1],
    [4, 3, 6, 1, 2, 5],
    [4, 3, 6, 1, 5, 2],
    [4, 3, 6, 2, 1, 5],
    [4, 3, 6, 2, 5, 1],
    [4, 3, 6, 5, 1, 2],
    [4, 3, 6, 5, 2, 1],
    [4, 5, 1, 2, 3, 6],
    [4, 5, 1, 2, 6, 3],
    [4, 5, 1, 3, 2, 6],
    [4, 5, 1, 3, 6, 2],
    [4, 5, 1, 6, 2, 3],
    [4, 5, 1, 6, 3, 2],
    [4, 5, 2, 1, 3, 6],
    [4, 5, 2, 1, 6, 3],
    [4, 5, 2, 3, 1, 6],
    [4, 5, 2, 3, 6, 1],
    [4, 5, 2, 6, 1, 3],
    [4, 5, 2, 6, 3, 1],
    [4, 5, 3, 1, 2, 6],
    [4, 5, 3, 1, 6, 2],
    [4, 5, 3, 2, 1, 6],
    [4, 5, 3, 2, 6, 1],
    [4, 5, 3, 6, 1, 2],
    [4, 5, 3, 6, 2, 1],
    [4, 5, 6, 1, 2, 3],
    [4, 5, 6, 1, 3, 2],
    [4, 5, 6, 2, 1, 3],
    [4, 5, 6, 2, 3, 1],
    [4, 5, 6, 3, 1, 2],
    [4, 5, 6, 3, 2, 1],
    [4, 6, 1, 2, 3, 5],
    [4, 6, 1, 2, 5, 3],
    [4, 6, 1, 3, 2, 5],
    [4, 6, 1, 3, 5, 2],
    [4, 6, 1, 5, 2, 3],
    [4, 6, 1, 5, 3, 2],
    [4, 6, 2, 1, 3, 5],
    [4, 6, 2, 1, 5, 3],
    [4, 6, 2, 3, 1, 5],
    [4, 6, 2, 3, 5, 1],
    [4, 6, 2, 5, 1, 3],
    [4, 6, 2, 5, 3, 1],
    [4, 6, 3, 1, 2, 5],
    [4, 6, 3, 1, 5, 2],
    [4, 6, 3, 2, 1, 5],
    [4, 6, 3, 2, 5, 1],
    [4, 6, 3, 5, 1, 2],
    [4, 6, 3, 5, 2, 1],
    [4, 6, 5, 1, 2, 3],
    [4, 6, 5, 1, 3, 2],
    [4, 6, 5, 2, 1, 3],
    [4, 6, 5, 2, 3, 1],
    [4, 6, 5, 3, 1, 2],
    [4, 6, 5, 3, 2, 1],
    [5, 1, 2, 3, 4, 6],
    [5, 1, 2, 3, 6, 4],
    [5, 1, 2, 4, 3, 6],
    [5, 1, 2, 4, 6, 3],
    [5, 1, 2, 6, 3, 4],
    [5, 1, 2, 6, 4, 3],
    [5, 1, 3, 2, 4, 6],
    [5, 1, 3, 2, 6, 4],
    [5, 1, 3, 4, 2, 6],
    [5, 1, 3, 4, 6, 2],
    [5, 1, 3, 6, 2, 4],
    [5, 1, 3, 6, 4, 2],
    [5, 1, 4, 2, 3, 6],
    [5, 1, 4, 2, 6, 3],
    [5, 1, 4, 3, 2, 6],
    [5, 1, 4, 3, 6, 2],
    [5, 1, 4, 6, 2, 3],
    [5, 1, 4, 6, 3, 2],
    [5, 1, 6, 2, 3, 4],
    [5, 1, 6, 2, 4, 3],
    [5, 1, 6, 3, 2, 4],
    [5, 1, 6, 3, 4, 2],
    [5, 1, 6, 4, 2, 3],
    [5, 1, 6, 4, 3, 2],
    [5, 2, 1, 3, 4, 6],
    [5, 2, 1, 3, 6, 4],
    [5, 2, 1, 4, 3, 6],
    [5, 2, 1, 4, 6, 3],
    [5, 2, 1, 6, 3, 4],
    [5, 2, 1, 6, 4, 3],
    [5, 2, 3, 1, 4, 6],
    [5, 2, 3, 1, 6, 4],
    [5, 2, 3, 4, 1, 6],
    [5, 2, 3, 4, 6, 1],
    [5, 2, 3, 6, 1, 4],
    [5, 2, 3, 6, 4, 1],
    [5, 2, 4, 1, 3, 6],
    [5, 2, 4, 1, 6, 3],
    [5, 2, 4, 3, 1, 6],
    [5, 2, 4, 3, 6, 1],
    [5, 2, 4, 6, 1, 3],
    [5, 2, 4, 6, 3, 1],
    [5, 2, 6, 1, 3, 4],
    [5, 2, 6, 1, 4, 3],
    [5, 2, 6, 3, 1, 4],
    [5, 2, 6, 3, 4, 1],
    [5, 2, 6, 4, 1, 3],
    [5, 2, 6, 4, 3, 1],
    [5, 3, 1, 2, 4, 6],
    [5, 3, 1, 2, 6, 4],
    [5, 3, 1, 4, 2, 6],
    [5, 3, 1, 4, 6, 2],
    [5, 3, 1, 6, 2, 4],
    [5, 3, 1, 6, 4, 2],
    [5, 3, 2, 1, 4, 6],
    [5, 3, 2, 1, 6, 4],
    [5, 3, 2, 4, 1, 6],
    [5, 3, 2, 4, 6, 1],
    [5, 3, 2, 6, 1, 4],
    [5, 3, 2, 6, 4, 1],
    [5, 3, 4, 1, 2, 6],
    [5, 3, 4, 1, 6, 2],
    [5, 3, 4, 2, 1, 6],
    [5, 3, 4, 2, 6, 1],
    [5, 3, 4, 6, 1, 2],
    [5, 3, 4, 6, 2, 1],
    [5, 3, 6, 1, 2, 4],
    [5, 3, 6, 1, 4, 2],
    [5, 3, 6, 2, 1, 4],
    [5, 3, 6, 2, 4, 1],
    [5, 3, 6, 4, 1, 2],
    [5, 3, 6, 4, 2, 1],
    [5, 4, 1, 2, 3, 6],
    [5, 4, 1, 2, 6, 3],
    [5, 4, 1, 3, 2, 6],
    [5, 4, 1, 3, 6, 2],
    [5, 4, 1, 6, 2, 3],
    [5, 4, 1, 6, 3, 2],
    [5, 4, 2, 1, 3, 6],
    [5, 4, 2, 1, 6, 3],
    [5, 4, 2, 3, 1, 6],
    [5, 4, 2, 3, 6, 1],
    [5, 4, 2, 6, 1, 3],
    [5, 4, 2, 6, 3, 1],
    [5, 4, 3, 1, 2, 6],
    [5, 4, 3, 1, 6, 2],
    [5, 4, 3, 2, 1, 6],
    [5, 4, 3, 2, 6, 1],
    [5, 4, 3, 6, 1, 2],
    [5, 4, 3, 6, 2, 1],
    [5, 4, 6, 1, 2, 3],
    [5, 4, 6, 1, 3, 2],
    [5, 4, 6, 2, 1, 3],
    [5, 4, 6, 2, 3, 1],
    [5, 4, 6, 3, 1, 2],
    [5, 4, 6, 3, 2, 1],
    [5, 6, 1, 2, 3, 4],
    [5, 6, 1, 2, 4, 3],
    [5, 6, 1, 3, 2, 4],
    [5, 6, 1, 3, 4, 2],
    [5, 6, 1, 4, 2, 3],
    [5, 6, 1, 4, 3, 2],
    [5, 6, 2, 1, 3, 4],
    [5, 6, 2, 1, 4, 3],
    [5, 6, 2, 3, 1, 4],
    [5, 6, 2, 3, 4, 1],
    [5, 6, 2, 4, 1, 3],
    [5, 6, 2, 4, 3, 1],
    [5, 6, 3, 1, 2, 4],
    [5, 6, 3, 1, 4, 2],
    [5, 6, 3, 2, 1, 4],
    [5, 6, 3, 2, 4, 1],
    [5, 6, 3, 4, 1, 2],
    [5, 6, 3, 4, 2, 1],
    [5, 6, 4, 1, 2, 3],
    [5, 6, 4, 1, 3, 2],
    [5, 6, 4, 2, 1, 3],
    [5, 6, 4, 2, 3, 1],
    [5, 6, 4, 3, 1, 2],
    [5, 6, 4, 3, 2, 1],
    [6, 1, 2, 3, 4, 5],
    [6, 1, 2, 3, 5, 4],
    [6, 1, 2, 4, 3, 5],
    [6, 1, 2, 4, 5, 3],
    [6, 1, 2, 5, 3, 4],
    [6, 1, 2, 5, 4, 3],
    [6, 1, 3, 2, 4, 5],
    [6, 1, 3, 2, 5, 4],
    [6, 1, 3, 4, 2, 5],
    [6, 1, 3, 4, 5, 2],
    [6, 1, 3, 5, 2, 4],
    [6, 1, 3, 5, 4, 2],
    [6, 1, 4, 2, 3, 5],
    [6, 1, 4, 2, 5, 3],
    [6, 1, 4, 3, 2, 5],
    [6, 1, 4, 3, 5, 2],
    [6, 1, 4, 5, 2, 3],
    [6, 1, 4, 5, 3, 2],
    [6, 1, 5, 2, 3, 4],
    [6, 1, 5, 2, 4, 3],
    [6, 1, 5, 3, 2, 4],
    [6, 1, 5, 3, 4, 2],
    [6, 1, 5, 4, 2, 3],
    [6, 1, 5, 4, 3, 2],
    [6, 2, 1, 3, 4, 5],
    [6, 2, 1, 3, 5, 4],
    [6, 2, 1, 4, 3, 5],
    [6, 2, 1, 4, 5, 3],
    [6, 2, 1, 5, 3, 4],
    [6, 2, 1, 5, 4, 3],
    [6, 2, 3, 1, 4, 5],
    [6, 2, 3, 1, 5, 4],
    [6, 2, 3, 4, 1, 5],
    [6, 2, 3, 4, 5, 1],
    [6, 2, 3, 5, 1, 4],
    [6, 2, 3, 5, 4, 1],
    [6, 2, 4, 1, 3, 5],
    [6, 2, 4, 1, 5, 3],
    [6, 2, 4, 3, 1, 5],
    [6, 2, 4, 3, 5, 1],
    [6, 2, 4, 5, 1, 3],
    [6, 2, 4, 5, 3, 1],
    [6, 2, 5, 1, 3, 4],
    [6, 2, 5, 1, 4, 3],
    [6, 2, 5, 3, 1, 4],
    [6, 2, 5, 3, 4, 1],
    [6, 2, 5, 4, 1, 3],
    [6, 2, 5, 4, 3, 1],
    [6, 3, 1, 2, 4, 5],
    [6, 3, 1, 2, 5, 4],
    [6, 3, 1, 4, 2, 5],
    [6, 3, 1, 4, 5, 2],
    [6, 3, 1, 5, 2, 4],
    [6, 3, 1, 5, 4, 2],
    [6, 3, 2, 1, 4, 5],
    [6, 3, 2, 1, 5, 4],
    [6, 3, 2, 4, 1, 5],
    [6, 3, 2, 4, 5, 1],
    [6, 3, 2, 5, 1, 4],
    [6, 3, 2, 5, 4, 1],
    [6, 3, 4, 1, 2, 5],
    [6, 3, 4, 1, 5, 2],
    [6, 3, 4, 2, 1, 5],
    [6, 3, 4, 2, 5, 1],
    [6, 3, 4, 5, 1, 2],
    [6, 3, 4, 5, 2, 1],
    [6, 3, 5, 1, 2, 4],
    [6, 3, 5, 1, 4, 2],
    [6, 3, 5, 2, 1, 4],
    [6, 3, 5, 2, 4, 1],
    [6, 3, 5, 4, 1, 2],
    [6, 3, 5, 4, 2, 1],
    [6, 4, 1, 2, 3, 5],
    [6, 4, 1, 2, 5, 3],
    [6, 4, 1, 3, 2, 5],
    [6, 4, 1, 3, 5, 2],
    [6, 4, 1, 5, 2, 3],
    [6, 4, 1, 5, 3, 2],
    [6, 4, 2, 1, 3, 5],
    [6, 4, 2, 1, 5, 3],
    [6, 4, 2, 3, 1, 5],
    [6, 4, 2, 3, 5, 1],
    [6, 4, 2, 5, 1, 3],
    [6, 4, 2, 5, 3, 1],
    [6, 4, 3, 1, 2, 5],
    [6, 4, 3, 1, 5, 2],
    [6, 4, 3, 2, 1, 5],
    [6, 4, 3, 2, 5, 1],
    [6, 4, 3, 5, 1, 2],
    [6, 4, 3, 5, 2, 1],
    [6, 4, 5, 1, 2, 3],
    [6, 4, 5, 1, 3, 2],
    [6, 4, 5, 2, 1, 3],
    [6, 4, 5, 2, 3, 1],
    [6, 4, 5, 3, 1, 2],
    [6, 4, 5, 3, 2, 1],
    [6, 5, 1, 2, 3, 4],
    [6, 5, 1, 2, 4, 3],
    [6, 5, 1, 3, 2, 4],
    [6, 5, 1, 3, 4, 2],
    [6, 5, 1, 4, 2, 3],
    [6, 5, 1, 4, 3, 2],
    [6, 5, 2, 1, 3, 4],
    [6, 5, 2, 1, 4, 3],
    [6, 5, 2, 3, 1, 4],
    [6, 5, 2, 3, 4, 1],
    [6, 5, 2, 4, 1, 3],
    [6, 5, 2, 4, 3, 1],
    [6, 5, 3, 1, 2, 4],
    [6, 5, 3, 1, 4, 2],
    [6, 5, 3, 2, 1, 4],
    [6, 5, 3, 2, 4, 1],
    [6, 5, 3, 4, 1, 2],
    [6, 5, 3, 4, 2, 1],
    [6, 5, 4, 1, 2, 3],
    [6, 5, 4, 1, 3, 2],
    [6, 5, 4, 2, 1, 3],
    [6, 5, 4, 2, 3, 1],
    [6, 5, 4, 3, 1, 2],
    [6, 5, 4, 3, 2, 1]
];

function NO_WALL() = 0;
function UP_WALL() = 1;
function RIGHT_WALL() = 2;
function UP_RIGHT_WALL() = 3;
function OVER_WALL() = 4;
function OVER_UP_WALL() = 5;
function OVER_RIGHT_WALL() = 6;
function OVER_UP_RIGHT_WALL() = 7;

function NOT_VISITED() = 0;
function VISITED() = 1;

/* 
 * modules for creating a maze
 *
 */

// give a [x, y, z] point and length. draw a line in the x direction
module xz_line(point, length, width, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, point[2] - offset]) 
        cube([length+thickness, thickness, width+thickness]);
}

// give a [x, y, z] point and length. draw a line in the y direction
module yz_line(point, length, width, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, point[2] - offset])  
        cube([thickness, length+thickness, width+thickness]);
}

// give a [x, y, z] point and length. draw a line in the z direction
module xy_line(point, length, width, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, point[2] - offset])  
        cube([length+thickness, width+thickness, thickness]);
}

// create the outer wall of maze
module maze_outer_wall(levels, rows, columns, block_width = 5, wall_thickness = 1) {
    xz_line([0, rows * block_width, 0], columns * block_width, levels * block_width, wall_thickness);
    difference() {
        yz_line([0, 0, 0], rows * block_width, levels * block_width, wall_thickness);
        translate([-FUDGE_FACTOR/4,0,0])
        yz_line([0, 0, 0], block_width, block_width, wall_thickness+FUDGE_FACTOR);
    }
    xy_line([0, 0, 0], columns * block_width, rows * block_width, wall_thickness);
}

// create the inner wall of maze
module maze_inner_wall(maze, block_width = 5, wall_thickness = 1) {
    for(i = [0:len(maze) - 1]) {
        cord = maze[i];
        x = (cord[0] - 1) * block_width;
        y = (cord[1] - 1) * block_width;
        z = (cord[2] - 1) * block_width;
        v = cord[4];
        
        if(v == 1 || v == 3 || v == 5 || v == 7) {
            xz_line([x, y, z], block_width, block_width, wall_thickness);
        }
        if(v == 2 || v == 3|| v == 6 || v == 7) {
            yz_line([x + block_width, y, z], block_width, block_width, wall_thickness);
        }
        if(v == 4 || v == 5|| v == 6 || v == 7) {
            xy_line([x, y, z + block_width], block_width, block_width, wall_thickness);
        }
    }  
}

// create a maze
module maze(levels, rows, columns, maze_vector, block_width = 5, wall_thickness = 1) {
     maze_outer_wall(levels, rows, columns, block_width, wall_thickness);
     maze_inner_wall(maze_vector, block_width, wall_thickness);
}

/* 
 * utilities functions
 *
 */
function vslice(v,s,e) = 
    [for (i=[s:e]) v[i]];

// compare the equality of [x1, y1, z1] and [x2, y2, z2]
function cord_equals(cord1, cord2) = cord1 == cord2;

// is the point visited?
function not_visited(cord, vs, index = 0) =
    vs[(cord[0]-1)*rows*levels+(cord[1]-1)*levels+(cord[2]-1)][3] == 0;
            
// pick a direction randomly
function rand_dirs(f) =
    PERMUTATION_OF_SIX()[round(RANDOM_NUMBERS[f])];

// replace v1 in the vector with v2 
function replace(v1, v2, vs) =
    [for(i = [0:len(vs) - 1]) vs[i] == v1 ? v2 : vs[i]];
    
/* 
 * functions for generating a maze vector
 *
 */

// initialize a maze
function init_maze(rows, columns, levels) = 
    [
        for(c = [1 : columns]) 
            for(r = [1 : rows]) 
                for(l = [1 : levels]) 
                    [c, r, l, 0,  OVER_UP_RIGHT_WALL()]
	];
    
// find a vector in the maze vector
function find(i, j, k, maze_vector, index = 0) =
    maze_vector[(i-1)*rows*levels+(j-1)*levels+(k-1)];

function debug1(vs,i,j,k,n, recurse,dirs,index) =
    concat(vslice(vs,0,rows*columns*levels-1),[str(vs[rows*columns*levels],":",i,",",j,",",k,"(",recurse,",",dirs,",",index,")","->",n,"$",vslice(vs,0,rows*columns*levels-1),"#"),vs[rows*columns*levels+1]+1]);

////
// NO_WALL = 0;
// UP_WALL = 1;
// RIGHT_WALL = 2;
// UP_RIGHT_WALL = 3;
// OVER_WALL = 4;
// OVER_UP_WALL = 5;
// OVER_RIGHT_WALL = 6;
// OVER_UP_RIGHT_WALL = 7;
function delete_right_wall(original_block) = 
    (original_block == RIGHT_WALL()) ?
        NO_WALL() :
    (original_block == UP_RIGHT_WALL()) ?
        UP_WALL() :
    (original_block == OVER_RIGHT_WALL()) ?
        OVER_WALL() :
    (original_block == OVER_UP_RIGHT_WALL()) ?
        OVER_UP_WALL() :
        original_block
;

function delete_up_wall(original_block) = 
    (original_block == UP_WALL()) ?
        NO_WALL() :
    (original_block == UP_RIGHT_WALL()) ?
        RIGHT_WALL() :
    (original_block == OVER_UP_WALL()) ?
        OVER_WALL() :
    (original_block == OVER_UP_RIGHT_WALL()) ?
        OVER_RIGHT_WALL() :
        original_block
;

function delete_over_wall(original_block) = 
     (original_block == OVER_WALL()) ?
        NO_WALL() :
    (original_block == OVER_RIGHT_WALL()) ?
        RIGHT_WALL() :
    (original_block == OVER_UP_WALL()) ?
        UP_WALL() :
    (original_block == OVER_UP_RIGHT_WALL()) ?
        UP_RIGHT_WALL() :
        original_block
;

function delete_right_wall_of(vs, is_visited, maze_vector) =
    replace(vs, [vs[0], vs[1], vs[2], is_visited, delete_right_wall(vs[4])] ,maze_vector);

function delete_up_wall_of(vs, is_visited, maze_vector) =
    replace(vs, [vs[0], vs[1], vs[2], is_visited, delete_up_wall(vs[4])] ,maze_vector);

function delete_over_wall_of(vs, is_visited, maze_vector) =
    replace(vs, [vs[0], vs[1], vs[2], is_visited, delete_over_wall(vs[4])] ,maze_vector);

function go_right(i, j, k, levels, rows, columns, maze_vector) =
    go_maze(i + 1, j, k, levels, rows, columns, delete_right_wall_of(find(i, j, k, maze_vector), VISITED(), maze_vector));
    
function go_up(i, j, k, levels, rows, columns, maze_vector) =
    go_maze(i, j - 1, k, levels, rows, columns, delete_up_wall_of(find(i, j, k, maze_vector), VISITED(), maze_vector));
    
function go_over(i, j, k, levels, rows, columns, maze_vector) =
    go_maze(i, j, k + 1, levels, rows, columns, delete_over_wall_of(find(i, j, k, maze_vector), VISITED(), maze_vector));
    
function visit(v, maze_vector) =
    replace(v, [v[0], v[1], v[2], VISITED(), v[4]], maze_vector);
 
function go_left(i, j, k, levels, rows, columns, maze_vector) =
    go_maze(i - 1, j, k, levels, rows, columns, delete_right_wall_of(find(i - 1, j, k, maze_vector), NOT_VISITED(), maze_vector));
    
function go_down(i, j, k, levels, rows, columns, maze_vector) =
    go_maze(i, j + 1, k, levels, rows, columns, delete_up_wall_of(find(i, j + 1, k, maze_vector), NOT_VISITED(), maze_vector));
    
function go_under(i, j, k, levels, rows, columns, maze_vector) =
    go_maze(i, j, k - 1, levels, rows, columns, delete_over_wall_of(find(i, j, k - 1, maze_vector), NOT_VISITED(), maze_vector));
    
function go_maze(i, j, k, levels, rows, columns, maze_vector) =
    look_around(i, j, k, rand_dirs(i*rows*levels+j*levels+k), levels, rows, columns, visit(find(i, j, k, maze_vector), maze_vector));
    
function look_around(i, j, k, dirs, levels, rows, columns, maze_vector, index = 0) =
    index == 6 ? maze_vector : 
        look_around( 
            i, j, k, dirs, 
            levels, rows, columns, 
            build_wall(i, j, k, dirs[index], levels, rows, columns, maze_vector), 
            index + 1
        ); 

function build_wall(i, j, k, n, levels, rows, columns, maze_vector) = 
    n == 1 && i != columns && not_visited([i + 1, j, k], maze_vector) ? go_right(i, j, k, levels, rows, columns, maze_vector) : ( 
        n == 2 && j != 1 && not_visited([i, j - 1, k], maze_vector) ? go_up(i, j, k, levels, rows, columns, maze_vector)  : (
            n == 3 && i != 1 && not_visited([i - 1, j, k], maze_vector) ? go_left(i, j, k, levels, rows, columns,  maze_vector)  : (
                n == 4 && j != rows && not_visited([i, j + 1, k], maze_vector) ? go_down(i, j, k, levels, rows, columns, maze_vector) : (
                    n == 5 && k != levels && not_visited([i, j, k + 1], maze_vector) ? go_over(i, j, k, levels, rows, columns, maze_vector) : (
                        n == 6 && k != 1 && not_visited([i, j, k - 1], maze_vector) ? go_under(i, j, k, levels, rows, columns, maze_vector) : (
                            maze_vector
                        )
                    ) 
                ) 
            ) 
        )
    );

module hole(hole_length) {
    cross_length = 3*block_width/4;
    hole_radius = block_width/5;
    holes_radius = block_width/12;
    holes_DELTA = block_width/4;
    if (peephole == PEEPHOLE_CIRCLE) {
        cylinder(r=hole_radius,h=hole_length,$fn=30,center=true);
    } else if (peephole == PEEPHOLE_CIRCLES) {
        union() {
            for (loop1 = [-holes_DELTA:holes_DELTA:holes_DELTA])
                for (loop2 = [-holes_DELTA:holes_DELTA:holes_DELTA])
                    translate([loop1,loop2,0])
                        cylinder(r=holes_radius,h=hole_length,$fn=30,center=true);
        }
    } else if (peephole == PEEPHOLE_CROSS) {
          cube([holes_radius,cross_length,hole_length],center=true);
          cube([cross_length,holes_radius,hole_length],center=true);
    }
}

module holes() {
    column_hole_length=columns*block_width+2*wall_thickness;
    row_hole_length=rows*block_width+2*wall_thickness;
    level_hole_length=levels*block_width+2*wall_thickness;
    hole_radius = block_width/4;
    union() {
        rotate([0,90,0])
        for (z=[1:levels])
            for (y=[1:rows])
                translate([-(z*block_width - block_width/2),y*block_width - block_width/2,column_hole_length/2 - wall_thickness])
                hole(column_hole_length)
                ;
        rotate([90,0,0])
        for (z=[1:levels])
            for (x=[1:columns])
                translate([x*block_width - block_width/2,z*block_width - block_width/2,-(row_hole_length/2 - wall_thickness)])
                hole(row_hole_length)
                ;
        rotate([0,0,90])
        for (y=[1:rows])
            for (x=[1:columns])
                translate([y*block_width - block_width/2,-(x*block_width - block_width/2),level_hole_length/2 - wall_thickness])
                hole(level_hole_length)
                ;
    }
}

/*
 * create a maze
 *
 */
maze_vector = go_maze(1, 1, 1, levels, rows, columns, replace([columns, rows, levels, 0, OVER_UP_RIGHT_WALL()], [columns, rows, levels, 0, OVER_UP_WALL()], init_maze(rows, columns, levels)));

difference() {
    maze(levels, rows, columns, maze_vector, block_width, wall_thickness);
    if (peephole != PEEPHOLE_NONE) {
         holes();
    }
}

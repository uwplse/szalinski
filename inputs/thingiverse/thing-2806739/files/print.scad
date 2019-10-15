WALL_THICKNESS = 3;
SIZE = 40;
STEPS = 150;
TOTAL_ROTATION = 35;
K = 2;

module make_cube_edges(size,rotation) {
    d1 = size - WALL_THICKNESS*2;
    d2 = size + WALL_THICKNESS;
    rotate([0,0,rotation])
    difference(){
        cube([size,size,size],true);
        cube([d2,d1,d1],true);
        cube([d1,d2,d1],true);
        cube([d1,d1,d2],true);
    }
}

for (i = [0:STEPS]){
    make_cube_edges(SIZE / exp(i/STEPS), i/STEPS * TOTAL_ROTATION*pow(i/STEPS*K,2));
}
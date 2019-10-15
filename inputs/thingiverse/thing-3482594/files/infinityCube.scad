// Cube overall size (mm)
cube_size = 100;
// Thickness of the 'frame' (mm)
frame_thickness = 11;
// Size of the gap between frame segments (mm)
gap_size = 5;
// Rotate up to one corner?
rotate_on_edge = 0;    //[0:No,1:Yes]

cubeL = cube_size;
frameT = max(1,frame_thickness);
gapL = max(0,gap_size);
edgeT = frameT+gapL;
rotateOnEdge = rotate_on_edge;


module infinityCube() {
    difference() {
        // main cube
        cube([cubeL,cubeL,cubeL]);
        // sub-cube cutaway dimension
        subCubeL = cubeL-2*frameT-edgeT;
        // edge cutaways
        translate([-1,-1,-1]) cube([cubeL+2,edgeT+1,edgeT+1]);
        translate([-1,-1,-1]) cube([edgeT+1,cubeL+2,edgeT+1]);
        translate([-1,-1,-1]) cube([edgeT+1,edgeT+1,cubeL+2]);
        //
        translate([-1,cubeL-edgeT,cubeL-edgeT]) cube([cubeL+2,edgeT+1,edgeT+1]);
        translate([cubeL-edgeT,-1,cubeL-edgeT]) cube([edgeT+1,cubeL+2,edgeT+1]);
        translate([cubeL-edgeT,cubeL-edgeT,-1]) cube([edgeT+1,edgeT+1,cubeL+2]);
        // bulk cutaway
        translate([frameT,frameT,frameT]) cube([subCubeL,subCubeL,cubeL+1]);
        translate([frameT+edgeT,frameT+edgeT,-1]) cube([subCubeL,subCubeL,cubeL+1-frameT]);
        //
        translate([edgeT+frameT,-1,edgeT+frameT]) cube([subCubeL,cubeL+1-frameT,subCubeL]);
        translate([frameT,frameT,frameT]) cube([subCubeL,cubeL+1-frameT,subCubeL]);
        //
        translate([-1,frameT+edgeT,frameT+edgeT]) cube([cubeL+1-frameT,subCubeL,subCubeL]);
        translate([frameT,frameT,frameT]) cube([cubeL+1-frameT,subCubeL,subCubeL]);
    }
}


if (rotateOnEdge==1) {
translate([0,0,-sqrt(2)*sin(atan(2/sqrt(2)))*edgeT]) rotate([atan(2/sqrt(2)),0,0]) rotate([0,0,45]) infinityCube();
}
else {
    infinityCube();
}
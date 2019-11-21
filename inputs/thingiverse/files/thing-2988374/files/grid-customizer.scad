//CUSTOMIZER VARIABLES

// General allowance in x direction (mm)
allowance_x = 0.0;
// General allowance in y direction (mm)
allowance_y = 0.0;
// Chamfer at grid bottom left/right x distance (mm)
chamfer_x = 0.2;
// Chamfer at grid bottom front/back y distance (mm)
chamfer_y = 0.2;
// Chamfer at grid bottom z distance (mm); grid height is 2.4 mm
chamfer_z = 1.2;

//CUSTOMIZER VARIABLES END

module grid(x, y) {

    square = 8.4;
    height = 2.4;
    strut = 0.9;
    xextra = 1.1;
    
    width = x * (square + strut) + strut + xextra;
    depth = y * (square + strut) + strut;
    
    points = [
        [     0 + allowance_x + chamfer_x,     0 + allowance_y + chamfer_y, 0 ],
        [ width - allowance_x - chamfer_x,     0 + allowance_y + chamfer_y, 0 ],
        [ width - allowance_x - chamfer_x, depth - allowance_y - chamfer_y, 0 ],
        [     0 + allowance_x + chamfer_x, depth - allowance_y - chamfer_y, 0 ],

        [     0 + allowance_x,     0 + allowance_y, chamfer_z ],
        [ width - allowance_x,     0 + allowance_y, chamfer_z ],
        [ width - allowance_x, depth - allowance_y, chamfer_z ],
        [     0 + allowance_x, depth - allowance_y, chamfer_z ],

        [     0 + allowance_x,     0 + allowance_y, height ],
        [ width - allowance_x,     0 + allowance_y, height ],
        [ width - allowance_x, depth - allowance_y, height ],
        [     0 + allowance_x, depth - allowance_y, height ]
    ];
    
    faces = [
        [0,1,2,3],   // bottom

        [4,5,1,0],   // chamfer front
        [5,6,2,1],   // chamfer right
        [6,7,3,2],   // chamfer back
        [7,4,0,3],   // chamfer left

        [8,9,5,4],   // front
        [9,10,6,5],  // right
        [10,11,7,6], // back
        [11,8,4,7],  // left
        
        [11,10,9,8] // top
    ];
    
    difference() { 
        polyhedron(points, faces);
        for (i = [0:x-1]) {
            translate([i * (square + strut) + strut + xextra/2, 0, 0])
            for (i = [0:y-1]) {
                translate([0, i * (square + strut) + strut, -1]) 
                cube(square, height+2);
            }
        }
    }
}

grid(6,2);
mirror([0,1,0])
translate([0,2,0])
grid(6,3);
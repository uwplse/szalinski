// shape of the model
shape = "pyramid";//[octahedron,pyramid]
//base size
size = 50;
//number of cutouts ( smaller number = more cutouts)
x = 0;
// thicken up the octahedron a little bit
thicken = .20;

// octahedron size
fdepth = 3;


size0 = size / sqrt(2);

module octa(depth, vec, sz) {
    cx = vec[0];
    cy = vec[1];
    cz = vec[2];
    if (depth == fdepth) {
        szc = sz + thicken;
        polyhedron(points = [
            [cx      , cy      , cz + szc],
            [cx + szc, cy      , cz      ],
            [cx      , cy + szc, cz      ],
            [cx - szc, cy      , cz      ],
            [cx      , cy - szc, cz      ],
            [cx      , cy      , cz - szc]],
           faces = [[0, 1, 2], [0, 2, 3], [0, 3, 4], [0, 4, 1],
                    [5, 4, 3], [5, 3, 2], [5, 2, 1], [5, 1, 4]],
            convexity = 2);
    } else {
       octa(depth + 1, [cx         , cy         , cz + sz / 2], sz / 2);
       octa(depth + 1, [cx + sz / 2, cy         , cz         ], sz / 2);
       octa(depth + 1, [cx         , cy + sz / 2, cz         ], sz / 2);
       octa(depth + 1, [cx - sz / 2, cy         , cz         ], sz / 2);
       octa(depth + 1, [cx         , cy - sz / 2, cz         ], sz / 2);
       octa(depth + 1, [cx         , cy         , cz - sz / 2], sz / 2);
    }
}
module cutout_cube(){
    translate([0, 0, -5000]){
    cube([10000, 10000, 10000], center=true);
}
}
if (shape == "pyramid"){
    echo("pyramid");
    difference(){
    octa(x, [0, 0, 0], size0);
        
    cutout_cube();
    }
}
else{
    octa(x, [0, 0, 0], size0);
}
// https://www.thingiverse.com/thing:1123004    
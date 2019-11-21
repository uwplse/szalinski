//base size
size = 30;

/*[Hidden]*/

x = 0;
thicken = .20;
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

    echo("pyramid");
    difference(){
    octa(x, [0, 0, 0], size0);
        
    cutout_cube();
    }

  

rotate([0, 0, 45]){
  translate([0, 0, (size / 2 - 1.2)]){
    difference() {
      cube([(size + 1), (size + 1), (size + 1)], center=true);

      cube([(size + 0), (size + 0), (size + 0)], center=true);
    }
  }
}
// remixed from a design by  taroh
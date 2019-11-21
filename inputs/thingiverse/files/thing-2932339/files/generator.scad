/* [Size] */

length = 1;
width = 1;
height = 10;

/* [Hidden] */

size = [length, width, height];

module 3DTriangle(size) {
    polyhedron(
        points = [
            [0, 0, 0], //0
            [size[0]/2, size[1], 0], //1
            [size[0], 0, 0], //2
            [0, 0, size[2]], //3
            [size[0]/2, size[1], size[2]], //4
            [size[0], 0, size[2]] //5
        ], faces = [
            [0, 1, 2], //bottom
            [0, 3, 4, 1], //s1
            [1, 4, 5, 2], //s2
            [2, 5, 3, 0], //s3
            [5, 4, 3] //top
        ]
    );
}

module genSide(type, h) {
    if (type==0) {
        cube([20, 1, h]);
        for (i = [0:1]) {
            translate([i*10+0.75, -7, 0]) {
                3DTriangle([8.5, 8, h]);
            }
        }
    } else if (type==1) {
        cube([20, 1, h]);
        translate([5.75, -7, 0]) {
            3DTriangle([8.5, 8, h]);
        }
    }
}

module genSides(type, h, count) {
    for (i = [0:20:(count-1)*20]) {
        translate([i, 0, 0]) {
            genSide(type, h);
        }
    }
}

module genContainer(size) {
    cube([size[0]*20, size[1]*20, 1]);
    for (i = [0:3]) {
        if (i==0) {
            genSides(0, size[2], size[0]);
        } else if (i==1) {
            rotate([0, 0, 90]) {
                translate([0, -size[0]*20, 0]) {
                    genSides(0, size[2], size[1]);
                }
            }
        } else if (i==2) {
            rotate([0, 0, 180]) {
                translate([-size[0]*20, -size[1]*20, 0]) {
                    genSides(1, size[2], size[0]);
                }
            }
        } else if (i==3) {
            rotate([0, 0, 270]) {
                translate([-size[1]*20, 0, 0]) {
                    genSides(1, size[2], size[1]);
                }
            }
        }
    }
}

genContainer(size);
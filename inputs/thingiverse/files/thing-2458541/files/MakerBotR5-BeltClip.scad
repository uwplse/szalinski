
gap = 2.3;
wallThick = 2.0;
clampWidth = 52;
clampHeight = 10.2;
teethDepth = 0.8;

module triangleR(size) {
    polyhedron(
        points = [ [0,0,0], [size[0], 0, 0], [0, size[1], 0], [0,0,size[2]], [size[0], 0, size[2]], [0,size[1],size[2]] ],
        faces = [ [0,1,2], [3,5,4], [0,3,1], [3,4,1], [1,4,2], [4,5,2], [2,5,0], [5,3,0] ]
    );
}

cube([clampWidth,wallThick,clampHeight]);

translate([0,wallThick+gap,0]) {
    difference() {
        cube([clampWidth,wallThick,clampHeight]);
        translate([clampWidth/4, -1+wallThick+2 ,1.001]) {
            translate([-0.001,0,0]) {
                rotate([90,0,0]) {
                    triangleR([(clampHeight-1.0)/2/tan(67),(clampHeight-1.0)/2,wallThick+2]);
                }
            }
            mirror([1,0,0]) {
                rotate([90,0,0]) {
                    triangleR([(clampHeight-1.0)/2/tan(67),(clampHeight-1.0)/2,wallThick+2]);
                }
            }
        }
        translate([clampWidth*3/4, -1+wallThick+2 ,1.001]) {
            translate([-0.001,0,0]) {
                rotate([90,0,0]) {
                    triangleR([(clampHeight-1.0)/2/tan(67),(clampHeight-1.0)/2,wallThick+2]);
                }
            }
            mirror([1,0,0]) {
                rotate([90,0,0]) {
                    triangleR([(clampHeight-1.0)/2/tan(67),(clampHeight-1.0)/2,wallThick+2]);
                }
            }
        }
    }
}

cube([clampWidth,wallThick*2+gap,1.0]);

translate([clampWidth/2-wallThick/2,0,0]) {
    cube([wallThick, wallThick*2+gap, clampHeight]);
}

for ( i = [ 1 : 2 : 21 ] ) {
    translate([i,0,0]) {
        cube([1.0, wallThick+teethDepth, clampHeight]);
    }
    translate([clampWidth-i-1,0,0]) {
        cube([1.0, wallThick+teethDepth, clampHeight]);
    }
}

translate([1.0, wallThick+gap, clampHeight/2.0-4.0/2.0]) {
    cube([1.0,3.0-1.2+wallThick,4.0]);
    translate([0,wallThick+1.8,0]) {
        triangleR([1.5, 1.2, 4.0]);
    }
    
}

translate([clampWidth-1.0-1.0, wallThick+gap, clampHeight/2.0-4.0/2.0]) {
    cube([1.0,3.0-1.2+wallThick,4.0]);
    translate([1.0,wallThick+1.8,0]) {
        mirror([1,0,0]) {
            triangleR([1.5, 1.2, 4.0]);
        }
    }
}

translate([clampWidth/2-10/2, wallThick+gap, clampHeight/2.0-6/2.0]) {
    cube([2.5, wallThick+1.0, 6]);
}

translate([clampWidth/2+10/2-2.5, wallThick+gap, clampHeight/2.0-6/2.0]) {
    cube([2.5, wallThick+1.0, 6]);
}

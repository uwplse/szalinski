/*
    Custom Geometric Lattice
    aka Space Filling Polyhedron/Tessellation/Honeycomb
    (see http://mathworld.wolfram.com/Space-FillingPolyhedron.html,
         https://en.wikipedia.org/wiki/Convex_uniform_honeycomb)

*/
shape=12;// [ 0:cubic,1:triangular prism,2:hexagonal prism,3:bitruncated cubic ,4:gyrobifastigium,5:rhombic dodecahedron,6:elongated dodecahedorn,7:alternated cubic,8:quarter cubic,9:truncated cubic,10:rectified cubic,11:omnitruncated cubic,12:cantellated cubic,13:cantitruncated cubic,14:runcitruncated cubic,15:cantic cubic,16:runcic cubic,17:runcicantic cubic ]

size = 12; // [1:40]
edge_radius = 2.0; // [0.5:0.5:4]
edge_fn = 0; // [0,4,8,16,32,64]

x_count=3; // [1:8]
y_count=3; // [1:8]
z_count=3; // [1:8]

/* [Hidden] */
CUBIC=0;
TRIANGULAR_PRISM=1;
HEXAGONAL_PRISM=2;
BITRUNCATED_CUBIC=3;
GYROBIFASTIGIUM=4;
RHOMBIC_DODECAHEDRON=5;
ELONGATED_DODECAHEDRON=6;
ALTERNATED_CUBIC=7;
QUARTER_CUBIC=8;
TRUNCATED_CUBIC=9;
RECTIFIED_CUBIC=10;
OMNITRUNCATED_CUBIC=11;
CANTELLATED_CUBIC=12;
CANTITRUNCATED_CUBIC=13;
RUNCITRUNCATED_CUBIC=14;
CANTIC_CUBIC=15;
RUNCIC_CUBIC=16;
RUNCICANTIC_CUBIC=17;

size1=size/2;

preview=1; // [0:no,1:yes]


//////// polyhedra: ////////

// cube
cube_vertices=[
    [ -size1,  -size1, -size1 ],
    [ -size1,  -size1, +size1 ],
    [ -size1,  +size1, -size1 ],
    [ -size1,  +size1, +size1 ],
    [ +size1,  -size1, -size1 ],
    [ +size1,  -size1, +size1 ],
    [ +size1,  +size1, -size1 ],
    [ +size1,  +size1, +size1 ]
];
cube_edges=[
    [0,1],
    [0,2],
    [0,4],
    [1,3],
    [1,5],
    [2,3],
    [2,6],
    [3,7],
    [4,5],
    [4,6],
    [5,7],
    [6,7]
];

// truncated cube
L_truncated_cube = size*(1+sqrt(2))/2;

truncated_cube_vertices=[
    [             -size1, -L_truncated_cube, -L_truncated_cube ],
    [ -L_truncated_cube,             -size1, -L_truncated_cube ],
    [             +size1, -L_truncated_cube, -L_truncated_cube ],
    [ +L_truncated_cube,             -size1, -L_truncated_cube ],
    [             -size1, +L_truncated_cube, -L_truncated_cube ],
    [ -L_truncated_cube,             +size1, -L_truncated_cube ],
    [             +size1, +L_truncated_cube, -L_truncated_cube ],
    [ +L_truncated_cube,             +size1, -L_truncated_cube ],
    [ -L_truncated_cube, -L_truncated_cube,             -size1 ],
    [ -L_truncated_cube, +L_truncated_cube,             -size1 ],
    [ +L_truncated_cube, -L_truncated_cube,             -size1 ],
    [ +L_truncated_cube, +L_truncated_cube,             -size1 ],
    [ -L_truncated_cube, -L_truncated_cube,             +size1 ],
    [ -L_truncated_cube, +L_truncated_cube,             +size1 ],
    [ +L_truncated_cube, -L_truncated_cube,             +size1 ],
    [ +L_truncated_cube, +L_truncated_cube,             +size1 ],
    [             -size1, -L_truncated_cube, +L_truncated_cube ],
    [ -L_truncated_cube,             -size1, +L_truncated_cube ],
    [             +size1, -L_truncated_cube, +L_truncated_cube ],
    [ +L_truncated_cube,             -size1, +L_truncated_cube ],
    [             -size1, +L_truncated_cube, +L_truncated_cube ],
    [ -L_truncated_cube,             +size1, +L_truncated_cube ],
    [             +size1, +L_truncated_cube, +L_truncated_cube ],
    [ +L_truncated_cube,             +size1, +L_truncated_cube ]
];

truncated_cube_edges=[
    [0,1],
    [1,5],
    [4,5],
    [4,6],
    [6,7],
    [7,3],
    [2,3],
    [0,2],
    [0,8],
    [1,8],
    [4,9],
    [5,9],
    [6,11],
    [7,11],
    [2,10],
    [3,10],
    [8,12],
    [9,13],
    [10,14],
    [11,15],
    [12,16],
    [12,17],
    [13,20],
    [13,21],
    [14,18],
    [14,19],
    [15,22],
    [15,23],
    [16,17],
    [17,21],
    [20,21],
    [20,22],
    [22,23],
    [23,19],
    [18,19],
    [16,18]
];

// triangular prism
L_triangular_prism = size1/sqrt(3);

triangular_prism_vertices_1=[
    [ -size1*1.5,   -L_triangular_prism, -size1 ],
    [ +size1*0.5,   -L_triangular_prism, -size1 ],
    [ -size1*0.5, +2*L_triangular_prism, -size1 ],
    [ +size1*1.5, +2*L_triangular_prism, -size1 ],
    [ -size1*1.5,   -L_triangular_prism, +size1 ],
    [ +size1*0.5,   -L_triangular_prism, +size1 ],
    [ -size1*0.5, +2*L_triangular_prism, +size1 ],
    [ +size1*1.5, +2*L_triangular_prism, +size1 ]
];
triangular_prism_vertices_2=[
    [ -size1*1.5,   +L_triangular_prism, -size1 ],
    [ +size1*0.5,   +L_triangular_prism, -size1 ],
    [ -size1*0.5, -2*L_triangular_prism, -size1 ],
    [ +size1*1.5, -2*L_triangular_prism, -size1 ],
    [ -size1*1.5,   +L_triangular_prism, +size1 ],
    [ +size1*0.5,   +L_triangular_prism, +size1 ],
    [ -size1*0.5, -2*L_triangular_prism, +size1 ],
    [ +size1*1.5, -2*L_triangular_prism, +size1 ]
];

triangular_prism_edges=[
    [0,1],
    [0,2],
    [1,2],
    [1,3],
    [2,3],
    [4,5],
    [4,6],
    [5,6],
    [5,7],
    [6,7],
    [0,4],
    [1,5],
    [2,6],
    [3,7]
];

// hexagonal prism
L_hexagonal_prism = size*sqrt(3)/2;

hexagonal_prism_vertices=[
    [ +size1,  +L_hexagonal_prism, -size1 ],
    [  +size,                   0, -size1 ],
    [ +size1,  -L_hexagonal_prism, -size1 ],
    [ -size1,  -L_hexagonal_prism, -size1 ],
    [  -size,                   0, -size1 ],
    [ -size1,  +L_hexagonal_prism, -size1 ],
    [ +size1,  +L_hexagonal_prism, +size1 ],
    [  +size,                   0, +size1 ],
    [ +size1,  -L_hexagonal_prism, +size1 ],
    [ -size1,  -L_hexagonal_prism, +size1 ],
    [  -size,                   0, +size1 ],
    [ -size1,  +L_hexagonal_prism, +size1 ]
];

hexagonal_prism_edges=[
    [0,1],
    [1,2],
    [2,3],
    [3,4],
    [4,5],
    [5,0],
    [6,7],
    [7,8],
    [8,9],
    [9,10],
    [10,11],
    [11,6],
    [0,6],
    [1,7],
    [2,8],
    [3,9],
    [4,10],
    [5,11]
];

// truncated octahedron
L_truncated_octahedron = size*sqrt(2)/2;

truncated_octahedron_vertices=[
    [   -L_truncated_octahedron,                         0, -2*L_truncated_octahedron ],
    [                         0,   -L_truncated_octahedron, -2*L_truncated_octahedron ],
    [   +L_truncated_octahedron,                         0, -2*L_truncated_octahedron ],
    [                         0,   +L_truncated_octahedron, -2*L_truncated_octahedron ],

    [ -2*L_truncated_octahedron,                         0,   -L_truncated_octahedron ],
    [ -2*L_truncated_octahedron,   -L_truncated_octahedron,                         0 ],
    [ -2*L_truncated_octahedron,                         0,   +L_truncated_octahedron ],
    [ -2*L_truncated_octahedron,   +L_truncated_octahedron,                         0 ],

    [                         0, -2*L_truncated_octahedron,   -L_truncated_octahedron ],
    [   -L_truncated_octahedron, -2*L_truncated_octahedron,                         0 ],
    [                         0, -2*L_truncated_octahedron,   +L_truncated_octahedron ],
    [   +L_truncated_octahedron, -2*L_truncated_octahedron,                         0 ],

    [                         0, +2*L_truncated_octahedron,   -L_truncated_octahedron ],
    [   -L_truncated_octahedron, +2*L_truncated_octahedron,                         0 ],
    [                         0, +2*L_truncated_octahedron,   +L_truncated_octahedron ],
    [   +L_truncated_octahedron, +2*L_truncated_octahedron,                         0 ],

    [ +2*L_truncated_octahedron,                         0,   -L_truncated_octahedron ],
    [ +2*L_truncated_octahedron,   -L_truncated_octahedron,                         0 ],
    [ +2*L_truncated_octahedron,                         0,   +L_truncated_octahedron ],
    [ +2*L_truncated_octahedron,   +L_truncated_octahedron,                         0 ],

    [   -L_truncated_octahedron,                         0, +2*L_truncated_octahedron ],
    [                         0,   -L_truncated_octahedron, +2*L_truncated_octahedron ],
    [   +L_truncated_octahedron,                         0, +2*L_truncated_octahedron ],
    [                         0,   +L_truncated_octahedron, +2*L_truncated_octahedron ]
];

truncated_octahedron_xy45_vertices=[
    [                    -size1,                    -size1, -2*L_truncated_octahedron ],
    [                    +size1,                    -size1, -2*L_truncated_octahedron ],
    [                    +size1,                    +size1, -2*L_truncated_octahedron ],
    [                    -size1,                    +size1, -2*L_truncated_octahedron ],

    [                     -size,                     -size,   -L_truncated_octahedron ],
    [                    -size1,                  -3*size1,                         0 ],
    [                     -size,                     -size,   +L_truncated_octahedron ],
    [                  -3*size1,                    -size1,                         0 ],

    [                     +size,                     -size,   -L_truncated_octahedron ],
    [                    +size1,                  -3*size1,                         0 ],
    [                     +size,                     -size,   +L_truncated_octahedron ],
    [                  +3*size1,                    -size1,                         0 ],

    [                     -size,                     +size,   -L_truncated_octahedron ],
    [                  -3*size1,                    +size1,                         0 ],
    [                     -size,                     +size,   +L_truncated_octahedron ],
    [                    -size1,                  +3*size1,                         0 ],

    [                     +size,                     +size,   -L_truncated_octahedron ],
    [                  +3*size1,                    +size1,                         0 ],
    [                     +size,                     +size,   +L_truncated_octahedron ],
    [                    +size1,                  +3*size1,                         0 ],

    [                    -size1,                    -size1, +2*L_truncated_octahedron ],
    [                    +size1,                    -size1, +2*L_truncated_octahedron ],
    [                    +size1,                    +size1, +2*L_truncated_octahedron ],
    [                    -size1,                    +size1, +2*L_truncated_octahedron ]
];

truncated_octahedron_edges=[
    [0,1],
    [1,2],
    [0,3],
    [2,3],
    [4,5],
    [5,6],
    [4,7],
    [6,7],
    [8,9],
    [9,10],
    [8,11],
    [10,11],
    [12,13],
    [13,14],
    [12,15],
    [14,15],
    [16,17],
    [16,19],
    [17,18],
    [18,19],
    [20,21],
    [21,22],
    [20,23],
    [22,23],
    [0,4],
    [1,8],
    [2,16],
    [3,12],
    [7,13],
    [9,5],
    [11,17],
    [19,15],
    [6,20],
    [10,21],
    [18,22],
    [14,23]
];

// gyrobifastigium
L_gyrobifastigium = size*sqrt(3)/2;

gyrobifastigium_vertices_1=[
    [      0,  -size1, +L_gyrobifastigium ],
    [      0,  +size1, +L_gyrobifastigium ],
    [ -size1,  -size1,                  0 ],
    [ -size1,  +size1,                  0 ],
    [ +size1,  -size1,                  0 ],
    [ +size1,  +size1,                  0 ],
    [ -size1,       0, -L_gyrobifastigium ],
    [ +size1,       0, -L_gyrobifastigium ]
];
gyrobifastigium_vertices_2=[
    [ -size1,       0, +L_gyrobifastigium ],
    [ +size1,       0, +L_gyrobifastigium ],
    [ -size1,  -size1,                  0 ],
    [ +size1,  -size1,                  0 ],
    [ -size1,  +size1,                  0 ],
    [ +size1,  +size1,                  0 ],
    [      0,  -size1, -L_gyrobifastigium ],
    [      0,  +size1, -L_gyrobifastigium ]
];
gyrobifastigium_edges=[
    [0,1],
    [0,2],
    [0,4],
    [1,3],
    [1,5],
    [2,3],
    [2,4],
    [4,5],
    [3,5],
    [2,6],
    [3,6],
    [6,7],
    [4,7],
    [5,7]
];

// rhombic dodecahedron
L_rhombic_dodecahedron = size*sqrt(2)/2;

rhombic_dodecahedron_vertices=[
    [ -size/2,                        0, -L_rhombic_dodecahedron ],
    [       0,  -L_rhombic_dodecahedron, -L_rhombic_dodecahedron ],
    [ +size/2,                        0, -L_rhombic_dodecahedron ],
    [       0,  +L_rhombic_dodecahedron, -L_rhombic_dodecahedron ],
    [   -size,                        0,                       0 ],
    [ -size/2,  -L_rhombic_dodecahedron,                       0 ],
    [ -size/2,  +L_rhombic_dodecahedron,                       0 ],
    [ +size/2,  -L_rhombic_dodecahedron,                       0 ],
    [ +size/2,  +L_rhombic_dodecahedron,                       0 ],
    [   +size,                        0,                       0 ],
    [ -size/2,                        0, +L_rhombic_dodecahedron ],
    [       0,  -L_rhombic_dodecahedron, +L_rhombic_dodecahedron ],
    [ +size/2,                       +0, +L_rhombic_dodecahedron ],
    [       0,  +L_rhombic_dodecahedron, +L_rhombic_dodecahedron ]
];
rhombic_dodecahedron_edges=[
    [0,1],
    [1,2],
    [2,3],
    [0,3],
    [0,4],
    [1,5],
    [1,7],
    [2,9],
    [3,6],
    [3,8],
    [4,5],
    [4,6],
    [7,9],
    [8,9],
    [4,10],
    [5,11],
    [7,11],
    [6,13],
    [8,13],
    [9,12],
    [10,11],
    [11,12],
    [12,13],
    [10,13]
];

// elongated dodecahedron
L_elongated_dodecahedron = size*sqrt(2)/2;

elongated_dodecahedron_vertices=[
    [     -size,                         0, -L_elongated_dodecahedron ],
    [   -size/2, -L_elongated_dodecahedron, -L_elongated_dodecahedron ],
    [   +size/2, -L_elongated_dodecahedron, -L_elongated_dodecahedron ],
    [     +size,                         0, -L_elongated_dodecahedron ],
    [   +size/2, +L_elongated_dodecahedron, -L_elongated_dodecahedron ],
    [   -size/2, +L_elongated_dodecahedron, -L_elongated_dodecahedron ],
    [ -size*1.5,                         0,                         0 ],
    [     -size, -L_elongated_dodecahedron,                         0 ],
    [     +size, -L_elongated_dodecahedron,                         0 ],
    [ +size*1.5,                         0,                         0 ],
    [     +size, +L_elongated_dodecahedron,                         0 ],
    [     -size, +L_elongated_dodecahedron,                         0 ],
    [     -size,                         0, +L_elongated_dodecahedron ],
    [   -size/2, -L_elongated_dodecahedron, +L_elongated_dodecahedron ],
    [   +size/2, -L_elongated_dodecahedron, +L_elongated_dodecahedron ],
    [     +size,                         0, +L_elongated_dodecahedron ],
    [   +size/2, +L_elongated_dodecahedron, +L_elongated_dodecahedron ],
    [   -size/2, +L_elongated_dodecahedron, +L_elongated_dodecahedron ]
];
elongated_dodecahedron_edges=[
    [0,1],
    [1,2],
    [2,3],
    [3,4],
    [4,5],
    [5,0],
    [0,6],
    [1,7],
    [2,8],
    [3,9],
    [4,10],
    [5,11],
    [6,7],
    [8,9],
    [9,10],
    [11,6],
    [6,12],
    [7,13],
    [8,14],
    [9,15],
    [10,16],
    [11,17],
    [12,13],
    [13,14],
    [14,15],
    [15,16],
    [16,17],
    [17,12]
];

// tetrahedron
L_tetrahedron = size1/sqrt(2);

tetrahedron_vertices_1=[
    [ +size1,      0, -L_tetrahedron ],
    [ -size1,      0, -L_tetrahedron ],
    [      0, -size1, +L_tetrahedron ],
    [      0, +size1, +L_tetrahedron ]
];

tetrahedron_vertices_2=[
    [      0, +size1, -L_tetrahedron ],
    [      0, -size1, -L_tetrahedron ],
    [ +size1,      0, +L_tetrahedron ],
    [ -size1,      0, +L_tetrahedron ]
];

tetrahedron_edges=[
    [0,1],
    [0,2],
    [0,3],
    [1,2],
    [1,3],
    [2,3]
];

// truncated tetrahedron
L_truncated_tetrahedron = size1/sqrt(2/3);

function truncated_tetrahedron_vertices(v1,v2,v3,v4) =
    let (
        v12 = 2*v1+v2,
        v21 = 2*v2+v1,
        v13 = 2*v1+v3,
        v31 = 2*v3+v1,
        v14 = 2*v1+v4,
        v41 = 2*v4+v1,
        v23 = 2*v2+v3,
        v32 = 2*v3+v2,
        v24 = 2*v2+v4,
        v42 = 2*v4+v2,
        v34 = 2*v3+v4,
        v43 = 2*v4+v3
    )
    L_truncated_tetrahedron*[v12,v21,v13,v31,v14,v41,v23,v32,v24,v42,v34,v43]
;

v1_1 = [          0, +2*sqrt(2)/3, +1/3 ];
v1_2 = [ +sqrt(2/3), -1*sqrt(2)/3, +1/3 ];
v1_3 = [ -sqrt(2/3), -1*sqrt(2)/3, +1/3 ];
v1_4 = [          0,            0,   -1 ];
truncated_tetrahedron_vertices_1=truncated_tetrahedron_vertices(v1_1,v1_2,v1_3,v1_4);

v2_1 = [          0, -2*sqrt(2)/3, +1/3 ];
v2_2 = [ +sqrt(2/3), +1*sqrt(2)/3, +1/3 ];
v2_3 = [ -sqrt(2/3), +1*sqrt(2)/3, +1/3 ];
v2_4 = [          0,            0,   -1 ];
truncated_tetrahedron_vertices_2=truncated_tetrahedron_vertices(v2_1,v2_2,v2_3,v2_4);

v3_1 = [          0, -2*sqrt(2)/3, -1/3 ];
v3_2 = [ +sqrt(2/3), +1*sqrt(2)/3, -1/3 ];
v3_3 = [ -sqrt(2/3), +1*sqrt(2)/3, -1/3 ];
v3_4 = [          0,            0,   +1 ];
truncated_tetrahedron_vertices_3=truncated_tetrahedron_vertices(v3_1,v3_2,v3_3,v3_4);

v4_1 = [          0, +2*sqrt(2)/3, -1/3 ];
v4_2 = [ +sqrt(2/3), -1*sqrt(2)/3, -1/3 ];
v4_3 = [ -sqrt(2/3), -1*sqrt(2)/3, -1/3 ];
v4_4 = [          0,            0,   +1 ];
truncated_tetrahedron_vertices_4=truncated_tetrahedron_vertices(v4_1,v4_2,v4_3,v4_4);

truncated_tetrahedron_edges=[
    [0,1],
    [1,6],
    [6,7],
    [7,3],
    [3,2],
    [2,0],
    [0,4],
    [4,5],
    [5,9],
    [9,8],
    [8,1],
    [6,8],
    [9,11],
    [11,10],
    [10,7],
    [3,10],
    [11,5],
    [4,2]
];

// cuboctahedron
L_cuboctahedron = size/sqrt(2);

cuboctahedron_vertices=[
    [  -L_cuboctahedron, -L_cuboctahedron, 0 ],
    [  -L_cuboctahedron, +L_cuboctahedron, 0 ],
    [  +L_cuboctahedron, -L_cuboctahedron, 0 ],
    [  +L_cuboctahedron, +L_cuboctahedron, 0 ],
    [  -L_cuboctahedron, 0, -L_cuboctahedron ],
    [  -L_cuboctahedron, 0, +L_cuboctahedron ],
    [  +L_cuboctahedron, 0, -L_cuboctahedron ],
    [  +L_cuboctahedron, 0, +L_cuboctahedron ],
    [  0, -L_cuboctahedron, -L_cuboctahedron ],
    [  0, -L_cuboctahedron, +L_cuboctahedron ],
    [  0, +L_cuboctahedron, -L_cuboctahedron ],
    [  0, +L_cuboctahedron, +L_cuboctahedron ]
];

cuboctahedron_edges=[
    [4,8],
    [4,10],
    [6,10],
    [6,8],
    [0,4],
    [0,8],
    [1,10],
    [1,4],
    [3,10],
    [3,6],
    [2,6],
    [2,8],
    [0,9],
    [0,5],
    [1,5],
    [1,11],
    [2,7],
    [2,9],
    [3,11],
    [3,7],
    [5,9],
    [7,9],
    [5,11],
    [7,11]
];

// rhombicuboctahedron
L_rhombicuboctahedron = size1*(1+sqrt(2));

rhombicuboctahedron_vertices=[
    [-size1,-size1,-L_rhombicuboctahedron],
    [-size1,+size1,-L_rhombicuboctahedron],
    [+size1,-size1,-L_rhombicuboctahedron],
    [+size1,+size1,-L_rhombicuboctahedron],

    [-size1,-L_rhombicuboctahedron,-size1],
    [-size1,+L_rhombicuboctahedron,-size1],
    [+size1,-L_rhombicuboctahedron,-size1],
    [+size1,+L_rhombicuboctahedron,-size1],
    [-L_rhombicuboctahedron,-size1,-size1],
    [-L_rhombicuboctahedron,+size1,-size1],
    [+L_rhombicuboctahedron,-size1,-size1],
    [+L_rhombicuboctahedron,+size1,-size1],

    [-size1,-L_rhombicuboctahedron,+size1],
    [-size1,+L_rhombicuboctahedron,+size1],
    [+size1,-L_rhombicuboctahedron,+size1],
    [+size1,+L_rhombicuboctahedron,+size1],
    [-L_rhombicuboctahedron,-size1,+size1],
    [-L_rhombicuboctahedron,+size1,+size1],
    [+L_rhombicuboctahedron,-size1,+size1],
    [+L_rhombicuboctahedron,+size1,+size1],

    [-size1,-size1,+L_rhombicuboctahedron],
    [-size1,+size1,+L_rhombicuboctahedron],
    [+size1,-size1,+L_rhombicuboctahedron],
    [+size1,+size1,+L_rhombicuboctahedron],

];
rhombicuboctahedron_edges=[
    [0,1],
    [1,3],
    [0,2],
    [2,3],


    [0,4],
    [0,8],
    [1,5],
    [1,9],
    [2,6],
    [2,10],
    [3,7],
    [3,11],

    [4,6],
    [4,8],
    [8,9],
    [5,9],
    [5,7],
    [7,11],
    [11,10],
    [6,10],

    [4,12],
    [5,13],
    [6,14],
    [7,15],
    [8,16],
    [9,17],
    [10,18],
    [11,19],

    [12,14],
    [12,16],
    [16,17],
    [13,17],
    [13,15],
    [15,19],
    [19,18],
    [14,18],

    [12,20],
    [16,20],
    [13,21],
    [17,21],
    [14,22],
    [18,22],
    [15,23],
    [19,23],

    [20,21],
    [21,23],
    [20,22],
    [22,23],

];

// great_rhombicuboctahedron
L_great_rhombicuboctahedron = size1*(1+2*sqrt(2));

great_rhombicuboctahedron_vertices=[
    [                       -size1,       -L_rhombicuboctahedron, -L_great_rhombicuboctahedron],
    [       -L_rhombicuboctahedron,                       -size1, -L_great_rhombicuboctahedron],
    [                       -size1,       +L_rhombicuboctahedron, -L_great_rhombicuboctahedron],
    [       -L_rhombicuboctahedron,                       +size1, -L_great_rhombicuboctahedron],
    [                       +size1,       -L_rhombicuboctahedron, -L_great_rhombicuboctahedron],
    [       +L_rhombicuboctahedron,                       -size1, -L_great_rhombicuboctahedron],
    [                       +size1,       +L_rhombicuboctahedron, -L_great_rhombicuboctahedron],
    [       +L_rhombicuboctahedron,                       +size1, -L_great_rhombicuboctahedron],
    [                       -size1, -L_great_rhombicuboctahedron,       -L_rhombicuboctahedron],
    [ -L_great_rhombicuboctahedron,                       -size1,       -L_rhombicuboctahedron],
    [                       -size1, +L_great_rhombicuboctahedron,       -L_rhombicuboctahedron],
    [ -L_great_rhombicuboctahedron,                       +size1,       -L_rhombicuboctahedron],
    [                       +size1, -L_great_rhombicuboctahedron,       -L_rhombicuboctahedron],
    [ +L_great_rhombicuboctahedron,                       -size1,       -L_rhombicuboctahedron],
    [                       +size1, +L_great_rhombicuboctahedron,       -L_rhombicuboctahedron],
    [ +L_great_rhombicuboctahedron,                       +size1,       -L_rhombicuboctahedron],
    [       -L_rhombicuboctahedron, -L_great_rhombicuboctahedron,                       -size1],
    [ -L_great_rhombicuboctahedron,       -L_rhombicuboctahedron,                       -size1],
    [       -L_rhombicuboctahedron, +L_great_rhombicuboctahedron,                       -size1],
    [ -L_great_rhombicuboctahedron,       +L_rhombicuboctahedron,                       -size1],
    [       +L_rhombicuboctahedron, -L_great_rhombicuboctahedron,                       -size1],
    [ +L_great_rhombicuboctahedron,       -L_rhombicuboctahedron,                       -size1],
    [       +L_rhombicuboctahedron, +L_great_rhombicuboctahedron,                       -size1],
    [ +L_great_rhombicuboctahedron,       +L_rhombicuboctahedron,                       -size1],
    [       -L_rhombicuboctahedron, -L_great_rhombicuboctahedron,                       +size1],
    [ -L_great_rhombicuboctahedron,       -L_rhombicuboctahedron,                       +size1],
    [       -L_rhombicuboctahedron, +L_great_rhombicuboctahedron,                       +size1],
    [ -L_great_rhombicuboctahedron,       +L_rhombicuboctahedron,                       +size1],
    [       +L_rhombicuboctahedron, -L_great_rhombicuboctahedron,                       +size1],
    [ +L_great_rhombicuboctahedron,       -L_rhombicuboctahedron,                       +size1],
    [       +L_rhombicuboctahedron, +L_great_rhombicuboctahedron,                       +size1],
    [ +L_great_rhombicuboctahedron,       +L_rhombicuboctahedron,                       +size1],
    [                       -size1, -L_great_rhombicuboctahedron,       +L_rhombicuboctahedron],
    [ -L_great_rhombicuboctahedron,                       -size1,       +L_rhombicuboctahedron],
    [                       -size1, +L_great_rhombicuboctahedron,       +L_rhombicuboctahedron],
    [ -L_great_rhombicuboctahedron,                       +size1,       +L_rhombicuboctahedron],
    [                       +size1, -L_great_rhombicuboctahedron,       +L_rhombicuboctahedron],
    [ +L_great_rhombicuboctahedron,                       -size1,       +L_rhombicuboctahedron],
    [                       +size1, +L_great_rhombicuboctahedron,       +L_rhombicuboctahedron],
    [ +L_great_rhombicuboctahedron,                       +size1,       +L_rhombicuboctahedron],
    [                       -size1,       -L_rhombicuboctahedron, +L_great_rhombicuboctahedron],
    [       -L_rhombicuboctahedron,                       -size1, +L_great_rhombicuboctahedron],
    [                       -size1,       +L_rhombicuboctahedron, +L_great_rhombicuboctahedron],
    [       -L_rhombicuboctahedron,                       +size1, +L_great_rhombicuboctahedron],
    [                       +size1,       -L_rhombicuboctahedron, +L_great_rhombicuboctahedron],
    [       +L_rhombicuboctahedron,                       -size1, +L_great_rhombicuboctahedron],
    [                       +size1,       +L_rhombicuboctahedron, +L_great_rhombicuboctahedron],
    [       +L_rhombicuboctahedron,                       +size1, +L_great_rhombicuboctahedron]
];

great_rhombicuboctahedron_edges=[
    [0,1],
    [1,3],
    [2,3],
    [2,6],
    [6,7],
    [5,7],
    [4,5],
    [0,4],
    [0,8],
    [1,9],
    [2,10],
    [3,11],
    [4,12],
    [5,13],
    [6,14],
    [7,15],
    [9,11],
    [10,14],
    [13,15],
    [8,12],
    [9,17],
    [11,19],
    [14,22],
    [10,18],
    [13,21],
    [15,23],
    [8,16],
    [12,20],
    [16,17],
    [18,19],
    [20,21],
    [22,23],
    [17,25],
    [19,27],
    [22,30],
    [18,26],
    [21,29],
    [23,31],
    [16,24],
    [20,28],
    [24,25],
    [26,27],
    [28,29],
    [30,31],
    [25,33],
    [27,35],
    [30,38],
    [26,34],
    [29,37],
    [31,39],
    [24,32],
    [28,36],
    [32,36],
    [34,38],
    [35,33],
    [37,39],
    [33,41],
    [35,43],
    [38,46],
    [34,42],
    [37,45],
    [39,47],
    [32,40],
    [36,44],
    [40,41],
    [41,43],
    [42,43],
    [42,46],
    [46,47],
    [45,47],
    [44,45],
    [40,44]
];

// octahedral prism
octagonal_prism_xy_vertices=[
    [                 -size1, -L_rhombicuboctahedron, -size1],
    [ -L_rhombicuboctahedron,                 -size1, -size1],
    [                 -size1, +L_rhombicuboctahedron, -size1],
    [ -L_rhombicuboctahedron,                 +size1, -size1],
    [                 +size1, -L_rhombicuboctahedron, -size1],
    [ +L_rhombicuboctahedron,                 -size1, -size1],
    [                 +size1, +L_rhombicuboctahedron, -size1],
    [ +L_rhombicuboctahedron,                 +size1, -size1],
    [                 -size1, -L_rhombicuboctahedron, +size1],
    [ -L_rhombicuboctahedron,                 -size1, +size1],
    [                 -size1, +L_rhombicuboctahedron, +size1],
    [ -L_rhombicuboctahedron,                 +size1, +size1],
    [                 +size1, -L_rhombicuboctahedron, +size1],
    [ +L_rhombicuboctahedron,                 -size1, +size1],
    [                 +size1, +L_rhombicuboctahedron, +size1],
    [ +L_rhombicuboctahedron,                 +size1, +size1]
];

octagonal_prism_xz_vertices=[
    [                 -size1, -size1, -L_rhombicuboctahedron],
    [ -L_rhombicuboctahedron, -size1,                 -size1],
    [                 -size1, -size1, +L_rhombicuboctahedron],
    [ -L_rhombicuboctahedron, -size1,                 +size1],
    [                 +size1, -size1, -L_rhombicuboctahedron],
    [ +L_rhombicuboctahedron, -size1,                 -size1],
    [                 +size1, -size1, +L_rhombicuboctahedron],
    [ +L_rhombicuboctahedron, -size1,                 +size1],
    [                 -size1, +size1, -L_rhombicuboctahedron],
    [ -L_rhombicuboctahedron, +size1,                 -size1],
    [                 -size1, +size1, +L_rhombicuboctahedron],
    [ -L_rhombicuboctahedron, +size1,                 +size1],
    [                 +size1, +size1, -L_rhombicuboctahedron],
    [ +L_rhombicuboctahedron, +size1,                 -size1],
    [                 +size1, +size1, +L_rhombicuboctahedron],
    [ +L_rhombicuboctahedron, +size1,                 +size1]
];
octagonal_prism_yz_vertices=[
    [ -size1,                 -size1, -L_rhombicuboctahedron],
    [ -size1, -L_rhombicuboctahedron,                 -size1],
    [ -size1,                 -size1, +L_rhombicuboctahedron],
    [ -size1, -L_rhombicuboctahedron,                 +size1],
    [ -size1,                 +size1, -L_rhombicuboctahedron],
    [ -size1, +L_rhombicuboctahedron,                 -size1],
    [ -size1,                 +size1, +L_rhombicuboctahedron],
    [ -size1, +L_rhombicuboctahedron,                 +size1],
    [ +size1,                 -size1, -L_rhombicuboctahedron],
    [ +size1, -L_rhombicuboctahedron,                 -size1],
    [ +size1,                 -size1, +L_rhombicuboctahedron],
    [ +size1, -L_rhombicuboctahedron,                 +size1],
    [ +size1,                 +size1, -L_rhombicuboctahedron],
    [ +size1, +L_rhombicuboctahedron,                 -size1],
    [ +size1,                 +size1, +L_rhombicuboctahedron],
    [ +size1, +L_rhombicuboctahedron,                 +size1]
];

octagonal_prism_edges=[
    [0,1],
    [1,3],
    [2,3],
    [2,6],
    [6,7],
    [5,7],
    [4,5],
    [0,4],
    [0,8],
    [1,9],
    [2,10],
    [3,11],
    [4,12],
    [5,13],
    [6,14],
    [7,15],
    [8,9],
    [9,11],
    [10,11],
    [10,14],
    [14,15],
    [13,15],
    [12,13],
    [8,12]
];

// truncated cuboctahedron
L_truncated_cuboctahedron_1 = size1*(1+sqrt(2));
L_truncated_cuboctahedron_2 = size1*(1+2*sqrt(2));

truncated_cuboctahedron_vertices=[
    [                       -size1, -L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2],
    [ -L_truncated_cuboctahedron_1,                       -size1, -L_truncated_cuboctahedron_2],
    [                       -size1, +L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2],
    [ -L_truncated_cuboctahedron_1,                       +size1, -L_truncated_cuboctahedron_2],
    [                       +size1, -L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2],
    [ +L_truncated_cuboctahedron_1,                       -size1, -L_truncated_cuboctahedron_2],
    [                       +size1, +L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2],
    [ +L_truncated_cuboctahedron_1,                       +size1, -L_truncated_cuboctahedron_2],

    [                       -size1, -L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1],
    [ -L_truncated_cuboctahedron_2,                       -size1, -L_truncated_cuboctahedron_1],
    [                       -size1, +L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1],
    [ -L_truncated_cuboctahedron_2,                       +size1, -L_truncated_cuboctahedron_1],
    [                       +size1, -L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1],
    [ +L_truncated_cuboctahedron_2,                       -size1, -L_truncated_cuboctahedron_1],
    [                       +size1, +L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1],
    [ +L_truncated_cuboctahedron_2,                       +size1, -L_truncated_cuboctahedron_1],


    [ -L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2,                       -size1],
    [ -L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1,                       -size1],
    [ -L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2,                       -size1],
    [ -L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1,                       -size1],
    [ +L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2,                       -size1],
    [ +L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1,                       -size1],
    [ +L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2,                       -size1],
    [ +L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1,                       -size1],


    [ -L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2,                       +size1],
    [ -L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1,                       +size1],
    [ -L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2,                       +size1],
    [ -L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1,                       +size1],
    [ +L_truncated_cuboctahedron_1, -L_truncated_cuboctahedron_2,                       +size1],
    [ +L_truncated_cuboctahedron_2, -L_truncated_cuboctahedron_1,                       +size1],
    [ +L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2,                       +size1],
    [ +L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1,                       +size1],







    [                       -size1, -L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1],
    [ -L_truncated_cuboctahedron_2,                       -size1, +L_truncated_cuboctahedron_1],
    [                       -size1, +L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1],
    [ -L_truncated_cuboctahedron_2,                       +size1, +L_truncated_cuboctahedron_1],
    [                       +size1, -L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1],
    [ +L_truncated_cuboctahedron_2,                       -size1, +L_truncated_cuboctahedron_1],
    [                       +size1, +L_truncated_cuboctahedron_2, +L_truncated_cuboctahedron_1],
    [ +L_truncated_cuboctahedron_2,                       +size1, +L_truncated_cuboctahedron_1],

    [                       -size1, -L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2],
    [ -L_truncated_cuboctahedron_1,                       -size1, +L_truncated_cuboctahedron_2],
    [                       -size1, +L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2],
    [ -L_truncated_cuboctahedron_1,                       +size1, +L_truncated_cuboctahedron_2],
    [                       +size1, -L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2],
    [ +L_truncated_cuboctahedron_1,                       -size1, +L_truncated_cuboctahedron_2],
    [                       +size1, +L_truncated_cuboctahedron_1, +L_truncated_cuboctahedron_2],
    [ +L_truncated_cuboctahedron_1,                       +size1, +L_truncated_cuboctahedron_2],

];
truncated_cuboctahedron_edges=[
    [0,1],
    [1,3],
    [2,3],
    [2,6],
    [6,7],
    [7,5],
    [4,5],
    [0,4],
    [0,8],
    [1,9],
    [2,10],
    [3,11],
    [4,12],
    [5,13],
    [6,14],
    [7,15],
    [8,16],
    [9,17],
    [10,18],
    [11,19],
    [12,20],
    [13,21],
    [14,22],
    [15,23],
    [16,17],
    [18,19],
    [20,21],
    [22,23],
    [24,25],
    [26,27],
    [28,29],
    [30,31],
    [8,12],
    [9,11],
    [10,14],
    [13,15],
    [16,24],
    [17,25],
    [18,26],
    [19,27],
    [20,28],
    [21,29],
    [22,30],
    [23,31],
    [24,32],
    [25,33],
    [26,34],
    [27,35],
    [28,36],
    [29,37],
    [30,38],
    [31,39],
    [32,36],
    [33,35],
    [34,38],
    [37,39],
    [32,40],
    [33,41],
    [34,42],
    [35,43],
    [36,44],
    [37,45],
    [38,46],
    [39,47],
    [40,41],
    [40,44],
    [41,43],
    [42,43],
    [42,46],
    [45,44],
    [45,47],
    [46,47]
];

////////

//////// honeycombs ////////

// cubic
cubic_offsets=[size,size,size];

module cubic(loop_xyz,range_xyz,dup_check) {
    shape(loop_xyz,range_xyz,cubic_offsets,cube_vertices,cube_edges,dup_check);
}

// triangular prism
triangular_prism_offsets=[size,3*L_triangular_prism,size];

module triangular_prism(loop_xyz,range_xyz,dup_check) {
    adjust=(loop_xyz[1]+(y_count%2==0?-0.5:0));
    even_y=adjust%2==0;
    translate_y=even_y?0:L_triangular_prism;
    translation=[0,translate_y,0];
    triangular_prism_vertices = even_y ? triangular_prism_vertices_1 : triangular_prism_vertices_2;
    shape(loop_xyz,range_xyz,triangular_prism_offsets,triangular_prism_vertices,triangular_prism_edges,dup_check,true,translation);
}

// hexagonal prism
hexagonal_prism_offsets=[1.5*size,2*L_hexagonal_prism,size];

module hexagonal_prism(loop_xyz,range_xyz,dup_check) {
    even_x = abs(round(loop_xyz[0]+0.5*(1-x_count%2)))%2 == 0;
    trans_x = even_x ? 0 : L_hexagonal_prism;
    translation=[0,trans_x,0];
    shape(loop_xyz,range_xyz,hexagonal_prism_offsets,hexagonal_prism_vertices,hexagonal_prism_edges,dup_check,true,translation);
}

// bitruncated cubic
bitruncated_cubic_offsets=[4*L_truncated_octahedron,4*L_truncated_octahedron,4*L_truncated_octahedron];

module bitruncated_cubic(loop_xyz,range_xyz,dup_check) {
    shape(loop_xyz,range_xyz,bitruncated_cubic_offsets,truncated_octahedron_vertices,truncated_octahedron_edges,dup_check);
}

// gyrobifastigium
gyrobifastigium_offsets=[size,size,2*L_gyrobifastigium];

module gyrobifastigium(loop_xyz,range_xyz,dup_check) {
    adjust_z=(loop_xyz[2]+(z_count%2==0?0.5:0));
    even_z=(adjust_z%2==0);
    translate_x=(abs(ceil(adjust_z/2))%2)*size/2;
    translate_y=(abs(floor(adjust_z/2))%2)*size/2;
    translate_z=-L_gyrobifastigium*floor((loop_xyz[2]-(z_count%2==0?0.5:0)));
    translation=[translate_x,translate_y,translate_z];
    gyrobifastigium_vertices = even_z ? gyrobifastigium_vertices_1 : gyrobifastigium_vertices_2;
    shape(loop_xyz,range_xyz,gyrobifastigium_offsets,gyrobifastigium_vertices,gyrobifastigium_edges,dup_check,true,translation);
}

// rhombic dodecahedron
rhombic_dodecahedron_offsets=[size,2*L_rhombic_dodecahedron,2*L_rhombic_dodecahedron];

module rhombic_dodecahedron(loop_xyz,range_xyz,dup_check) {
    even_x=(loop_xyz[0]+(x_count%2==0?0.5:0))%2==0;
    translate_y=even_x?0:L_rhombic_dodecahedron;
    translate_z=even_x?0:-L_rhombic_dodecahedron;
    translation=[0,translate_y,translate_z];
    shape(loop_xyz,range_xyz,rhombic_dodecahedron_offsets,rhombic_dodecahedron_vertices,rhombic_dodecahedron_edges,dup_check,true,translation);
}

// elongated dodecahedron
elongated_dodecahedron_offsets=[2*size,2*L_elongated_dodecahedron,2*L_elongated_dodecahedron];

module elongated_dodecahedron(loop_xyz,range_xyz,dup_check) {
    even_x=(loop_xyz[0]+(x_count%2==0?0.5:0))%2==0;
    translate_y=even_x?0:L_rhombic_dodecahedron;
    translate_z=even_x?0:-L_rhombic_dodecahedron;
    translation=[0,translate_y,translate_z];
    shape(loop_xyz,range_xyz,elongated_dodecahedron_offsets,elongated_dodecahedron_vertices,elongated_dodecahedron_edges,dup_check,true,translation);
}

// alternated cubic
alternated_cubic_offsets=[size,size,4*L_tetrahedron];

module alternated_cubic(loop_xyz,range_xyz,dup_check) {
    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_2,tetrahedron_edges,dup_check,false,[-size1,0,+L_tetrahedron]);
    
    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_2,tetrahedron_edges,dup_check,false,[size1,0,+L_tetrahedron]);

    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_1,tetrahedron_edges,dup_check,false,[0,-size1,+L_tetrahedron]);

    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_1,tetrahedron_edges,dup_check,false,[0,size1,+L_tetrahedron]);
    
    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_1,tetrahedron_edges,dup_check,false,[-size1,0,-L_tetrahedron]);
    
    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_1,tetrahedron_edges,dup_check,false,[size1,0,-L_tetrahedron]);
    
    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_2,tetrahedron_edges,dup_check,false,[0,-size1,-L_tetrahedron]);
    
    shape(loop_xyz,range_xyz,alternated_cubic_offsets,tetrahedron_vertices_2,tetrahedron_edges,dup_check,true,[0,size1,-L_tetrahedron]);
}

// quarter cubic
L_truncated_tetrahedron_x = 2*L_truncated_tetrahedron*sqrt(2/3);
L_truncated_tetrahedron_y = 2*L_truncated_tetrahedron*sqrt(2);
L_truncated_tetrahedron_z = 8*L_truncated_tetrahedron/3;

quarter_cubic_offsets=[L_truncated_tetrahedron_x,L_truncated_tetrahedron_y,L_truncated_tetrahedron_z];

translation_y=L_truncated_tetrahedron*(sqrt(2)/3);
translation_z=-L_truncated_tetrahedron*2/3;

translation_xyz=[
    [
     [
      [0,0,0],
      [0,0,translation_z],
      [0,0,0],
      [0,0,translation_z]
     ],
     [
      [0,+2*translation_y,translation_z],
      [0,-2*translation_y,0],
      [0,-2*translation_y,translation_z],
      [0,+2*translation_y,0]
     ],
     [
      [0,0,0],
      [0,0,translation_z],
      [0,0,0],
      [0,0,translation_z]
     ],
     [
      [0,+2*translation_y,translation_z],
      [0,-2*translation_y,0],
      [0,-2*translation_y,translation_z],
      [0,+2*translation_y,0]
     ]
    ]
    ,
    [
     [
      [0,+2*translation_y,translation_z],
      [0,-2*translation_y,0],
      [0,-2*translation_y,translation_z],
      [0,+2*translation_y,0]
     ],
     [
      [0,0,0],
      [0,0,translation_z],
      [0,0,0],
      [0,0,translation_z]
     ],
     [
      [0,+2*translation_y,translation_z],
      [0,-2*translation_y,0],
      [0,-2*translation_y,translation_z],
      [0,+2*translation_y,0]
     ],
     [
      [0,0,0],
      [0,0,translation_z],
      [0,0,0],
      [0,0,translation_z]
     ]
    ]
];

vertices_xyz=[
    [
     [
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_2,
      truncated_tetrahedron_vertices_4
     ],
     [
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_4,
      truncated_tetrahedron_vertices_2
     ],
     [
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_2,
      truncated_tetrahedron_vertices_4
     ],
     [
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_4,
      truncated_tetrahedron_vertices_2
     ]
    ]
    ,
    [
     [
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_4,
      truncated_tetrahedron_vertices_2
     ],
     [
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_2,
      truncated_tetrahedron_vertices_4
     ],
     [
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_4,
      truncated_tetrahedron_vertices_2
     ],
     [
      truncated_tetrahedron_vertices_1,
      truncated_tetrahedron_vertices_3,
      truncated_tetrahedron_vertices_2,
      truncated_tetrahedron_vertices_4
     ]
    ],
];

module quarter_cubic(loop_xyz,range_xyz,dup_check) {
    alt_x=loop_xyz[0]+(x_count%2==0?0.5:0);
    alt_y=loop_xyz[1]+(y_count%2==0?0.5:0);
    alt_z=loop_xyz[2]+(z_count%2==0?0.5:0);

    mod_x=((alt_x%2)+2)%2;
    mod_y=((alt_y%4)+4)%4;
    mod_z=((alt_z%4)+4)%4;
    translation=translation_xyz[mod_x][mod_y][mod_z];
    vertices=vertices_xyz[mod_x][mod_y][mod_z];
    shape(loop_xyz,range_xyz,quarter_cubic_offsets,vertices,truncated_tetrahedron_edges,dup_check,true,translation);
}

// truncated cubic
truncated_cubic_offsets=[2*L_truncated_cube,2*L_truncated_cube,2*L_truncated_cube];

module truncated_cubic(loop_xyz,range_xyz,dup_check) {
    shape(loop_xyz,range_xyz,truncated_cubic_offsets,truncated_cube_vertices,truncated_cube_edges,dup_check);
}

// rectified cubic
rectified_cubic_offsets=[2*L_cuboctahedron,2*L_cuboctahedron,2*L_cuboctahedron];

module rectified_cubic(loop_xyz,range_xyz,dup_check) {
    shape(loop_xyz,range_xyz,rectified_cubic_offsets,cuboctahedron_vertices,cuboctahedron_edges,dup_check);
}

// omnitruncated cubic
omnitruncated_cubic_offsets=[2*L_great_rhombicuboctahedron+size,2*L_great_rhombicuboctahedron+size,2*L_great_rhombicuboctahedron+size];

module omnitruncated_cubic(loop_xyz,range_xyz,dup_check) {
    if (loop_xyz[0]>range_xyz[0][0]) {
        translation=[-(L_great_rhombicuboctahedron+size1),0,0];
        shape(loop_xyz,range_xyz,omnitruncated_cubic_offsets,octagonal_prism_yz_vertices,octagonal_prism_edges,dup_check,false,translation);
    }
    if (loop_xyz[1]>range_xyz[1][0]) {
        translation=[0,-(L_great_rhombicuboctahedron+size1),0];
        shape(loop_xyz,range_xyz,omnitruncated_cubic_offsets,octagonal_prism_xz_vertices,octagonal_prism_edges,dup_check,false,translation);
    }
    if (loop_xyz[2]>range_xyz[2][0]) {
        translation=[0,0,-(L_great_rhombicuboctahedron+size1)];
        shape(loop_xyz,range_xyz,omnitruncated_cubic_offsets,octagonal_prism_xy_vertices,octagonal_prism_edges,dup_check,false,translation);
    }
    shape(loop_xyz,range_xyz,omnitruncated_cubic_offsets,great_rhombicuboctahedron_vertices,great_rhombicuboctahedron_edges,dup_check,true);
}

// cantellated cubic
cantellated_cubic_offsets=[2*L_rhombicuboctahedron,2*L_rhombicuboctahedron,2*L_rhombicuboctahedron];

module cantellated_cubic(loop_xyz,range_xyz,dup_check) {
    shape(loop_xyz,range_xyz,cantellated_cubic_offsets,rhombicuboctahedron_vertices,rhombicuboctahedron_edges,dup_check);
}

// cantitruncated cubic
cantitruncated_cubic_offsets=[2*L_great_rhombicuboctahedron,2*L_great_rhombicuboctahedron,2*L_great_rhombicuboctahedron];

module cantitruncated_cubic(loop_xyz,range_xyz,dup_check) {
    shape(loop_xyz,range_xyz,cantitruncated_cubic_offsets,great_rhombicuboctahedron_vertices,great_rhombicuboctahedron_edges,dup_check);
}

// runcitruncated cubic
runcitruncated_cubic_offsets=[2*L_truncated_cube+size,2*L_truncated_cube+size,2*L_truncated_cube+size];

module runcitruncated_cubic(loop_xyz,range_xyz,dup_check) {
    if (loop_xyz[0]>range_xyz[0][0]) {
        translation=[-(L_truncated_cube+size1),0,0];
        shape(loop_xyz,range_xyz,runcitruncated_cubic_offsets,octagonal_prism_yz_vertices,octagonal_prism_edges,dup_check,false,translation);
    }
    if (loop_xyz[1]>range_xyz[1][0]) {
        translation=[0,-(L_truncated_cube+size1),0];
        shape(loop_xyz,range_xyz,runcitruncated_cubic_offsets,octagonal_prism_xz_vertices,octagonal_prism_edges,dup_check,false,translation);
    }
    if (loop_xyz[2]>range_xyz[2][0]) {
        translation=[0,0,-(L_truncated_cube+size1)];
        shape(loop_xyz,range_xyz,runcitruncated_cubic_offsets,octagonal_prism_xy_vertices,octagonal_prism_edges,dup_check,false,translation);
    }
    shape(loop_xyz,range_xyz,runcitruncated_cubic_offsets,truncated_cube_vertices,truncated_cube_edges,dup_check,true);
}

// cantic cubic
L_cantic_cubic=4*L_truncated_octahedron;

cantic_cubic_offsets=[3*size,3*size1,L_cantic_cubic];

module cantic_cubic(loop_xyz,range_xyz,dup_check) {
    even_y=(abs(loop_xyz[1]+(y_count%2==0?0.5:0)))%2==0;

    translation=even_y?[0,0,0]:[3*size1,0,3*L_truncated_octahedron];
    shape(loop_xyz,range_xyz,cantic_cubic_offsets,truncated_octahedron_xy45_vertices,truncated_octahedron_edges,dup_check,true,translation);
}

// runcic cubic
runcic_cubic_offsets=[L_rhombicuboctahedron+size1,2*(L_rhombicuboctahedron+size1),L_rhombicuboctahedron+size1];

module runcic_cubic(loop_xyz,range_xyz,dup_check) {
    even_x=(loop_xyz[0]+(x_count%2==0?0.5:0))%2==0;
    even_y=(loop_xyz[1]+(y_count%2==0?0.5:0))%2==0;
    even_z=(loop_xyz[2]+(z_count%2==0?0.5:0))%2==0;
    even_x_xor_even_z=(even_x&&!even_z)||(!even_x&&even_z);
    translation=[0,even_x_xor_even_z?0:L_rhombicuboctahedron+size1,0];
    shape(loop_xyz,range_xyz,runcic_cubic_offsets,rhombicuboctahedron_vertices,rhombicuboctahedron_edges,dup_check,true,translation);
}

// runcicantic_cubic
runcicantic_cubic_offsets=[2*L_truncated_cuboctahedron_2+2*L_truncated_cube,2*L_truncated_cuboctahedron_2+2*L_truncated_cube,2*L_truncated_cuboctahedron_2+2*L_truncated_cube];

module runcicantic_cubic(loop_xyz,range_xyz,dup_check) {
    if (loop_xyz[0]>range_xyz[0][0]) {
        translation_x=[-(L_truncated_cube+L_truncated_cuboctahedron_2),0,0];
        shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cube_vertices,truncated_cube_edges,dup_check,false,translation_x);
    }
    if (loop_xyz[1]>range_xyz[1][0]) {
        translation_y=[0,-(L_truncated_cube+L_truncated_cuboctahedron_2),0];
        shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cube_vertices,truncated_cube_edges,dup_check,false,translation_y);
    }
    if (loop_xyz[2]>range_xyz[2][0]) {
        translation_z=[0,0,-(L_truncated_cube+L_truncated_cuboctahedron_2)];
        shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cube_vertices,truncated_cube_edges,dup_check,false,translation_z);
    }
    if (loop_xyz[0]>range_xyz[0][0]&&loop_xyz[1]>range_xyz[1][0]) {
        translation_xy=[-(L_truncated_cube+L_truncated_cuboctahedron_2),-(L_truncated_cube+L_truncated_cuboctahedron_2),0];
        shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cuboctahedron_vertices,truncated_cuboctahedron_edges,dup_check,false,translation_xy);
    }
    if (loop_xyz[0]>range_xyz[0][0]&&loop_xyz[2]>range_xyz[2][0]) {
        translation_xz=[-(L_truncated_cube+L_truncated_cuboctahedron_2),0,-(L_truncated_cube+L_truncated_cuboctahedron_2)];
        shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cuboctahedron_vertices,truncated_cuboctahedron_edges,dup_check,false,translation_xz);
    }
    if (loop_xyz[1]>range_xyz[1][0]&&loop_xyz[2]>range_xyz[2][0]) {
        translation_yz=[0,-(L_truncated_cube+L_truncated_cuboctahedron_2),-(L_truncated_cube+L_truncated_cuboctahedron_2)];
        shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cuboctahedron_vertices,truncated_cuboctahedron_edges,dup_check,false,translation_yz);
    }
    if (loop_xyz[0]>range_xyz[0][0]&&loop_xyz[1]>range_xyz[1][0]&&loop_xyz[2]>range_xyz[2][0]) {
        translation_xyz=[-(L_truncated_cube+L_truncated_cuboctahedron_2),-(L_truncated_cube+L_truncated_cuboctahedron_2),-(L_truncated_cube+L_truncated_cuboctahedron_2)];
        shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cube_vertices,truncated_cube_edges,dup_check,false,translation_xyz);
    }
    shape(loop_xyz,range_xyz,runcicantic_cubic_offsets,truncated_cuboctahedron_vertices,truncated_cuboctahedron_edges,dup_check);
}

////////

function dup_search(element,vector,loop=0) =
    (loop == len(vector)) ?
        -1
    :
        (element==vector[loop]) ?
            loop
        :
            dup_search(element,vector,loop+1)
;

function check_dup_vertex(vertex,dup_check) =
    dup_search(vertex,dup_check[0]) > -1
;

function check_dup_edge(edge,dup_check) =
    dup_search(edge,dup_check[1]) > -1
;

function add_dups(dup_check,vertices,edges,translation) =
    let (
        new_vertices = [for (vertex = vertices) if (!check_dup_vertex(vertex+translation,dup_check)) (vertex+translation)],
        new_edges = [for (edge = edges) if (!check_dup_edge(normalize_translate_edge(edge, vertices, translation),dup_check)) normalize_translate_edge(edge, vertices, translation)]
    )
    [
        concat(dup_check[0],new_vertices),
        concat(dup_check[1],new_edges)
    ]
;

module draw_vertex(vertex) {
    translate(vertex)
    sphere(r=edge_radius,$fn=edge_fn,center=true);
}

module draw_edge(edge) {
    c=edge[0]-edge[1];
    distance = norm(c);

    if (distance > 0) {
        angle_z = (c[0] == 0 && c[1] == 0) ? 0 : atan(c[1]/c[0]);
        angle_y = acos(c[2]/distance);
        translate(edge[1]+c/2) 
        rotate([0,angle_y,angle_z])
        cylinder(r=edge_radius,$fn=edge_fn,h=distance,center=true);
    }
}

module shape_vertices(vertices,translation,dup_check) {
    for (loop_vertex=[0:len(vertices)-1]) {
        vertex=vertices[loop_vertex]+translation;
        is_dup = (preview==0) && check_dup_vertex(vertex,dup_check);
        if (!is_dup) {
            draw_vertex(vertex);
        }
    }
}

function normalize_translate_edge(edge, vertices, translation) =
    let (
        v1=vertices[edge[0]],
        v2=vertices[edge[1]],
        rev=((v2[0]>v1[0])||(v2[0]==v1[0]&&v2[1]>v1[1])||(v2[0]==v1[0]&&v2[1]==v1[1]&&v2[2]>v1[2])),
        s1=rev?v2:v1,
        s2=rev?v1:v2
    )
    [s1+translation,s2+translation]
;

module shape_edges(vertices,edges,translation,dup_check) {
    for (loop_edge=[0:len(edges)-1]) {
        edge=normalize_translate_edge(edges[loop_edge], vertices, translation);
        is_dup = (preview==0) && check_dup_edge(edge,dup_check);
        if (!is_dup) {
            draw_edge(edge);
        }
    }
}

module shape(loop_xyz,range_xyz,offsets,vertices,edges,dup_check,recurse=true,translation=[0,0,0]) {
    translation__=[loop_xyz[0]*offsets[0]+translation[0],loop_xyz[1]*offsets[1]+translation[1],loop_xyz[2]*offsets[2]+translation[2]];
    shape_vertices(vertices,translation__,dup_check);
    shape_edges(vertices,edges,translation__,dup_check);
    change_y=(loop_xyz[2]==range_xyz[2][1]);
    change_x=change_y&&(loop_xyz[1]==range_xyz[1][1]);
    done=change_x&&(loop_xyz[0]==range_xyz[0][1]);
    if ((preview==0) && recurse && !done) {
        new_loop_x=change_x?loop_xyz[0]+1:loop_xyz[0];
        new_loop_y=change_x?range_xyz[1][0]:change_y?loop_xyz[1]+1:loop_xyz[1];
        new_loop_z=change_y?range_xyz[2][0]:loop_xyz[2]<range_xyz[2][1]?loop_xyz[2]+1:loop_xyz[2];
        new_loop_xyz=[new_loop_x,new_loop_y,new_loop_z];
        new_dup_check = add_dups(dup_check,vertices,edges,translation__);
        choose_shape(new_loop_xyz,range_xyz,new_dup_check);
    }
}

module choose_shape(loop_xyz,range_xyz,dup_check) {
    if (shape == CUBIC) {
        cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == TRIANGULAR_PRISM) {
        triangular_prism(loop_xyz,range_xyz,dup_check);
    } else if (shape == HEXAGONAL_PRISM) {
        hexagonal_prism(loop_xyz,range_xyz,dup_check);
    } else if (shape == BITRUNCATED_CUBIC) {
        bitruncated_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == GYROBIFASTIGIUM) {
        gyrobifastigium(loop_xyz,range_xyz,dup_check);
    } else if (shape == RHOMBIC_DODECAHEDRON) {
        rhombic_dodecahedron(loop_xyz,range_xyz,dup_check);
    } else if (shape == ELONGATED_DODECAHEDRON) {
        elongated_dodecahedron(loop_xyz,range_xyz,dup_check);
    } else if (shape == ALTERNATED_CUBIC) {
        alternated_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == QUARTER_CUBIC) {
        quarter_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == TRUNCATED_CUBIC) {
        truncated_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == RECTIFIED_CUBIC) {
        rectified_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == OMNITRUNCATED_CUBIC) {
        omnitruncated_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == CANTELLATED_CUBIC) {
        cantellated_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == CANTITRUNCATED_CUBIC) {
        cantitruncated_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == RUNCITRUNCATED_CUBIC) {
        runcitruncated_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == CANTIC_CUBIC) {
        cantic_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == RUNCIC_CUBIC) {
        runcic_cubic(loop_xyz,range_xyz,dup_check);
    } else if (shape == RUNCICANTIC_CUBIC) {
        runcicantic_cubic(loop_xyz,range_xyz,dup_check);
    }
}

dup_check=[[],[]];
lim_x = (x_count-1)/2;
range_x=[-lim_x,lim_x];
lim_y = (y_count-1)/2;
range_y=[-lim_y,lim_y];
lim_z = (z_count-1)/2;
range_z=[-lim_z,lim_z];
range_xyz=[range_x,range_y,range_z];
if (preview==0) {
    loop_xyz=[-lim_x,-lim_y,-lim_z];
    choose_shape(loop_xyz,range_xyz,dup_check);
} else {
    for (loop_x=[-lim_x:lim_x])
        for (loop_y=[-lim_y:lim_y])
            for (loop_z=[-lim_z:lim_z]) {
                loop_xyz=[loop_x,loop_y,loop_z];
                choose_shape(loop_xyz,range_xyz,undef);
            }
}


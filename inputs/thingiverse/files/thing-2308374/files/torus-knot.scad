p = 2;
q = 3;
phi_step = 0.05;
star_radius = 0.5;

/* [Hidden] */

// private commom-based API

function __to2d(p) = [p[0], p[1]];

function __to3d(p) = [p[0], p[1], 0];
    
function __is_vector(value) = !(value >= "") && len(value) != undef; 

/**
* rotate_p.scad
*
* Rotates a point 'a' degrees around an arbitrary axis. 
* The rotation is applied in the following order: x, y, z. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html
*
**/ 

function _rotx(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0], 
        pt[1] * cosa - pt[2] * sina,
        pt[1] * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa + pt[2] * sina, 
        pt[1],
        -pt[0] * sina + pt[2] * cosa, 
    ];

function _rotz(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa - pt[1] * sina,
        pt[0] * sina + pt[1] * cosa,
        pt[2]
    ];

function _rotate_p_3d(point, a) =
    _rotz(_roty(_rotx(point, a[0]), a[1]), a[2]);

function to_avect(a) =
     len(a) == 3 ? a : (
         len(a) == 2 ? [a[0], a[1], 0] : (
             len(a) == 1 ? [a[0], 0, 0] : [0, 0, a]
         ) 
     );

function rotate_p(point, a) =
    let(angle = to_avect(a))
    len(point) == 3 ? 
        _rotate_p_3d(point, angle) :
        __to2d(
            _rotate_p_3d(__to3d(point), angle)
        );

        
/**
* polysections.scad
*
* Crosscutting a tube-like shape at different points gets several cross-sections.
* This module can operate reversely. It uses cross-sections to construct a tube-like shape.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html
*
**/

module polysections(sections, triangles = "SOLID") {
    module solid_sections() {
        leng_sections = len(sections);
        leng_pts_section = len(sections[0]);
        
        side_idxes = [
                for(j = [0:leng_pts_section:(leng_sections - 2) * leng_pts_section])
                    for(i = [0:leng_pts_section - 1]) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_section, 
                            j + (i + 1) % leng_pts_section + leng_pts_section , 
                            j + i + leng_pts_section
                        ]
             ];

        first_idxes = [for(i = [0:leng_pts_section - 1]) i];   
        
        last_idxes = [
            for(i = [0:leng_pts_section - 1]) 
                i + leng_pts_section * (leng_sections - 1)
        ];    
        
        v_pts = [
            for(section = sections) 
                for(pt = section) 
                    pt
        ];
        
       polyhedron(
           v_pts, 
           concat([first_idxes], side_idxes, [last_idxes])
       );    
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 4, 5], 
                    [0, 1, 4], [1, 2, 5], [2, 0, 3], 
                    [0, 3, 4], [1, 4, 5], [2, 5, 3]
                ]
            );  
        }
        
        function hollow_tris() = 
            let(
                leng_section = len(sections[0]),
                inner_i_begin = leng_section / 2,
                idxes = concat(
                    [
                        for(i = [0:inner_i_begin - 1]) 
                            let(n = inner_i_begin + i + 1)
                            [i, inner_i_begin + i, n % inner_i_begin + inner_i_begin]
                    ],
                    [
                        for(i = [0:inner_i_begin - 1]) 
                            let(n = inner_i_begin + i + 1)
                            [i, i + 1, n % leng_section]
                    ]
                )
            ) idxes; 

        function tris() =
            triangles == "HOLLOW" ? hollow_tris() : triangles;

        module two_sections(section1, section2) {
            for(idx = tris()) {
                // hull is for preventing from WARNING: Object may not be a valid 2-manifold
                hull() tri_sections(
                    [
                        section1[idx[0]], 
                        section1[idx[1]], 
                        section1[idx[2]]
                    ], 
                    [
                        section2[idx[0]], 
                        section2[idx[1]], 
                        section2[idx[2]]
                    ]
                );
            }
        }
        
        for(i = [0:len(sections) - 2]) {
             two_sections(
                 sections[i], 
                 sections[i + 1]
             );
        }
    }
    
    //
    if(triangles == "SOLID") {
        solid_sections();
    } else {
        triangles_defined_sections();
    }
}

/**
* cross_sections.scad
*
* Given a starting cross-section, points and angles along the path, this function
* will return all cross-sections.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-cross_sections.html
*
**/

function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        scale_step_vt = __is_vector(scale) ? 
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one] :
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one],
        scale_step_x = scale_step_vt[0],
        scale_step_y = scale_step_vt[1],
        twist_step = twist / len_path_pts_minus_one
    )
    [
        for(i = [0:len_path_pts_minus_one])
            [
                for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                    rotate_p(
                        rotate_p(scaled_p, twist_step * i)
                        , angles[i]
                    ) + pth_pts[i]
            ]
    ];

/**
* shape_pentagram.scad
*
* Returns shape points of a pentagram.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/

function shape_pentagram(r) =
    [
        [0, 1], [-0.224514, 0.309017], 
        [-0.951057, 0.309017], [-0.363271, -0.118034], 
        [-0.587785, -0.809017], [0, -0.381966], 
        [0.587785, -0.809017], [0.363271, -0.118034], 
        [0.951057, 0.309017], [0.224514, 0.309017]
    ] * r;
    
/**
* path_extrude.scad
*
* It extrudes a 2D shape along a path. 
* This module is suitable for a path created by a continuous function.
* It depends on the rotate_p function and the polysections module. 
* Remember to include "rotate_p.scad" and "polysections.scad".
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html
*
**/

module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false) {
    sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)];

    len_path_pts = len(path_pts);    
    len_path_pts_minus_one = len_path_pts - 1;     

    scale_step_vt = __is_vector(scale) ? 
        [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one] :
        [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one];

    scale_step_x = scale_step_vt[0];
    scale_step_y = scale_step_vt[1];
    twist_step = twist / len_path_pts_minus_one;

    function first_section() = 
        let(
            p1 = path_pts[0], 
            p2 = path_pts[1],
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = sh_pts) 
                rotate_p(p, [0, ay, az]) + p1
        ];

    function section(p1, p2, i) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2)),
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                rotate_p(
                     rotate_p(scaled_p, twist_step * i) + [0, 0, length], 
                     [0, ay, az]
                ) + p1
        ];
    
    function path_extrude_inner(index) =
       index == len_path_pts ? [] :
           concat(
               [section(path_pts[index - 1], path_pts[index],  index)],
               path_extrude_inner(index + 1)
           );

    if(closed && path_pts[0] == path_pts[len_path_pts_minus_one]) {
        // round-robin
        sections = path_extrude_inner(1);
        polysections(
            concat(sections, [sections[0]]),
            triangles = triangles
        );   
    } else {
        polysections(
            concat([first_section()], path_extrude_inner(1)),
            triangles = triangles
        ); 
    }
}

module torus_knot(p, q, phi_step, star_radius) {
    pts = [
        for(phi = [0:phi_step:6.28318])
        let(
            degree = phi * 180 / 3.14159,
            r = cos(q * degree) + 2,
            x = r * cos(p * degree),
            y = r * sin(p * degree),
            z = -sin(q * degree)
        )
        [x, y, z]
    ];

    shape_pentagram_pts = shape_pentagram(star_radius);

    path_extrude(
        shape_pentagram_pts, 
        concat(pts, [pts[0]]), 
        closed = true
    );
}

torus_knot(p, q, phi_step, star_radius);
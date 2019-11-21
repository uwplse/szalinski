/* [Superformula] */
phi_step = 0.025;
m = 16;
n = 5;
n3 = 8;

/* [Offset] */
d = 0.025;

/* [Curve] */
r1 = 1;
r2 = 2;
h1 = 4;
h2 = 8;
t_step = 0.05;
twist = 90;

module superformula_vase(phi_step, m, n, n3, d, r1, r2, h1, h2, t_step, twist) {

    shape_pts = shape_superformula(phi_step, m, m, n, n, n3);
    outer_shape_pts = bijection_offset(shape_pts, d);

    all = concat(outer_shape_pts, shape_pts);

    offset_v = outer_shape_pts[0] - shape_pts[0];

    ctrl_pts = [
        [1, 0, 0],
        [4, 0, 2],
        [2, 0, 3],
        [r1, 0, h1],
        [1, 0, 5],
        [r2, 0, h2],
    ];
    ctrl_pts2 = [for(p = ctrl_pts) p + [offset_v[0], offset_v[1], 0]];

    path = bezier_curve(t_step, ctrl_pts2);

    leng = len(path);
    twist_step = twist / leng;

    sections = path_scaling_sections(all, path);
    twisted_sections = [
        for(i = [0:leng - 1]) 
            [for(p = sections[i]) rotate_p(p, twist_step * i)]
    ];

    polysections(twisted_sections, "HOLLOW");
    rotate(-twist_step) linear_extrude(d) offset(d) polygon(shape_pts);
}

superformula_vase(phi_step, m, n, n3, d, r1, r2, h1, h2, t_step, twist);
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

/**
* shape_superformula.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_superformula.html
*
**/ 


function _superformula_r(angle, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
    pow(
        pow(abs(cos(m1 * angle / 4) / a), n2) + 
        pow(abs(sin(m2 * angle / 4) / b), n3),
        - 1 / n1    
    );

function shape_superformula(phi_step, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
   [
        for(phi = [0:phi_step:6.28318]) 
            let(
                angle = __to_degree(phi),
                r = _superformula_r(angle, m1, m2, n1, n2, n3, a, b)
                
            )
            __ra_to_xy(r, angle)
   ];

function _bijection_edges_from(pts) = 
    let(leng = len(pts))
    concat(
        [for(i = [0:leng - 2]) [pts[i], pts[i + 1]]], 
        [[pts[len(pts) - 1], pts[0]]]
    );
    
function _bijection_inward_edge_normal(edge) =  
    let(
        pt1 = edge[0],
        pt2 = edge[1],
        dx = pt2[0] - pt1[0],
        dy = pt2[1] - pt1[1],
        edge_leng = norm([dx, dy])
    )
    [-dy / edge_leng, dx / edge_leng];

function _bijection_outward_edge_normal(edge) = -1 * _bijection_inward_edge_normal(edge);

function _bijection_offset_edge(edge, dx, dy) = 
    let(
        pt1 = edge[0],
        pt2 = edge[1],
        dxy = [dx, dy]
    )
    [pt1 + dxy, pt2 + dxy];
    
function _bijection__bijection_offset_edges(edges, d) = 
    [ 
        for(edge = edges)
        let(
            ow_normal = _bijection_outward_edge_normal(edge),
            dx = ow_normal[0] * d,
            dy = ow_normal[1] * d
        )
        _bijection_offset_edge(edge, dx, dy)
    ];
    

function _bijection__bijection__bijection_offset_edges_intersection(edge1, edge2) = 
    let(
        den = (edge2[1][1] - edge2[0][1]) * (edge1[1][0] - edge1[0][0]) - (edge2[1][0] - edge2[0][0]) * (edge1[1][1] - edge1[0][1])
    )
    // when den is 0, they are parallel or conincident edges
    den == 0 ? [] : _bijection_offset__bijection__bijection__bijection_offset_edges_intersection_sub(edge1, edge2, den);

function _bijection_offset__bijection__bijection__bijection_offset_edges_intersection_sub(edge1, edge2, den) = 
    let(
        ua = ((edge2[1][0] - edge2[0][0]) * (edge1[0][1] - edge2[0][1]) - (edge2[1][1] - edge2[0][1]) * (edge1[0][0] - edge2[0][0])) / den
    ) 
    [
        edge1[0][0] + ua * (edge1[1][0] - edge1[0][0]),
        edge1[0][1] + ua * (edge1[1][1] - edge1[0][1])
    ];

function bijection_offset(pts, d) = 
    let(
        es = _bijection_edges_from(pts), 
        offset_es = _bijection__bijection_offset_edges(es, d),
        leng = len(offset_es),
        last_p = _bijection__bijection__bijection_offset_edges_intersection(offset_es[leng - 1], offset_es[0])
    )
    concat(
        [
            for(i = [0:leng - 2]) 
            let(
                this_edge = offset_es[i],
                next_edge = offset_es[i + 1],
                p = _bijection__bijection__bijection_offset_edges_intersection(this_edge, next_edge)
            )
            // p == p to avoid [nan, nan], because [nan, nan] != [nan, nan]
            if(p != [] && p == p) p
        ],
        last_p != [] && last_p == last_p ? [last_p] : []
    );
    
function path_scaling_sections(shape_pts, edge_path) = 
    let(
        start_point = edge_path[0],
        base_leng = norm(start_point),
        scaling_matrice = [
            for(p = edge_path) 
            let(s = norm([p[0], p[1], 0]) / base_leng)
            m_scaling([s, s, 1])
        ]
    )
    __reverse([
        for(i = [0:len(edge_path) - 1])
        [
            for(p = shape_pts) 
            let(scaled_p = scaling_matrice[i] * [p[0], p[1], edge_path[i][2], 1])
            [scaled_p[0], scaled_p[1], scaled_p[2]]
        ]
    ]);

/**
* rotate_p.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html
*
**/ 


function _q_rotate_p_3d(p, a, v) = 
    let(
        half_a = a / 2,
        axis = v / norm(v),
        s = sin(half_a),
        x = s * axis[0],
        y = s * axis[1],
        z = s * axis[2],
        w = cos(half_a),
        
        x2 = x + x,
        y2 = y + y,
        z2 = z + z,

        xx = x * x2,
        yx = y * x2,
        yy = y * y2,
        zx = z * x2,
        zy = z * y2,
        zz = z * z2,
        wx = w * x2,
        wy = w * y2,
        wz = w * z2        
    )
    [
        [1 - yy - zz, yx - wz, zx + wy] * p,
        [yx + wz, 1 - xx - zz, zy - wx] * p,
        [zx - wy, zy + wx, 1 - xx - yy] * p
    ];

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

function _rotate_p(p, a) =
    let(angle = __to_ang_vect(a))
    len(p) == 3 ? 
        _rotate_p_3d(p, angle) :
        __to2d(
            _rotate_p_3d(__to3d(p), angle)
        );


function _q_rotate_p(p, a, v) =
    len(p) == 3 ? 
        _q_rotate_p_3d(p, a, v) :
        __to2d(
            _q_rotate_p_3d(__to3d(p), a, v)
        );

function rotate_p(point, a, v) =
    v == undef ? _rotate_p(point, a) : _q_rotate_p(point, a, v);


function __to2d(p) = [p[0], p[1]];

function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : (
         leng == 2 ? [a[0], a[1], 0] :  [a[0], 0, 0]
     );

function __to_ang_vect(a) = __is_float(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

function __reverse(vt) = 
    let(leng = len(vt))
    [
        for(i = [0:leng - 1])
            vt[leng - 1 - i]
    ];

/**
* m_scaling.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-m_scaling.html
*
**/


function _to_3_elems_scaling_vect(s) =
     let(leng = len(s))
     leng == 3 ? s : (
         leng == 2 ? [s[0], s[1], 1] : [s[0], 1, 1]
     );

function _to_scaling_vect(s) = __is_float(s) ? [s, s, s] : _to_3_elems_scaling_vect(s);

function m_scaling(s) = 
    let(v = _to_scaling_vect(s))
    [
        [v[0], 0, 0, 0],
        [0, v[1], 0, 0],
        [0, 0, v[2], 0],
        [0, 0, 0, 1]
    ];

function __to3d(p) = [p[0], p[1], 0];

function __to_degree(phi) = 180 / 3.14159 * phi;

/**
* polysections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html
*
**/


module polysections(sections, triangles = "SOLID") {

    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0])
        ) 
        concat(
            [
                for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                    for(i = [0:leng_pts_sect - 1]) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect
                        ]
            ],
            [
                for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                    for(i = [0:leng_pts_sect - 1]) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                            j + i + leng_pts_sect
                        ]
            ]      
        );

    function search_at(f_sect, p, leng_pts_sect, i = 0) =
        i < leng_pts_sect ?
            (p == f_sect[i] ? i : search_at(f_sect, p, leng_pts_sect, i + 1)) : -1;
    
    function the_same_after_twisting(f_sect, l_sect, leng_pts_sect) =
        let(
            found_at_i = search_at(f_sect, l_sect[0], leng_pts_sect)
        )
        found_at_i <= 0 ? false : 
            l_sect == concat(
                [for(i = [found_at_i:leng_pts_sect-1]) f_sect[i]],
                [for(i = [0:found_at_i - 1]) f_sect[i]]
            ); 

    function to_v_pts(sects) = 
            [
            for(sect = sects) 
                for(pt = sect) 
                    pt
            ];                   

    module solid_sections(sects) {
        
        leng_sects = len(sects);
        leng_pts_sect = len(sects[0]);
        first_sect = sects[0];
        last_sect = sects[leng_sects - 1];
   
        v_pts = [
            for(sect = sects) 
                for(pt = sect) 
                    pt
        ];

        function begin_end_the_same() =
            first_sect == last_sect || 
            the_same_after_twisting(first_sect, last_sect, leng_pts_sect);

        if(begin_end_the_same()) {
            f_idxes = side_indexes(sects);

            polyhedron(
                v_pts, 
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);
        } else {
            first_idxes = [for(i = [0:leng_pts_sect - 1]) leng_pts_sect - 1 - i];  
            last_idxes = [
                for(i = [0:leng_pts_sect - 1]) 
                    i + leng_pts_sect * (leng_sects - 1)
            ];    

            f_idxes = concat([first_idxes], side_indexes(sects), [last_idxes]);
            
            polyhedron(
                v_pts, 
                f_idxes
            );   

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);             
        }
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            [
                for(i = [0:leng_sects - 1]) 
                    [
                        for(j = [begin_idx:end_idx])
                            sects[i][j]
                    ]
            ]; 

        function first_idxes() = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                       i,
                       i + half_leng_v_pts,
                       (i + 1) % half_leng_sect + half_leng_v_pts, 
                       (i + 1) % half_leng_sect
                    ] 
            ];

        function last_idxes(begin_idx) = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                       begin_idx + i,
                       begin_idx + (i + 1) % half_leng_sect,
                       begin_idx + (i + 1) % half_leng_sect + half_leng_v_pts,
                       begin_idx + i + half_leng_v_pts
                    ]     
            ];            

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        outer_v_pts =  to_v_pts(outer_sects);
        inner_v_pts = to_v_pts(inner_sects);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = [ 
            for(idxes = side_indexes(inner_sects, half_leng_v_pts))
                __reverse(idxes)
        ];

        first_outer_sect = outer_sects[0];
        last_outer_sect = outer_sects[leng_sects - 1];
        first_inner_sect = inner_sects[0];
        last_inner_sect = inner_sects[leng_sects - 1];
        
        leng_pts_sect = len(first_outer_sect);

        function begin_end_the_same() = 
           (first_outer_sect == last_outer_sect && first_inner_sect == last_inner_sect) ||
           (
               the_same_after_twisting(first_outer_sect, last_outer_sect, leng_pts_sect) && 
               the_same_after_twisting(first_inner_sect, last_inner_sect, leng_pts_sect)
           ); 

        v_pts = concat(outer_v_pts, inner_v_pts);

        if(begin_end_the_same()) {
            f_idxes = concat(outer_idxes, inner_idxes);

            polyhedron(
                v_pts,
                f_idxes
            );      

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);                     
        } else {
            first_idxes = first_idxes();
            last_idxes = last_idxes(half_leng_v_pts - half_leng_sect);

            f_idxes = concat(first_idxes, outer_idxes, inner_idxes, last_idxes);
            
            polyhedron(
                v_pts,
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);              
        }
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            hull() polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 5, 4], 
                    [1, 3, 4], [2, 1, 4], [2, 3, 0], 
                    [0, 3, 1], [2, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
               tri_sections(
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
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

// override it to test

module test_polysections_solid(points, faces) {

}

function __is_float(value) = value + 0 != undef;

/**
* bezier_curve.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_curve.html
*
**/ 


function _combi(n, k) =
    let(  
        bi_coef = [      
               [1],     // n = 0: for padding
              [1,1],    // n = 1: for Linear curves, how about drawing a line directly?
             [1,2,1],   // n = 2: for Quadratic curves
            [1,3,3,1]   // n = 3: for Cubic Bézier curves
        ]  
    )
    n < len(bi_coef) ? bi_coef[n][k] : (
        k == 0 ? 1 : (_combi(n, k - 1) * (n - k + 1) / k)
    );
        
function bezier_curve_coordinate(t, pn, n, i = 0) = 
    i == n + 1 ? 0 : 
        (_combi(n, i) * pn[i] * pow(1 - t, n - i) * pow(t, i) + 
            bezier_curve_coordinate(t, pn, n, i + 1));
        
function _bezier_curve_point(t, points) = 
    let(n = len(points) - 1) 
    [
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[0]], 
            n
        ),
        bezier_curve_coordinate(
            t,  
            [for(p = points) p[1]], 
            n
        ),
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[2]], 
            n
        )
    ];

function bezier_curve(t_step, points) = 
    let(
        pts = concat([
            for(t = [0: ceil(1 / t_step) - 1])
                _bezier_curve_point(t * t_step, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];



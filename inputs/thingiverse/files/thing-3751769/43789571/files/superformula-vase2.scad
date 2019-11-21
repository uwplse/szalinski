
/* [Superformula] */
phi_step = 0.025;
m = 8;
n = 5;
n3 = 8;

/* [Offset] */
d = 0.1;

/* [Curve] */
r1 = 1;
r2 = 2;
h1 = 5;
h2 = 8;
t_step = 0.025;
twist = 90;

module superformula_vase(phi_step, m, n, n3, d, r1, r2, h1, h2, t_step, twist) {

    function cal_sections(shapt_pts, edge_path, twist) =
        let(
            sects = path_scaling_sections(shapt_pts, edge_path),
            leng = len(sects),
            twist_step = twist / leng
        )
        [
            for(i = [0:leng - 1]) 
            [
                for(p = sects[i]) 
                    rotate_p(p, twist_step * i)        
            ]
        ];

    superformula = shape_superformula(phi_step, m, m, n, n, n3);

    edge_path = bezier_curve(t_step, [
        [1, 0, 0],
        [4, 0, 3],
        [2, 0, 4],
        [r1, 0, h1],
        [1, 0, 6],
        [r2, 0, h2],
    ]);

    offseted = bijection_offset(superformula, d);

    edge_path2 = [for(p = edge_path) p + [d, 0, 0]];
    superformula2 = trim_shape(offseted, 3, len(offseted) - 1, epsilon = 0.0001);

    sections = cal_sections(superformula, edge_path, twist);
    outer_sections = cal_sections(superformula2, edge_path2, twist);

    difference() {
        polysections(outer_sections);
        polysections(sections);
    }

    linear_extrude(d) 
        rotate(twist - twist / len(sections)) 
            polygon(superformula2);    
}

superformula_vase(phi_step, m, n, n3, d, r1, r2, h1, h2, t_step, twist);
    
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

function __to_degree(phi) = 180 / PI * phi;

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
    is_undef(v) ? _rotate_p(point, a) : _q_rotate_p(point, a, v);


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
            leng_pts_sect = len(sects[0]),
            range_j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect],
            range_i = [0:leng_pts_sect - 1]
        ) 
        concat(
            [
                for(j = range_j)
                    for(i = range_i) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect
                        ]
            ],
            [
                for(j = range_j)
                    for(i = range_i) 
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
                [for(i = found_at_i; i < leng_pts_sect; i = i + 1) f_sect[i]],
                [for(i = 0; i < found_at_i; i = i + 1) f_sect[i]]
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

        begin_end_the_same =
            first_sect == last_sect || 
            the_same_after_twisting(first_sect, last_sect, leng_pts_sect);

        if(begin_end_the_same) {
            f_idxes = side_indexes(sects);

            polyhedron(
                v_pts, 
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);
        } else {
            range_i = [0:leng_pts_sect - 1];
            first_idxes = [for(i = range_i) leng_pts_sect - 1 - i];  
            last_idxes = [
                for(i = range_i) 
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
                for(i = 0; i < leng_sects; i = i + 1) 
                    [
                        for(j = begin_idx; j <= end_idx; j = j + 1)
                            sects[i][j]
                    ]
            ]; 

        function first_idxes() = 
            [
                for(i = 0; i < half_leng_sect; i = i + 1) 
                    [
                       i,
                       i + half_leng_v_pts,
                       (i + 1) % half_leng_sect + half_leng_v_pts, 
                       (i + 1) % half_leng_sect
                    ] 
            ];

        function last_idxes(begin_idx) = 
            [
                for(i = 0; i < half_leng_sect; i = i + 1) 
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

        begin_end_the_same = 
           (first_outer_sect == last_outer_sect && first_inner_sect == last_inner_sect) ||
           (
               the_same_after_twisting(first_outer_sect, last_outer_sect, leng_pts_sect) && 
               the_same_after_twisting(first_inner_sect, last_inner_sect, leng_pts_sect)
           ); 

        v_pts = concat(outer_v_pts, inner_v_pts);

        if(begin_end_the_same) {
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

function __to3d(p) = [p[0], p[1], 0];

function __lines_from(pts, closed = false) = 
    let(
        leng = len(pts),
        endi = leng - 1
    )
    concat(
        [for(i = 0; i < endi; i = i + 1) [pts[i], pts[i + 1]]], 
        closed ? [[pts[len(pts) - 1], pts[0]]] : []
    );
    

function __line_intersection(line_pts1, line_pts2, epsilon = 0.0001) = 
    let(
        a1 = line_pts1[0],
        a2 = line_pts1[1],
        b1 = line_pts2[0],
        b2 = line_pts2[1],
        a = a2 - a1, 
        b = b2 - b1, 
        s = b1 - a1
    )
    abs(cross(a, b)) < epsilon ? [] :  // they are parallel or conincident edges
        a1 + a * cross(s, b) / cross(a, b);

function __m_scaling_to_3_elems_scaling_vect(s) =
     let(leng = len(s))
     leng == 3 ? s : (
         leng == 2 ? [s[0], s[1], 1] : [s[0], 1, 1]
     );

function __m_scaling_to_scaling_vect(s) = is_num(s) ? [s, s, s] : __m_scaling_to_3_elems_scaling_vect(s);

function __m_scaling(s) = 
    let(v = __m_scaling_to_scaling_vect(s))
    [
        [v[0], 0, 0, 0],
        [0, v[1], 0, 0],
        [0, 0, v[2], 0],
        [0, 0, 0, 1]
    ];

/**
* bijection_offset.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bijection_offset.html
*
**/

    
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

function bijection_offset(pts, d, epsilon = 0.0001) = 
    let(
        es = __lines_from(pts, true), 
        offset_es = _bijection__bijection_offset_edges(es, d),
        leng = len(offset_es),
        last_p = __line_intersection(offset_es[leng - 1], offset_es[0], epsilon)
    )
    concat(
        [
            for(i = 0; i < leng - 1; i = i + 1)
            let(
                this_edge = offset_es[i],
                next_edge = offset_es[i + 1],
                p = __line_intersection(this_edge, next_edge, epsilon)
            )
            // p == p to avoid [nan, nan], because [nan, nan] != [nan, nan]
            if(p != [] && p == p) p
        ],
        last_p != [] && last_p == last_p ? [last_p] : []
    );
    

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

function __to2d(p) = [p[0], p[1]];

function __in_line(line_pts, pt, epsilon = 0.0001) =
    let(
        pts = len(line_pts[0]) == 2 ? [for(p = line_pts) __to3d(p)] : line_pts,
        pt3d = len(pt) == 2 ? __to3d(pt) : pt,
        v1 = pts[0] - pt3d, 
        v2 = pts[1] - pt3d
    )
    (norm(cross(v1, v2)) < epsilon) && ((v1 * v2) <= epsilon);

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
   let(tau = PI * 2)
   [
        for(phi = 0; phi <= tau; phi = phi + phi_step) 
            let(
                angle = __to_degree(phi),
                r = _superformula_r(angle, m1, m2, n1, n2, n3, a, b)
            )
            __ra_to_xy(r, angle)
   ];

/**
* path_scaling_sections.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_scaling_sections.html
*
**/


function path_scaling_sections(shape_pts, edge_path) = 
    let(
        start_point = edge_path[0],
        base_leng = norm(start_point),
        scaling_matrice = [
            for(p = edge_path) 
            let(s = norm([p[0], p[1], 0]) / base_leng)
            __m_scaling([s, s, 1])
        ],
        leng_edge_path = len(edge_path)
    )
    __reverse([
        for(i = 0; i < leng_edge_path; i = i + 1)
        [
            for(p = shape_pts) 
            let(scaled_p = scaling_matrice[i] * [p[0], p[1], edge_path[i][2], 1])
            [scaled_p[0], scaled_p[1], scaled_p[2]]
        ]
    ]);

function __reverse(vt) = [for(i = len(vt) - 1; i >= 0; i = i - 1) vt[i]];

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
            for(t = 0; t < ceil(1 / t_step); t = t + 1)
                _bezier_curve_point(t * t_step, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];


/**
* trim_shape.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-trim_shape.html
*
**/


function _trim_shape_any_intersection_sub(lines, line, lines_leng, i, epsilon) =
    let(
        p = __line_intersection(lines[i], line, epsilon)
    )
    (p != [] && __in_line(line, p, epsilon) && __in_line(lines[i], p, epsilon)) ? [i, p] : _trim_shape_any_intersection(lines, line, lines_leng, i + 1, epsilon);

// return [idx, [x, y]] or []
function _trim_shape_any_intersection(lines, line, lines_leng, i, epsilon) =
    i == lines_leng ? [] : _trim_shape_any_intersection_sub(lines, line, lines_leng, i, epsilon);

function _trim_sub(lines, leng, epsilon) = 
    let(
        current_line = lines[0],
        next_line = lines[1],
        lines_from_next = [for(j = 1; j < leng; j = j + 1) lines[j]],
        lines_from_next2 = [for(j = 2; j < leng; j = j + 1) lines[j]],
        current_p = current_line[0],
        leng_lines_from_next2 = len(lines_from_next2),
        inter_p = _trim_shape_any_intersection(lines_from_next2, current_line, leng_lines_from_next2, 0, epsilon)
    )
    // no intersecting pt, collect current_p and trim remain lines
    inter_p == [] ? (concat([current_p], _trim_shape_trim_lines(lines_from_next, epsilon))) : (
        // collect current_p, intersecting pt and the last pt
        (leng == 3 || (inter_p[0] == (leng_lines_from_next2 - 1))) ? [current_p, inter_p[1], lines[leng - 1]] : (
            // collect current_p, intersecting pt and trim remain lines
            concat([current_p, inter_p[1]], 
                _trim_shape_trim_lines([for(i = inter_p[0] + 1; i < leng_lines_from_next2; i = i + 1) lines_from_next2[i]], epsilon)
            )
        )
    );
    
function _trim_shape_trim_lines(lines, epsilon) = 
    let(leng = len(lines))
    leng > 2 ? _trim_sub(lines, leng, epsilon) : _trim_shape_collect_pts_from(lines, leng);

function _trim_shape_collect_pts_from(lines, leng) = 
    concat([for(line = lines) line[0]], [lines[leng - 1][1]]);

function trim_shape(shape_pts, from, to, epsilon = 0.0001) = 
    let(
        pts = [for(i = from; i <= to; i = i + 1) shape_pts[i]],
        trimmed = _trim_shape_trim_lines(__lines_from(pts), epsilon)
    )
    len(shape_pts) == len(trimmed) ? trimmed : trim_shape(trimmed, 0, len(trimmed) - 1, epsilon);


function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : (
         leng == 2 ? [a[0], a[1], 0] :  [a[0], 0, 0]
     );

function __to_ang_vect(a) = is_num(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);


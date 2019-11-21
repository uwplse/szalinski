
radius1 = 10;
radius2 = 20;
bottom_height = 60;
thickness = 1.5;
t_step = 0.025;
fn = 24;
cut = "false"; // [true,false]

module klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn) {
    $fn = fn;

    module bottom() {
        rotate(180) rotate_extrude() {


            translate([radius1 + radius2, 0, 0]) 
                polyline2d(
                     arc_path(radius = radius2, angle = [180, 360])
                     ,thickness
                );
                
            polyline2d(
                bezier_curve(t_step, [
                    [radius1 + radius2 * 2, 0, 0],
                    [radius1 + radius2 * 2, bottom_height * 0.25, 0],
                    [radius1 + radius2 * 0.5, bottom_height * 0.5, 0],
                    [radius1, bottom_height * 0.75, 0],
                    [radius1, bottom_height, 0]            
                ]), 
                thickness
            );      
        }
    }

    module tube() {

        mid_pts = [
            [0, 0, bottom_height + radius1],
            [0, 0, bottom_height + radius1 * 2], 
            [0, radius1, bottom_height + radius1 * 3],
            [0, radius1 * 2, bottom_height + radius1 * 3],
            [0, radius1 * 3, bottom_height + radius1 * 3],
            [0, radius1 * 4, bottom_height + radius1 * 2],  
            [0, radius1 * 4, bottom_height + radius1],
            [0, radius1 * 4, bottom_height], 
            [0, radius1 * 3, bottom_height - radius1], 
            [0, radius1 * 2, bottom_height - radius1 * 2], 
            [0, radius1, bottom_height + thickness / 2 - radius1 * 3], 
            [0, 0, bottom_height - radius1 * 4],
            [0, 0, bottom_height - radius1 * 5]
        ];

        tube_path = bezier_curve(
            t_step, 
            concat(
                concat([[0, 0, bottom_height]], mid_pts), 
                [[0, 0, 0]]
            )
        );

        tube_path2 = bezier_curve(
            t_step, 
            concat(
                concat([[0, 0, bottom_height - thickness]], mid_pts), 
                [[0, 0, -thickness] ]
            )
        );

        difference() { 
            union() {
                bottom(); 

                path_extrude(
                    circle_path(radius1 + thickness / 2),
                    tube_path
                );
            }

            path_extrude(
                circle_path(radius1 - thickness / 2),
                tube_path2
            );
        }

    }

    tube();
}

module cutted_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn) {
    difference() {
            union() {
                translate([radius2 + thickness, 0, 0]) 
                    rotate([0, 90, 0]) klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
                translate([-radius2 - thickness, 0, 0]) 
                    rotate([0, -90, 0]) klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);

                
            }
            
            h = (radius1 + radius2) * 2;
            w = 2 * h;
            l = bottom_height * 4;
            translate([0, 0, h / 2]) 
                    cube([l, w, h], center = true);
        }
}

if(cut == "true") {
    cutted_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
} else {
    klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
}



    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

function __angy_angz(p1, p2) = 
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2],
        ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
        za = atan2(dy, dx)
    ) [ya, za];

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

function __edge_r_begin(orig_r, a, a_step, m) =
    let(leng = orig_r * cos(a_step / 2))
    leng / cos((m - 0.5) * a_step - a);

function __edge_r_end(orig_r, a, a_step, n) =      
    let(leng = orig_r * cos(a_step / 2))    
    leng / cos((n + 0.5) * a_step - a);

/**
* arc_shape.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc_path.html
*
**/ 


function arc_path(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        angles = __is_float(angle) ? [0, angle] : angle,
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        points = concat([__ra_to_xy(__edge_r_begin(radius, angles[0], a_step, m), angles[0])],
            m > n ? [] : [
                for(i = [m:n]) 
                    __ra_to_xy(radius, a_step * i)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(__edge_r_end(radius, angles[1], a_step, n), angles[1])])
    ) points;

function __reverse(vt) = 
    let(leng = len(vt))
    [
        for(i = [0:leng - 1])
            vt[leng - 1 - i]
    ];

/**
* polyline2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polyline2d.html
*
**/

module polyline2d(points, width, startingStyle = "CAP_SQUARE", endingStyle = "CAP_SQUARE") {
    leng_pts = len(points);

    module line_segment(index) {
        styles = index == 1 ? [startingStyle, "CAP_ROUND"] : (
            index == leng_pts - 1 ? ["CAP_BUTT", endingStyle] : [
                "CAP_BUTT", "CAP_ROUND"
            ]
        );

        p1 = points[index - 1];
        p2 = points[index];
        p1Style = styles[0];
        p2Style = styles[1];
        
        line2d(points[index - 1], points[index], width, 
               p1Style = p1Style, p2Style = p2Style);

        // hook for testing
        test_line_segment(index, p1, p2, width, p1Style, p2Style);
    }

    module polyline2d_inner(index) {
        if(index < leng_pts) {
            line_segment(index);
            polyline2d_inner(index + 1);
        } 
    }

    polyline2d_inner(1);
}

// override it to test
module test_line_segment(index, point1, point2, width, p1Style, p2Style) {

}

/**
* path_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html
*
**/


// Becuase of improving the performance, this module requires m_rotation.scad which doesn't require in dotSCAD 1.0. 
// For backward compatibility, I directly include m_rotation here.

module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false) {
    // pre-process parameters
    function scale_pts(pts, s) = [
        for(p = pts) [p[0] * s[0], p[1] * s[1], p[2] * s[2]]
    ];
    
    function translate_pts(pts, t) = [
        for(p = pts) [p[0] + t[0], p[1] + t[1], p[2] + t[2]]
    ];
        
    function rotate_pts(pts, a, v) = [for(p = pts) rotate_p(p, a, v)];
    
    sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)];
    pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)];
        
    len_path_pts = len(pth_pts);
    len_path_pts_minus_one = len_path_pts - 1;
    twist_step_a = twist / len_path_pts;

    function scale_step() =
        let(s =  (scale - 1) / len_path_pts_minus_one)
        [s, s, s];  

    scale_step_vt = __is_float(scale) ? 
        scale_step() : 
        [
            (scale[0] - 1) / len_path_pts_minus_one, 
            (scale[1] - 1) / len_path_pts_minus_one,
            scale[2] == undef ? 0 : (scale[2] - 1) / len_path_pts_minus_one
        ];   

    // get rotation matrice for sections

    function local_ang_vects(j) = 
        j == 0 ? [] : local_ang_vects_sub(j);
    
    function local_ang_vects_sub(j) =
        let(
            vt0 = pth_pts[j] - pth_pts[j - 1],
            vt1 = pth_pts[j + 1] - pth_pts[j],
            a = acos((vt0 * vt1) / (norm(vt0) * norm(vt1))),
            v = cross(vt0, vt1)
        )
        concat([[a, v]], local_ang_vects(j - 1));

    rot_matrice = [
        for(ang_vect = local_ang_vects(len_path_pts - 2)) 
            m_rotation(ang_vect[0], ang_vect[1])
    ];

    leng_rot_matrice = len(rot_matrice);
    leng_rot_matrice_minus_one = leng_rot_matrice - 1;
    leng_rot_matrice_minus_two= leng_rot_matrice - 2;

    identity_matrix = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];

    function cumulated_rot_matrice(i) = 
        leng_rot_matrice == 0 ? [identity_matrix] : (
             leng_rot_matrice == 1 ? [rot_matrice[0], identity_matrix] : 
                (
                    i == leng_rot_matrice_minus_two ? 
                    [
                        rot_matrice[leng_rot_matrice_minus_one], 
                        rot_matrice[leng_rot_matrice_minus_two] * rot_matrice[leng_rot_matrice_minus_one]
                    ] 
                    : cumulated_rot_matrice_sub(i))
        );

    function cumulated_rot_matrice_sub(i) = 
        let(
            matrice = cumulated_rot_matrice(i + 1),
            curr_matrix = rot_matrice[i],
            prev_matrix = matrice[len(matrice) - 1]
        )
        concat(matrice, [curr_matrix * prev_matrix]);

    cumu_rot_matrice = cumulated_rot_matrice(0);

    // get all sections

    function init_section(a, s) =
        let(angleyz = __angy_angz(pth_pts[0], pth_pts[1]))
        rotate_pts(
            rotate_pts(
                rotate_pts(
                    scale_pts(sh_pts, s), a
                ), [90, 0, -90]
            ), [0, -angleyz[0], angleyz[1]]
        );
        
    function local_rotate_section(j, init_a, init_s) =
        j == 0 ? 
            init_section(init_a, init_s) : 
            local_rotate_section_sub(j, init_a, init_s);
    
    function local_rotate_section_sub(j, init_a, init_s) = 
        let(
            vt0 = pth_pts[j] - pth_pts[j - 1],
            vt1 = pth_pts[j + 1] - pth_pts[j],
            ms = cumu_rot_matrice[j - 1]
        )
        [
            for(p = init_section(init_a, init_s)) 
                [
                    [ms[0][0], ms[0][1], ms[0][2]] * p,
                    [ms[1][0], ms[1][1], ms[1][2]] * p,
                    [ms[2][0], ms[2][1], ms[2][2]] * p
                ]
        ];        

    function sections() =
        let(
            fst_section = 
                translate_pts(local_rotate_section(0, 0, [1, 1, 1]), pth_pts[0]),
            remain_sections = [
                for(i = [0:len_path_pts - 2]) 
                
                    translate_pts(
                        local_rotate_section(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i),
                        pth_pts[i + 1]
                    )
                
                    
            ]
        ) concat([fst_section], remain_sections);
    
    sects = sections();

    function calculated_sections() =
        closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
            concat(sects, [sects[0]]) : // round-robin
            sects;
     
     polysections(
        calculated_sections(),
        triangles = triangles
    );   

    // hook for testing
    test_path_extrude(sects);
}


// override to test
module test_path_extrude(sections) {

}

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


/**
* circle_path.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-circle_path.html
*
**/


function circle_path(radius, n) =
    let(
        _frags = __frags(radius),
        step_a = 360 / _frags,
        end_a = 360 - step_a * ((n == undef || n > _frags) ? 1 : _frags - n + 1)
    )
    [
        for(a = [0 : step_a : end_a]) 
            [radius * cos(a), radius * sin(a)]
    ];


function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

function __to2d(p) = [p[0], p[1]];

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : (
         leng == 2 ? [a[0], a[1], 0] :  [a[0], 0, 0]
     );

function __to_ang_vect(a) = __is_float(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);

/**
* m_rotation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-m_rotation.html
*
**/


function _q_rotation(a, v) = 
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
        [1 - yy - zz, yx - wz, zx + wy, 0],
        [yx + wz, 1 - xx - zz, zy - wx, 0],
        [zx - wy, zy + wx, 1 - xx - yy, 0],
        [0, 0, 0, 1]
    ];

function _m_xRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [1, 0, 0, 0],
        [0, c, -s, 0],
        [0, s, c, 0],
        [0, 0, 0, 1]
    ];

function _m_yRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, 0, s, 0],
        [0, 1, 0, 0],
        [-s, 0, c, 0],
        [0, 0, 0, 1]
    ];    

function _m_zRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, -s, 0, 0],
        [s, c, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];    

function _xyz_rotation(a) =
    let(ang = __to_ang_vect(a))
    _m_zRotation(ang[2]) * _m_yRotation(ang[1]) * _m_xRotation(ang[0]);

function m_rotation(a, v) = 
    (a == 0 || a == [0, 0, 0] || a == [0] || a == [0, 0]) ? [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ] : (v == undef ? _xyz_rotation(a) : _q_rotation(a, v));

/**
* line2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line2d.html
*
**/


module line2d(p1, p2, width, p1Style = "CAP_SQUARE", p2Style =  "CAP_SQUARE") {
    half_width = 0.5 * width;    

    atan_angle = atan2(p2[1] - p1[1], p2[0] - p1[0]);
    leng = sqrt(pow(p2[0] - p1[0], 2) + pow(p2[1] - p1[1], 2));

    frags = __nearest_multiple_of_4(__frags(half_width));
        
    module square_end(point) {
        translate(point) 
            rotate(atan_angle) 
                square(width, center = true);

        // hook for testing
        test_line2d_cap(point, "CAP_SQUARE");
    }

    module round_end(point) {
        translate(point) 
            rotate(atan_angle) 
                circle(half_width, $fn = frags);    

        // hook for testing
        test_line2d_cap(point, "CAP_ROUND");                
    }
    
    if(p1Style == "CAP_SQUARE") {
        square_end(p1);
    } else if(p1Style == "CAP_ROUND") {
        round_end(p1);
    }

    translate(p1) 
        rotate(atan_angle) 
            translate([0, -width / 2]) 
                square([leng, width]);
    
    if(p2Style == "CAP_SQUARE") {
        square_end(p2);
    } else if(p2Style == "CAP_ROUND") {
        round_end(p2);
    }

    // hook for testing
    test_line2d_line(atan_angle, leng, width, frags);
}

// override them to test
module test_line2d_cap(point, style) {
}

module test_line2d_line(angle, length, width, frags) {
}



function __to3d(p) = [p[0], p[1], 0];

function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;


function __is_float(value) = value + 0 != undef;


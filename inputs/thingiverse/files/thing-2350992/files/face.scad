model = "SOLID"; // [SOLID, SOLID_CROSS, MASK, MESH]
// Bigger is better
resolution = 0.25;
thickness = 3;

// Commonly-used private APIs

function __to2d(p) = [p[0], p[1]];
function __to3d(p) = [p[0], p[1], 0];

function __reverse(vt) = 
    let(leng = len(vt))
    [
        for(i = [0:leng - 1])
            vt[leng - 1 - i]
    ];
    
function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);
            
function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;


/**
* bezier_curve.scad
*
* Given a set of control points, the bezier_curve function returns points of the Bézier path. 
* Combined with the polyline, polyline3d or hull_polyline3d module defined in my lib-openscad, 
* you can create a Bézier curve.
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
            for(t = [0: t_step: 1]) 
                _bezier_curve_point(t, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];

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
            polyhedron(
                v_pts, 
                side_indexes(sects)
            ); 
        } else {
            first_idxes = [for(i = [0:leng_pts_sect - 1]) leng_pts_sect - 1 - i];  
            last_idxes = [
                for(i = [0:leng_pts_sect - 1]) 
                    i + leng_pts_sect * (leng_sects - 1)
            ];       

            polyhedron(
                v_pts, 
                concat([first_idxes], side_indexes(sects), [last_idxes])
            );    
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

        function to_v_pts(sects) = 
             [
                for(sect = sects) 
                    for(pt = sect) 
                        pt
             ];

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

        if(begin_end_the_same()) {
            polyhedron(
                concat(outer_v_pts, inner_v_pts),
                concat(outer_idxes, inner_idxes)
            );             
        } else {
            first_idxes = first_idxes();
            last_idxes = last_idxes(half_leng_v_pts - half_leng_sect);
            
            polyhedron(
                concat(outer_v_pts, inner_v_pts),
                concat(first_idxes, outer_idxes, inner_idxes, last_idxes)
            ); 
        }
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 5, 4], 
                    [0, 4, 1], [1, 5, 2], [2, 3, 0], 
                    [0, 3, 4], [1, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
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
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

/**
* line3d.scad
*
* Creates a 3D line from two points. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line3d.html
*
**/


module line3d(p1, p2, thickness, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE") {
    r = thickness / 2;

    frags = __nearest_multiple_of_4(__frags(r));
    half_fa = 180 / frags;
    
    dx = p2[0] - p1[0];
    dy = p2[1] - p1[1];
    dz = p2[2] - p1[2];
    
    
    length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2));

    ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2)));
    az = atan2(dy, dx);

    module cap_butt() {
        translate(p1) 
            rotate([0, ay, az]) 
                linear_extrude(length) 
                    circle(r, $fn = frags);
    }
                
    module capCircle(p) {
        w = r / 1.414;
        translate(p) 
            rotate([0, ay, az]) 
                translate([0, 0, -w]) 
                    linear_extrude(w * 2) 
                        circle(r, $fn = frags);       
    }

    module capSphere(p) {
        translate(p) 
            rotate([0, ay, az]) 
                sphere(r / cos(half_fa), $fn = frags);          
    }
    
    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            capCircle(p);     
        } else if(style == "CAP_SPHERE") { 
            capSphere(p);  
        }       
    }
    
    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}

/**
* polyline3d.scad
*
* Creates a 3D polyline from a list of `[x, y, z]` coordinates. 
* It depends on the line3d module so you have to include line3d.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polyline3d.html
*
**/

module polyline3d(points, thickness, startingStyle = "CAP_CIRCLE", endingStyle = "CAP_CIRCLE") {
    leng_pts = len(points);
    
    module line_segment(index) {
        styles = index == 1 ? [startingStyle, "CAP_BUTT"] : (
            index == leng_pts - 1 ? ["CAP_SPHERE", endingStyle] : [
                "CAP_SPHERE", "CAP_BUTT"
            ]
        );
        
        line3d(points[index - 1], points[index], thickness, 
               p1Style = styles[0], p2Style = styles[1]);
    }

    module polyline3d_inner(index) {
        if(index < leng_pts) {
            line_segment(index);
            polyline3d_inner(index + 1);
        }
    }

    polyline3d_inner(1);
}

/**
* function_grapher.scad
*
* 
* Given a set of points `[x, y, f(x, y)]` where `f(x, y)` is a 
* mathematics function, the `function_grapher` module can 
* create the graph of `f(x, y)`.
* It depends on the line3d and polyline3d modules so you have 
* to include "line3d.scad" and "polyline3d.scad".
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-function_grapher.html
*
**/ 

module function_grapher(points, thickness, style = "FACES", slicing = "SLASH") {

    rows = len(points);
    columns = len(points[0]);

    // Increasing $fn will be slow when you use "LINES" or "HULL_FACES".
    
    module faces() {
        function xy_to_index(x, y, columns) = y * columns + x; 

        top_pts = [
                for(row_pts = points)
                    for(pt = row_pts)
                        pt
        ];
            
        base_pts = [
            for(pt = top_pts)
                [pt[0], pt[1], pt[2] - thickness]
        ];
        
        leng_pts = len(top_pts);
                
        top_tri_faces1 = slicing == "SLASH" ? [
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ] : [
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];

        top_tri_faces2 = slicing == "SLASH" ? [
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns)
                    ]    
        ] : [
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];        

        base_tri_faces1 = [
            for(face = top_tri_faces1)
                __reverse(face) + [leng_pts, leng_pts, leng_pts]
        ];

        base_tri_faces2 = [
            for(face = top_tri_faces2)
                __reverse(face) + [leng_pts, leng_pts, leng_pts]
        ];
        
        side_faces1 = [
            for(xi = [0:columns - 2])
                let(
                    idx1 = xy_to_index(xi, 0, columns),
                    idx2 = xy_to_index(xi + 1, 0, columns)
                )
                [
                    idx1,
                    idx2,
                    idx2 + leng_pts,
                    idx1 + leng_pts
                ]
        ];

        side_faces2 = [
            for(yi = [0:rows - 2])
                let(
                    xi = columns - 1,
                    idx1 = xy_to_index(xi, yi, columns),
                    idx2 = xy_to_index(xi, yi + 1, columns)
                )
                [
                    idx1,
                    idx2,
                    idx2 + leng_pts,
                    idx1 + leng_pts
                ]
        ];                  
      
        side_faces3 = [
            for(xi = [0:columns - 2])
                let(
                    yi = rows - 1,
                    idx1 = xy_to_index(xi, yi, columns), 
                    idx2 = xy_to_index(xi + 1, yi, columns)
                )
                [
                    idx2,
                    idx1,
                    idx1 + leng_pts,
                    idx2 + leng_pts
                ]
        ];
        
        side_faces4 = [
            for(yi = [0:rows - 2])
                let(
                    idx1 = xy_to_index(0, yi, columns),
                    idx2 = xy_to_index(0, yi + 1, columns)
                )
                [
                    idx2,
                    idx1,
                    idx1 + leng_pts,
                    idx2 + leng_pts
                ]
        ];                  
        
        polyhedron(
            points = concat(top_pts, base_pts), 
            faces = concat(
                top_tri_faces1, top_tri_faces2,
                base_tri_faces1, base_tri_faces2, 
                side_faces1, 
                side_faces2, 
                side_faces3, 
                side_faces4
            )
        );    
    }

    module tri_to_lines(tri1, tri2) {
       polyline3d(concat(tri1, [tri1[0]]), thickness);
       polyline3d(concat(tri2, [tri2[0]]), thickness);
    }
    
    module hull_pts(tri) {
       half_thickness = thickness / 2;
       hull() {
           translate(tri[0]) sphere(half_thickness);
           translate(tri[1]) sphere(half_thickness);
           translate(tri[2]) sphere(half_thickness);
       }    
    }
    
    module tri_to_hull_faces(tri1, tri2) {
       hull_pts(tri1);
       hull_pts(tri2);
    }    

    module tri_to_graph(tri1, tri2) {
        if(style == "LINES") {
            tri_to_lines(tri1, tri2);
        } else {  // Warning: May be very slow!!
            tri_to_hull_faces(tri1, tri2);
        }
    }
    
    
    

    
    if(style == "FACES") {
        faces();
    } else {
        for(yi = [0:rows - 2]) {
            for(xi = [0:columns - 2]) {
                if(slicing == "SLASH") {
                    tri_to_graph([
                        points[yi][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi + 1]
                    ], [
                        points[yi][xi], 
                        points[yi + 1][xi + 1], 
                        points[yi + 1][xi]
                    ]);
                } else {                
                    tri_to_graph([
                        points[yi][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi]
                    ], [
                        points[yi + 1][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi + 1]
                    ]);                    
                }        
            }
        }
    }
}

/**
* shape_ellipse.scad
*
* Returns shape points of an ellipse.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/

function shape_ellipse(axes) =
    let(
        frags = __frags(axes[0]),
        step_a = 360 / frags,
        shape_pts = [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ]
    ) shape_pts;



function face_section(ctrl_points) = 
    let(
        middle = [
            [-ctrl_points[1][0], ctrl_points[1][1], ctrl_points[1][2]],
            [-ctrl_points[0][0], ctrl_points[0][1], ctrl_points[0][2]],
            ctrl_points[0],
            ctrl_points[1]
        ],
        right = [
            ctrl_points[1],
            ctrl_points[2],
            ctrl_points[3],
            ctrl_points[4]
        ],
        left = [
            for(i = [0:3]) 
                [
                    -right[3 - i][0],
                    right[3 - i][1],
                    right[3 - i][2]
                ]
        ]
    ) __reverse(
        concat(
            bezier_curve(resolution, left), 
            bezier_curve(resolution, middle), 
            bezier_curve(resolution, right)
        )
    );

//

sections = [
    // chin
    face_section([
        [4, -35, -16],
        [6, -35, -16],
        [8, -35, -17],
        [8, -35, -18],
        [8, -35, -20]
    ]),
    
    face_section([
        [8, -32, -12],
        [8, -32, -12],
        [18, -32, -15],
        [16, -32, -18],
        [18, -32, -20]
    ]),
    
    face_section([
        [8, -27, -6],
        [8, -27, -6],
        [20, -27, -9],
        [20, -27, -9],
        [28, -27, -20]
    ]),
    
    // mouth
    face_section([
        [5, -20, -1],
        [10, -22, -3],
        [22.5, -22, -4],
        [22, -22, -7],
        [35, -22, -20]
    ]),
   
    face_section([
        [5, -18, 4],
        [12, -18, -1.5],
        [20, -18, -3],
        [24, -20, -3],
        [37, -20, -20]
    ]),    
    
    face_section([
        [5, -15, 4],
        [12, -15, -1.5],
        [24, -15, -3.5],
        [25, -19, -2],
        [38.5, -18, -20]
    ]),
    
    face_section([
        [3, -14, 1],
        [8, -14, -0.5],
        [20, -14, -2],
        [30, -16, -2],
        [40, -16, -20]
    ]),

    face_section([
        [3, -14, 5],
        [15, -14, -1],
        [16, -14, -2],
        [32, -14, -1],
        [41, -14, -20]
    ]),

    face_section([
        [3, -9, 5],
        [15, -10, 0],
        [16, -12, -0.75],
        [32.5, -12, -1],
        [42, -12, -20]
    ]),
   
    face_section([
        [5, -7, 1],
        [9, -8.5, 0],
        [18, -9.5, 0],
        [33, -10, 0],
        [43, -10, -20]
    ]),   
   
    face_section([
        [3, -4, 0],
        [8, -5, 0],
        [23, -6, 0.5],
        [34, -8, 0],
        [44, -8, -20]
    ]),
    
    face_section([
        [5, -3, 20],
        [14, -3, 0],
        [24, -4, 0],
        [35, -4, 1],
        [45, -5, -20]
    ]),
    // x-axis
    face_section([
        [5, -2, 30],
        [15, -2, 0],
        [25, 0, 0],
        [35, 0, 3],
        [47, 0, -20]    
    ]),

    face_section([
        [5, 10, 25],
        [12.5, 10, 0],
        [22.5, 10, 0],
        [32.5, 10, 5],
        [50, 10, -20]  
    ]),

    face_section([
        [5, 20, 15],
        [10, 20, 0],
        [20, 20, 0],
        [30, 20, 5],
        [52, 20, -20]
    ]),

    face_section([
        [5, 30, 10],
        [7.5, 30, 0],
        [17.5, 30, 0],
        [27.5, 30, 8],
        [53.5, 32, -20]
    ]),
    // eyes
    face_section([
        [5, 35, 7],
        [7, 35, 0],
        [17, 34, -8.5],
        [27, 34, 8.5],
        [53, 37, -20]
    ]),

    face_section([
        [5, 40, 6],
        [6, 40, 0],
        [18, 40, -12],
        [28, 40, 5],
        [53, 40, -20]
    ]),

    face_section([
        [5, 45, 7],
        [6, 43, 0],
        [18, 46, -10],
        [28, 49, 10],
        [53, 45, -20]
    ]),
    // forehead
    face_section([
        [6, 55, 5],
        [10, 55, 5],
        [22, 55, 0],
        [32, 55, 12],
        [54.5, 53, -20]
    ]),


    face_section([
        [5, 65, 6],
        [10, 65, 6],
        [22, 65, 3],
        [32, 65, 13],
        [54.5, 63, -20]
    ]),
    
    face_section([
        [5, 75, 6],
        [10, 75, 6],
        [22, 75, 4],
        [32, 75, 13],
        [53, 73, -20]
    ]),
    
    face_section([
        [5, 85, 4],
        [10, 85, 4],
        [22, 85, 2],
        [32, 85, 10],
        [51, 83, -20]
    ]),
    
    face_section([
        [5, 95, 1],
        [10, 95, 1],
        [18, 95, 0],
        [28, 95, 5],
        [45, 93, -20]
    ]),
    
    face_section([
        [5, 105, -5],
        [10, 105, -6],
        [18, 105, -7],
        [25, 105, -4],
        [36, 103, -20]
    ]),
    
    face_section([
        [2, 110, -13],
        [5, 110, -13],
        [10, 110, -14],
        [20, 110, -14],
        [30, 105, -20]
    ])           
];

if(model == "SOLID" || model == "SOLID_CROSS") {
    polysections(sections);
    if(model == "SOLID_CROSS") {
        for(section = sections) {
            polyline3d(section, thickness);
        }    
    }
} else if(model == "MASK") {
    difference() {
        function_grapher(
            sections, 
            thickness, 
            style = "HULL_FACES", 
            $fn = 4
        );

        translate([27, 42, 0]) 
            linear_extrude(100, center = true) 
                polygon(shape_ellipse([14, 5], $fn = 8));
                
        translate([-27, 42, 0]) 
            linear_extrude(100, center = true) 
                polygon(shape_ellipse([14, 5], $fn = 8));            
    }     
} else if(model == "MESH") {
    function_grapher(
        sections, 
        thickness, 
        style = "LINES", 
        $fn = 4
    );
}

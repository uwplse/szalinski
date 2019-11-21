
spring_radius = 25;
spring_levels = 30;
spring_sides = 48;
line_thickness = 2.5; 

/**
* circle_path.scad
*
* Sometimes you need all points on the path of a circle. Here's 
* the function. Its $fa, $fs and $fn parameters are consistent 
* with the circle module.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-circle_path.html
*
**/

function circle_path(radius, n) =
    let(
        _frags = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5),
        step_a = 360 / _frags,
        end_a = 360 - step_a * ((n == undef || n > _frags) ? 1 : _frags - n + 1)
    )
    [
        for(a = [0 : step_a : end_a]) 
            [radius * cos(a), radius * sin(a)]
    ];

/**
* helix.scad
*
* Gets all points on the path of a spiral around a cylinder. 
* Its $fa, $fs and $fn parameters are consistent with the cylinder module.
* It depends on the circle_path module so you have to include circle_path.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-helix.html
*
**/ 

function helix(radius, levels, level_dist, 
               vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        points = circle_path(radius),
        leng = len(points),
        _frags = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5),
        offset_z = level_dist / _frags,
        v_dir = (vt_dir == "SPI_DOWN" ? -1 : 1),
        r_dir = (rt_dir == "CT_CLK" ? 1 : -1)
    ) [
        for(l = [0:levels - 1])
            for(i = [0:leng - 1])
                r_dir == 1 ? [     // COUNT_CLOCKWISE
                    points[i][0], 
                    points[i][1],
                    v_dir * (l * level_dist + offset_z * i)
                ] : (             //  CLOCKWISE
                        i == 0 ? [
                            points[0][0],
                            points[0][1],
                            v_dir * l * level_dist
                        ] : [
                            points[leng - i][0], 
                            points[leng - i][1], 
                            v_dir * (l * level_dist + offset_z * i)
                        ]
                )
    ];

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

function _to2d(p) = [p[0], p[1]];

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
        _to2d(
            _rotate_p_3d([point[0], point[1], 0], angle)
        );

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
        sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) [p[0], p[1], 0]],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) [p[0], p[1], 0]],
        scale_step_vt = len(scale) == 2 ? 
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

module polysections(sections, triangles = "RADIAL") {
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
    
    function flat(vector, i = 0) =
        i == len(vector) ? [] :
        concat(vector[i], flat(vector, i + 1));    
    
    leng_section = len(sections[0]);
    
    function radial_tris() = [
        for(i = [1:leng_section - 2]) [0, i, i + 1]
    ];
        
    function hollow_tris() = 
        let(
            inner_i_begin = leng_section / 2,
            pair_idxes = [for(i = [0:inner_i_begin - 1])
                let(n = inner_i_begin + i + 1)
                [
                    [i, inner_i_begin + i, n % inner_i_begin + inner_i_begin], 
                    [i, i + 1, n % leng_section]
                ]
                
            ]
           
        ) flat(pair_idxes); 

    function tris() = triangles == "RADIAL" ? radial_tris() : 
        (triangles == "HOLLOW" ? hollow_tris() : triangles);
    
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

/**
* helix_extrude.scad
*
* Extrudes a 2D shape along a helix path.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-helix_extrude.html
*
**/

module helix_extrude(shape_pts, radius, levels, level_dist, 
                     vt_dir = "SPI_UP", rt_dir = "CT_CLK", 
                     twist = 0, scale = 1.0, triangles = "RADIAL") {
    frags = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

    v_dir = vt_dir == "SPI_UP" ? 1 : -1;
    r_dir = rt_dir == "CT_CLK" ? 1 : -1;
            
    angle_step = 360 / frags * r_dir;
    initial_angle = atan2(level_dist / frags, 6.28318 * radius / frags) * v_dir * r_dir;

    path_points = helix(
        radius = radius, 
        levels = levels, 
        level_dist = level_dist, 
        vt_dir = vt_dir, 
        rt_dir = rt_dir
    );

    angles = [for(i = [0:len(path_points) - 1]) [90 + initial_angle, 0, angle_step * i]];

    polysections(
        cross_sections(shape_pts, path_points, angles, twist, scale),
        triangles = triangles
    );
}


module toy_spring(radius, levels, sides, line_thickness) {
    $fn = 4;
    shape_pts = concat(
        circle_path(radius = line_thickness / 2)
    );

    helix_extrude(shape_pts, 
        radius = radius, 
        levels = levels, 
        level_dist = line_thickness,
        $fn = sides
    );
}

toy_spring(spring_radius, spring_levels, spring_sides, line_thickness);
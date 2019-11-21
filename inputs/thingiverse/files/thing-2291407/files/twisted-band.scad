band_width = 20;
band_thickness = 2;    
circle_radius = 50;    
circle_frags = 48;
half_circles_twisted = 1;

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

module path_extrude(shape_pts, path_pts, triangles = "RADIAL", twist = 0, scale = 1.0, closed = false) {

    s_pts = to3d(shape_pts);
    pth_pts = to3d(path_pts);

    len_path_pts = len(pth_pts);    
    len_path_pts_minus_one = len_path_pts - 1;     

    scale_step_vt = len(scale) == 2 ? 
        [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one] :
        [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one];

    scale_step_x = scale_step_vt[0];
    scale_step_y = scale_step_vt[1];
    twist_step = twist / len_path_pts_minus_one;

    function to3d(pts) = 
        len(pts[0]) == 3 ? pts : [for(p = pts) [p[0], p[1], 0]];

    function first_section() = 
        let(
            p1 = pth_pts[0],
            p2 = pth_pts[1],
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = s_pts) 
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
            for(p = s_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                rotate_p(
                     rotate_p(scaled_p, twist_step * i) + [0, 0, length], 
                     [0, ay, az]
                ) + p1
        ];
    
    function path_extrude_inner(index) =
       index == len_path_pts ? [] :
           concat(
               [section(pth_pts[index - 1], pth_pts[index],  index)],
               path_extrude_inner(index + 1)
           );

    if(closed && pth_pts[0] == pth_pts[len_path_pts_minus_one]) {
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

module twisted_band(width, thickness, circle_radius, circle_frags, half_circles_twisted) {
    function flatten(vt, i = 0) = 
        i == len(vt) ? [] :
            concat(vt[i], flatten(vt, i + 1));

    function circle_pair_pts(circle_radius, circle_frags) = 
        let(
            a = 360 / circle_frags,
            half_a = a / 2,
            x = circle_radius * cos(half_a),
            y = circle_radius * sin(half_a),
            tri_pts = [[x, 0, 0], [x, y, 0]]
        )
        [
            for(i = [0:circle_frags - 1]) 
                [rotate_p(tri_pts[0], i * a), rotate_p(tri_pts[1], i * a)]
        ];
        
    function circle_path_for_mobius(circle_radius, circle_frags) = 
        concat(
            flatten(circle_pair_pts(circle_radius, circle_frags)), 
            [[circle_radius * cos(180 / circle_frags), 0, 0]]
        );
        
    half_width = width / 2;  
    half_thickness = thickness / 2;  
        
    shape_pts = [
        [-half_thickness, -half_width],
        [-half_thickness, half_width],
        [half_thickness, half_width],
        [half_thickness, -half_width]
    ];
    
    path_pts = circle_path_for_mobius(circle_radius, circle_frags);

    path_extrude(shape_pts, path_pts, twist = 180 * half_circles_twisted);
}
     
twisted_band(band_width, band_thickness, circle_radius, circle_frags, half_circles_twisted);
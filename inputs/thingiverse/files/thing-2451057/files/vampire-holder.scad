holder_height = 80;
holder_round_r = 5;
feet_height = 15;

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

function __is_vector(value) = !(value >= "") && len(value) != undef;

function __to2d(p) = [p[0], p[1]];

function __reverse(vt) = 
    let(leng = len(vt))
    [
        for(i = [0:leng - 1])
            vt[leng - 1 - i]
    ];

/**
* function_grapher.scad
*
* 
* Given a set of points `[x, y, f(x, y)]` where `f(x, y)` is a 
* mathematics function, the `function_grapher` module can 
* create the graph of `f(x, y)`.
* It depends on the line3d, polyline3d, hull_polyline3d modules so you have 
* to include "line3d.scad", "polyline3d.scad", "hull_polyline3d.scad".
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

    // Increasing $fn will be slow when you use "LINES", "HULL_FACES" or "HULL_LINES".
    
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
        
        pts = concat(top_pts, base_pts);
        face_idxs = concat(
                top_tri_faces1, top_tri_faces2,
                base_tri_faces1, base_tri_faces2, 
                side_faces1, 
                side_faces2, 
                side_faces3, 
                side_faces4
            );

        polyhedron(
            points = pts, 
            faces = face_idxs
        );

        // hook for testing
        test_function_grapher_faces(pts, face_idxs);
    }

    module tri_to_lines(tri1, tri2) {
       polyline3d(concat(tri1, [tri1[0]]), thickness);
       polyline3d(concat(tri2, [tri2[0]]), thickness);
    }

    module tri_to_hull_lines(tri1, tri2) {
       hull_polyline3d(concat(tri1, [tri1[0]]), thickness);
       hull_polyline3d(concat(tri2, [tri2[0]]), thickness);
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
        } else if(style == "HULL_FACES") {  // Warning: May be very slow!!
            tri_to_hull_faces(tri1, tri2);
        } else if(style == "HULL_LINES") {  // Warning: very very slow!!
            tri_to_hull_lines(tri1, tri2);
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

// override it to test
module test_function_grapher_faces(points, faces) {

}

/**
* bezier_surface.scad
*
* Given a set of control points, the bezier_surface function returns points of the Bézier surface. 
* Combined with the function_grapher module defined in my lib-openscad, 
* you can create a Bézier surface.
*
* It depends on the bezier_curve function so remember to include bezier_curve.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_surface.html
*
**/ 

function bezier_surface(t_step, ctrl_pts) =
    let(pts =  [
        for(i = [0:len(ctrl_pts) - 1]) 
            bezier_curve(t_step, ctrl_pts[i])
    ]) 
    [for(x = [0:len(pts[0]) - 1]) 
        bezier_curve(t_step,  
                [for(y = [0:len(pts) - 1]) pts[y][x]]
        ) 
    ];            
            
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
* hollow_out.scad
*
* Hollows out a 2D object. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-hollow_out.html
*
**/

module hollow_out(shell_thickness) {
    difference() {
        children();
        offset(delta = -shell_thickness) children();
    }
}
            
/**
* rounded_extrude.scad
*
* Extrudes a 2D object roundly from 0 to 180 degrees.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_extrude.html
*
**/

module rounded_extrude(size, round_r, angle = 90, twist = 0, convexity = 10) {

    is_vt = __is_vector(size);
    x = is_vt ? size[0] : size;
    y = is_vt ? size[1] : size;
    
    q_corner_frags = __frags(round_r) / 4;
    
    step_a = angle / q_corner_frags;
    twist_step = twist / q_corner_frags;

    module layers(pre_x, pre_y, pre_h = 0, i = 1) {
        module one_layer(current_a) {
            wx = pre_x;    
            wy = pre_y;
            
            h = (round_r - pre_h) - round_r * cos(current_a);
            
            d_leng = 
                round_r * (sin(current_a) - sin(step_a * (i - 1)));
            
            sx = (d_leng * 2 + wx) / wx;
            sy = (d_leng * 2 + wy) / wy;

            translate([0, 0, pre_h]) 
                rotate(-twist_step * (i - 1)) 
                    linear_extrude(
                        h, 
                        slices = 1, 
                        scale = [sx, sy], 
                        convexity = convexity, 
                        twist = twist_step
                    ) scale([wx / x, wy / y]) 
                          children();     

            test_rounded_extrude_data(i, wx, wy, pre_h, sx, sy);

            layers(wx * sx, wy * sy, h + pre_h, i + 1)
                children();   
                    
        }    
    
        if(i <= q_corner_frags) {
            one_layer(i * step_a) 
                children();
        } else if(i - q_corner_frags < 1) {
            one_layer(q_corner_frags * step_a) 
                children();
        }
    }
    
    layers(x, y) 
        children();
}

module test_rounded_extrude_data(i, wx, wy, pre_h, sx, sy) {

}

/**
* bend.scad
*
* Bends a 3D object into an arc shape. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bend.html
*
**/ 


module bend(size, angle, frags = 24) {
    x = size[0];
    y = size[1];
    z = size[2];
    frag_width = x / frags;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    h = r * cos(half_frag_angle);
    
    tri_frag_pts = [
        [0, 0], 
        [half_frag_width, h], 
        [frag_width, 0], 
        [0, 0]
    ];

    module triangle_frag() {
        translate([0, -z, 0]) 
            linear_extrude(y) 
                polygon(tri_frag_pts);    
    }
    
    module get_frag(i) {
        translate([-frag_width * i - half_frag_width, -h + z, 0]) 
            intersection() {
                translate([frag_width * i, 0, 0]) 
                    triangle_frag();
                rotate([90, 0, 0]) 
                    children();
            }
    }

    for(i = [0 : frags - 1]) {
        rotate(i * frag_angle + half_frag_angle) 
            get_frag(i) 
                children();  
    }

    // hook for testing
    test_bend_tri_frag(tri_frag_pts, frag_angle);
}

// override it to test
module test_bend_tri_frag(points, angle) {

}

            
/**
* ellipse_extrude.scad
*
* Extrudes a 2D object along the path of an ellipse from 0 to 180 degrees.
* The semi-major axis is not necessary because it's eliminated while calculating.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ellipse_extrude.html
*
**/

module ellipse_extrude(semi_minor_axis, height, center = false, convexity = 10, twist = 0, slices = 20) {
    h = height == undef ? semi_minor_axis : (
        // `semi_minor_axis` is always equal to or greater than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    function f_extrude(i = 1) = 
        i <= slices ? 
            concat(
                [
                    [
                        cos(angle * i) / cos(angle * (i - 1)), 
                        semi_minor_axis * sin(angle * i)
                    ]
                ],
                f_extrude(i + 1)
            ) : []; 

    fzs = f_extrude(); 
    len_fzs = len(fzs);

    function accm_fs(pre_f = 1, i = 0) =
        i < len_fzs ? 
            concat(
                [pre_f * fzs[i][0]],
                accm_fs(pre_f * fzs[i][0], i + 1)
            ) : [];
    
    child_fs = concat([1], accm_fs());
    pre_zs = concat(
        [0],
        [
            for(i = [0:len_fzs - 1])
                fzs[i][1]
        ]
    );

    module extrude() {
        for(i = [0:len_fzs - 1]) {
            f = fzs[i][0];
            z = fzs[i][1];

            translate([0, 0, pre_zs[i]]) 
                rotate(-twist / slices * i) 
                    linear_extrude(
                        z - pre_zs[i], 
                        convexity = convexity,
                        twist = twist / slices, 
                        slices = 1,
                        scale = f 
                    ) scale(child_fs[i]) children();
        }
    }
    
    center_offset = [0, 0, center == true ? -h / 2 : 0];
    translate(center_offset) 
        extrude() 
            children();

    // hook for testing
    test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset);
}

// override for testing
module test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset) {

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

include <__private__/__frags.scad>;

function shape_ellipse(axes) =
    let(
        frags = __frags(axes[0]),
        step_a = 360 / frags,
        shape_pts = [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ]
    ) shape_pts;

module vampire_holder() {
    $fn = 48;
        
    module feet() {
        module foot() {
            ellipse_extrude(semi_minor_axis = feet_height)    
                polygon(shape_ellipse(axes  = [20, 30]));
        }
        
        translate([25, 0, 0]) foot();
        translate([-25, 0, 0]) foot();
    }

    module holder() {
        radius = 30;

        rounded_extrude(radius * 2, round_r = holder_round_r) 
            circle(radius);
                
        translate([0, 0, holder_round_r])
            linear_extrude(holder_height) 
                hollow_out(shell_thickness = 4) circle(30 + 5);
    }

    module sun_glasses() {
        glasses_path = [[0, 5], [40, 10], , [15, -10], [0, -5]];
        thickness = 4;
        
        rotate(-45) 
            bend(size = [80, 20, thickness], angle = 90) 
                translate([40, 10, 0]) 
                    linear_extrude(thickness) 
                        union() {
                            polygon(glasses_path);
                            mirror([1, 0, 0]) polygon(glasses_path);
                        }

    }

    module cloak() {
        t_step = 0.05;
        thickness = 4;

        ctrl_pts = [
            [[10, 0, -20],  [60, 0, 55],   [90, 0, 60], [150, 0, -20]],
            [[85, 50, -25], [55, 40, 10], [115, 30, 35], [80, 50, -40]],
            [[25, 50, 100], [60, 70, 70],  [90, 70, 70],  [150, 60, 70]],
            [[0, 70, 100], [30, 80, 90], [90, 80, 90],  [150, 80, 90]]
        ];

        g = bezier_surface(t_step, ctrl_pts);
        
        rotate([-90, 0, 0])  
            function_grapher(g, thickness, style = "HULL_FACES", $fn = 3);       
    }

    color("black") 
        feet();

    color("white") 
        translate([0, 0, feet_height - holder_round_r]) 
            holder();

    color("black")  
        translate([0, 12.5, holder_height * 5 / 6]) 
            sun_glasses(); 


    color("gray") 
        translate([-80, holder_round_r + 0.5, holder_height + feet_height - holder_round_r])
            cloak();
        
}

vampire_holder();
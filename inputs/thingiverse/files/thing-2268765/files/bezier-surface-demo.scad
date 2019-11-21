t_step = 0.05;
thickness = 0.5;
show_control_points = "YES"; // [YES, NO]

p00_z = 20; // [-120:120]
p01_z = -35; // [-120:120]
p02_z = 60; // [-120:120]
p03_z = 5; // [-120:120]

p10_z = 30; // [-120:120]
p11_z = -25; // [-120:120]
p12_z = 120; // [-120:120]
p13_z = 5; // [-120:120]

p20_z = 0; // [-120:120]
p21_z = 35; // [-120:120]
p22_z = 60; // [-120:120]
p23_z = 45; // [-120:120]

p30_z = 0; // [-120:120]
p31_z = -35; // [-120:120]
p32_z = 60; // [-120:120]
p33_z = 45; // [-120:120]

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

    frags = $fn > 0 ? 
        ($fn >= 3 ? $fn : 3) : 
        max(min(360 / $fa, r * 6.28318 / $fs), 5)
    ;

    remain = frags % 4;
    frags_of_4 = (remain / 4) > 0.5 ? frags - remain + 4 : frags - remain;
    half_fa = 180 / frags_of_4;
    
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
                    circle(r, $fn = frags_of_4);
    }
                
    module capCircle(p) {
        w = r / 1.414;
        translate(p) 
            rotate([0, ay, az]) 
                translate([0, 0, -w]) 
                    linear_extrude(w * 2) 
                        circle(r, $fn = frags_of_4);       
    }

    module capSphere(p) {
        translate(p) 
            rotate([0, ay, az]) 
                sphere(r / cos(half_fa), $fn = frags_of_4);          
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
    module line_segment(index) {
        styles = index == 1 ? [startingStyle, "CAP_BUTT"] : (
            index == len(points) - 1 ? ["CAP_SPHERE", endingStyle] : [
                "CAP_SPHERE", "CAP_BUTT"
            ]
        );
        
        line3d(points[index - 1], points[index], thickness, 
               p1Style = styles[0], p2Style = styles[1]);
    }

    module polyline3d_inner(points, index) {
        if(index < len(points)) {
            line_segment(index);
            polyline3d_inner(points, index + 1);
        }
    }

    polyline3d_inner(points, 1);
}

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
            [points[0][0], points[1][0], points[2][0], points[3][0]], 
            n
        ),
        bezier_curve_coordinate(
            t,  
            [points[0][1], points[1][1], points[2][1], points[3][1]], 
            n
        ),
        bezier_curve_coordinate(
            t, 
            [points[0][2], points[1][2], points[2][2], points[3][2]], 
            n
        )
    ];

function bezier_curve(t_step, points) = 
    concat([
        for(t = [0: t_step: 1]) 
            _bezier_curve_point(t, points)
    ], [_bezier_curve_point(1, points)]);
    
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
    // Increasing $fn will be slow when you use "LINES" or "HULL_FACES".
     
    function tri_shell_points(top) =
        let(
            z_offset = [0, 0, -thickness],
            bottom = [
                top[0] + z_offset, 
                top[1] + z_offset, 
                top[2] + z_offset
            ],
            faces = [
                [0, 1, 2],
                [3, 4, 5],
                [0, 1, 4, 3],
                [1, 2, 5, 4],
                [2, 0, 3, 5]
            ]
        )
        [
            concat(top, bottom), 
            faces
        ];
        
        
    module tri_to_faces(top_tri1, top_tri2) {
        pts_faces1 = tri_shell_points(top_tri1);
        pts_faces2 = tri_shell_points(top_tri2);
        
        hull() {
            polyhedron(
                points = pts_faces1[0], 
                faces = pts_faces1[1]
            );
            polyhedron(
                points = pts_faces2[0],
                faces = pts_faces2[1]
            );
        }
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
        if(style == "FACES") {
            tri_to_faces(tri1, tri2);
        } else if(style == "LINES") {
            tri_to_lines(tri1, tri2);
        } else {  // Warning: May be very slow!!
            tri_to_hull_faces(tri1, tri2);
        }
    }

    for(yi = [0:len(points) - 2]) {
        for(xi = [0:len(points[yi]) - 2]) {
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

module demo() {

    ctrl_pts = [
        [[0, 0, p00_z],  [60, 0, p01_z],   [90, 0, p02_z],    [200, 0, p03_z]],
        [[0, 50, p10_z], [100, 60, p11_z], [120, 50, p12_z], [200, 50, p13_z]],
        [[0, 100, p20_z], [60, 120, p21_z],  [90, 100, p22_z],  [200, 100, p23_z]],
        [[0, 150, p30_z], [60, 150, p31_z], [90, 180, p32_z],  [200, 150, p33_z]]
    ];

    g = bezier_surface(t_step, ctrl_pts);

    color("yellow") function_grapher(g, thickness);    

    if(show_control_points == "YES") {
        color("gray") function_grapher(ctrl_pts, thickness * 2, "LINES"); 
        color("red") for(i = [0:len(ctrl_pts) - 1]) {
            for(j = [0:len(ctrl_pts[0]) - 1]) {
                translate(ctrl_pts[i][j]) 
                    sphere(thickness * 4);          
            }
        }  
    }    
}

demo();
diameter = 7;
thickness = 1;
resolution = 0.3;

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);
            
function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;

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

include <__private__/__reverse.scad>;

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

    angles = [0, ay, az];

    module cap_with(p) { 
        translate(p) 
            rotate(angles) 
                children();  
    } 

    module cap_butt() {
        cap_with(p1)                 
            linear_extrude(length) 
                circle(r, $fn = frags);
        
        // hook for testing
        test_line3d_butt(p1, r, frags, length, angles);
    }

    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            cap_leng = r / 1.414;
            cap_with(p) 
                linear_extrude(cap_leng * 2, center = true) 
                    circle(r, $fn = frags);

            // hook for testing
            test_line3d_cap(p, r, frags, cap_leng, angles);
        } else if(style == "CAP_SPHERE") { 
            cap_leng = r / cos(half_fa);
            cap_with(p)
                sphere(cap_leng, $fn = frags);  
            
            // hook for testing
            test_line3d_cap(p, r, frags, cap_leng, angles);
        }            
    }


    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}

// Override them to test
module test_line3d_butt(p, r, frags, length, angles) {

}

module test_line3d_cap(p, r, frags, cap_leng, angles) {
    
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

        p1 = points[index - 1];
        p2 = points[index];
        p1Style = styles[0];
        p2Style = styles[1];        
        
        line3d(p1, p2, thickness, 
               p1Style = p1Style, p2Style = p2Style);

        // hook for testing
        test_line3d_segment(index, p1, p2, thickness, p1Style, p2Style);               
    }

    module polyline3d_inner(index) {
        if(index < leng_pts) {
            line_segment(index);
            polyline3d_inner(index + 1);
        }
    }

    polyline3d_inner(1);
}

// override it to test
module test_line3d_segment(index, point1, point2, thickness, p1Style, p2Style) {

}

/**
* hull_polyline3d.scad
*
* Creates a 3D polyline from a list of `[x, y, z]` coordinates. 
* As the name says, it uses the built-in hull operation for each pair of points (created by the sphere module). 
* It's slow. However, it can be used to create metallic effects for a small $fn, large $fa or $fs.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/hull_polyline3d.html
*
**/

module hull_polyline3d(points, thickness) {
    half_thickness = thickness / 2;
    leng = len(points);
    
    module hull_line3d(index) {
        point1 = points[index - 1];
        point2 = points[index];

        hull() {
            translate(point1) 
                sphere(half_thickness);
            translate(point2) 
                sphere(half_thickness);
        }

        // hook for testing
        test_line_segment(index, point1, point2, half_thickness);        
    }

    module polyline3d_inner(index) {
        if(index < leng) {
            hull_line3d(index);
            polyline3d_inner(index + 1);
        }
    }

    polyline3d_inner(1);
}

// override it to test
module test_line_segment(index, point1, point2, radius) {

}
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

module formula_spring_festival() {

    function f(x, y) = pow(x, 4) + pow(y, 4) + 100 / (pow(x, 4) + pow(2 * y - 2, 4) + pow(2 * y - 1, 2)) + 100 / (pow(x, 4) + pow(2 * y + 2, 4) + pow(2 * y + 1, 2)) - 1 / (pow(y + 3, 4) + pow(x / 15, 4)) - 1 / (pow(y + 4, 4) + pow(x / 15, 4)) - 1 / (pow(y + 5, 4) + pow(x / 15, 4)) -
    1 / (4 * pow((x + y + 4), 4) + pow((x - y + 1) / 5, 4)) - pow(100, 16) / pow((pow(pow(x - 4, 2) + pow(y + 5, 2) - 13, 2) + pow(pow(x - 19, 2) + pow(y + 12, 2) - 400, 2)), 16) - 25;

    min_value =  -7.5;
    max_value = 7.5;
    
    $fn = 4;

    points = [
        for(y = [min_value:resolution:max_value])
            [
                for(x = [min_value:resolution:max_value]) 
                    [x, y , f(x, y)]
            ] 
    ];
    
    factor = 5 / 7;

    scale([factor * diameter, factor * diameter, 1]) union() {
        color("red") 
            linear_extrude(thickness) 
                circle(max_value);

        color("black") 
            linear_extrude(thickness * 2) 
                difference() {
                    offset(delta = -0.25) circle(max_value);
                    offset(delta = -0.5) circle(max_value);
                }

        color("black") 
            scale([1, 1, 0.3 * 2 * thickness]) 
                translate([0, 2, 2.5]) 
                    intersection() {
                        cube([max_value * 2, max_value * 2, 5], center = true);
                        function_grapher(points, .25, style = "HULL_FACES");
                    }
    }
}

formula_spring_festival();
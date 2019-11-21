thickness = 2;
min_value =  -200;
max_value = 200;
resolution = 10;
style = "FACES";   // [FACES, LINES, HULL_FACES]
slicing = "BACK_SLASH";  // [SLASH, BACK_SLASH]

function f(x, y) = 
   30 * (
       cos(sqrt(pow(x, 2) + pow(y, 2))) + 
       cos(3 * sqrt(pow(x, 2) + pow(y, 2)))
   );

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
        max(min(360 / $fa, r * 2 * 3.14159 / $fs), 5)
    ;
    
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
                    circle(r);
    }
                
    module capCube(p) {
        w = r / 1.414;
        translate(p) 
            rotate([0, ay, az]) 
                translate([0, 0, -w]) 
                    linear_extrude(w * 2) 
                        circle(r);       
    }
    
    module capSphere(p) {
        translate(p) 
            rotate([0, ay, az]) 
                sphere(r * 1.0087);          
    }
    
    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            capCube(p);     
        } else if(style == "CAP_SPHERE") { 
            if(frags > 4) {
                capSphere(p);  
            } else {
                capCube(p);       
            }        
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
    points = [
        for(y = [min_value:resolution:max_value])
            [
                for(x = [min_value:resolution:max_value]) 
                    [x, y, f(x, y)]
            ]
    ];

    function_grapher(points, thickness, style, slicing);
}

demo();




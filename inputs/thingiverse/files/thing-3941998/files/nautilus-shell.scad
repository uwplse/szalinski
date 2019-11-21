chambered_section_max_angle = 300;
steps = 25;
thickness = 1;
slices = 5;
semi_minor_axis = 10;
height = 5;

module nautilus_shell(chambered_section_max_angle, steps, thickness) {
    function r(a) = pow(2.71828, 0.0053468 * a);
    
    a_step = chambered_section_max_angle / steps;
    spiral = [
        for(a = [a_step:a_step:chambered_section_max_angle + 450])  
            rotate_p([r(a), 0], a)
    ];

    render() {
        hull_polyline2d(spiral, thickness);

        for(a = [a_step:a_step * 2:chambered_section_max_angle]) {
            a2 = a + 360;
            a3 = a + 420;
            p1 = rotate_p([r(a), 0], a);
            p2 = rotate_p((p1 + rotate_p([r(a2), 0], a2)) * .6, -5);
            p3 = rotate_p([r(a3), 0], a3);
            
            hull_polyline2d(bezier_curve(0.1, 
                [p1, p2, p3]
            ), thickness);
        }

    }
}

ellipse_extrude(semi_minor_axis, height = height, slices = slices)
    nautilus_shell(chambered_section_max_angle, steps, thickness);

mirror([0, 0, 1])    
ellipse_extrude(semi_minor_axis, height = height, slices = slices)
    nautilus_shell(chambered_section_max_angle, steps, thickness);

    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

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



function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * PI * 2 / $fs), 5);

function __to3d(p) = [p[0], p[1], 0];

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
        t_end = ceil(1 / t_step),
        pts = concat([
            for(t = 0; t < t_end; t = t + 1)
                _bezier_curve_point(t * t_step, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];


/**
* hull_polyline2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/hull_polyline2d.html
*
**/

module hull_polyline2d(points, width) {
    half_width = width / 2;
    leng = len(points);
    
    module hull_line2d(index) {
        point1 = points[index - 1];
        point2 = points[index];

        hull() {
            translate(point1) 
                circle(half_width);
            translate(point2) 
                circle(half_width);
        }

        // hook for testing
        test_line_segment(index, point1, point2, half_width);
    }

    module polyline2d_inner(index) {
        if(index < leng) {
            hull_line2d(index);
            polyline2d_inner(index + 1);
        }
    }

    polyline2d_inner(1);
}

// override it to test
module test_line_segment(index, point1, point2, radius) {

}

function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : (
         leng == 2 ? [a[0], a[1], 0] :  [a[0], 0, 0]
     );

function __to_ang_vect(a) = is_num(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);

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
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0], 
        pt[1] * cosa - pt[2] * sina,
        pt[1] * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa + pt[2] * sina, 
        pt[1],
        -pt[0] * sina + pt[2] * cosa, 
    ];

function _rotz(pt, a) = 
    a == 0 ? pt :
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


function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;


function __to2d(p) = [p[0], p[1]];

/**
* ellipse_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ellipse_extrude.html
*
**/

module ellipse_extrude(semi_minor_axis, height, center = false, convexity = 10, twist = 0, slices = 20) {
    h = is_undef(height) ? semi_minor_axis : (
        // `semi_minor_axis` is always equal to or greater than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    f_extrude = [
        for(i = 1; i <= slices; i = i + 1) 
        [
            cos(angle * i) / cos(angle * (i - 1)), 
            semi_minor_axis * sin(angle * i)
        ]
    ]; 
    len_f_extrude = len(f_extrude);

    accm_fs =
        [
            for(i = 0, pre_f = 1; i < len_f_extrude; pre_f = pre_f * f_extrude[i][0], i = i + 1)
                pre_f * f_extrude[i][0]
        ];

    child_fs = concat([1], accm_fs);
    pre_zs = concat(
        [0],
        [
            for(i = 0; i < len_f_extrude; i = i + 1)
                f_extrude[i][1]
        ]
    );

    module extrude() {
        for(i = [0:len_f_extrude - 1]) {
            f = f_extrude[i][0];
            z = f_extrude[i][1];

            translate([0, 0, pre_zs[i]]) 
            rotate(-twist / slices * i) 
            linear_extrude(
                z - pre_zs[i], 
                convexity = convexity,
                twist = twist / slices, 
                slices = 1,
                scale = f 
            ) 
            scale(child_fs[i]) 
                children();
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


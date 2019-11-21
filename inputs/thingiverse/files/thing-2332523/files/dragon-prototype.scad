x1 = 30;
x2 = 30;
x3 = 0;
x4 = 0;

// Commonly-used private API

function __angy_angz(p1, p2) = 
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2],
        ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
        za = atan2(dy, dx)
    ) [ya, za];

function __is_vector(value) = !(value >= "") && len(value) != undef;


function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);
            
function __pie_for_rounding(r, begin_a, end_a, frags) =
    let(
        sector_angle = end_a - begin_a,
        step_a = sector_angle / frags,
        is_integer = frags % 1 == 0
    )
    r < 0.00005 ? [[0, 0]] : concat([
        for(ang = [begin_a:step_a:end_a])
            [
                r * cos(ang), 
                r * sin(ang)
            ]
    ], 
    is_integer ? [] : [[
            r * cos(end_a), 
            r * sin(end_a)
        ]]
    );
    
function __tr__corner_t_leng_lt_zero(frags, t_sector_angle, l1, l2, h, round_r) = 
    let(t_height = tan(t_sector_angle) * l1 - round_r / sin(90 - t_sector_angle) - h / 2)
    [ 
        for(pt = __pie_for_rounding(round_r, 90 - t_sector_angle, 90, frags * t_sector_angle / 180))
            [pt[0], pt[1] + t_height]
    ];

function __tr_corner_t_leng_gt_or_eq_zero(frags, t_sector_angle, t_leng, h, round_r) = 
    let(offset_y = h / 2 - round_r)
    [
        for(pt = __pie_for_rounding(round_r, 90 - t_sector_angle, 90, frags * t_sector_angle / 360))
            [pt[0] + t_leng, pt[1] + offset_y]
    ];    

function __tr_corner(frags, b_ang, l1, l2, h, round_r) = 
    let(t_leng = l2 - round_r * tan(b_ang / 2))
    t_leng >= 0 ? 
        __tr_corner_t_leng_gt_or_eq_zero(frags, b_ang, t_leng, h, round_r) : 
        __tr__corner_t_leng_lt_zero(frags, b_ang, l1, l2, h, round_r);

function __tr__corner_b_leng_lt_zero(frags, b_sector_angle, l1, l2, h, round_r) = 
    let(
        reversed = __tr__corner_t_leng_lt_zero(frags, b_sector_angle, l2, l1, h, round_r),
        leng = len(reversed)
    )
    [
        for(i = [0:leng - 1])
            let(pt = reversed[leng - 1 - i])
            [pt[0], -pt[1]]
    ];

function __br_corner_b_leng_gt_or_eq_zero(frags, b_sector_angle, l1, l2, b_leng, h, round_r) = 
    let(half_h = h / 2) 
    [
        for(pt = __pie_for_rounding(round_r, -90, -90 + b_sector_angle, frags * b_sector_angle / 360))
            [pt[0] + b_leng, pt[1] + round_r - half_h]
    ];

function __br_corner(frags, b_ang, l1, l2, h, round_r) = 
    let(b_leng = l1 - round_r / tan(b_ang / 2)) 
    b_leng >= 0 ? 
    __br_corner_b_leng_gt_or_eq_zero(frags, 180 - b_ang, l1, l2, b_leng, h, round_r) :
    __tr__corner_b_leng_lt_zero(frags, 180 - b_ang, l1, l2, h, round_r);

function __half_trapezium(length, h, round_r) =
    let(
        is_vt = __is_vector(length),
        l1 = is_vt ? length[0] : length,
        l2 = is_vt ? length[1] : length,
        frags = __frags(round_r),
        b_ang = atan2(h, l1 - l2),
        br_corner = __br_corner(frags, b_ang, l1, l2, h, round_r),
        tr_corner = __tr_corner(frags, b_ang, l1, l2, h, round_r)
    )    
    concat(
        br_corner,
        tr_corner
    );
    
function __trapezium(length, h, round_r) =
    let(
        r_half_trapezium = __half_trapezium(length / 2, h, round_r),
        to = len(r_half_trapezium) - 1,
        l_half_trapezium = [
            for(i = [0:to]) 
                let(pt = r_half_trapezium[to - i])
                [-pt[0], pt[1]]
        ]
    )    
    concat(
        r_half_trapezium,
        l_half_trapezium
    );

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
    concat([
        for(t = [0: t_step: 1]) 
            _bezier_curve_point(t, points)
    ], [_bezier_curve_point(1, points)]);
    

/**
* along_with.scad
*
* Puts children along the given path. If there's only one child, 
* it will put the child for each point. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html
*
**/ 

module along_with(points, angles, twist = 0, scale = 1.0) {
    leng_points = len(points);
    leng_points_minus_one = leng_points - 1;
    twist_step_a = twist / leng_points;
        
    function scale_step() =
        let(s =  (scale - 1) / leng_points_minus_one)
        [s, s, s];

    scale_step_vt = __is_vector(scale) ? 
        [
            (scale[0] - 1) / leng_points_minus_one, 
            (scale[1] - 1) / leng_points_minus_one,
            scale[2] == undef ? 0 : (scale[2] - 1) / leng_points_minus_one
        ] : scale_step(); 

    function _path_angles(i = 0) = 
        i == leng_points_minus_one ?
                [] : 
                concat(
                    [__angy_angz(points[i], points[i + 1])], 
                    _path_angles(i + 1)
                );
            
    function path_angles(points) = 
       let(angs = _path_angles())
       concat(
           [[0, -angs[0][0], angs[0][1]]], 
           [for(a = angs) [0, -a[0], a[1]]]
       );
       
    angles_defined = angles != undef;
    angs = angles_defined ? angles : path_angles(points);

    module align(i) {
        translate(points[i]) 
            rotate(angs[i])
                rotate(angles_defined ? [0, 0, 0] : [90, 0, -90])
                    rotate(twist_step_a * i) 
                         scale([1, 1, 1] + scale_step_vt * i) 
                             children(0);
    }

    if($children == 1) { 
        for(i = [0:leng_points_minus_one]) {
            align(i) children(0);
        }
    } else {
        for(i = [0:min(leng_points, $children) - 1]) {
            align(i) children(i);
        }
    }
}    
    
/**
* shape_trapezium.scad
*
* Returns shape points of an isosceles trapezium.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_trapezium.html
*
**/

function shape_trapezium(length, h, corner_r = 0) = 
    __trapezium(
        length = length, 
        h = h, 
        round_r = corner_r
    );
    
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
        // `semi_minor_axis` is always equal to or greater than than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    module extrude(pre_z = 0, i = 1) {
        if(i <= slices) {
            f = cos(angle * i) / cos(angle * (i - 1));
            z = semi_minor_axis * sin(angle * i);

            translate([0, 0, pre_z]) 
                rotate(-twist / slices * (i - 1)) 
                    linear_extrude(
                        z - pre_z, 
                        convexity = convexity,
                        twist = twist / slices, 
                        slices = 1,
                        scale = f
                    ) children();

            extrude(z, i + 1) 
                scale(f) 
                    children();
        }
    }
    
    translate([0, 0, center == true ? -h / 2 : 0]) 
        extrude() 
            children();
}
    
module scales(ang, leng, radius, height, thickness) {
    module one_scale() {
        rotate([0, ang, 0]) 
            linear_extrude(thickness, center = true) 
                scale([leng, 1]) 
                    circle(1, $fn = 4);    
    }

    for(a = [0:30:330]) {
        rotate(a) 
            translate([radius, 0, height]) 
                one_scale();
        rotate(a + 15) 
            translate([radius, 0, height + 1.75]) 
                one_scale();
    }
}

module one_segment() {
    // scales
    union() {
        scales(60, 5, 5, 0, 1.5);
        scales(75, 2.5, 5, -4, 1.25);
        scales(100, 1.25, 4.5, -7, 1);
        scales(110, 1.25, 3, -9, 1);
        scales(120, 2.5, 2, -9, 1);   
    }
    
    // hair
    for(i = [0:5]) {
        rotate([15 -15 * i, 0, 0]) 
            translate([0, 3, -4]) 
                rotate([45, 0, 0]) rotate([0, 90, 0]) 
                    linear_extrude(2, center = true) 
                        scale([3.5, 2, 1]) 
                            circle(3, $fn = 3);
    }                

    scale([1, 1, 1.1]) sphere(5); 

    // belly
    translate([0, -5, 1]) 
        rotate([-10, 0, 0]) 
            scale([1.1, 0.8, 1.1]) 
                sphere(5, $fn = 8);    
}

module head(angy_angz) {

    module hair() {
        for(i = [18:35]) {
            rotate(i * 10) 
                translate([0, -14, 0]) 
                    rotate([9, 0, 0]) 
                        linear_extrude(15, scale = 0, twist = 30) 
                            translate([0, 10, 0]) 
                                circle(3, $fn = 3);    
        }       

        for(i = [0:35]) {
            rotate(i * 10) 
                translate([0, -12, 0]) 
                    rotate([5, 0, 0]) 
                        linear_extrude(20, scale = 0, twist = 30) 
                            translate([0, 10, 0]) 
                                circle(2, $fn = 3);    
        }
        
        for(i = [0:35]) {
            rotate(i * 10) 
                translate([0, -10, 0]) 
                    rotate([2, 0, 0]) 
                        linear_extrude(22, scale = 0, twist = -30) 
                            translate([0, 10, 0]) 
                                circle(3, $fn = 3);    
        }     
    }
    
    module one_horn() {        
        translate([-10, -4, -1]) 
            rotate([40, -25, 0]) 
                linear_extrude(30, scale = 0, twist = -90) 
                    translate([7.5, 0, 0]) 
                        circle(3, $fn = 4);    
    }
    
    module mouth() {
        translate([0, 0, -2]) 
            rotate([90, 0, -90]) 
                ellipse_extrude(8, slices = 2) 
                    polygon(
                        shape_trapezium([4, 15], 
                        h = 22,
                        corner_r = 0)
                    );       
        
        translate([0, 0, -3]) 
            rotate([90, 0, -90]) 
                 ellipse_extrude(6, slices = 4) 
                     polygon(
                        shape_trapezium([6, 20], 
                        h = 20,
                        corner_r = 0)
                    );    
                    
        mirror([1, 0, 0]) 
            translate([0, 0, -3]) 
                rotate([85, 0, -90])
                    ellipse_extrude(4, slices = 2) 
                        polygon(
                            shape_trapezium([6, 19], 
                            h = 20,
                            corner_r = 0)
                        );       
    }
    
    module one_eye() {
        translate([-5, 3, -2]) 
            rotate([-15, 0, 75]) 
                scale([1, 1, 1.5]) 
                    sphere(1.5, $fn = 5);      
        translate([-5.5, 3.5, -2.5]) 
            rotate([-15, 0, 75]) 
                sphere(0.5, $fn = 12);                      
    }
    
    module one_beard() {
        translate([-11, -12, -11])
            rotate(180) 
                linear_extrude(10, scale = 0, twist = 90) 
                    translate([-10, -10, 0]) 
                        circle(0.75, $fn = 6);    
    }
    


    rotate([0, angy_angz[0] + 15, angy_angz[1]]) 
        translate([0, 0, -25 / 2]) 
            scale(1.15) union() {
                hair();

                translate([0, 0, 2]) union() {
                    rotate(-90) union() {
                         one_horn();
                         mirror([-1, 0, 0]) one_horn();       
                    }
                    
                    mouth();

                    one_eye();
                    mirror([0, 1, 0]) one_eye();
                    
                    one_beard();
                    mirror([0, 1, 0]) one_beard();
                }        
            }
}

module dragon() {


    t_step = 0.015;

    p0 = [0, 0, 0];
    p1 = [0, 50, 35];
    p2 = [-100, 70, 0];
    p3 = [x1, 10, -35];
    p4 = [x2, 150, -40];
    p5 = [x3, 180, -3];
    p6 = [x4, 220, 30];

    path_pts = bezier_curve(t_step, 
        [p0, p1, p2, p3, p4, p5, p6]
    );

    
    angy_angz = __angy_angz(path_pts[0], path_pts[1]);
    
    along_with(path_pts, scale = 0.6)  one_segment();
    head(angy_angz);
}

dragon();




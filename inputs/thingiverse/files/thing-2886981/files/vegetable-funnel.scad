ring_radius = 3.5;
ring_start_angle = 20;
ring_end_angle = 180;
thickness = 2;

funnel_length = 25;
funnel_width = 14;
funnel_height = 25;
linear_extrude_scale = 0.6;

union() {
    linear_extrude(thickness) 
        arc(radius = ring_radius, 
            angle = [ring_start_angle, ring_end_angle], 
            width = thickness, 
            width_mode = "LINE_OUTWARD",
            $fn = 96);

    translate([0, -funnel_width / 2+ thickness / 2, 0]) 
        linear_extrude(funnel_height, scale = linear_extrude_scale) 
            hollow_out(shell_thickness = thickness)
                rounded_square(
                    size = [funnel_length, funnel_width],
                    corner_r = 2, 
                    center = true,
                    $fn = 96
                );
}
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

/**
* arc.scad
*
* Creates an arc. You can pass a 2 element vector to define the central angle. 
* Its $fa, $fs and $fn parameters are consistent with the circle module.
* It depends on the circular_sector module so you have to include circular_sector.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc.html
*
**/ 


module arc(radius, angle, width, width_mode = "LINE_CROSS") {
    polygon(__shape_arc(radius, angle, width, width_mode));
}

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

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
* rounded_square.scad
*
* Creates a rounded square or rectangle in the first quadrant. 
* When center is true the square is centered on the origin.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_square.html
*
**/


module rounded_square(size, corner_r, center = false) {
    is_vt = __is_vector(size);
    x = is_vt ? size[0] : size;
    y = is_vt ? size[1] : size;       
    
    position = center ? [0, 0] : [x / 2, y / 2];
    points = __trapezium(
        length = x, 
        h = y, 
        round_r = corner_r
    );

    translate(position) 
        polygon(points);

    // hook for testing
    test_rounded_square(position, points);
}

// override it to test
module test_rounded_square(position, points) {
}

function __edge_r_begin(orig_r, a, a_step, m) =
    let(leng = orig_r * cos(a_step / 2))
    leng / cos((m - 0.5) * a_step - a);

function __edge_r_end(orig_r, a, a_step, n) =      
    let(leng = orig_r * cos(a_step / 2))    
    leng / cos((n + 0.5) * a_step - a);

function __shape_arc(radius, angle, width, width_mode = "LINE_CROSS") =
    let(
        w_offset = width_mode == "LINE_CROSS" ? [width / 2, -width / 2] : (
            width_mode == "LINE_INWARD" ? [0, -width] : [width, 0]
        ),
        frags = __frags(radius),
        a_step = 360 / frags,
        half_a_step = a_step / 2,
        angles = __is_vector(angle) ? angle : [0, angle],
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        r_outer = radius + w_offset[0],
        r_inner = radius + w_offset[1],
        points = concat(
            // outer arc path
            [__ra_to_xy(__edge_r_begin(r_outer, angles[0], a_step, m), angles[0])],
            m > n ? [] : [
                for(i = [m:n]) 
                    __ra_to_xy(r_outer, a_step * i)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(__edge_r_end(r_outer, angles[1], a_step, n), angles[1])],
            // inner arc path
            angles[1] == a_step * n ? [] : [__ra_to_xy(__edge_r_end(r_inner, angles[1], a_step, n), angles[1])],
            m > n ? [] : [
                for(i = [m:n]) 
                    let(idx = (n + (m - i)))
                    __ra_to_xy(r_inner, a_step * idx)

            ],
            [__ra_to_xy(__edge_r_begin(r_inner, angles[0], a_step, m), angles[0])]        
        )
    ) points;

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

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

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

function __is_vector(value) = !(value >= "") && len(value) != undef;


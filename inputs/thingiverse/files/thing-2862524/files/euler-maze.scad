number_of_circles = 15;
minimum_radius = 3;
gap_distance = 3;
line_width = 1.5;
line_height = 2;
bottom = "NO";       // [YES, NO]
bottom_height = 1;

function angle(r, d) = acos(
    (2 * pow(r, 2) - pow(d, 2)) / (2 * pow(r, 2))
);


module oneGapCircle(r, d, gap_angle1, gap_angle2, width = 1) {
    arc(radius = r, angle = [gap_angle2, gap_angle1 + 360], width = width);
}

module twoGapsCircle(r, d, gap_angle, gap_angle1_begin, gap_angle2_begin, width = 1) {
    arc(radius = r, angle = [gap_angle1_begin + gap_angle, gap_angle2_begin], width = width);
    arc(radius = r, angle = [gap_angle2_begin + gap_angle, gap_angle1_begin + 360], width = width);  
}

module euler_maze(n, r, d, width = 1) {

    module euler_circles(n, inner_r, pre_gap_angle, pre_gap_angle_offset) {
        outer_r = inner_r + r;
        gap_angle = angle(outer_r, d);
        gap_angle_offset = pre_gap_angle_offset + pre_gap_angle / 2 - gap_angle / 2;  
            
        p1 = [inner_r * cos(pre_gap_angle_offset), inner_r * sin(pre_gap_angle_offset)];
        p2 = [outer_r * cos(gap_angle_offset), outer_r * sin(gap_angle_offset)];
        
        p3 = [inner_r * cos(pre_gap_angle + pre_gap_angle_offset), inner_r * sin(pre_gap_angle + pre_gap_angle_offset)];
        p4 = [outer_r * cos(gap_angle_offset + gap_angle), outer_r * sin(gap_angle_offset + gap_angle)]; 

        line2d(p1, p2, width = width, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND");
        line2d(p3, p4, width = width, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND");  
                   
        if(n != 0) {
            rand_a = rands(15, 180, 15)[0];
            angle_between_gap = rand_a - gap_angle;         
            twoGapsCircle(outer_r, d, 
                gap_angle,
                gap_angle_offset,
                gap_angle_offset + gap_angle + angle_between_gap,
                width = width);
            euler_circles(n - 1, outer_r, gap_angle, gap_angle_offset + rand_a);            
        } else {
            oneGapCircle(outer_r, d, gap_angle_offset, gap_angle_offset + gap_angle, width = width);  
        }
    }
    
    gap_angle = angle(r, d);
    
    oneGapCircle(r, d, 0, gap_angle, width = width);
    euler_circles(n - 2, r, gap_angle, 0);
}

linear_extrude(line_height) euler_maze(number_of_circles, minimum_radius, gap_distance, line_width, $fn = 96);

if(bottom == "YES") {
    linear_extrude(bottom_height) circle(minimum_radius * number_of_circles + line_width / 2, $fn = 96);
}
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

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

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

function __is_vector(value) = !(value >= "") && len(value) != undef;

/**
* line2d.scad
*
* Creates a line from two points.
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
                circle(half_width, center = true, $fn = frags);    

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

function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;



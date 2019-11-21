radius = 45; // [45:450]
bottom_thickness = 2;

text = "NEVER CRASH";
font_name = "Arial Black";
font_size = 8;

/**
* pie.scad
*
* Creates a pie (circular sector). You can pass a 2 element vector to define the central angle. Its $fa, $fs and $fn parameters are consistent with the circle module.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-pie.html
*
**/

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);
                
function __is_vector(value) = !(value >= "") && len(value) != undef;

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

function __shape_pie(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        leng = radius * cos(a_step / 2),
        angles = __is_vector(angle) ? angle : [0:angle],
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        edge_r_begin = leng / cos((m - 0.5) * a_step - angles[0]),
        edge_r_end = leng / cos((n + 0.5) * a_step - angles[1]),
        shape_pts = concat(
            [[0, 0], __ra_to_xy(edge_r_begin, angles[0])],
            m > n ? [] : [
                for(i = [m:n]) 
                    let(a = a_step * i) 
                    __ra_to_xy(radius, a)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(edge_r_end, angles[1])]
        )
    ) shape_pts;
 
module pie(radius, angle) {
    polygon(__shape_pie(radius, angle));
}

module char(c, font_name, font_size) {
    rotate(90) 
        rotate([-90, 0, 0]) 
            intersection() {
                linear_extrude(font_size * 2, center = true) 
                    pie(radius = font_size * 2, angle = [-30, 0]);  
                    
                rotate_extrude() 
                    translate([font_size / 1.25, 0, 0]) rotate(-90) 
                        text(c, font = font_name, size = font_size, valign = "center", halign = "center"); 
            }
}

module Buddha_Duke() {
    t_len = len(text);
    a_step = 180 / t_len;
    
    for(i = [0:t_len - 1]) {
        translate([0, 0, bottom_thickness]) 
            rotate(-90 + a_step * i + 0.45 * a_step)
                translate([0, -radius + font_size / 2, 0]) 
                    char(text[i], font_name, font_size, $fn = 12);
    }

    linear_extrude(bottom_thickness) 
        circle(radius, $fn = 48); 
}

Buddha_Duke(text, font_name, font_size, radius, bottom_thickness);
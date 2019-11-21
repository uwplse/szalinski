minute = 18; 
hour = 9;    
r = 30;
thickness = 2;
angle = 90;
frags = 24; 
xscale = 1.5;

module clock(r, thickness, hour, minute) {
    hollow_out(thickness) 
        circle(r);
    
    circle(thickness);
    
    rotate(-30 * hour - 0.5 * minute) 
        line2d([0, 0], [0, r - thickness * 6], thickness, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND", $fn = 4);
    
    rotate(-6 * minute) 
        line2d([0, 0], [0, r - thickness * 3], thickness * 0.75, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND", $fn = 4);  
 
    for(i = [0: 11]) {
        rotate(i * 30) translate([0, r - thickness * 4, 0]) 
            square([thickness / 2, thickness * 2]);
    }
}

module melt(r, thickness, angle, frags, xscale = 1) {
    double_r = r * 2;
    half_r = r * 0.5;
    rz = r * 180 / (angle * 3.14159);
    
    union() {
        scale([xscale, 1, 1]) translate([0, -r, rz])
            rotate([90, 0, 0]) 
                bend_extrude([r, double_r], thickness, angle, frags) 
                    translate([0, r, 0]) 
                        children(); 

        linear_extrude(thickness) 
            intersection() {
                translate([-half_r, 0, 0]) 
                    square([r, double_r], center = true);
                children();
            }
    }
}

module melted_clock() {

    $fn = 48;
    sa = r * angle / (r + thickness);
    rotate([180, 0, 0]) {
        color("Gold") translate([0, 0, thickness])  melt(r, thickness, angle, frags, xscale) circle(r);
        color("Gainsboro") melt(r, thickness, sa, frags, xscale) mirror([0, 1, 0]) clock(r - thickness * 2, thickness, hour, minute);
        ;
    }

}
 melted_clock();


/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;



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



/**
* hollow_out.scad
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

module bend_extrude(size, thickness, angle, frags = 24) {
    x = size[0];
    y = size[1];
    frag_width = x / frags ;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    s =  (r - thickness) / r;
    
    module get_frag(i) {
        offsetX = i * frag_width;
        linear_extrude(thickness, scale = [s, 1]) 
            translate([-offsetX - half_frag_width, 0, 0]) 
                intersection() {
                    children();
                    translate([offsetX, 0, 0]) 
                        square([frag_width, y]);
                }
    }

    offsetY = -r * cos(half_frag_angle) ;
    for(i = [0 : frags - 1]) {
       rotate(i * frag_angle + half_frag_angle) 
            translate([0, offsetY, 0])
                rotate([-90, 0, 0]) 
                    get_frag(i) 
                        children();  
    }

}


function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);


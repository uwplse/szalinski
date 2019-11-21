// include <voronoi.scad>;
r = 35;
height = 35;
thickness = 2.5;
n = 25;
frags = 24;
offset_r = 0.5;
region_type = "square"; // [square, circle]

module voronoi_bracelet(r, height, thickness, n, frags, offset_r, region_type) {
    $fn = 12;
    
    x = 6.28318 * r - thickness;
    y = height;
    z = thickness;

    xs = rands(0, x, n);
    ys = rands(0, y, n);

    points = [for(i = [0: len(xs) - 1]) [xs[i], ys[i]]];
        
    bend_extrude(size = [x, y, z], angle = 360 * (1 - thickness / (6.28318 * r)), frags = frags)  
         {
            difference() {
                square([x, y]);
                voronoi(points, spacing = thickness, r = offset_r, region_type = region_type);
            }
            hollow_out(thickness * 1.5)
                square([x, y]);
        }
}

voronoi_bracelet(r, height, thickness, n, frags, offset_r, region_type);

module voronoi(points, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square") {
    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];

    region_size = max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);    
    half_region_size = 0.5 * region_size; 
    offset_leng = spacing * 0.5 + half_region_size;

    function normalize(v) = v / norm(v);
    
    module region(pt) {
        intersection_for(p = points) {
            if(pt != p) {
                v = p - pt;
                translate((pt + p) / 2 - normalize(v) * offset_leng)
                    rotate(atan2(v[1], v[0])) 
                    if(region_type == "square") {
                        square(region_size, center = true);
                    }
                    else if(region_type == "circle") {
                        circle(region_size / 2);
                    }
                    
            }
        }
    }    
    
    for(p = points) {	
        if(r != 0) {        
            offset(r) region(p);
        }
        else {
            offset(delta = delta, chamfer = chamfer) region(p);
        }
    }
}
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

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

module bend_extrude(size, angle, frags = 24) {
    x = size[0];
    y = size[1];
    z = size[2];
    frag_width = x / frags ;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    s =  (r - z) / r;
    
    module get_frag(i) {
        offsetX = i * frag_width;
        linear_extrude(z, scale = [s, 1]) 
            translate([-offsetX - half_frag_width, 0, 0]) 
                intersection() {
                    children();
                    translate([offsetX, 0, 0]) 
                        square([frag_width, y]);
                }
    }

    offsetY = -r * cos(half_frag_angle) ;
    for(i = [0 : frags - 1]) {
       rotate(i * frag_angle) 
            translate([0, offsetY, 0])
                rotate([-90, 0, 0]) 
                    get_frag(i) 
                        children();  
    }

}

// override it to test
module test_bend_tri_frag(points, angle) {

}




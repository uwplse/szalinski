r = 30;
thickness = 2;
point_number = 12;
fn = 24;
stl_file = "";

module voronoi_sphere(r, thickness, point_number, fn, stl_file = "") {
    $fn = fn;
    if(stl_file == "") {

        zas = rands(0, 359, point_number);
        yas = rands(0, 179, point_number);

        points = [
            for(i = [0:point_number - 1])
            let(cyas = cos(yas[i]))
            [
                r * cyas * cos(zas[i]), 
                r * cyas * sin(zas[i]), 
                r * sin(yas[i])
            ]
        ];

        intersection() {
            sphere(r);
            voronoi3d(points);
        }  
    }
    else {
        difference() {
            sphere(r);
            scale(1.01) import(stl_file);
            sphere(r - thickness);
        }        
    }
}

voronoi_sphere(r, thickness, point_number, fn, stl_file);


    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

function __angy_angz(p1, p2) = 
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2],
        ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
        za = atan2(dy, dx)
    ) [ya, za];


// slow but workable

module voronoi3d(points, spacing = 1, space_type = "cube") {
    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];
    zs = [for(p = points) abs(p[2])];

    space_size = max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2, (max(zs) -  min(zs)) / 2]);    
    half_space_size = 0.5 * space_size; 
    offset_leng = spacing * 0.5 + half_space_size;

    function normalize(v) = v / norm(v);
    
    module space(pt) {
        intersection_for(p = points) {
            if(pt != p) {
                v = p - pt;
                ryz = __angy_angz(p, pt);

                translate((pt + p) / 2 - normalize(v) * offset_leng)
                    rotate([0, -ryz[0], ryz[1]]) 
                    if(space_type == "cube") {
                        cube(space_size, center = true); 
                    }
                    else if(space_type == "sphere") {
                        sphere(half_space_size); 
                    }
            }
        }
    }    
    
    for(p = points) {	
        space(p);
    }
}


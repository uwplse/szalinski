
leng = 50;
thickness = 5;
segs_per_side = 20;
line_fn = 5;
model = "Tetrahedron"; // [Tetrahedron, Base, Both]

module lines_between(side1, side2, thickness, segs) {
    function pts(p1, p2, segs) =
        let(
             p = p2 - p1,
             dx = p[0] / segs,
             dy = p[1] / segs,
             dz = p[2] / segs
        ) [for(i = [0:segs]) p1 + [dx, dy, dz] * i];

    pts1 = pts(side1[0], side1[1], segs);
    pts2 = pts(side2[0], side2[1], segs);
    
    for(i = [0:len(pts1) - 1]) {
        hull_polyline3d(points = [pts1[i], pts2[i]], thickness = thickness);
    }
}

function height(leng) = 
    leng * sqrt(1 - 4 / 9 * pow(sin(60), 2));

function vts(leng) = 
    let(
        half_leng = leng / 2,
        vt1 = [half_leng, 0, 0],
        vt2 = [0, leng * sin(60), 0],
        vt3 = [-half_leng, 0, 0],
        vt4 = [0, half_leng * tan(30), height(leng)]
    ) [vt1, vt2, vt3, vt4];

module string_tetrahedron(leng, thickness, segs_per_side, line_fn) {
    $fn = line_fn;
    
    half_leng = leng / 2;
    
    vts = vts(leng);

    vt1 = vts[0];
    vt2 = vts[1];
    vt3 = vts[2];
    vt4 = vts[3];

    lines_between([vt1, vt2], [vt3, vt4], thickness, segs_per_side);
    lines_between([vt2, vt3], [vt1, vt4], thickness, segs_per_side);
    lines_between([vt3, vt1], [vt2, vt4], thickness, segs_per_side);
}

module base(leng, thickness, line_fn) {
    vts = vts(leng);
    r = leng / 4;

    difference() {
        sphere(r, $fn = 48);
        
        translate([0, 0, -r])
            linear_extrude(r) 
                square(r * 2, center = true);
        
        translate([0, 0, height(leng) + thickness / 2])
             rotate([0, 180, 0]) 
                 translate([0, -leng / 2 * tan(30), 0]) 
                     hull() {
                        translate(vts[0])
                            sphere(thickness / 2, $fn = line_fn);
                        translate(vts[1])
                            sphere(thickness / 2, $fn = line_fn);
                        translate(vts[2])
                            sphere(thickness / 2, $fn = line_fn);
                        translate(vts[3])
                            sphere(thickness / 2, $fn = line_fn);     
                     }
    }
}

if(model == "Tetrahedron") {
    string_tetrahedron(leng, thickness, segs_per_side, line_fn);
} else if(model == "Base") {
    base(leng, thickness, line_fn);
} else {
    translate([0, 0, height(leng) + thickness / 2])
         rotate([0, 180, 0]) 
             translate([0, -leng / 2 * tan(30), 0]) 
                 string_tetrahedron(leng, thickness, segs_per_side, line_fn);
    base(leng, thickness, line_fn);
}
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

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


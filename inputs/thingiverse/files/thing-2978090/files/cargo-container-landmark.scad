platform = "YES"; // [YES, NO]
cube_only = "YES";   // [YES, NO]

cargo_container_landmark();

module cargo_container_landmark() {
    cargo_width = 15;
    cargo_height = 16;
    cargo20ft_len = 37.5;
    cargo40ft_len = 75;
    edge = cargo_height / 40;

    if(platform == "YES") {
        color("black") 
            box_extrude(height = 2, shell_thickness = 1)  
                circle(75, $fn = 96);
        }
    
    color("red") 
        translate([-40, -10, 38.75]) 
            rotate([18.315, 17.75, 0])
                cargo_container_landmark0();


    module cargo_container(cargo_leng) {
        difference() {
            union() {
                cargo_container0(cargo_leng);
                translate([0, cargo_width / 2, cargo_height / 2]) rotate([0, 90, 0])
                 union() {
                    translate([0, cargo_width / 4.45, 0]) door();
                    translate([0, -cargo_width / 4.45, 0]) door();
                }
            }
            translate([cargo_leng / 2, cargo_width / 2, -cargo_height / 400]) linear_extrude(cargo_height / 80, scale = 0.95) square([cargo_leng * 0.975, cargo_width  * 0.9], center = true);
        }
    }

    module door() {
        difference() {
                linear_extrude(cargo_height / 40, scale = 0.95) square([cargo_height * 0.9, cargo_width * 0.425], center = true);
                
                translate([0, 0, ,-cargo_height / 400]) linear_extrude(cargo_height / 30, scale = 0.95) square([cargo_height * 0.045, cargo_width * 0.425 * 0.8], center = true);
                translate([cargo_height / 4.25, 0, ,-cargo_height / 400]) linear_extrude(cargo_height / 30, scale = 0.95) square([cargo_height * 0.045, cargo_width * 0.425 * 0.8], center = true);
                translate([-cargo_height / 4.25, 0, ,-cargo_height / 400]) linear_extrude(cargo_height / 30, scale = 0.95) square([cargo_height * 0.045, cargo_width * 0.425 * 0.8], center = true);        
            }
    }

    module cargo_container0(cargo_len) {
        d_offset = cargo_height / 400;
        railing_leng = cargo_len == cargo20ft_len ? 20 : 40;

        difference() {
            cube([cargo_len, cargo_width, cargo_height]);
            
            
       translate([-d_offset, cargo_width / 2, cargo_height / 2]) rotate([0, 90, 0]) linear_extrude(cargo_height / 40, scale = 0.95) square([cargo_height * 0.95, cargo_width * 0.95], center = true);


        translate([cargo_len + d_offset, cargo_width / 2, cargo_height / 2]) rotate([90, 0, -90]) railing(cargo_width);

        translate([cargo_len / 2, cargo_width / 2, cargo_height + d_offset]) rotate([180, 0, 0]) scale([1, 0.925, 1]) railing(railing_leng);


        translate([0, -d_offset, 0]) mirror([0, 1, 0]) translate([cargo_len / 2, 0, cargo_height / 2]) rotate([90, 0, 0]) railing(railing_leng);

        translate([cargo_len / 2, cargo_width + d_offset, cargo_height / 2]) rotate([90, 0, 0]) railing(railing_leng);
        }
    }

    module railing(length) {
        end = length == 20 ? 22 : (length == 40 ? 45 : 8);
        leng = length == 20 ? cargo20ft_len : (length == 40 ? cargo40ft_len : length);
        x_offset = length == 20 ? cargo_height / 30 : (length == 40 ? cargo_height / 80 : cargo_height / 30);
        
        points = [for(i = [0:end]) [i * (cargo_height / 10), 0]];
        translate([-leng / 2 + cargo_height / 10 - x_offset , 0, 0]) along_with(points) 
            rotate([-90, 90, 0]) linear_extrude(cargo_height / 40, scale = [0.7, 0.9]) 
                square([cargo_height / 20, cargo_height - edge], center = true);
    }

    module cargo20ft() {
        if(cube_only == "NO") {
            cargo_container(cargo20ft_len);
        }
        else {
            cube([cargo20ft_len, cargo_width, cargo_height]);
        }
    }

    module cargo40ft() {
        if(cube_only == "NO") {
            cargo_container(cargo40ft_len);
        }
        else {
            cube([cargo40ft_len, cargo_width, cargo_height]);
        }
    }




    module cargo_container_landmark0() {
        union() {
            union() {
                translate([cargo40ft_len + cargo_width, cargo_width - cargo20ft_len, 0]) 
                    rotate(90) 
                        cargo20ft();
                translate([cargo20ft_len + cargo_width, -cargo20ft_len, 0]) 
                    cargo20ft();
            }

            union() {
                translate([cargo_width + cargo20ft_len, -cargo40ft_len + cargo20ft_len, cargo40ft_len - cargo20ft_len])  
                    rotate(90) 
                        cargoL1();
            }

            translate([cargo_width, cargo20ft_len, -cargo20ft_len]) 
                cargoL2();

            union() {
                cargoL1();
                translate([cargo_width, cargo_width, -cargo20ft_len]) 
                    rotate([0, 0, 90]) 
                        cargo20ft();
            }
        }
    }

    module cargoL1() {
        union() {
            translate([cargo_height, 0, -cargo20ft_len]) 
                rotate([0, -90, 0]) 
                    cargo20ft();
            cargo40ft();
        }
    }


    module cargoL2() {
        union() {
            translate([cargo20ft_len, 0, cargo_height]) 
                rotate([0, -90, 0]) 
                    cargo40ft();
            cargo20ft();
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

function __is_vector(value) = !(value >= "") && len(value) != undef;

function __angy_angz(p1, p2) = 
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2],
        ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
        za = atan2(dy, dx)
    ) [ya, za];

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
    
    end_i = $children == 1 ? leng_points_minus_one : $children - 1;

    function _path_angles(pts, i = 0) = 
        i == end_i ?
                [] : 
                concat(
                    [__angy_angz(pts[i], pts[i + 1])], 
                    _path_angles(pts, i + 1)
                );
            
    function path_angles() = 
       let(
           pts = len(points[0]) == 3 ? points : [for(pt = points) __to3d(pt)],
           angs = _path_angles(pts)
        )
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

    // hook for testing
    test_along_with_angles(angs);
}

module test_along_with_angles(angles) {
    
}

function __to3d(p) = [p[0], p[1], 0];

/**
* box_extrude.scad
*
* Creates a box (container) from a 2D object.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-box_extrude.html
*
**/

module box_extrude(height, shell_thickness, offset_mode = "delta", chamfer = false) {
    linear_extrude(shell_thickness)
        children();
        
    linear_extrude(height) 
        difference() {
            children();
            if(offset_mode == "delta") {
                offset(delta = -shell_thickness, chamfer = chamfer) 
                    children(); 
            } else {
                offset(r = -shell_thickness) 
                    children(); 
            } 
        }    
}

    



part = "SPRING"; // [FRONT, SPRING, BACK]

head_radius = 15;
spring_levels = 20;
line_thickness = 4;
line_distance = 1.5;

latch_r1 = 2.5;
latch_r2 = 3;
latch_h = 6;
latch_spacing = 0.4;


module latch_prototype(r1, r2, h) {
    rd = r2 - r1;
    
    union() {
        linear_extrude(h) 
            circle(r1);
            
        translate([0, 0, h - rd]) 
            rotate_extrude() 
                translate([r2 - rd, 0, 0]) 
                    circle(rd, $fn = 4);
    }
}

module latch_convex(r1, r2, h) {
    rd = r2 - r1;
    
    difference() {
        latch_prototype(r1, r2, h);
        
        translate([0, 0, rd * 2])  
            linear_extrude(h - rd * 2) 
                square([rd * 2, r2 * 2], center = true);
    
    }
}

module latch_concave(r1, r2, h, spacing) {
    latch_prototype(r1 + spacing, r2 + spacing, h);
    translate([0, 0, h]) 
        linear_extrude(spacing) 
            circle(r2);
}


module toy_spring(radius, levels, sides, line_thickness, line_distance) {
    $fn = 4;
    
    spring = circle_path(radius = line_thickness / 2);

    helix_extrude(spring, 
        radius = radius, 
        levels = levels, 
        level_dist = line_thickness + line_distance,
        $fn = sides
    );
    
    if(line_distance != 0) {
        spring_gap = circle_path(radius = line_distance / 2);
        
        #translate([0, 0, line_thickness / 2 + line_distance / 2])
            helix_extrude(spring_gap, 
                radius = radius, 
                levels = levels, 
                level_dist = line_thickness + line_distance,
                $fn = sides
            );        
    }
    
}


module dog_back(head_r, latch_r1, latch_r2, latch_h) {
    $fn = 36;    

    module foot() {
        translate([head_r, 0, 0]) union() {
            color("PapayaWhip") ellipse_extrude(head_r / 3) polygon(
                shape_ellipse([head_r / 3, head_r / 2])
            );
            
            color("Maroon")  linear_extrude(head_r) circle(head_r / 8);
            
            color("Goldenrod") translate([head_r / 45, 0, head_r / 2]) rotate([0, -15, 0]) rounded_cylinder(
                radius = [head_r / 5, head_r / 3.5], 
                h = head_r * 1.25, 
                round_r = 2
            );            
        }    
    }


    module feet() {
        foot();
        mirror([1, 0, 0]) foot();
    }

    module body_feet() {
        translate([0, -head_r / 5, -head_r * 1.65]) 
            feet();

        union() {
            color("Goldenrod") scale([1, 1.25, 1]) difference() {
                sphere(head_r);
                
                translate([-head_r, head_r / 6, -head_r]) 
                    cube(head_r * 2);
            }
        }
    }

    module back() {
        mirror([0, 1, 0]) 
            body_feet();
        rotate([-36.5, 0, 0]) 
            color("Goldenrod") 
                linear_extrude(head_r * 2, scale = 0.5) 
                    circle(head_r / 6);
    }

    back();
    

        
    color("Goldenrod")  translate([0, -head_r * 0.2, 0]) 
        rotate([90, 0, 0]) 
            latch_convex(latch_r1, latch_r2, latch_h);
}

module spring_dog_spring(head_r, spring_levels, line_thickness, line_distance, latch_r1, latch_r2, latch_h, latch_spacing) {
    spring_sides = 36;
    h = spring_levels * line_thickness;

    module latch_plate_back() {
        difference() {
            linear_extrude(latch_h + latch_spacing) 
                circle(head_r);  
            
            latch_concave(latch_r1, latch_r2, latch_h, latch_spacing, $fn = spring_sides);
        }         
    }

    module latch_plate_front() {
        linear_extrude(latch_h + latch_spacing) 
            circle(head_r);  
        
        translate([0, 0, latch_h + latch_spacing]) 
            latch_convex(latch_r1, latch_r2, latch_h, $fn = spring_sides);      
    }    
    
    color("yellow") union() {
        latch_plate_back();
        
        translate([0, 0, line_thickness / 2])  toy_spring(
            head_r - line_thickness / 1.5, 
            spring_levels, 
            spring_sides, 
            line_thickness,
            line_distance
        );
        
        translate([0, 0, h + line_distance * spring_levels]) 
            latch_plate_front();
    }
}

module dog_front(head_r, latch_r1, latch_r2, latch_h, latch_spacing) {
    $fn = 36;
    
    module head() {

        module head_nose() {
            color("Goldenrod") 
                rotate([-15, 0, 0]) 
                    scale([1, 0.9, 0.9]) 
                        sphere(head_r);

            // nose
            color("PapayaWhip") 
                translate([0, -head_r * 0.45, -head_r / 5]) 
                    rotate([85, 0, 0]) 
                        scale([1.25, 0.8, 1]) 
                            rounded_cylinder(
                                radius = [head_r / 2, head_r / 6], 
                                h = head_r * 1.25, 
                                round_r = 4
                            );    

            color("black") 
                translate([0, -head_r * 1.6, 0]) 
                    rotate([15, 0, 0]) 
                        scale([1.25, 1, 1]) 
                            sphere(head_r / 7);    
        }
        
        module eye() {
            translate([head_r / 2, -head_r / 1.75, head_r / 3]) 
                rotate([-20, 5, 30]) 
                    scale([1.2, 0.5, 1]) union() {
                        color("Goldenrod") 
                            sphere(head_r / 3);

                         color("white") 
                             translate([0, 0, -head_r / 15]) 
                                 rotate([-25, -10, 0]) 
                                     scale([1.1, 1.25, 1.2]) 
                                         sphere(head_r / 3.5);
                     
                        color("black") 
                            translate([-head_r / 15, -head_r / 4, -head_r / 12]) 
                                sphere(head_r / 7);
                }    
        }
        
        module eyes() {
            eye();
            mirror([1, 0, 0]) 
                eye();
        }
        
        module eyebrow() {
            color("black") 
                translate([head_r / 2.5, -head_r / 2.5, head_r / 3]) 
                    rotate([60, 15, 30]) 
                        linear_extrude(head_r / 2, center = true) scale([1.5, 1, 1]) 
                            arc(radius = head_r / 3, angle = 120, width = head_r / 20);
            
        }
        
        module eyebrows() {
            eyebrow();
            mirror([1, 0, 0]) eyebrow();
        }
        
        shape_pts = shape_glued2circles(head_r / 2, head_r * 2.5, tangent_angle = 35);

        module ear() {
            color("Maroon") 
                rotate([-15, 0, -10]) 
                    translate([-head_r / 2.75, head_r / 15, -head_r / 2.75]) 
                        rotate([0, -60, 0]) 
                            scale([1.25, 1, 1]) intersection() {
                                translate([head_r, 0, 0]) 
                                    linear_extrude(head_r) 
                                        polygon(shape_pts); 

                                difference() {
                                    sphere(head_r);
                                    sphere(head_r - head_r / 10);
                                }
                            }    
        }   

        module ears() {
            ear();
            mirror([1, 0, 0]) ear();
        }    

        head_nose();
        eyes();
        eyebrows();
        ears();

    }


    module foot() {
        translate([head_r, -head_r / 11, 0]) union() {
            color("PapayaWhip") ellipse_extrude(head_r / 3) polygon(
                shape_ellipse([head_r / 3, head_r / 2])
            );
            
            color("Maroon")  linear_extrude(head_r) circle(head_r / 8);
            
            color("Goldenrod") translate([head_r / 45, 0, head_r / 2]) rotate([0, -15, 0]) rounded_cylinder(
                radius = [head_r / 5, head_r / 3.5], 
                h = head_r * 1.25, 
                round_r = 2
            );            
        }    
    }


    module feet() {
        foot();
        mirror([1, 0, 0]) foot();
    }

    module body_feet() {
        translate([0, -head_r / 5, -head_r * 1.65]) 
            feet();

        union() {
            color("Goldenrod") scale([1, 1.25, 1]) difference() {
                sphere(head_r);
                
                translate([-head_r, head_r / 6, -head_r]) 
                    cube(head_r * 2);
            }
        }
    }

    module front() {
        body_feet();

        // neck
        rotate([60, 0, 0]) 
            union() {
                color("Goldenrod") 
                    linear_extrude(head_r * 2) 
                        circle(head_r / 4);
                
                color("green") 
                    translate([0, 0, head_r * 1.1]) 
                        rotate([-10, 0, 0]) 
                            rotate_extrude() 
                                translate([head_r / 4, 0, 0]) 
                                    circle(head_r / 10);
            }
    }
    
        
    
    translate([0, -head_r * 1.75 , head_r * 1.3]) 
        head();
        
    difference() {
        front();
        
        translate([0, head_r * 0.209, 0]) rotate([90, 0, 0]) latch_concave(latch_r1, latch_r2, latch_h, latch_spacing, $fn = 36);    
    }
}

if(part == "FRONT") {
    dog_front(head_radius, latch_r1, latch_r2, latch_h, latch_spacing);
} else if(part == "SPRING") {
    spring_dog_spring(head_radius, spring_levels, line_thickness, line_distance, latch_r1, latch_r2, latch_h, latch_spacing);

} else if(part == "BACK") {
    dog_back(head_radius, latch_r1, latch_r2, latch_h);
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

function __is_float(value) = value + 0 != undef;

function __to2d(p) = [p[0], p[1]];

/**
* rounded_cylinder.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cylinder.html
*
**/


module rounded_cylinder(radius, h, round_r, convexity = 2, center = false) {  
    r_corners = __half_trapezium(radius, h, round_r);
    
    shape_pts = concat(
        [[0, -h/2]],
        r_corners,           
        [[0, h/2]]
    );

    center_pt = center ? [0, 0, 0] : [0, 0, h/2];

    translate(center ? [0, 0, 0] : [0, 0, h/2]) 
        rotate(180) 
            rotate_extrude(convexity = convexity) 
                polygon(shape_pts);

    // hook for testing
    test_center_half_trapezium(center_pt, shape_pts);
}

// override it to test
module test_center_half_trapezium(center_pt, shape_pts) {
    
}


/**
* cross_sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-cross_sections.html
*
**/


function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        scale_step_vt = __is_float(scale) ? 
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one] :
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one]
            ,
        scale_step_x = scale_step_vt[0],
        scale_step_y = scale_step_vt[1],
        twist_step = twist / len_path_pts_minus_one
    )
    [
        for(i = [0:len_path_pts_minus_one])
            [
                for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                    rotate_p(
                        rotate_p(scaled_p, twist_step * i)
                        , angles[i]
                    ) + pth_pts[i]
            ]
    ];


function __reverse(vt) = 
    let(leng = len(vt))
    [
        for(i = [0:leng - 1])
            vt[leng - 1 - i]
    ];

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
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0], 
        pt[1] * cosa - pt[2] * sina,
        pt[1] * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa + pt[2] * sina, 
        pt[1],
        -pt[0] * sina + pt[2] * cosa, 
    ];

function _rotz(pt, a) = 
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
    v == undef ? _rotate_p(point, a) : _q_rotate_p(point, a, v);


/**
* shape_ellipse.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/


function shape_ellipse(axes) =
    let(
        frags = __frags(axes[0]),
        step_a = 360 / frags,
        shape_pts = [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ]
    ) shape_pts;

/**
* circle_path.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-circle_path.html
*
**/


function circle_path(radius, n) =
    let(
        _frags = __frags(radius),
        step_a = 360 / _frags,
        end_a = 360 - step_a * ((n == undef || n > _frags) ? 1 : _frags - n + 1)
    )
    [
        for(a = [0 : step_a : end_a]) 
            [radius * cos(a), radius * sin(a)]
    ];


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
    h = height == undef ? semi_minor_axis : (
        // `semi_minor_axis` is always equal to or greater than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    function f_extrude(i = 1) = 
        i <= slices ? 
            concat(
                [
                    [
                        cos(angle * i) / cos(angle * (i - 1)), 
                        semi_minor_axis * sin(angle * i)
                    ]
                ],
                f_extrude(i + 1)
            ) : []; 

    fzs = f_extrude(); 
    len_fzs = len(fzs);

    function accm_fs(pre_f = 1, i = 0) =
        i < len_fzs ? 
            concat(
                [pre_f * fzs[i][0]],
                accm_fs(pre_f * fzs[i][0], i + 1)
            ) : [];
    
    child_fs = concat([1], accm_fs());
    pre_zs = concat(
        [0],
        [
            for(i = [0:len_fzs - 1])
                fzs[i][1]
        ]
    );

    module extrude() {
        for(i = [0:len_fzs - 1]) {
            f = fzs[i][0];
            z = fzs[i][1];

            translate([0, 0, pre_zs[i]]) 
                rotate(-twist / slices * i) 
                    linear_extrude(
                        z - pre_zs[i], 
                        convexity = convexity,
                        twist = twist / slices, 
                        slices = 1,
                        scale = f 
                    ) scale(child_fs[i]) children();
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

function __to3d(p) = [p[0], p[1], 0];

function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : (
         leng == 2 ? [a[0], a[1], 0] :  [a[0], 0, 0]
     );

function __to_ang_vect(a) = __is_float(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);

/**
* polysections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html
*
**/


module polysections(sections, triangles = "SOLID") {

    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0])
        ) 
        concat(
            [
                for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                    for(i = [0:leng_pts_sect - 1]) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect
                        ]
            ],
            [
                for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                    for(i = [0:leng_pts_sect - 1]) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                            j + i + leng_pts_sect
                        ]
            ]      
        );

    function search_at(f_sect, p, leng_pts_sect, i = 0) =
        i < leng_pts_sect ?
            (p == f_sect[i] ? i : search_at(f_sect, p, leng_pts_sect, i + 1)) : -1;
    
    function the_same_after_twisting(f_sect, l_sect, leng_pts_sect) =
        let(
            found_at_i = search_at(f_sect, l_sect[0], leng_pts_sect)
        )
        found_at_i <= 0 ? false : 
            l_sect == concat(
                [for(i = [found_at_i:leng_pts_sect-1]) f_sect[i]],
                [for(i = [0:found_at_i - 1]) f_sect[i]]
            ); 

    function to_v_pts(sects) = 
            [
            for(sect = sects) 
                for(pt = sect) 
                    pt
            ];                   

    module solid_sections(sects) {
        
        leng_sects = len(sects);
        leng_pts_sect = len(sects[0]);
        first_sect = sects[0];
        last_sect = sects[leng_sects - 1];
   
        v_pts = [
            for(sect = sects) 
                for(pt = sect) 
                    pt
        ];

        function begin_end_the_same() =
            first_sect == last_sect || 
            the_same_after_twisting(first_sect, last_sect, leng_pts_sect);

        if(begin_end_the_same()) {
            f_idxes = side_indexes(sects);

            polyhedron(
                v_pts, 
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);
        } else {
            first_idxes = [for(i = [0:leng_pts_sect - 1]) leng_pts_sect - 1 - i];  
            last_idxes = [
                for(i = [0:leng_pts_sect - 1]) 
                    i + leng_pts_sect * (leng_sects - 1)
            ];    

            f_idxes = concat([first_idxes], side_indexes(sects), [last_idxes]);
            
            polyhedron(
                v_pts, 
                f_idxes
            );   

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);             
        }
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            [
                for(i = [0:leng_sects - 1]) 
                    [
                        for(j = [begin_idx:end_idx])
                            sects[i][j]
                    ]
            ]; 

        function first_idxes() = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                       i,
                       i + half_leng_v_pts,
                       (i + 1) % half_leng_sect + half_leng_v_pts, 
                       (i + 1) % half_leng_sect
                    ] 
            ];

        function last_idxes(begin_idx) = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                       begin_idx + i,
                       begin_idx + (i + 1) % half_leng_sect,
                       begin_idx + (i + 1) % half_leng_sect + half_leng_v_pts,
                       begin_idx + i + half_leng_v_pts
                    ]     
            ];            

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        outer_v_pts =  to_v_pts(outer_sects);
        inner_v_pts = to_v_pts(inner_sects);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = [ 
            for(idxes = side_indexes(inner_sects, half_leng_v_pts))
                __reverse(idxes)
        ];

        first_outer_sect = outer_sects[0];
        last_outer_sect = outer_sects[leng_sects - 1];
        first_inner_sect = inner_sects[0];
        last_inner_sect = inner_sects[leng_sects - 1];
        
        leng_pts_sect = len(first_outer_sect);

        function begin_end_the_same() = 
           (first_outer_sect == last_outer_sect && first_inner_sect == last_inner_sect) ||
           (
               the_same_after_twisting(first_outer_sect, last_outer_sect, leng_pts_sect) && 
               the_same_after_twisting(first_inner_sect, last_inner_sect, leng_pts_sect)
           ); 

        v_pts = concat(outer_v_pts, inner_v_pts);

        if(begin_end_the_same()) {
            f_idxes = concat(outer_idxes, inner_idxes);

            polyhedron(
                v_pts,
                f_idxes
            );      

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);                     
        } else {
            first_idxes = first_idxes();
            last_idxes = last_idxes(half_leng_v_pts - half_leng_sect);

            f_idxes = concat(first_idxes, outer_idxes, inner_idxes, last_idxes);
            
            polyhedron(
                v_pts,
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);              
        }
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            hull() polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 5, 4], 
                    [1, 3, 4], [2, 1, 4], [2, 3, 0], 
                    [0, 3, 1], [2, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
               tri_sections(
                    [
                        section1[idx[0]], 
                        section1[idx[1]], 
                        section1[idx[2]]
                    ], 
                    [
                        section2[idx[0]], 
                        section2[idx[1]], 
                        section2[idx[2]]
                    ]
                );
            }
        }
        
        for(i = [0:len(sections) - 2]) {
             two_sections(
                 sections[i], 
                 sections[i + 1]
             );
        }
    }
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

// override it to test

module test_polysections_solid(points, faces) {

}

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

/**
* arc.scad
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

/**
* shape_pie.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_pie.html
*
**/


function shape_pie(radius, angle) =
    __shape_pie(radius, angle);

/**
* helix.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-helix.html
*
**/ 


function helix(radius, levels, level_dist, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        is_flt = __is_float(radius),
        r1 = is_flt ? radius : radius[0],
        r2 = is_flt ? radius : radius[1],
        init_r = vt_dir == "SPI_DOWN" ? r2 : r1,
        _frags = __frags(init_r),
        h = level_dist * levels,
        vt_d = vt_dir == "SPI_DOWN" ? 1 : -1,
        rt_d = rt_dir == "CT_CLK" ? 1 : -1,
        r_diff = (r1 - r2) * vt_d,
        h_step = level_dist / _frags * vt_d,
        r_step = r_diff / (levels * _frags),
        a_step = 360 / _frags * rt_d,
        begin_r = vt_dir == "SPI_DOWN" ? r2 : r1,
        begin_h = vt_dir == "SPI_DOWN" ? h : 0
    )
    [
        for(i = [0:_frags * levels]) 
            let(r = begin_r + r_step * i, a = a_step * i)
                [r * cos(a), r * sin(a), begin_h - h_step * i]
    ];

function __shape_pie(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        leng = radius * cos(a_step / 2),
        angles = __is_float(angle) ? [0:angle] : angle,
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

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);


/**
* shape_glued2circles.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_glued2circles.html
*
**/ 

function _glued2circles_pie_curve(radius, centre_dist, tangent_angle) =
    let(
        begin_ang = 90 + tangent_angle,
        shape_pts = shape_pie(radius, [-begin_ang, begin_ang])
    )
    [
        for(i = [1:len(shape_pts) - 1])
            shape_pts[i] + [centre_dist / 2, 0]
    ];
    
function _glued2circles_bezier(radius, centre_dist, tangent_angle, t_step, ctrl_p1) = 
    let(
        ctrl_p = rotate_p([radius * tan(tangent_angle), -radius], tangent_angle),
        ctrl_p2 = [-ctrl_p[0], ctrl_p[1]] + [centre_dist / 2, 0],
        ctrl_p3 = [-ctrl_p2[0], ctrl_p2[1]],
        ctrl_p4 = [-ctrl_p1[0], ctrl_p1[1]]            
    )
    bezier_curve(
        t_step,
        [
            ctrl_p1,
            ctrl_p2,
            ctrl_p3,
            ctrl_p4        
        ]
    );    

function _glued2circles_lower_half_curve(curve_pts, leng, i = 0) =
    i < leng ? (
        curve_pts[leng - 1 - i][0] >= 0 ? 
            concat(
                [curve_pts[leng - 1 - i]], 
                _glued2circles_lower_half_curve(curve_pts, leng, i + 1)
            ) : 
            _glued2circles_lower_half_curve(curve_pts, leng, i + 1)
    ) : [];    
    
function _glued2circles_half_glued_circle(radius, centre_dist, tangent_angle, t_step) =
    let(
        pie_curve_pts = _glued2circles_pie_curve(radius, centre_dist, tangent_angle),
        curve_pts = _glued2circles_bezier(radius, centre_dist, tangent_angle, t_step, pie_curve_pts[0]),
        lower_curve_pts = _glued2circles_lower_half_curve(curve_pts, len(curve_pts)),
        leng_half_curve_pts = len(lower_curve_pts),
        upper_curve_pts = [
            for(i = [0:leng_half_curve_pts - 1])
                let(pt = lower_curve_pts[leng_half_curve_pts - 1 - i])
                [pt[0], -pt[1]]
        ]
    ) concat(
        lower_curve_pts,
        pie_curve_pts,        
        upper_curve_pts
    );
    
function shape_glued2circles(radius, centre_dist, tangent_angle = 30, t_step = 0.1) =
    let(
        half_glued_circles = _glued2circles_half_glued_circle(radius, centre_dist, tangent_angle, t_step),
        leng_half_glued_circles = len(half_glued_circles),
        left_half_glued_circles = [
            for(i = [0:leng_half_glued_circles - 1])
                let(pt = half_glued_circles[leng_half_glued_circles - 1 - i])
                [-pt[0], pt[1]]
        ]    
    ) concat(half_glued_circles, left_half_glued_circles);

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
        pts = concat([
            for(t = [0: ceil(1 / t_step) - 1])
                _bezier_curve_point(t * t_step, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];


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

/**
* helix_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-helix_extrude.html
*
**/


module helix_extrude(shape_pts, radius, levels, level_dist, 
                     vt_dir = "SPI_DOWN", rt_dir = "CT_CLK", 
                     twist = 0, scale = 1.0, triangles = "SOLID") {

    function reverse(vt) = 
        let(leng = len(vt))
        [
            for(i = [0:leng - 1])
                vt[leng - 1 - i]
        ];                         
                         
    is_flt = __is_float(radius);
    r1 = is_flt ? radius : radius[0];
    r2 = is_flt ? radius : radius[1];
    
    init_r = vt_dir == "SPI_DOWN" ? r2 : r1;

    frags = __frags(init_r);

    v_dir = vt_dir == "SPI_UP" ? 1 : -1;
    r_dir = rt_dir == "CT_CLK" ? 1 : -1;
            
    angle_step = 360 / frags * r_dir;
    initial_angle = atan2(level_dist / frags, 6.28318 * init_r / frags) * v_dir * r_dir;

    path_points = helix(
        radius = radius, 
        levels = levels, 
        level_dist = level_dist, 
        vt_dir = vt_dir, 
        rt_dir = rt_dir
    );

    clk_a = r_dir == 1 ? 0 : 180;
    angles = [for(i = [0:len(path_points) - 1]) [90 + initial_angle, 0, clk_a + angle_step * i]];
    
    sections = cross_sections(shape_pts, path_points, angles, twist, scale);

    polysections(
        sections,
        triangles = triangles
    );
    
    // hook for testing
    test_helix_extrude(sections);
}

// override it to test
module test_helix_extrude(sections) {

}

function __shape_arc(radius, angle, width, width_mode = "LINE_CROSS") =
    let(
        w_offset = width_mode == "LINE_CROSS" ? [width / 2, -width / 2] : (
            width_mode == "LINE_INWARD" ? [0, -width] : [width, 0]
        ),
        frags = __frags(radius),
        a_step = 360 / frags,
        half_a_step = a_step / 2,
        angles = __is_float(angle) ? [0, angle] : angle,
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
        is_flt = __is_float(length),
        l1 = is_flt ? length : length[0],
        l2 = is_flt ? length : length[1],
        frags = __frags(round_r),
        b_ang = atan2(h, l1 - l2),
        br_corner = __br_corner(frags, b_ang, l1, l2, h, round_r),
        tr_corner = __tr_corner(frags, b_ang, l1, l2, h, round_r)
    )    
    concat(
        br_corner,
        tr_corner
    );


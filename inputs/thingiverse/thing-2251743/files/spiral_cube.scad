leng = 30;
leng_diff = 3;
min_leng = 3;
model = "Cube"; // [Cube, Base, Both]

module spiral_stack(orig_leng, orig_height, current_leng, leng_diff, min_leng, angle_offset, pre_height = 0, i = 0) {
    if(current_leng > min_leng && current_leng - leng_diff > 0) {
        angle = atan2(leng_diff, current_leng - leng_diff);
        
        factor = current_leng / orig_leng;
        
        translate([0, 0, pre_height]) 
            scale([factor, factor, 1]) 
                children();
         
        next_square_leng = sqrt(pow(leng_diff, 2) + pow(current_leng - leng_diff, 2));
        
        height = orig_height + pre_height;
        
        rotate(angle + angle_offset)
            spiral_stack(
                orig_leng, 
                orig_height, 
                next_square_leng, 
                leng_diff, 
                min_leng,
                angle_offset,                
                height,
                i + 1
            ) children();
    } else {
       // for debugging
       //  echo(i);
       // echo(current_leng / orig_leng * orig_height / 2);
    }
}

module spiral_cube(leng, leng_diff, min_leng) {
    thickness = leng / 30;

    module spiral_squares() {
        translate([0, 0, -leng / 2]) 
            spiral_stack(leng + leng_diff * 2 + thickness * 2.5, thickness, leng, leng_diff, min_leng, 0)
                translate([0, 0, thickness / 2]) 
                    cube([leng , leng, thickness], center = true);
    }

    module pair_spiral_squares() {
        spiral_squares();
        //mirror([0, 0, 1])
        rotate([180, 0, 0])
            spiral_squares();
    }

    difference() {
        cube(leng * 0.99, center = true);
        
        pair_spiral_squares();
        rotate([90, 0, 0]) pair_spiral_squares();
        rotate([0, 90, 0]) pair_spiral_squares();
         
    }
}

module base(leng) {
    $fn = 96;
    r = leng / 3;
    difference() {
        difference() {
            sphere(r);
            translate([0, 0, -r]) 
                linear_extrude(r) 
                    square(r * 2, center = true);
        }
        translate([0, 0, leng * sqrt(3) / 2 + leng / 15]) 
            rotate([45, atan2(1, sqrt(2)), 0]) 
                cube(leng * 0.99, center = true);
    }
}

if(model == "Cube") {
    spiral_cube(leng, leng_diff, min_leng);
} else if(model == "Base") {
    base(leng);
} else {

    // Because of float precision problems, I roate the base instead of the cube.
    spiral_cube(leng, leng_diff, min_leng);
    rotate([-45, 0, 0]) 
        rotate([0, -atan2(1, sqrt(2)), 0]) 
            translate([0, 0, -leng * sqrt(3) / 2 - leng / 15]) 
                base(leng);
}


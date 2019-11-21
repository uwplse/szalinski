leng = 35;
thickness = 4;
height = 15;
bk_number = 9;
stair_number = 15;

walkway_only = "FALSE"; // [TRUE, FALSE]

module 8_3_torus_knot_fort(leng, thickness, height, bk_number, stair_number) {
    $fn = 48;

    module wall_raft(leng, thickness, height, bk_number) {
       bk_width = leng / (bk_number * 1.5 - 0.5);
       bk_thickness = thickness / 3;
       gap_leng = bk_width / 2;
       
       half_leng = leng / 2;
       half_thickness = thickness / 2;
       half_bk_thickness = bk_thickness / 2;
       half_h = height / 2;
       half_bk_width = bk_width / 2;
       
        translate([0, 0, half_h]) union() {
            cube([leng, thickness, height], center = true);
            // raft
            for(i = [0: bk_number - 1]) {
               offset_x = i * (bk_width + gap_leng) - (half_leng - half_bk_width);
               translate([offset_x, half_thickness - half_bk_thickness, half_h + half_bk_width])
                   cube([bk_width, bk_thickness, half_bk_width * 2], center = true);
            }
        }
    }

    module tower(leng, radius, height) {
        linear_extrude(height) 
            circle(radius);
        translate([0, 0, height]) 
            sphere(radius);
    }

    module stairs(thickness, height, n) {
        w = height / n;

        tri_points = [[0, 0], [0, height], [-height, 0]];
                
        for(i = [0: n - 1]) {
            translate([w * i - height + w / 2, 0, w / 2 + w * i]) 
                cube([w, thickness, w], center = true);
        }
    }

    module walkway(leng, thickness, height, wall_thickness, stair_number) {
        half_leng = leng / 2;
        half_h = height / 2;
        
        module door_df() {
            union() {
                sphere(thickness * 1.25);
                translate([0, 0, -thickness * 2]) 
                    cube(thickness * 3.5, center = true);
            }
        }

        module half_door_df() {
            intersection() {    
                door_df();
                translate([-thickness * 2, 0, -thickness * 4]) 
                    linear_extrude(thickness * 8) 
                        square(thickness * 4, center = true);
            }    
        }
        
        tri_points = [[0, 0], [0, height], [-height, 0]];
        
        // walkway with doors
        difference() {
            hull() {
                translate([half_leng, 0, 0]) 
                    cube([leng, thickness, height], center = true);
                translate([-half_leng, 0, -half_h]) rotate([90, 0, 0]) 
                    linear_extrude(thickness, center = true)
                        polygon(tri_points);
            }
            // doors   
            if(walkway_only == "TRUE") {
                translate([-wall_thickness / 1.2, 0, 0]) 
                    scale([0.8, 0.8, 1]) door_df();
            } else {
                translate([-wall_thickness / 2, 0, 0]) 
                    half_door_df();
            }
            translate([-leng / 2.125, 0, 0])
                door_df();
        }
        
        translate([-half_leng, 0, -half_h]) 
            stairs(thickness, height, stair_number);
        
        // walkway without doors
        leng2 = leng * 0.75;
        translate([-leng * 1.75, 0, 0]) rotate(180) union() {
            translate([leng2 / 2, 0, 0]) 
                cube([leng2, thickness, height], center = true);
            translate([0, 0, -half_h]) rotate([90, 0, 0]) 
                linear_extrude(thickness, center = true)
                    polygon(tri_points);
            translate([0, 0, -half_h]) 
                stairs(thickness, height, stair_number);
        }
        
        // walkway on the bottom
        translate([-leng * 1.25, 0, -half_h + height/20]) 
            cube([leng, thickness, height / 10], center = true);
    }

    module one_burst(leng, thickness, height, bk_number, stair_number) {
        bk_width = leng / (bk_number * 1.5 - 0.5);
        bk_thickness = thickness / 3;
        offset = leng / 2 + thickness / 2;

        half_thickness = thickness / 2;
        half_h = height / 2;
        
        if(walkway_only == "FALSE") {
            // wall rafts
            union() {
                translate([0, 0, half_h]) union() {
                    cube([thickness, thickness, height], center = true);
                    translate([half_thickness - bk_thickness, half_thickness - bk_thickness, half_h]) 
                        cube([bk_thickness, bk_thickness, bk_width]);
                }
                    
                translate([offset, 0, 0]) 
                    wall_raft(leng, thickness, height, bk_number);
                    
                translate([0, offset, 0]) 
                    rotate(-90) 
                        wall_raft(leng, thickness, height, bk_number);
            }
        }

        translate([leng + (walkway_only == "TRUE" ? -half_thickness * 1.25: half_thickness), walkway_only == "TRUE" ? -half_thickness : 0]) 
            tower(leng, thickness * 0.95, height * 1.125); 
            
        road_width = thickness / 1.5;
        translate([0, -half_thickness - road_width / 2, half_h - height / stair_number / 2])
            walkway(leng, road_width, height / stair_number * (stair_number - 1), thickness, stair_number);
    }

    offset = leng / 1.325;
    for(i = [0:7]) {
        rotate(45 * i) 
           translate([offset, offset, 0]) 
               one_burst(leng, thickness, height, bk_number, stair_number);
    }
}

8_3_torus_knot_fort(leng, thickness, height, bk_number, stair_number);
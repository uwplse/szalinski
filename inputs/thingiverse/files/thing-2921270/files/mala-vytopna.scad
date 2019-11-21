/*******************************************************************\
|         __  ____       _ ____        _ __                         |
|        /  |/  (_)___  (_) __ \____ _(_) /      ______ ___  __     |
|       / /|_/ / / __ \/ / /_/ / __ `/ / / | /| / / __ `/ / / /     |
|      / /  / / / / / / / _, _/ /_/ / / /| |/ |/ / /_/ / /_/ /      |
|     /_/  /_/_/_/ /_/_/_/ |_|\__,_/_/_/ |__/|__/\__,_/\__, /       |
|                                                     /____/        |
|*******************************************************************|
|                                                                   |
|        Small depot in station Jachymov, Czech Republic            |
|                                                                   |
|                      designed by Svenny                           |
|                                                                   |
|       source: https://www.thingiverse.com/thing:2921270           |
|                                                                   |
\*******************************************************************/


/* [GENERAL SETTINGS] */
model_scale = 160;

wall_thickness = 1.5;
roof_thickness = 1.5;

window_line_thickness = 0.5;
// offset to fit the hole
inner_window_offset = 0.15;
// 1 = true, 0 = false
window_has_glass = 1; // [1, 0]

view = "arranged"; // [arranged, building, walls, main_building_whole_roof, main_building_roof_part, workshop_whole_roof, workshop_roof_part, chimneys, gate, windows] 

/* [DON'T TOUCH] */
// big window
bw_width = 1100 / model_scale;
bw_height = 2200 / model_scale;
bw_above_ground = 1200 / model_scale;

// small_window
sw_height = 1000 / model_scale;
sw_width = 700 / model_scale;
sw_above_ground = 1200 / model_scale;
sw_x_offsets = [1400 / model_scale, 2950 / model_scale, 4400 / model_scale];
sw_rimsa_width = 900 / model_scale;
sw_rimsa_height = 120 / model_scale;
sw_rimsa_thickness = 100 / model_scale;

// door
door_width = 900 / model_scale;
door_step_height = 200 / model_scale;
door_step_thickness = 350 / model_scale;
door_height = sw_above_ground+sw_height-door_step_height;

// vertical lines
vl_width = 200 / model_scale;
vl_step = 1567 / model_scale;
vl_w_step = bw_width+vl_width;
vl_thickness = 30 / model_scale;

// horizontal lines
hl_width = 200 / model_scale;
hl_thickness = 30 / model_scale;
small_hl_y_levels = [1820 / model_scale, 3500 / model_scale];
bottom_hl_y_level = 450 / model_scale;

// main building
mb_base_height = 5000 / model_scale;
mb_max_height = 6650 / model_scale;
mb_width = 6000 / model_scale;
mb_length = 25500 / model_scale;

// workshop
w_base_height = 3500 / model_scale;
w_max_height = 5200 / model_scale;
w_width = mb_width;
w_length = 5800 / model_scale;

// gate
gate_width = 3800 / model_scale;
gate_height = 5000 / model_scale;
gate_thickness = 100 / model_scale;

// chimneys
small_chimney_d = 400 / model_scale;
small_chimney_h = mb_max_height - mb_base_height + 800 / model_scale;
big_chimney_a = 600 / model_scale;
big_chimney_h = 800 / model_scale;
big_chimney_pipe_d = 300 / model_scale;

// materials
plank_cleft = 24 / model_scale;
plank_width = 240 / model_scale;

eternit_side = 400 / model_scale;
eternit_thickness = 32 / model_scale;
eternit_dividing = 24 / model_scale;

mb_roof_angle = atan((mb_max_height-mb_base_height)/(mb_width/2));
w_roof_angle = atan((w_max_height-w_base_height)/(w_width/2));

module plank_wall(length, height, thickness) {
    cleft = plank_cleft;
    width = plank_width;
    intersection() {
        for(x=[-length/2:width+cleft:length/2])
            translate([x, 0, 0])
            cube([width, height, thickness]);
        translate([-length/2,0,0])
        cube([length, height, 2*thickness]);
    }
}

module window(w, h, rows, cols, hole_z_offset=-1) {    
    hole_w = (w-(cols+1)*window_line_thickness)/cols;
    hole_h = (h-(rows+1)*window_line_thickness)/rows;
    difference() {
        union() {
            cube([w, h, wall_thickness/2]);
            translate([-1, -1, -0.2])
            cube([w+2, h+2, 0.2]);
        }
        translate([window_line_thickness, window_line_thickness, hole_z_offset])
        for(y=[0:rows-1]) {
            for(x=[0:cols-1]) {
                translate([x*(hole_w+window_line_thickness),
                           y*(hole_h+window_line_thickness), 0])
                cube([hole_w, hole_h, 5*wall_thickness]);
            }
        }
    }
}

module all_windows() {
    for(i=[0:3])
        translate([i*1.8*sw_width, 0, 0])
        if(window_has_glass) {
            window(sw_width-2*inner_window_offset, 
                   sw_height-2*inner_window_offset, 2, 2, 0);
        } else {
            window(sw_width-2*inner_window_offset, 
                   sw_height-2*inner_window_offset, 2, 2);
        }
    for(i=[0:9])
        translate([i*1.7*bw_width, 1.8*sw_height, 0])
        if(window_has_glass) {
            window(bw_width-2*inner_window_offset,
                   bw_height-2*inner_window_offset, 5, 3, 0);
        } else {
            window(bw_width-2*inner_window_offset,
                   bw_height-2*inner_window_offset, 5, 3);
        }    
}

module podezdivka(length, height, thickness) {
    brick_length = 600 / model_scale;
    dividing = 32 / model_scale;
    translate([-length/2, 0, 0])
    difference() {
        cube([length, height, thickness]);
        for(x=[brick_length:brick_length:length])
            translate([x,0,thickness])
            cube([dividing, 3*height, 2*dividing], center=true);
    }    
}

module eternit(x, y) {
    long = max(x,y);
    difference() {
        translate([0,0,eternit_thickness/2])
        cube([x, y, eternit_thickness], center=true);
        
        intersection() {
            rotate(45)
            union() {
                for(a=[-(x+y)/2:eternit_side:(x+y)/2]) {
                    translate([a, 0, 0])
                    cube([eternit_dividing, 2*long, 3*eternit_thickness], center=true);
                    translate([0, a, 0])
                    cube([2*long, eternit_dividing, 3*eternit_thickness], center=true);
                }
            }
            translate([0, eternit_side/2, 0])
            cube([x-2*eternit_side, y-eternit_side, 10*eternit_thickness], 
                 center=true);
        }
        
        difference() {
            union() {
                for(a=[-(y+eternit_dividing)/2+eternit_side:eternit_side:y/2]) {
                    translate([0, a, 0])
                    cube([4*x, eternit_dividing, 3*eternit_thickness], center=true);
                }
                
                for(a=[-(x+eternit_dividing)/2+eternit_side:eternit_side:0]) {
                    translate([a, 0, 0])
                    cube([eternit_dividing, 4*y, 3*eternit_thickness], center=true);
                    translate([-a, 0, 0])
                    cube([eternit_dividing, 4*y, 3*eternit_thickness], center=true);
                }
            }
            translate([0, eternit_side/2, 0])
            cube([x-2*eternit_side, y-eternit_side, 10*eternit_thickness], 
                 center=true);
        }
    }
}

module small_window() {
    translate([-sw_rimsa_width/2, -sw_rimsa_height, 0])
    cube([sw_rimsa_width, sw_rimsa_height, sw_rimsa_thickness]);
    
    all_x = 1.1*sw_width;
    all_y = 330/model_scale;
    center_x1 = sw_width/4;
    center_x2 = 1.3*sw_width/4;
    center_y = 400/model_scale;
    translate([0, sw_height, 0]) {
        translate([-all_x/2, 0, 0])
        cube([all_x, all_y, 0.5*sw_rimsa_thickness]);
        linear_extrude(sw_rimsa_thickness)
        polygon([[-center_x1/2, 0], [center_x1/2, 0],
                 [center_x2/2, center_y], [-center_x2/2, center_y]]);
    }
}

module wall_B_details() {
    l = mb_length + w_length;
    x1 = -l / 2;
    x2 = x1 + w_length;
    x3 = l / 2;
    y1 = w_base_height;
    y2 = mb_base_height;
    mb_center = w_length / 2;
    
    difference() {
        translate([0,0,-wall_thickness])
        linear_extrude(wall_thickness)
        polygon([[x1, 0], [x3, 0], [x3, y2], [x2, y2], [x2, y1], [x1, y1]]);
        
        for(x=[-mb_length/2:2*vl_step+vl_w_step:mb_length/2])
            translate([mb_center+x+2*vl_step+vl_width,
                       bw_above_ground, -2*wall_thickness])
            cube([bw_width, bw_height, 100*wall_thickness]);
    }
    
    color("brown")    
    podezdivka(mb_length+w_length+4*vl_thickness,
               bottom_hl_y_level-hl_width/2,
               2*vl_thickness);
    
    // main building details
    translate([mb_center, 0, 0]) {
        color("red")
        for(y=[bottom_hl_y_level, mb_base_height-hl_width/2])
            translate([0, y, 0])
            cube([mb_length+3*hl_thickness, hl_width, 3*hl_thickness], center=true);
        
        vl_y_offset = bottom_hl_y_level+hl_width/2;
        for(x=[-mb_length/2:2*vl_step+vl_w_step:mb_length/2])
            translate([x, vl_y_offset, 0])
            for(i=[0,1,2]) {
                color("red")
                translate([i*vl_step, 0, 0])
                cube([vl_width, mb_base_height-vl_y_offset-hl_width, vl_thickness]);
                
                if(i < 2)
                    for(y=small_hl_y_levels)
                        color("orange")
                        translate([i*vl_step+vl_width, y-vl_y_offset-hl_width/2, 0])
                        cube([vl_step-vl_width, hl_width, vl_thickness]);
                else
                    for(y=[bw_above_ground-hl_width, bw_above_ground+bw_height])
                        color("orange")
                        translate([i*vl_step+vl_width, y-vl_y_offset, 0])
                        cube([bw_width, hl_width, vl_thickness]);
            }
            
        // corners
        color("red")
        for(x=[-(mb_length+vl_thickness)/2, (mb_length+vl_thickness)/2])
            translate([x, (mb_base_height)/2, vl_thickness/2])
            cube([vl_thickness, mb_base_height, vl_thickness], center=true);
    }
}

module wall_B_prototype() {
    difference() {
        intersection() {
            wall_B_details();
            
            translate([0, 0, -(mb_length+w_length)/2])
            rotate([0,-45,0])
            cube([3*(mb_length+w_length), mb_base_height, 3*(mb_length+w_length)]);
            
            translate([-(mb_length+w_length), 0, mb_base_height])
            rotate([-135,0,0])
            cube([2*(mb_length+w_length), 3*mb_base_height, 3*mb_base_height]);
        }
        translate([-mb_length/2+w_length/2+wall_thickness,
                    w_base_height, 
                    -wall_thickness])
        rotate([0,-135,0])
        cube([3*(mb_length+w_length), mb_base_height, 3*(mb_length+w_length)]);
    }
}

module wall_B_1() {
    l = mb_length + w_length;
    difference() {
        union() {
            wall_B_prototype();
            
            color("lime")
            translate([-l/2, sw_above_ground, 0])
            for(x=sw_x_offsets)
                translate([x, 0, 0])
                small_window();
        }
        
        translate([-l/2, sw_above_ground+sw_height/2, -2*wall_thickness])
        for(x=sw_x_offsets)
            translate([x, 0, 0])
            cube([sw_width, sw_height, 100*wall_thickness], center=true);
    }
}

module wall_B_2() {
    l = mb_length + w_length;
    mirror()
    difference() {
        union() {
            wall_B_prototype();
            
            color("lime") {
                translate([-l/2, sw_above_ground, 0])
                translate([sw_x_offsets[2], 0, 0])
                small_window();
                
                translate([-l/2+sw_x_offsets[0]-door_width/2, 0, 0])
                cube([door_width, door_step_height, door_step_thickness]);
            }
        }
        
        translate([-l/2+sw_x_offsets[2], sw_above_ground+sw_height/2, 
                   -2*wall_thickness])
        cube([sw_width, sw_height, 100*wall_thickness], center=true);
        
        translate([-l/2+sw_x_offsets[0]-door_width/2, door_step_height,
                   -0.5*wall_thickness]) {
            cube([door_width, door_height, 100*wall_thickness]);
            for(y=[door_height/4, 3*door_height/4])
                translate([door_width/2, y, 0])
                cube([0.7*door_width, 0.35*door_height, 0.4*wall_thickness], center=true);
        }
    }
}

module wall_A_details() {
    x = mb_width/2;
    y1 = mb_base_height;
    y2 = mb_max_height;
    
    translate([0,0,-wall_thickness])
    linear_extrude(wall_thickness)
    polygon([[-x, 0], [x, 0], [x, y1], [0, y2], [-x, y1]]);

    color("brown")    
    podezdivka(mb_width+4*vl_thickness,
               bottom_hl_y_level-hl_width/2,
               2*vl_thickness);
    
    vl_y_offset = bottom_hl_y_level+hl_width/2;
    color("red") {
        for(y=[bottom_hl_y_level, mb_base_height-hl_width/2])
            translate([0, y, 0])
            cube([mb_width+3*hl_thickness, hl_width, 3*hl_thickness], center=true);
        
        for(xx=[-x, x-vl_width,
               -gate_width/2-vl_width, gate_width/2])
            translate([xx, bottom_hl_y_level+hl_width/2, 0])
            cube([vl_width, y1-bottom_hl_y_level-1.5*hl_width, vl_thickness]);
        
        for(x=[-(mb_width+vl_thickness)/2, (mb_width+vl_thickness)/2])
            translate([x, (mb_base_height)/2, vl_thickness/2])
            cube([vl_thickness, mb_base_height, vl_thickness], center=true);
    }
    
    color("orange")
    for(y=small_hl_y_levels)
        translate([0, y, 0])
        cube([mb_width, hl_width, 2*vl_thickness], center=true);
    
    intersection() {
        color("silver")
        translate([0, mb_base_height, 0])
        plank_wall(mb_width, mb_max_height-mb_base_height, vl_thickness);
    
        linear_extrude(wall_thickness)
        polygon([[-x, 0], [x, 0], [x, y1], [0, y2], [-x, y1]]);
    }
}

module wall_A_prototype() {
    intersection() {
        wall_A_details();
        
        union() {
            translate([0, 0, -mb_width/2])
            rotate([0,-45,0])
            cube([3*mb_width, mb_base_height, 3*mb_width]);
            
            translate([-mb_width/2, mb_base_height, -wall_thickness])
            cube([mb_width, mb_max_height-mb_base_height, 100*wall_thickness]);
        }
    }
}

module wall_A_1() {
    difference() {
        wall_A_prototype();
        
        translate([0, 0, -2*wall_thickness])
        cube([gate_width, 2*gate_height, 100*wall_thickness], center=true);
    }
}

module wall_A_2() {
    x = mb_width/2;
    y1 = w_base_height;
    y2 = w_max_height;
    
    difference() {
        union() {
            difference() {
                wall_A_prototype();
                linear_extrude(wall_thickness)
                offset(delta=roof_thickness)
                polygon([[-x, 0], [x, 0], [x, y1], [0, y2], [-x, y1]]);
            }
            
            linear_extrude(wall_thickness)
            polygon([[-x, 0], [x, 0], [x, y1], [0, y2], [-x, y1]]);
        }
        for(x=[-w_width/2, w_width/2])
            translate([x, 0, 0])
            cube([2*wall_thickness, 2*w_base_height, 4*wall_thickness], center=true);
    }
}

module wall_A_3() {
    x = mb_width/2;
    y1 = w_base_height;
    y2 = w_max_height;
    
    intersection() {
        union() {
            translate([0,0,-wall_thickness])
            linear_extrude(wall_thickness)
            polygon([[-x, 0], [x, 0], [x, y1], [0, y2], [-x, y1]]);
            
            color("brown")    
            podezdivka(w_width+4*vl_thickness,
                       bottom_hl_y_level-hl_width/2,
                       2*vl_thickness);
        }
        
        union() {
            translate([0, 0, -w_width/2])
            rotate([0,-45,0])
            cube([3*w_width, w_base_height, 3*w_width]);
            
            translate([-w_width/2, w_base_height, -wall_thickness])
            cube([w_width, w_max_height-w_base_height, 100*wall_thickness]);
        }
    }
}

module w_roof() {
    y_base = sqrt(pow(w_max_height-w_base_height, 2) + pow(w_width/2, 2));
    x = w_length+400 / model_scale;
    y = y_base+400 / model_scale;
    z = roof_thickness-eternit_thickness;
    
    intersection() {
        translate([0, 0, -eternit_thickness])
        union() {
            translate([0, -y/2, 0])
            eternit(x, y);
            translate([-x/2, -y, -z])
            cube([x, y, z]);
        }
        
        rotate([-w_roof_angle, 0, 0])
        translate([0, -y, 0])
        cube([2*x, 2*y, 2*y], center=true);
    }
}

module w_whole_roof() {
    rotate([0, 90, -w_roof_angle])
    w_roof();
    mirror([0, 1, 0])
    rotate([0, 90, -w_roof_angle])
    w_roof();
}

module mb_roof() {
    y_base = sqrt(pow(mb_max_height-mb_base_height, 2) + pow(mb_width/2, 2));
    x = mb_length+800 / model_scale;
    y = y_base+400 / model_scale;
    z = roof_thickness-eternit_thickness;
    
    difference() {
        intersection() {
            translate([0, 0, -eternit_thickness])
            union() {
                translate([0, -y/2, 0])
                eternit(x, y);
                translate([-x/2, -y, -z])
                cube([x, y, z]);
            }
            
            rotate([-mb_roof_angle, 0, 0])
            translate([0, -y, 0])
            cube([2*x, 2*y, 2*y], center=true);
        }
        
   //     for(i=[-1,1])
     //       translate([i*(mb_length/2-2.4*vl_step), 0, 0])
       //     rotate([-mb_roof_angle, 0, 0])
         //   cylinder(d=1.05*small_chimney_d, h=10*roof_thickness, center=true, $fn=100);
    }
}

module mb_whole_roof() {
    y_base = sqrt(pow(mb_max_height-mb_base_height, 2) + pow(mb_width/2, 2));
    h = mb_length+800 / model_scale;
    
    difference() {
        union() {
            rotate([0, 90, -mb_roof_angle])
            mb_roof();
            mirror([0, 1, 0])
            rotate([0, 90, -mb_roof_angle])
            mb_roof();
            
            for(i=[-1,1])
                translate([-roof_thickness/2, 0, i*(mb_length/2-2.4*vl_step)])
                polyhedron([[0,0,2.5*small_chimney_d],
                            [-tan(mb_roof_angle)*y_base/2, y_base/2, 0.6*small_chimney_d],
                            [-tan(mb_roof_angle)*y_base/2, -y_base/2, 0.6*small_chimney_d],
                            [-tan(mb_roof_angle)*y_base/2, y_base/2, -0.6*small_chimney_d],
                            [-tan(mb_roof_angle)*y_base/2, -y_base/2, -0.6*small_chimney_d],
                            [0,0,-2.5*small_chimney_d]],
                           [[0,1,3,5], [0,5,4,2], [0,2,1], [5,3,4], [1,2,4,3]]
                );
        }
        
        for(i=[-1,1])
            translate([0,0,i*(mb_length/2-2.4*vl_step)])
            rotate([0, 90, 0])
            cylinder(d=1.05*small_chimney_d, h=12*roof_thickness, center=true, $fn=100);
    }
}

module small_chimney() {
    cylinder(r1=1.5*small_chimney_d, r2=small_chimney_d/2, h=small_chimney_d, $fn=100);
    difference() {
        cylinder(d=small_chimney_d, h=small_chimney_h, $fn=100);
        translate([0,0,small_chimney_h]) {
            cube([small_chimney_d/3, 10*small_chimney_d, 500/model_scale], center=true);
            cube([10*small_chimney_d, small_chimney_d/3, 500/model_scale], center=true);
        }
    }
    
}

module small_chimney_cap() {
    cylinder(r1=0.65*small_chimney_d, r2=0.1, h=150/model_scale, $fn=100);
}

module big_chimney() {
    difference() {
        cube([big_chimney_a, big_chimney_h, big_chimney_a]);
        
        rotate(-90+w_roof_angle)
        cube(10*big_chimney_a);
        
        translate([big_chimney_a/2, 0, big_chimney_a/2])
        rotate([90,0,0])
        cylinder(d=big_chimney_pipe_d, h=3*big_chimney_h, center=true, $fn=100);
    }
}

module gate_side() {
    w = gate_width / 2 + 100 / model_scale;
    h = gate_height + 100 / model_scale;
    h_rail = 350 / model_scale;
    w_rail = 1100 / model_scale;
    sign_a = 500 / model_scale;
    
    translate([0, h_rail, 0]) {
        difference() {
            translate([0, -h_rail, 0])
            union() {
                translate([w/2, 0, -0.75*gate_thickness])
                plank_wall(w, h, 1.5*gate_thickness);
                translate([0, 0, -0.5*gate_thickness])
                cube([w, h, gate_thickness]);
                
                // sign
                color("blue")
                translate([w/2, (h+h_rail)/2, gate_thickness/2])
                rotate(45)
                cube([sign_a, sign_a, gate_thickness], center=true);
            }
            
            translate([0, -h_rail, 0])
            cube([2*w_rail, 2*h_rail, 3*gate_thickness], center=true);
        }
        
        difference() {
            translate([0, 0, -gate_thickness])
            cube([w, h-h_rail, 2*gate_thickness]);
            
            difference() {
                translate([0.6*plank_width, 0.6*plank_width, -2*gate_thickness])
                cube([w-1.2*plank_width, h-h_rail-1.2*plank_width, 5*gate_thickness]);
                
                translate([0, 0, -0.8*gate_thickness])
                hull() {
                    cube([0.4*plank_width, 0.4*plank_width, 1.8*gate_thickness]);
                    translate([w-0.4*plank_width, h-h_rail-0.4*plank_width, 0])
                    cube([0.4*plank_width, 0.4*plank_width, 1.8*gate_thickness]);
                }
            }
            
            for(i=[-1,1])
                translate([0, 0, i*gate_thickness])
                rotate([0,45,0])
                cube([0.2, 2*h, 0.2], center=true);
        }
    }
}

module gate() {
    w = gate_width / 2 + 100 / model_scale;
    translate([1, 0, w])
    rotate([0,90,0])
    gate_side();
    translate([-1, 0, w])
    rotate([0,-90,0])
    mirror()
    gate_side();
}

module building() {
    mb_center = w_length / 2;
    translate([mb_width/2, mb_length/2-mb_center, 0])
    rotate([90,0,90])
    wall_B_1();
    
    translate([-mb_width/2, mb_length/2-mb_center, 0])
    rotate([90,0,-90])
    wall_B_2();
    
    translate([0, mb_length, 0])
    rotate([90,0,180])
    wall_A_1();
    
    rotate([90,0,0])
    wall_A_2();
    
    translate([0, -w_length, 0])
    rotate([90,0,0])
    wall_A_3();
    
    // floor
    translate([-w_width/2, -w_length, 0])
    cube([w_width, w_length, 0.6]);
    
    difference() {
        translate([-mb_width/2, 0, 0])
        cube([mb_width, mb_length, 0.6]);
        translate([0, mb_length, 0])
        cube([gate_width, 1.9*mb_length, 6], center=true);
    }
}

module arranged() {
    building();
    
    translate([0, mb_length/2, mb_max_height+roof_thickness])
    rotate([90, -90, 0])
    color("silver")
    mb_whole_roof();
    
    translate([0, -w_length/2-200/model_scale, w_max_height+roof_thickness])
    rotate([90, -90, 0])
    color("silver")
    w_whole_roof();
    
    for(i=[-1,1])
        translate([0, mb_length/2+i*(mb_length/2-2.4*vl_step), mb_base_height]) {
            small_chimney();
            translate([0, 0, small_chimney_h])
            small_chimney_cap();
        }
    
    translate([-1.2*big_chimney_a, -w_length/3, 0.96*w_max_height])
    rotate([90,0,0])
    big_chimney();
        
    translate([0, mb_length, 0]) {
        rotate([90, 0, 180])
        gate_side();
        
        translate([gate_width/2, 0, 0])
        rotate(-100)
        translate([-gate_width/2, 0, 0])
        rotate([90, 0, 180])
        mirror()
        gate_side();
    }

}

module chimneys() {
    for(i=[-1,1]) {
        translate([i*2*small_chimney_d, 4*small_chimney_d, 0])
        small_chimney();
        translate([i*2*small_chimney_d, 0, 0])
        small_chimney_cap();
    }
    
    translate([-big_chimney_a/2, 0, 0])
    big_chimney();
}

module walls() {
    translate([0, 1.1*mb_max_height, 0]) {
        translate([0, 1.1*mb_base_height, 0])
        wall_B_1();
        wall_B_2();
    }    
    translate([-1.1*mb_width, 0, 0])
    wall_A_1();
    translate([1.1*mb_width, 0, 0])
    wall_A_2();
    wall_A_3();
}

if(view == "arranged")
    arranged();
if(view == "building")
    building();
if(view == "walls")
    walls();
if(view == "main_building_whole_roof")
    mb_whole_roof();
if(view == "main_building_roof_part")
    mb_roof();
if(view == "workshop_whole_roof")
    w_whole_roof();
if(view == "workshop_roof_part")
    w_roof();
if(view == "chimneys")
    chimneys();
if(view == "gate")
    gate();
if(view == "windows")
    all_windows();

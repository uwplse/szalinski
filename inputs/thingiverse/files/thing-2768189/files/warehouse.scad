/*******************************************************************\
|         __  ____       _ ____        _ __                         |
|        /  |/  (_)___  (_) __ \____ _(_) /      ______ ___  __     |
|       / /|_/ / / __ \/ / /_/ / __ `/ / / | /| / / __ `/ / / /     |
|      / /  / / / / / / / _, _/ /_/ / / /| |/ |/ / /_/ / /_/ /      |
|     /_/  /_/_/_/ /_/_/_/ |_|\__,_/_/_/ |__/|__/\__,_/\__, /       |
|                                                     /____/        |
|*******************************************************************|
|                                                                   |
|                 Wooden Railway Station Warehouse                  |
|                                                                   |
|                      designed by Svenny                           |
|                                                                   |
|       source: https://www.thingiverse.com/thing:2768189           |
|                                                                   |
\*******************************************************************/


/* [VIEW] */
// rendering precission
$fn=140;
// what to show
view = "arranged"; // [arranged, building, walls, whole_roof, roof_part, ramp]
// scale
model_scale = 160; // Z=220, N=160, TT=120, H0=87
wall_thickness = 1.2;
roof_thickness = 1.1;

// building
b_length = 9000 / model_scale;
b_width = 5000 / model_scale;
b_base_height = 4000 / model_scale;
b_podezdivka_height = 1200 / model_scale;
b_max_height = 5100 / model_scale;

ramp_width = 1000 / model_scale;

gate_width = 2100 / model_scale;
gate_height = 2200 / model_scale;

plank_thickness = 30 / model_scale;
plank_cleft = 24 / model_scale;
plank_width = 240 / model_scale;
spar_thickness = 60 / model_scale;
podezdivka_thickness = 80 / model_scale;

brick_length = 600 / model_scale;
brick_height = 200 / model_scale;
brick_dividing = 32 / model_scale;

eternit_side = 400 / model_scale;
eternit_thickness = 32 / model_scale;
eternit_dividing = 24 / model_scale;

roof_angle = atan((b_max_height-b_base_height)/(b_width/2));

/* [HELPER] */
hl_y_offsets = [2200 / model_scale, 3200 / model_scale, b_base_height];

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

module brick_wall(length, height, thickness) {
    dividing = brick_dividing;
    translate([-length/2, 0, 0])
    difference() {
        cube([length, height, thickness]);
        for(y=[height-brick_height:-brick_height:0]) {
            translate([-1,y,thickness])
            cube([3*length, dividing, 2*dividing], center=true);
            for(x=[brick_length:brick_length:length])
                translate([x-((y/brick_height)%2)*brick_length/2,y,thickness/2])
                cube([dividing, brick_height, 2*dividing]);
        }
    }    
}

module eternit(x, y) {
    difference() {
        translate([0,0,eternit_thickness/2])
        cube([x, y, eternit_thickness], center=true);
        
        intersection() {
            rotate(45)
            union() {
                for(a=[-(x+y)/2:eternit_side:(x+y)/2]) {
                    translate([a, 0, 0])
                    cube([eternit_dividing, 4*y, 3*eternit_thickness], center=true);
                    translate([0, a, 0])
                    cube([4*x, eternit_dividing, 3*eternit_thickness], center=true);
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

module wall_A_prototype() {
    x = b_width/2;
    y1 = b_base_height;
    y2 = b_max_height;
    
    intersection() {
        union() {
            translate([0, 0, -wall_thickness])
            linear_extrude(wall_thickness-plank_thickness)
            polygon([[-x, 0], [x, 0], [x, y1], [0, y2], [-x, y1]]);
            
            translate([0, 0, -plank_thickness]) {
                color("silver")
                intersection() {
                    translate([0, b_podezdivka_height, 0])
                    plank_wall(b_width, b_max_height-b_podezdivka_height, 
                               plank_thickness);
                    
                    translate([0, 0, -2*wall_thickness])
                    linear_extrude(100*wall_thickness)
                    polygon([[-x, 0], [x, 0], [x, y1], [0, y2], [-x, y1]]);
                }
                
                color("brown")
                brick_wall(b_width+2*podezdivka_thickness,
                           b_podezdivka_height,
                           podezdivka_thickness);
                
                color("brown")
                for(y=hl_y_offsets)
                    translate([0, y-spar_thickness/2, 0])
                    cube([b_width+2*spar_thickness, spar_thickness, 2*spar_thickness],
                         center=true);
                
                for(i=[-1,1])
                    translate([i*x, (b_base_height+b_podezdivka_height)/2, 0])
                    cube([4*spar_thickness, 
                          b_base_height-b_podezdivka_height, 
                          3*spar_thickness], center=true);
                
                difference() {
                    for(i=[-1,1])
                        translate([i*x, y1-spar_thickness/2, 0])
                        rotate([0,0,i*140])
                        translate([0, b_base_height/2, 0])
                        cube([spar_thickness, b_base_height, 2*spar_thickness],
                             center=true);
                    cube([b_width, 2*b_podezdivka_height, 10*wall_thickness],
                         center=true);
                }
            }
        }
        
        union() {
            translate([0, 0, -b_width/2])
            rotate([0,-45,0])
            cube([3*b_length, b_base_height, 3*b_length]);
            
            translate([-x, y1,-2*wall_thickness])
            cube([b_width, b_max_height-b_base_height, 100*wall_thickness]);
        }
    }
}

module wall_A() {
    window_width = 800 / model_scale;
    window_height = hl_y_offsets[1] - hl_y_offsets[0] - spar_thickness;
    window_y = hl_y_offsets[0]+spar_thickness/2+window_height/2;
    difference() {
        wall_A_prototype();
        translate([0, window_y, -2*wall_thickness])
        cube([window_width, window_height, 200*wall_thickness], center=true);
    }
}

module wall_B_base() {
    x = b_length/2;
    y1 = b_base_height;
    
    translate([0, 0, -wall_thickness])
    linear_extrude(wall_thickness-plank_thickness)
    polygon([[-x, 0], [x, 0], [x, y1], [-x, y1]]);
    
    translate([0, 0, -plank_thickness]) {
        color("silver")
        intersection() {
            translate([0, b_podezdivka_height, 0])
            plank_wall(b_length, b_max_height-b_podezdivka_height, plank_thickness);
            
            translate([0, 0, -2*wall_thickness])
            linear_extrude(100*wall_thickness)
            polygon([[-x, 0], [x, 0], [x, y1], [-x, y1]]);
        }
        
        color("brown")
        brick_wall(b_length+2*podezdivka_thickness,
                   b_podezdivka_height,
                   podezdivka_thickness);
        
        color("brown")
        for(y=hl_y_offsets)
            translate([0, y-spar_thickness/2, 0])
            cube([b_length+2*spar_thickness, spar_thickness, 2*spar_thickness],
                 center=true);
        
        for(i=[-1,1])
            translate([i*x, (b_base_height+b_podezdivka_height)/2, 0])
            cube([4*spar_thickness, 
                  b_base_height-b_podezdivka_height, 
                  3*spar_thickness], center=true);
        
        difference() {
            for(i=[-1,1])
                translate([i*x, y1-spar_thickness/2, 0])
                rotate([0,0,i*140])
                translate([0, b_base_height/2, 0])
                cube([spar_thickness, b_base_height, 2*spar_thickness],
                     center=true);
            cube([b_width, 2*b_podezdivka_height, 10*wall_thickness],
                 center=true);
        }
    }
}

module wall_B_prototype() {
    intersection() {
        wall_B_base();
        
        translate([0, 0, -b_length/2])
        rotate([0,-45,0])
        cube([3*b_length, b_base_height, 3*b_length]);
        
        translate([-b_length, 0, b_base_height])
        rotate([-135,0,0])
        cube([2*b_length, 3*b_base_height, 3*b_base_height]);
    }
}

module wall_B_1() {
    difference() {
        wall_B_prototype();
        translate([-gate_width/2, b_podezdivka_height, -plank_thickness])
        cube([gate_width, gate_height, 100*spar_thickness]);
    }
    
    translate([0, b_podezdivka_height, -plank_thickness]) {
        plank_wall(gate_width, gate_height, plank_thickness+spar_thickness);
        for(i=[-1, 1]) {
            for(j=[-1,1])
                translate([j*gate_width/4, 
                           gate_height/2+i*0.4*gate_height,
                           plank_thickness])
                cube([gate_width/2-2*plank_cleft,
                      1.5*spar_thickness, 
                      2*(plank_thickness+spar_thickness)], center=true);
            
            hull() {
                translate([i*gate_width/2-2*i*plank_thickness, 
                           gate_height/2+0.4*gate_height,
                           plank_thickness])
                cube([3*plank_thickness, 
                      3*plank_thickness, 
                      2*(plank_thickness+spar_thickness)], center=true);
                
                translate([i*plank_cleft+i*plank_thickness, 
                           gate_height/2-0.4*gate_height,
                           plank_thickness])
                cube([2*plank_thickness,
                      2*plank_thickness,
                      2*(plank_thickness+spar_thickness)], center=true);
            }
        }
    }
}

module roof() {
    y_base = sqrt(pow(b_max_height-b_base_height, 2) + pow(b_width/2, 2));
    x = b_length+1600 / model_scale;
    y = y_base+900 / model_scale;
    z = roof_thickness-eternit_thickness;
    
    intersection() {
        translate([0, 0, -eternit_thickness])
        union() {
            translate([0, -y/2, 0])
            eternit(x, y);
            translate([-x/2, -y, -z])
            cube([x, y, z]);
        }
        
        rotate([-roof_angle, 0, 0])
        translate([0, -y, 0])
        cube([2*x, 2*y, 2*y], center=true);
    }
}

module whole_roof() {
    rotate([0, 90, -roof_angle])
    roof();
    mirror([0, 1, 0])
    rotate([0, 90, -roof_angle])
    roof();
}

module ramp() {
    spar_a = 160 / model_scale;
    step_length = 300 / model_scale;
    step_height = 250 / model_scale;
    support_step = (b_length-spar_a)/5;
    
    translate([-b_length/2, 0, 0])
    cube([b_length, 3*plank_thickness, ramp_width]);
        
    for(x=[-b_length/2+support_step:support_step:b_length/2-support_step])
        translate([x, 0, 0]) {
            cube([spar_a, spar_a, ramp_width]);
            cube([spar_a, b_podezdivka_height, spar_a]);
        }
        
    for(i=[ceil(b_podezdivka_height/step_height):-1:0])
        translate([-b_length/2-i*step_length, i*step_height, 0])
        cube([step_length, b_podezdivka_height-i*step_height, ramp_width]);
    
    mirror()
    for(i=[ceil(b_podezdivka_height/step_height):-1:0])
        translate([-b_length/2-i*step_length, i*step_height, 0])
        cube([step_length, b_podezdivka_height-i*step_height, ramp_width]);
}

module building() {
    translate([b_width/2, 0, 0])
    rotate([90,0,90])
    wall_B_1();
    
    translate([-b_width/2, 0, 0])
    rotate([90,0,-90])
    wall_B_prototype();
    
    translate([0, b_length/2, 0])
    rotate([90,0,180])
    wall_A();
    
    translate([0, -b_length/2, 0])
    rotate([90,0,0])
    wall_A();
    
    translate([-b_width/2, -b_length/2, 0])
    cube([b_width, b_length, 0.5]);
}

module arranged() {
    translate([b_width/2, 0, 0])
    rotate([90,0,90])
    wall_B_1();
    
    translate([-b_width/2, 0, 0])
    rotate([90,0,-90])
    wall_B_prototype();
    
    translate([0, b_length/2, 0])
    rotate([90,0,180])
    wall_A();
    
    translate([0, -b_length/2, 0])
    rotate([90,0,0])
    wall_A();
    
    translate([-b_width/2, -b_length/2, 0])
    cube([b_width, b_length, 0.5]);
    
    translate([-0, 0, b_max_height+roof_thickness])
    rotate([0, -90, 90])
    whole_roof();
    
    translate([ramp_width+b_width/2, 0, 0])
    rotate([-90, 0, 90])
    translate([0, -b_podezdivka_height, 0])
    ramp();
}

module walls() {
    wall_B_1();
    
    translate([0, 10+b_base_height, 0])
    wall_B_prototype();
    
    translate([0, -10-b_max_height, 0])
    for(i=[-1,1])
        translate([i*(b_width/2+5), 0, 0])
        wall_A();
}

if(view == "ramp")
    ramp();

if(view == "arranged")
    arranged();

if(view == "building")
    building();

if(view == "walls")
    walls();

if(view == "whole_roof")
    whole_roof();

if(view == "roof_part")
    roof();

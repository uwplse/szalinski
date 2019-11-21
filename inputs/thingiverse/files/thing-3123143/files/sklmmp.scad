/*******************************************************************\
|         __  ____       _ ____        _ __                         |
|        /  |/  (_)___  (_) __ \____ _(_) /      ______ ___  __     |
|       / /|_/ / / __ \/ / /_/ / __ `/ / / | /| / / __ `/ / / /     |
|      / /  / / / / / / / _, _/ /_/ / / /| |/ |/ / /_/ / /_/ /      |
|     /_/  /_/_/_/ /_/_/_/ |_|\__,_/_/_/ |__/|__/\__,_/\__, /       |
|                                                     /____/        |
|*******************************************************************|
|                                                                   |
|       Czechoslovakian acid containers carriage "Sklmmp"           |
|                                                                   |
|                      designed by Svenny                           |
|                                                                   |
|       source: https://www.thingiverse.com/thing:3123143           |
|                                                                   |
\*******************************************************************/


/* [VIEW] */
// rendering precission
$fn=40;
// what to show
view = "parts"; // [parts, arranged]
// scale
model_scale = 160; // Z=220, N=160, TT=120, H0=87
// include bumpers to chassis part (easier to print but not as nice)
include_bumpers_to_chassis = true; // [true, false]
// wall thickness of the chassis part
chassis_wall_thickness = 0.6;
// thickness of the rails of the construction
real_rail_thickness = 120;
// how to join rails 1 = by halves of rail thickness (may be bad idea for small scales)
bed_rail_join = 1; // [1, 0]

/* [JOIN BOGGIE ] */
// bolt hole diameter (default 2.4mm for M2.5 bolts)
bolt_hole = 2.5;
// center of the joining cylinder from the edge of the chassis (without bumpers!)
bogie_offset = 12.2;
// pivoting cylinder diameter
bogie_pivot_d = 5;
// pivoting cylinder height
bogie_pivot_h = 2.6;


body_y_offset = 600 / model_scale;
chassis_length = 13000 / model_scale;
chassis_height = 315 / model_scale;
chassis_width = 3000 / model_scale;
chassis_center_height = 630 / model_scale;
chassis_center_length = 5000 / model_scale;
chassis_center_length_2 = 10000 / model_scale;

rail_thickness = real_rail_thickness / model_scale;
rail_length = chassis_length - body_y_offset;
rail_height = 890 / model_scale;
rail_step = (rail_length - rail_thickness) / 11;
rail_width = (rail_length-rail_thickness)/11+rail_thickness;

barrel_d = 900 / model_scale;
barrel_height = 950 / model_scale;
barrel_offset_r = 150 / model_scale;

bumper_distance = 1750 / model_scale;
bumper_length = 620 / model_scale;
bumper_shaft_d = 238 / model_scale;
bumper_head_d = 490 / model_scale;
bumper_head_h = 100 / model_scale;

ladder_step_h = 350 / model_scale;
ladder_w = 400 / model_scale;
ladder_thickness = 80 / model_scale;

handlebar_h = 1200 / model_scale;


module bumper() {
    cylinder(d=bumper_head_d, h=bumper_head_h);
    cylinder(d=bumper_shaft_d, h=bumper_length);
}

module small_step() {
    translate([-body_y_offset/2, ladder_step_h, 0])
    cube([body_y_offset, ladder_thickness, 2.5*ladder_thickness]);
    translate([-body_y_offset/2, -chassis_height/2, 0])
    cube([body_y_offset, chassis_height, 0.2]);
    translate([-body_y_offset/2, 0, 0])
    cube([ladder_thickness, ladder_step_h, ladder_thickness]);
    translate([body_y_offset/2-ladder_thickness, 0, 0])
    cube([ladder_thickness, ladder_step_h, ladder_thickness]);
}

module front_handlebar() {
    translate([0,-chassis_height/2,ladder_thickness/2])
    difference() {
        cube([chassis_width,
              handlebar_h+chassis_height,
              ladder_thickness], center=true);
        translate([0,-ladder_thickness,0])
        cube([chassis_width - 2*ladder_thickness,
              handlebar_h+chassis_height,
              2*ladder_thickness], center=true);
    }
    translate([0, -(handlebar_h+chassis_height)/2, 0.1])
    difference() {
        cube([chassis_width, chassis_height, 0.2], center=true);
        cube([bumper_distance+2*bumper_shaft_d, 2*chassis_height, 2], center=true);
    }
}

module side_railing_base() {
    z_offset = -0.01 + bed_rail_join * rail_thickness/2;
    difference() {
        union() {
            difference() {
                cube([rail_height, rail_length, rail_thickness]);
                translate([rail_thickness, rail_thickness, -rail_thickness])    
                cube([rail_height-2*rail_thickness,
                      rail_length-2*rail_thickness, 3*rail_thickness]);
            }
            step = rail_step;
            translate([rail_thickness/2, 0, 0])
            for(i=[0:10]) {
                j = i+1;
                hull() {
                    translate([(i%2)*(rail_height-rail_thickness),
                               rail_thickness/2+i*step, 0])
                    cylinder(d=rail_thickness, h=rail_thickness, $fn=20);
                    translate([(j%2)*(rail_height-rail_thickness),
                               rail_thickness/2+j*step, 0])
                    cylinder(d=rail_thickness, h=rail_thickness, $fn=20);
                }
            }
        }
        for(y=[0,rail_length-rail_thickness])
            translate([-0.001, y-0.001, z_offset])
            cube([2*rail_height, rail_thickness+0.002, 2*rail_thickness]);
        translate([-0.001, -0.001, z_offset])
        cube([rail_thickness+0.002, 2*rail_length, 2*rail_thickness]);
    }
}

module side_railing(mirror_it=false) {
    if(mirror_it)
        translate([0, rail_length, 0])
        mirror([0,1,0])
        side_railing_base();
    else
        side_railing_base();
}

module top_railing() {
    join_k = bed_rail_join;
    intersection() {
        union() {
            difference() {
                cube([rail_width, rail_length, rail_thickness]);
                translate([rail_thickness, rail_thickness, -rail_thickness])    
                cube([rail_width-2*rail_thickness,
                      rail_length-2*rail_thickness, 3*rail_thickness]);
            }
            step = rail_step;
            for(i=[1:10]) {
                translate([0, i*step, 0])
                cube([rail_width, rail_thickness, rail_thickness]);
            }
            for(i=[0:11]) {
                translate([0, i*step, 0]) {
                    for(m=[0,1])
                        translate([0, m*rail_thickness, 0])
                        mirror([0,m,0]) {
                            translate([0.3*rail_width, 0, 0])
                            rotate(225)
                            translate([0, -rail_thickness, 0])
                            cube([rail_width, rail_thickness, rail_thickness]);
                            
                            translate([0.7*rail_width, 0, 0])
                            rotate(315)
                            cube([rail_width, rail_thickness, rail_thickness]);
                        }                    
                }
            }
        }
        translate([0, rail_thickness, -rail_thickness/2]+join_k*[rail_thickness/2, 0, 0])
        cube([rail_width-join_k*rail_thickness, rail_length-2*rail_thickness, 2*rail_thickness]);
    }
}

module front_desk() {
    join_k = bed_rail_join;
    size = [rail_width, rail_height, rail_thickness];
    off = [rail_thickness, rail_thickness, 0];
    
    difference() {
        translate(join_k*[rail_thickness/2, 0, 0])
        cube(size-join_k*[rail_thickness, 0, 0]);
        translate(off+[0,0,rail_thickness/2])
        cube(size-2*off);
    }    
    translate([rail_width/2, rail_height-rail_thickness/2, rail_thickness/2])
    difference() {
        _front_top_shape();
        linear_extrude(rail_thickness)
        offset(r=-0.7*rail_thickness)
        projection()
        _front_top_shape();
    }
}

module _front_top_shape() {
    hull() {
        cube([rail_width-2*rail_thickness, rail_thickness, rail_thickness], 
             center=true);
        translate([0, 0.4*rail_width-rail_thickness/2, 0])
        cube([0.4*rail_width, rail_thickness, rail_thickness], 
             center=true);
    }
}

module chassis() {
    difference() {
        union() {
            translate([0,0,chassis_height/2])
            difference() {
                union() {
                    cube([chassis_width,
                          chassis_length,
                          chassis_height], center=true);
                    translate([0, body_y_offset, 0])
                    hull() {
                        cube([chassis_width,
                              chassis_center_length_2,
                              chassis_height], center=true);
                        translate([0,0,(chassis_center_height-chassis_height)/2])
                        cube([chassis_width,
                              chassis_center_length,
                              chassis_center_height], center=true);
                    }
                }
                translate([0,0,
                (chassis_center_height-chassis_height)/2+chassis_wall_thickness])
                cube([chassis_width - 2*chassis_wall_thickness,
                      chassis_length - 2*chassis_wall_thickness,
                      chassis_center_height], center=true);
                translate([0,0,chassis_wall_thickness])
                cube([bumper_distance-bumper_shaft_d,
                      chassis_length+10,
                      chassis_height], center=true);
            }
            for(y=[-1,1])
                translate([0,
                           y * (chassis_length/2 - bogie_offset),
                           chassis_wall_thickness])
                cylinder(d=bogie_pivot_d, h=bogie_pivot_h);
        }
        for(y=[-1,1]) {
            // wheel module
            translate([0,
                       y * (chassis_length/2 - bogie_offset),
                       chassis_wall_thickness])
            cylinder(d=bolt_hole, h=100);
        }
        
        if(!include_bumpers_to_chassis)
            for(za=[0,180])
                rotate(za)
                for(x=[-bumper_distance/2, bumper_distance/2])
                    translate([x*1.1, chassis_length/2,
                               chassis_height/2])
                    rotate([90,0,0]) 
                    cylinder(d=bumper_shaft_d+0.1, h=1.5*chassis_wall_thickness);
    }
    
    if(include_bumpers_to_chassis)
        for(za=[0,180])
            rotate(za)
            for(x=[-bumper_distance/2, bumper_distance/2])
                translate([x*1.1, bumper_length+chassis_length/2, 
                           bumper_shaft_d/2])
                rotate([90,0,0]) 
                intersection() {
                    bumper();
                    cube([bumper_head_d, bumper_shaft_d, 3*bumper_length],
                         center=true);
                }
}

module parts() {
    chassis();
    
    for(i=[0,1]) {
        translate([0, -1.2*chassis_length/2-(i*1000)/model_scale, 0])
        small_step();
        
        translate([-chassis_width/2-3*rail_width,
                   -i*1.1*rail_length, 0])
        top_railing();
    }
    
    translate([0, 1.4*chassis_length/2, 0]) front_handlebar();

    if(!include_bumpers_to_chassis)
        for(y=[-1.5:1.5])
            translate([2*y*bumper_head_d,1.15*chassis_length/2,0])
            bumper();
        
    for(i=[0:3]) {
        translate([1.5*chassis_width/2+i*rail_height, 
                   -1.1*(i%2)*rail_length, 0])
        mirror([i%2, 0, 0])
        side_railing();
        
        translate([-chassis_width/2-1.5*rail_width,
                   -rail_length/2+3*i*rail_height, 0])
        front_desk();
    }
}

module arranged() {
    translate([0, body_y_offset/2+chassis_length/2, handlebar_h/2])
    rotate([90,0,180])
    front_handlebar();

    translate()
    mirror([0,1,0])
    mirror([0,0,1])
    translate([0,-body_y_offset/2,0]) {
        chassis();
        if(!include_bumpers_to_chassis)
            for(za=[0,180])
                rotate(za)
                for(x=[-bumper_distance/2, bumper_distance/2])
                    translate([1.1*x, bumper_length+chassis_length/2, 
                               chassis_height/2])
                    rotate([90,0,0]) bumper();
    }
    
    for(i=[0,1]) {
        mirror([i, 0, 0]) {
            translate([chassis_width/2, chassis_length/2, 0])
            rotate([-90,0,-90])
            small_step();
            
            translate([chassis_width/2,0,0])
            rotate(180)
            rotate([0,90,0])
            translate([-rail_height, -rail_length/2, 0])
            side_railing();
            
            translate([chassis_width/2-rail_width,0,0])
            mirror([0,1,0])
            rotate([0,90,0])
            translate([-rail_height, -rail_length/2, 0])
            side_railing();
            
            translate([chassis_width/2-rail_width,
                       -rail_length/2, rail_height-rail_thickness])
            top_railing();
            
            for(j=[0,1])
                translate([chassis_width/2-rail_width, 
                           (j-0.5)*(rail_length-2*rail_thickness), 0])
                mirror([0, j, 0])
                rotate([90,0,0])
                front_desk();
        }
    }
}

//barrel();

/**/
if(view == "arranged")
    arranged();
else if(view == "parts")
    parts();
/**/
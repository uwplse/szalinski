/*******************************************************************\
|         __  ____       _ ____        _ __                         |
|        /  |/  (_)___  (_) __ \____ _(_) /      ______ ___  __     |
|       / /|_/ / / __ \/ / /_/ / __ `/ / / | /| / / __ `/ / / /     |
|      / /  / / / / / / / _, _/ /_/ / / /| |/ |/ / /_/ / /_/ /      |
|     /_/  /_/_/_/ /_/_/_/ |_|\__,_/_/_/ |__/|__/\__,_/\__, /       |
|                                                     /____/        |
|*******************************************************************|
|                                                                   |
|        Czechoslovakian bulk materials carriage "Uacs"             |
|                                                                   |
|                      designed by Svenny                           |
|                                                                   |
|       source: https://www.thingiverse.com/thing:2749128           |
|                                                                   |
\*******************************************************************/


/* [VIEW] */
// rendering precission
$fn=140;
// what to show
view = "arranged"; // [parts, arranged]
// scale
model_scale = 160; // Z=220, N=160, TT=120, H0=87
// include bumpers to chassis part (easier to print but not as nice)
include_bumpers_to_chassis = true;
// wall thickness of the chassis part
chassis_wall_thickness = 0.6;

/* [JOIN WHEEL MODULE ] */
// bolt hole diameter (default 2.4mm for M2.5 bolts)
bolt_hole = 2.5;
// center of the joining cylinder from the edge of the chassis (without bumpers!)
bogie_offset = 13.2;
// pivoting cylinder diameter
bogie_pivot_d = 5;
// pivoting cylinder height
bogie_pivot_h = 2.6;

barrel_d = 3100 / model_scale;
barrel_top_d = 600 / model_scale;
barrel_center_h = 650 / model_scale;
barrel_top_h = 1050 / model_scale;
barrel_bottom_h = 1000 / model_scale;
barrel_bottom_d = 1650 / model_scale;
barrel_round_r = 160 / model_scale;
barrel_h = barrel_top_h + barrel_bottom_h + barrel_center_h;
barrels_distance = 3200 / model_scale;

body_top_width = 2000 / model_scale;
body_bottom_width = 2700 / model_scale;
body_top_length = 11800 / model_scale;
body_bottom_length = 12500 / model_scale;
body_height = 800 / model_scale;
body_y_offset = 600 / model_scale;

chassis_length = 13300 / model_scale;
chassis_height = 380 / model_scale;
chassis_width = 2700 / model_scale;

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

module barrel() {
    difference() {
        intersection() {
            union() {
                minkowski() {
                    union() {
                        cylinder(r1=barrel_bottom_d/2-barrel_round_r,
                                 r2=barrel_d/2-barrel_round_r,
                                 h=barrel_bottom_h);
                        translate([0,0,barrel_bottom_h])
                        cylinder(r=barrel_d/2-barrel_round_r,
                                 h=barrel_center_h);
                        translate([0,0,barrel_bottom_h + barrel_center_h])
                        cylinder(r1=barrel_d/2-barrel_round_r,
                                 r2=barrel_top_d/2-barrel_round_r,
                                 h=barrel_top_h);
                    }
                    
                    sphere(r=barrel_round_r);
                }
                translate([0,0,barrel_bottom_h + barrel_center_h + barrel_top_h])
                cylinder(r=barrel_top_d/2,
                         h=barrel_round_r);
            }
            
            cylinder(d=2*barrel_d,
                     h=2*(barrel_h));
        }
        
        cylinder(d=3.2, h=3);
    }
}

module ladder(length) {
    translate([0,0,ladder_thickness/2]) {
        for(x=[-1,1])
            translate([x*ladder_w/2, 0, 0])
            cube([ladder_thickness, length, ladder_thickness], center=true);
        
        for(y=[-length/2+ladder_step_h:ladder_step_h:length/2])
            translate([0, y, 0])
            cube([ladder_w, ladder_thickness, ladder_thickness], center=true);
    }
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

module bridge() {
    bridge_h = barrel_h - 0.6*barrel_top_h;
    translate([0,0,-bridge_h+ladder_thickness/2])
    difference() {
        hull()
        intersection() {
            union() {
                for(y=[-barrels_distance/2, barrels_distance/2])
                    translate([0,y,0]) barrel();
            }
            translate([0,0,bridge_h])
            cube([body_top_width-2*ladder_thickness, 
                  barrels_distance, 
                  ladder_thickness], center=true);
        }
        for(y=[-barrels_distance/2, barrels_distance/2])
            translate([0,y,0]) barrel();
    }
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

module body() {
    difference() {
        union() {
            hull() {
                translate([0,0,body_height/2])
                cube([body_top_width, body_top_length, body_height], 
                     center=true);     
                translate([0,0,0.05])
                cube([body_bottom_width, body_bottom_length, 0.1], center=true);
            }
            for(y=[-1.5*barrels_distance:barrels_distance:1.5*barrels_distance])
                translate([0,y,body_height]) cylinder(d=3, h=1);
        }
        
        translate([0,body_y_offset/2,0])
        for(y=[-1, 1, -0.2, 0.2])
            translate([0,
                       y * (chassis_length/2 - bogie_offset),
                       -chassis_wall_thickness])
            cylinder(d=bolt_hole, h=body_height);
    }
}

module chassis() {
    difference() {
        union() {
            translate([0,0,chassis_height/2])
            difference() {
                cube([chassis_width,
                      chassis_length,
                      chassis_height], center=true);
                translate([0,0,chassis_wall_thickness])
                cube([chassis_width - 2*chassis_wall_thickness,
                      chassis_length - 2*chassis_wall_thickness,
                      chassis_height], center=true);
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
            cylinder(d=bolt_hole, h=100, center=true);
            
            // join chassis + body (+ weight)
            translate([0,
                       0.2 * y * (chassis_length/2 - bogie_offset),
                       chassis_wall_thickness])
            cylinder(d=bolt_hole+0.3, h=100, center=true);
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
    translate([6400/model_scale,0,0])
    body();

    translate([3200/model_scale,0,0])
    chassis();
    
    ladder_l = 2.95*(barrel_center_h+barrel_top_h+barrel_bottom_h);
    translate([-1600/model_scale, -ladder_l/3, 0])
    ladder(ladder_l);
    
    for(i=[0,1]) {
        translate([-2500/model_scale, (5600-i*1000)/model_scale, 0])
        small_step();
        
        translate([-3200/model_scale, -(5600-i*2600)/model_scale, 0])
        bridge();
    }
    
    translate([-3200/model_scale,0,0]) rotate(90) front_handlebar();

    for(y=[-1.5:1.5])
        translate([0,y*3500/model_scale,0])
        barrel();
    
    if(!include_bumpers_to_chassis)
        for(y=[3:6])
            translate([-1600/model_scale,2*y*bumper_head_d,0])
            bumper();
}

module arranged() {
    body();
    
    translate([0,0,body_height])
    for(y=[-1.5*barrels_distance:barrels_distance:1.5*barrels_distance])
        translate([0,y,0]) barrel();
    
    for(y=[-1,1]) {
        translate([-body_top_width/2,
                   y*barrels_distance,
                   0.85*barrel_h/2+body_height])
        rotate([90,0,90])
        ladder(0.85*barrel_h);
        
        translate([0,y*barrels_distance,body_height+barrel_h-0.6*barrel_top_h])
        bridge();
        
        translate([y*chassis_width/2,
                   (body_y_offset+body_bottom_length)/2,
                   -ladder_step_h/2])
        rotate([-90,0,-y*90])
        small_step();
    }
    
    translate([0, body_y_offset/2+chassis_length/2, handlebar_h/2])
    rotate([90,0,180])
    front_handlebar();

    mirror([0,0,1])
    translate([0,body_y_offset/2,0]) {
        chassis();
        if(!include_bumpers_to_chassis)
            for(za=[0,180])
                rotate(za)
                for(x=[-bumper_distance/2, bumper_distance/2])
                    translate([1.1*x, bumper_length+chassis_length/2, 
                               chassis_height/2])
                    rotate([90,0,0]) bumper();
    }
}


if(view == "arranged")
    arranged();
else if(view == "parts")
    parts();

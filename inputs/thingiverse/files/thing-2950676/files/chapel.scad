/*******************************************************************\
|         __  ____       _ ____        _ __                         |
|        /  |/  (_)___  (_) __ \____ _(_) /      ______ ___  __     |
|       / /|_/ / / __ \/ / /_/ / __ `/ / / | /| / / __ `/ / / /     |
|      / /  / / / / / / / _, _/ /_/ / / /| |/ |/ / /_/ / /_/ /      |
|     /_/  /_/_/_/ /_/_/_/ |_|\__,_/_/_/ |__/|__/\__,_/\__, /       |
|                                                     /____/        |
|*******************************************************************|
|                                                                   |
|     Small Chapel in Bubovice, Central Bohemia, Czech Rep.         |
|                                                                   |
|                      designed by Svenny                           |
|                                                                   |
|       source: https://www.thingiverse.com/thing:2950676           |
|                                                                   |
\*******************************************************************/


/* [VIEW] */
// rendering precission
$fn=140;
// what to show
view = "arranged"; // [small_roof, big_roof, building, cross, gate, arranged]
// scale
model_scale = 160; // Z=220, N=160, TT=120, H0=87
// absolute thickness of the walls
wall_thickness = 1.2;
// should it be hollow?  0 = false
is_hollow = 1; // [0, 1]
// should be the gate included to building?  0 = false
is_gate_included = 1; // [0, 1]
// absolute thickness of the gate
gate_thickness = 0.6;

// Customizer is ignoring booleans...
hollow = is_hollow != 0;
gate_included = is_gate_included != 0;

width = 3000 / model_scale;
base_height = 3700 / model_scale;

gate_width = 1000 / model_scale;
gate_z_offset = 100 / model_scale;
gate_door_height = 2000 / model_scale;

side_window_width = 700 / model_scale;
side_window_height = 1200 / model_scale;

cross_width = 230 / model_scale;
cross_height = 450 / model_scale;
cross_thickness = 75 / model_scale;

podezdivka_height = 650 / model_scale;
podezdivka_thickness = 40 / model_scale;

deco_thickness = 30 / model_scale;
top_deco_height = 300 / model_scale;
vert_deco_width = 450 / model_scale;

big_under_roof_height = 130 / model_scale;
big_roof_width = width + 300 / model_scale;
big_roof_height = 700 / model_scale;
big_roof_top_width = 1200 / model_scale;
big_roof_triangle_height = 500 / model_scale;

belfry_bottom_height = 230 / model_scale;
belfry_bottom_thickness = 150 / model_scale;
belfry_width = 1070 / model_scale;
belfry_height = 950 / model_scale;
belfry_ceil_width = 1250 / model_scale;
belfry_ceil_height = 160 / model_scale;

belfry_window_width = 260 / model_scale;
belfry_window_height = 650 / model_scale;
belfry_window_z_offset = 80 / model_scale;

// sr = small roof
sr_1_width = 1400 / model_scale;
sr_1_height = 250 / model_scale;
sr_2_width = 770 / model_scale;
sr_2_height = 820 / model_scale;
sr_sphere_d = 280 / model_scale;


module base_building() {
    difference() {
        union() {
            color("white")
            translate([0,0,(base_height-big_under_roof_height/2)/2])
            cube([width, width, base_height-big_under_roof_height/2], center=true);
            
            color("brown")
            translate([0,0,podezdivka_height/2])
            cube([width+2*podezdivka_thickness,
                  width+2*podezdivka_thickness,
                  podezdivka_height], center=true);
            
            color("gold")
            for(ix=[-1,1]) {
                x = ix*(width/2-(width-gate_width)/4);
                translate([x, width/2, base_height/2])
                cube([vert_deco_width,
                      2*deco_thickness, 
                      base_height-2*big_under_roof_height], center=true);
            }
            
            color("gold")
            translate([0,width/2,
                       base_height-(big_under_roof_height+top_deco_height)/2])
            cube([width, 2*deco_thickness, top_deco_height], 
                center=true);
            
            // cross
            color("brown")
            translate([0,width/2,0.8*base_height]) {
                cube([cross_thickness, cross_thickness, cross_height], center=true);
                translate([0,0,cross_height/2 - cross_width/2])
                cube([cross_width, cross_thickness, cross_thickness], center=true);
            }
        }
        if(hollow)
        difference() {
            translate([0,0,base_height/2+0.2])
            cube([width-2*wall_thickness,
                  width-2*wall_thickness, base_height], center=true);
            for(i=[-1,1])
                translate([i*(width/2-wall_thickness-gate_thickness/2),
                           0, 
                           0.6*base_height-1.5])
                cube([gate_thickness, side_window_width+3, side_window_height+3],
                     center=true);
        }
        
        // side windows
        for(i=[-1,1])
            translate([i*width/2, 0, 0.6*base_height]) {
                rotate([0,90,0])
                cylinder(d=side_window_width, h=2*wall_thickness, center=true);
                translate([0,0,-(side_window_height-side_window_width/2)/2])
                cube([2*wall_thickness, 
                      side_window_width,
                      side_window_height-side_window_width/2], center=true);
            }
            
        translate([0, width/2, gate_z_offset+gate_door_height/2])
        cube([gate_width, 2*wall_thickness, gate_door_height], center=true);
            
        translate([0, width/2, gate_z_offset+gate_door_height])
        rotate([90,0,0])
        cylinder(d=gate_width, h=2*wall_thickness, center=true);
    }
}

module building() {
    base_building();
    if(gate_included)
        color("SaddleBrown")
        translate([0, width/2-wall_thickness, gate_z_offset])
        rotate([90,0,180])
        gate();
}

module big_roof() {
    color("white")
    translate([0,0,-big_under_roof_height/2])
    cube([big_roof_width, big_roof_width, big_under_roof_height], center=true);
    
    difference() {
        union() {
            color("gray")
            hull() {
                cube([big_roof_width, big_roof_width, 0.001], center=true);
                translate([0,0,big_roof_height])
                cube([big_roof_top_width, big_roof_top_width, 0.001], center=true);
            }
            
            color("gray")
            hull() {
                translate([0,big_roof_width/4,0])
                cube([big_roof_width, big_roof_width/2, 0.001], center=true);
                translate([0,big_roof_width/4,big_roof_triangle_height])
                cube([0.001, big_roof_width/2, 0.001], center=true);
            }    
        }
        
        // front triangle
        color("gold")
        translate([0, width/2, 0])
        rotate([-90,0,0])
        linear_extrude(width)
        offset(r=-big_under_roof_height)
        projection()
        rotate([90,0,0])
        hull() {
            translate([0,big_roof_width/4,-big_under_roof_height/2])
            cube([big_roof_width, big_roof_width/2, big_under_roof_height],
                 center=true);
            translate([0,big_roof_width/4,big_roof_triangle_height])
            cube([0.001, big_roof_width/2, 0.001], center=true);
        }
    }
    
    // belfry
    color("white")
    translate([0,0,big_roof_height+0.45*belfry_bottom_height])
    minkowski() {
        sphere(d=belfry_bottom_height, $fn=6);
        cube([belfry_width, belfry_width, 0.2], center=true);
    }
    
    translate([0,0,big_roof_height+0.9*belfry_bottom_height])
    difference() {  // belfry
        union() {
            color("white")
            translate([0,0,belfry_height/2])
            cube([belfry_width, belfry_width, belfry_height], center=true);
            
            color("gold")
            translate([0,0,belfry_height+belfry_ceil_height])
            hull() {
                translate([0,0,-belfry_ceil_height])
                cube([1.1*belfry_width,
                      1.1*belfry_width,
                      0.01], center=true);
                translate([0,0,0])
                cube([belfry_ceil_width,
                      belfry_ceil_width,
                      0.01], center=true);
            }
        }
        // belfry hollow
        if(hollow)
        cube([belfry_width-2*wall_thickness,
              belfry_width-2*wall_thickness, 
              2.5*belfry_height], center=true);
        // belfry windows
        for(angle=[0,90]) {
            rotate(angle)
            hull() {
                translate([0,0,belfry_window_height-0.65*belfry_window_width])
                rotate([90,0,0])
                intersection() {
                    translate([belfry_window_width/2,0,0])
                    cylinder(r=belfry_window_width, h=2*belfry_width, center=true);
                    translate([-belfry_window_width/2,0,0])
                    cylinder(r=belfry_window_width, h=2*belfry_width, center=true);
                }
                
                translate([0,0,belfry_window_z_offset])
                cube([belfry_window_width, 2*belfry_width, 0.01], center=true);
            }
        }
    }
}

module small_roof() {    
    color("gray") {
        hull() {
            translate([0,0,0])
            cube([sr_1_width, sr_1_width, 0.01], center=true);
            translate([0,0,sr_1_height])
            cube([sr_2_width, sr_2_width, 0.01], center=true);
        }
        hull() {
            translate([0,0,sr_1_height])
            cube([sr_2_width, sr_2_width, 0.01], center=true);
            translate([0,0,sr_1_height+sr_2_height])
            cube([0.1, 0.1, 0.01], center=true);
        }
        translate([0,0,sr_1_height+sr_2_height])
        difference() {
            sphere(d=sr_sphere_d);
            scale(1.25)
            translate([0,0,sr_sphere_d/2])
            cube([cross_thickness, cross_thickness, sr_sphere_d], center=true);
        }
    }
}

module top_cross() {
    color("brown") 
    scale(1.2)
    translate([0, cross_height/2, 0]) {
        cube([cross_thickness, cross_height, cross_thickness], center=true);
        translate([0,cross_height/2 - cross_width/2,0])
        cube([cross_width, cross_thickness, cross_thickness], center=true);
    }
}

module _gate_shape() {
    translate([0, gate_door_height/2])
    square([gate_width, gate_door_height], center=true);
    translate([0, gate_door_height])
    circle(d=gate_width);
}

module gate() {
    gate_rim = gate_width/8;
    intersection() {
        translate([0,0,-gate_thickness])
        linear_extrude(gate_thickness)
        offset(r=1.5)
        _gate_shape();
        
        translate([-3*gate_width, 0, -2*wall_thickness])
        cube([6*gate_width, 4*gate_door_height, 4*wall_thickness]);
    }
    
    intersection() {
        linear_extrude(gate_thickness)
        _gate_shape();
        union() {
            translate([-gate_width, gate_door_height, 0])
            cube([2*gate_width, 0.15*gate_width, gate_thickness]);
            translate([0, gate_door_height, 0])
            difference() {
                cylinder(d=gate_width, h=gate_thickness);
                cylinder(d=0.8*gate_width, h=2*gate_thickness);
                translate([0, -2*gate_width, 0])
                cube(4*gate_width, center=true);
            }
            for(angle=[-60:30:60]) {
                translate([0, 1.04*gate_door_height, 0])
                rotate(angle)
                translate([0,gate_width/2,0])
                cube([0.1*gate_width, gate_width, 2*gate_thickness], center=true);
            }
            for(i=[0,1]) {
                mirror([i,0,0])
                translate([0.05,0,-0.01])
                difference() {
                    cube([gate_width/2-0.05, gate_door_height-0.1, gate_thickness]);
                    translate([gate_rim, gate_rim, 0.6*gate_thickness])
                    cube([gate_width/2-0.05-2*gate_rim,
                          gate_door_height/2-1.5*gate_rim, 
                          2*gate_thickness]);
                    translate([gate_rim, gate_door_height/2+0.5*gate_rim, 0])
                    cube([gate_width/2-0.05-2*gate_rim,
                          gate_door_height/2-1.5*gate_rim, 
                          2*gate_thickness]);
                }
            }
        }
    }
}

module arranged() {
    base_building();
    translate([0,0,base_height])
    big_roof();
    translate([0,0,base_height+big_roof_height+0.9*belfry_bottom_height+belfry_height+belfry_ceil_height])
    small_roof();
    translate([0,0,base_height+big_roof_height+0.9*belfry_bottom_height+belfry_height+belfry_ceil_height+sr_1_height+sr_2_height])
    rotate([90,0,0])
    top_cross();
    color("SaddleBrown")
    translate([0, width/2-wall_thickness, gate_z_offset])
    rotate([90,0,180])
    gate();
}

if(view == "building")
    building();
else if(view == "arranged")
    arranged();
else if(view == "big_roof")
    big_roof();
else if(view == "small_roof")
    small_roof();
else if(view == "cross")
    top_cross();
else if(view == "gate")
    gate();

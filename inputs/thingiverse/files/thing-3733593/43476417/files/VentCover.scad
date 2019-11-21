//
// Vent cover: Cover for ventilation openings 
//
//  Author: MrFuzzy_F, 
//  License: CC BY-NC
//

$fa=1*1;
$fs=0.25*1;

// type of grid
grid_type = 0; // [0:circular, 1:net, 2:radial]


// thickness of base/cover plate
h_plate = 3;

// diameter of base/cover plate
d_plate = 150;

// tube wall thickness
d_tube_wall = 2.5;

// tube outer diameter
d_tube_outer = 100;

// height/length of tube
h_tube = 50;

// thickness/width of grid lines
grid_thickness = 1.2;

// max distance between grid lines
grid_max_dist = 3;

// number of screw holes
n_screws = 3;

// screw type 
screw_mode = 0; // [0:countersunk, 1:flat sunk]

// screw diameter
d_screw = 3;

// computed values
d_tube_inner = d_tube_outer - 2*d_tube_wall;


plate();
if (grid_type == 0) {
    circular_grid();
} else if (grid_type == 1) {
    net_grid();
} else if (grid_type == 2) {
    radial_grid();
}    


module plate() {
    
    
    difference() {
        union() {
            cylinder(h_plate+h_tube, d=d_tube_outer);
            cylinder(h_plate, d1=d_plate-5, d2=d_plate);
        }
        cylinder((h_plate+h_tube)*3, d=d_tube_inner,center=true);
        screws();
    }
}


module net_grid() {
    
    n_lines = ceil((d_tube_inner-grid_thickness) / (grid_thickness+grid_max_dist));
    
    intersection() {
        translate([-d_tube_outer/2, -d_tube_inner/2, 0]) {
            for (d_delta = [0:(d_tube_inner-grid_thickness)/n_lines:d_tube_inner]) 
                translate([0, d_delta, 0])
                    cube([d_tube_outer, grid_thickness, h_plate]);
        }
        cylinder(h_plate, d=d_tube_inner);
    }
    intersection() {
        translate([-d_tube_inner/2, -d_tube_outer/2, 0]) {
            for (d_delta = [0:(d_tube_inner-grid_thickness)/n_lines:d_tube_inner]) 
                translate([d_delta, 0, 0])
                    cube([grid_thickness, d_tube_outer, h_plate]);
        }
        cylinder(h_plate, d=d_tube_inner);
    }
    
}


module radial_grid() {

    translate([-d_tube_outer/2, -grid_thickness/2, 0])
        cube([d_tube_outer, grid_thickness, h_plate]);

    n_lines = ceil(d_tube_inner*3.14 / (grid_thickness+grid_max_dist) / 2);
    d_delta = 2*(grid_thickness+grid_max_dist);
    echo("d_delta: ", d_delta);
    for (angle = [0:180/n_lines:180]) 
        rotate([0,0,angle])
            translate([-d_tube_outer/2, -grid_thickness/2, 0])
                cube([d_tube_outer, grid_thickness, h_plate]);
   
}


module circular_grid() {

    /*
    translate([-d_tube_outer/2, -grid_thickness/2, 0])
        cube([d_tube_outer, grid_thickness, h_plate]);
    translate([-grid_thickness/2, -d_tube_outer/2, 0])
        cube([grid_thickness, d_tube_outer, h_plate]);
    */
    for (angle = [0:180/4:180]) {
        rotate([0,0,angle])
            circular_grid_axle();
        
    }

    n_delta = d_tube_inner/2 / (grid_thickness+grid_max_dist);
    d_delta = 2*(grid_thickness+grid_max_dist);
    echo("d_delta: ", d_delta);
    for (d = [0:d_delta:d_tube_inner]) 
        circular_grid_element(d);
   
}

module circular_grid_axle() {
     translate([-d_tube_outer/2, -grid_thickness/2, 0])
        cube([d_tube_outer, grid_thickness, h_plate]);     
}

module circular_grid_element(d_inner) {
    
    difference() {
        cylinder(h_plate, d=d_inner+2*grid_thickness);
        cylinder(h_plate*3, d=d_inner, center=true);        
    }
}

module tooth() {
 
    tx = tooth_size * cos(tooth_angle/2);
    ty = tooth_size * sin(tooth_angle/2);
    translate([d_halter_innen/2-tx, 0, h_platte])
        linear_extrude(h_halter_innen)
            polygon(points=[[0,0], [tx,ty], [tx,-ty]]);
    
    
}


module screws() {
 
   angle = 360/n_screws;
    for (angle = [0:360/n_screws:360]) 
        rotate([0,0,angle])
            translate([(d_plate + d_tube_outer - 10)/4, 0, 0])
                union() {
                    cylinder(h_plate, d=d_screw);
                    if (screw_mode == 0) {
                        cylinder(h_plate/2, d1=d_screw*2.5, d2=d_screw);
                    } else {
                        cylinder(h_plate/2, d=d_screw*2.5);
                    }
                }
    
}
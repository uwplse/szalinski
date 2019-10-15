
// Measurements are assumed to be in millimetres
radius_outer = 34.5; //7.5;
radius_lip =  radius_outer + 5;
radius_inner = 27.5;
depth  = 30;
depth_lip = 2;

$fn = radius_outer * 16;

difference() {    
    translate([0, 0, -depth_lip]) {
        cylinder(depth_lip, d = radius_lip);
    }
    translate([0, 0, -.5 * depth]) {
        cylinder(depth * 2, d = radius_inner);    
    }
}
    
difference() {    
    cylinder(depth, d = radius_outer);

    translate([0, 0, -.5 * depth]) {
        cylinder(depth * 2, d = radius_inner);    
    }
}


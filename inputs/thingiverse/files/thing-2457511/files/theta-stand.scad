// Stand for RICOH THETA SC


/* [Basic parameters] */

// Height of the stand
height = 20;          // [5:95]
// Wall thickness
stand_thickness = 1.6;  // 0.3
// Leg spread
base_r = 100;            // [50:200]
// additional clearance for inserting camera
clearance = 1.5;         // [0:5]

/* [Camera Dimensions] */

//Radius of the theta body
tetha_r = 75;
//Thickness of theta
tetha_depth = 18;
//Width of theta
tetha_width = 45;


module theta_profile(extra=0) {
    r = tetha_r; 
    r_dist = tetha_depth + extra;
    w = tetha_width + extra;
    
    intersection() {
        translate([-r+r_dist/2,0,0])
        circle(r=r, $fn=180);
    
        translate([r-r_dist/2,0,0])
        circle(r=r, $fn=180);
        
        square([r_dist,w], center=true);
    }        
}

module theta_body(extra=0, height=10) {
    linear_extrude(height=height) {
        theta_profile(extra=extra);
    }
}

module theta_shell(thickness=2, height=130, extra=0) {
    
    difference() {    
        theta_body(extra=2*thickness+extra, height=height);
    
        translate([0,0,thickness])
        theta_body(extra=extra, height=height);
    }    
}

module theta_mount_leg(height=20, len=20, thickness=2) {
    
    translate([0,-thickness/2,0])
    rotate([90,0,180])
    linear_extrude(height=thickness) {
        polygon(points=[[0,0],[0,height],[len,0]]);
    }
    
    translate([-len,0,0])
    cylinder(r=thickness*2, h=thickness);

}

module theta_stand(extra=0, height=20, thickness=2, base_r=70) {
    r_dist = tetha_depth+extra;
    w = tetha_width+extra;
    
    l1 = (base_r - r_dist) / 2 - 2*thickness - thickness;
    l2 = (base_r - w) / 2 - 2*thickness - thickness;
    
    theta_shell(height=height, thickness=thickness, extra=extra);
    
    translate([-r_dist/2-thickness,0,0])
    theta_mount_leg(height=height, len=l1);

    translate([r_dist/2+thickness,0,0])
    rotate([0,0,180])
    theta_mount_leg(height=height, len=l1);
    
    translate([0,-w/2-thickness,0])
    rotate([0,0,90])
    theta_mount_leg(height=height, len=l2);

    translate([0,w/2+thickness,0])
    rotate([0,0,-90])
    theta_mount_leg(height=height, len=l2);
    
    
}

theta_stand(extra=clearance, height=height, thickness=stand_thickness, base_r=base_r);

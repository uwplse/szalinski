// motor clip internal diameter
motor_d = 8; 
// motor clip height
motor_h = 3;    
// motor clip thickness
motor_t = 1.5; 
// motor clip pin height
pin_h = 2;      
// motor clip pin width
pin_w = 2;      
// motor clip pin z rotation angle
pin_r = 0;      
// motor clip cut width
cut_w = 2;      
// guard height
guard_h = 1.5;  
// guard width
guard_w = 1;    
// arm length from motor center
arm_l = 30;     
// arm base height
arm_base_h = 3; 
// arm base width
arm_base_w = 2; 
// angle between the two arms
arm_a = 120; // [0:180]   

module prop_guard() {
    $fn=40;

    difference() {
        union() {
            arm(-arm_a/2);
            arm(arm_a/2);
            cylinder(r=motor_d/2+motor_t,h=motor_h);
            rotate([0,0,0])translate([0,0,motor_h]) motor_pin();
        }
        cylinder(r=motor_d/2,h=motor_h);
        translate([-motor_d/2-motor_t,-cut_w/2,0]) cube([motor_t*2,cut_w,motor_h]);
    }

    intersection() {
        difference() {
            cylinder(r=arm_l,h=2);
            cylinder(r=arm_l-guard_w,h=guard_h);
        }
        hull() {
            rotate([0,0,-arm_a/2]) cube([arm_l*2,0.1,guard_h]);
            cube([arm_l*2,0.1,guard_h]);
            rotate([0,0,arm_a/2]) cube([arm_l*2,0.1,guard_h]);
        }
    }
}

module arm(angle) {
    rotate([0,0,angle])hull() {
        cylinder(r=arm_base_w/2,h=arm_base_h);
        translate([arm_l-guard_w/2,0,0])cylinder(r=guard_w/2,h=guard_h);
    }
}

module motor_pin() {
    intersection() {
        cylinder(r=motor_d/2+motor_t,h=pin_h);
        translate([motor_d/2,-pin_w/2,0])cube([motor_t,pin_w,pin_h]);
    }
}

prop_guard();
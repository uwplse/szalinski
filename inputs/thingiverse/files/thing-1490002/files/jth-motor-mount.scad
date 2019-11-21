/* [Motor Bolts] */
Motor_Bolt_X_spacing = 16; // Motor Bolts X distance
Motor_Bolt_Y_spacing = 19; // Motor Bolts Y distance
Screw_Size = 3; // Screw Size

/* [Motor Plate] */
Plate_Thickness = 5;
Plate_Diameter = 32;

/* [Arm Size] */
arm_outside_diameter = 13;

/* [Shell Size] */
Shell_OD = 20;

/* [Hidden] */
$fs = 0.2;
Plate_Radius = Plate_Diameter/2;


difference() {
    hull() {
        difference() {
            // Shell
            translate([3,0,11]) cube([26,Shell_OD,Shell_OD],true);
            // Shell clipping shape
            difference() {
                translate([5,0,11]) cube([32,Shell_OD+1,Shell_OD+1],true);      
                translate([5,0,11]) rotate([0,90,0]) cylinder(32,9.7,12,true);
                translate([5,0,0]) cube([40,Shell_OD+1,Shell_OD+1],true);
            }
        }
        // Motor Plate
        cylinder(Plate_Thickness,Plate_Radius,Plate_Radius,true);
        // End Ball
        translate([-Shell_OD/2,0,Shell_OD/2]) sphere(Shell_OD/2);
    }
    // Remove arm material
    translate ([20,0,10]) cube([60,arm_outside_diameter,arm_outside_diameter],true);
    // Remove motor post material
    translate([0,0,30]) motor_posts(25);
    // Remove motor screw material
    motor_screws(50);
    // Remove motor shaft clerance
    translate([0,0,0]) cylinder(8,3,3,true);
}

module motor_posts(sl=10) {
    rotate([0,0,45]) {
    translate([Motor_Bolt_X_spacing/2,0,0]) cylinder(sl,Screw_Size,Screw_Size,true);
    translate([-Motor_Bolt_X_spacing/2,0,0]) cylinder(sl,Screw_Size,Screw_Size,true);
    translate([0,Motor_Bolt_Y_spacing/2,0]) cylinder(sl,Screw_Size,Screw_Size,true);
    translate([0,-Motor_Bolt_Y_spacing/2,0]) cylinder(sl,Screw_Size,Screw_Size,true);
    }
}

module motor_screws(sl=10) {
    rotate([0,0,45]) {
    translate([Motor_Bolt_X_spacing/2,0,0]) cylinder(sl,Screw_Size/2,Screw_Size/2,true);
    translate([-Motor_Bolt_X_spacing/2,0,0]) cylinder(sl,Screw_Size/2,Screw_Size/2,true);
    translate([0,Motor_Bolt_Y_spacing/2,0]) cylinder(sl,Screw_Size/2,Screw_Size/2,true);
    translate([0/2,-Motor_Bolt_Y_spacing/2,0]) cylinder(sl,Screw_Size/2,Screw_Size/2,true);
    }
}
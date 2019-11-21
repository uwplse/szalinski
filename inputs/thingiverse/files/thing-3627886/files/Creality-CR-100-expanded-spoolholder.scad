// tubes: 334mm, 404mm, 500mm
// top notches: 352mm, noth height: 1.4mm, width: 14mm

extended = +20; // 36 base model + this height

module base_shape() {
    union() {
        cylinder(50 + extended, 33.2 / 2, 33.2 / 2, true, $fn = 180); // added 0.2
        translate([0, 0, -14.7 / 2]) cylinder(50 + extended - 14.7, 40.4 / 2, 40.4 / 2, true, $fn = 180);
        translate([0, 0, -(50 + extended - 2) / 2 ]) cylinder(2, 50.0 / 2, 50.0 / 2, true, $fn = 180);
        translate([0, 0, -(50 + extended - 6) / 2 ]) cylinder(2, 50.0 / 2, 40.0 / 2, true, $fn = 180);
    }
}

module base_shape_with_marking() {
    difference() {
        base_shape();
        rotate([0, 0, -12]) translate([20, 0, 9 + extended / 2]) cube([1, 1, 5], true); 
        translate([0, 0, -2.5]) cylinder(50 + extended, 28 / 2, 28 / 2, true, $fn = 180);
    }    
}    

module latches() {
    translate([0, 0,  (50 + extended - 1.8) / 2]) difference() {
        cylinder(1.8, 35.5 / 2, 35.5 / 2, true, $fn = 180); // added 0.5 to witdh and 0.2 to thickness
        translate([0, +(25 + 7), 0]) cube([50, 50, 5], true); 
        translate([0, -(25 + 7), 0]) cube([50, 50, 5], true); 
    }
}    

union() {
    base_shape_with_marking();
    latches();
    rotate([0, 0, -21]) translate([33.2 / 2 + 0.4, 0, 11.8 + extended / 2]) cube([1, 2, 3], true);  // left
    rotate([0, 0, +30]) translate([33.2 / 2 + 0.4, 0, 11.8 + extended / 2]) difference() { 
        cube([1, 3, 3], true); 
        translate([0, 2, 2]) rotate([45, 0, 0]) cube([1 + 1, 3, 3], true);
    } // right
}    
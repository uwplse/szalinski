phone_width = 77.7; // [20:200]
phone_thickness = 20; // [5:100]
arm_width = 5; // [1:20]
finger_length = 3; // [2:20]
ziptie_width = 8; // [2:20]
bike_tube_size = 11; // [5:40]

difference(){
    union() {
        translate([0, 0, ziptie_width+2]) cylinder(2, bike_tube_size+4, bike_tube_size+4);
        translate([0, 0, 2]) cylinder(ziptie_width, bike_tube_size+3, bike_tube_size+3);
        cylinder(2, bike_tube_size+4, bike_tube_size+4);
    }
    cylinder(50, bike_tube_size, bike_tube_size, true);
    translate([0, bike_tube_size, 0]) cube([bike_tube_size*2,bike_tube_size*2,50], true);
};



translate([-phone_width/2, -bike_tube_size-phone_thickness-arm_width, 0]) linear_extrude(2) difference(){
    translate([-arm_width, -arm_width, 0])
        square([phone_width+arm_width*2,phone_thickness+arm_width*2]);
    square([phone_width,phone_thickness]);
    translate([finger_length, -arm_width, 0]) square([phone_width-finger_length*2,arm_width]);
}
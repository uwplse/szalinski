r_front = 60;
r_middle = 50;
r_back = 40;
h_front = 30;
h_back = 30;
thinckness = 1;

plate_thinckness = 3;
motor_width = 20;
motor_height = 15;

//front
translate([0,0,-h_front/2]) {
    difference() {
     cylinder(h = h_front, r1 = r_front+thinckness, r2 = r_middle+thinckness, center = true);
        cylinder(h = h_front+2, r1 = r_front, r2 = r_middle, center = true);
    }
}

//back
translate([0,0,h_back/2]) {
    difference() {
        cylinder(h = h_back, r1 = r_middle+thinckness, r2 = r_back+thinckness, center = true);
        cylinder(h = h_back+2, r1 = r_middle, r2 = r_back, center = true);
    }
}

translate([0,plate_thinckness/2+motor_height/2,h_back/2]) {
    cube([motor_width,plate_thinckness,h_back],center=true);
}

translate([0,plate_thinckness/2+r_front,h_back/2]) {
    cube([motor_width,plate_thinckness,h_back],center=true);
}

translate([0,r_front-(r_front-motor_height/2-plate_thinckness/2)/2,h_back/2]) {
    cube([plate_thinckness,r_front-motor_height/2-plate_thinckness/2,h_back],center=true);
}



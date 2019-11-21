$fs=1;
$fa=1;

diameter = 40;

gridx_num = 2;

gridy_num = 2;

module rotate_method(diameter=40) {
    rotate_extrude() difference() {
        intersection() {
            translate([0,diameter]) circle(diameter);
            translate([diameter/2,diameter-(diameter*sqrt(3))/2]) circle(diameter);
            translate([-diameter/2,diameter-(diameter*sqrt(3))/2]) circle(diameter);
        }
        translate([-diameter/2,0]) square([diameter/2,diameter]);
    }
}

module grid(diameter=40, x_num=2, y_num=2) {
    spacing = diameter+diameter/4;
    for (x = [0 : spacing : spacing*(x_num-1)]) {
        for (y = [0 : spacing : spacing*(y_num-1)]) {
            translate([x,y,0]) rotate_method(diameter);
        }
    }
}

grid(diameter, gridx_num, gridy_num);
PLATE_THICKNESS = 2.0;
LID_THICKNESS = 1.2;
WALL_THICKNESS = 1.2;
BOX_HEIGHT = 50;
USE_MOUNTHOLE_MODULE = 3;

$fn=0;
$fa=0.5;
$fs=0.5;

module dose() {
    difference() {
        union(){
            linear_extrude(BOX_HEIGHT-(LID_THICKNESS/2.0)){
                intersection() {
                    circle(d=58);
                    square([50,50], center=true);
                }
            }
        }
        union(){
            translate([0,0,-.1])
            linear_extrude(BOX_HEIGHT+0.2){
                intersection() {
                    circle(d=58-(2*WALL_THICKNESS));
                    square([50-(2*WALL_THICKNESS), 50-(2*WALL_THICKNESS)], center=true);
                }
            }
        }
    }
}

module mount_hole1() {
    rotate([0,0,-15]) {
        translate([0,0,1]) {
            union() {
                rotate_extrude(angle=30){
                    translate([30,0,0]) {
                        square([3,2], center=true);
                    }
                }
                translate([30,0,-1]) {
                    cylinder(d=3,h=2);
                }

                rotate([0,0,30]) {
                    translate([30,0,-1]) {
                        cylinder(d=6,h=2);
                    }
                }
            }
        }
    }
}

module mount_hole2() {
    translate([30,0,-0.1]) {
        linear_extrude(PLATE_THICKNESS+0.2) {
            import("up_gehaeuse_mounting_hole.dxf");
        }
    }
}

module mount_hole3() {
    linear_extrude(PLATE_THICKNESS+0.2) {
        rotate([0,0,-15]) {
            intersection(){
                difference() {
                    circle(r=31.5);
                    circle(r=28.5);
                }
                polygon([[0,0],[40,0],[40,20],[0,0]]);
            }
            translate([30,0,0]) {
                circle(d=3);
            }
            rotate([0,0,30]) {
                translate([30,0,0]) {
                    circle(d=6);
                }
            }
        }
    }
}

module mount_holes() {
    for (i=[0:90:360]) {
        rotate([0,0,i]) {
            if (USE_MOUNTHOLE_MODULE == 1) {
                mount_hole1();
            }
            if (USE_MOUNTHOLE_MODULE == 2) {
                mount_hole2();
            }
            if (USE_MOUNTHOLE_MODULE == 3) {
                mount_hole3();
            }
        }
    }
}

module plate() {
    linear_extrude(PLATE_THICKNESS){
        difference(){
            intersection(){
                square([70.5,70.5], center=true);
                circle(d=90);
            }
            intersection(){
                circle(d=58);
                square([50,50], center=true);
            }
        }
    }
}


module deckel(){
    linear_extrude(LID_THICKNESS / 2.0){
        intersection() {
            circle(d=58);
            square([50,50], center=true);
        }
    }
    linear_extrude(LID_THICKNESS){
        intersection() {
            circle(d=58-(2*WALL_THICKNESS));
            square([50-(2*WALL_THICKNESS),50-(2*WALL_THICKNESS)], center=true);
        }
    }
}

module dose_komplett() {
    difference(){
        plate();
        translate([0,0,-.1]) {
            mount_holes();
        }
    }
    dose();
}

dose_komplett();
translate([70,0,0]) {
    deckel();
}

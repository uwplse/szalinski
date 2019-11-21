stand_size = 200;
stud_size_x = 19;
stud_size_y = 38;

arm_thickness = 20;
palm_thickness = 8;
palm_height = 50;

smooth_radius = 2;

screw_hole_diameter = 4;

arm_length = sqrt(
    pow(stand_size/2-stud_size_x, 2) +
    pow(stand_size/2-stud_size_y, 2)
);
rot_angle = 
    asin((stand_size/2 - stud_size_y)/arm_length)
;

module studs() {
    module stud() {
        cube([stud_size_x, stud_size_y, 100], center=true);
    }
    stud_shift_x = stand_size/2-stud_size_x/2;
    stud_shift_y = stand_size/2-stud_size_y/2;
    translate([ stud_shift_x,  stud_shift_y, 0]) stud();
    translate([-stud_shift_x,  stud_shift_y, 0]) stud();
    translate([-stud_shift_x, -stud_shift_y, 0]) stud();
    translate([ stud_shift_x, -stud_shift_y, 0]) stud();
}
//color("Brown") studs();

module print_area() {
    color("Green", alpha=1.0)
        cube([200, 200, 1], center=true);
}
//print_area();

module smoother() {
    difference()
    {
        sphere(smooth_radius, $fn = 60);
        union() 
        {
            translate([0, 0, -smooth_radius])
            cube(2 * smooth_radius, center=true);
            translate([0, -smooth_radius, 0])
            cube(2 * smooth_radius, center=true);
        }
    }
}

module octa_smoother() {
    difference() {
        smoother();
        translate([smooth_radius, 0, 0])
        cube(2 * smooth_radius, center=true);
    }
}

module arm() {
    module screw_hole() {
        cylinder(palm_thickness * 4, d = screw_hole_diameter, $fn = 30);
    }
    
    rotate([0, 0, rot_angle])
    translate([0, -arm_thickness / 2, 0])
    {

        minkowski(){
            cube([arm_length, arm_thickness, arm_thickness]);
            rotate([0, 0, 90])
            smoother();
        }
        
        color("Red")
        translate([arm_length, arm_thickness / 2, 0 ])
        rotate([0, 0, 90 - rot_angle])
        difference() 
        {
            minkowski() {
                cube([stud_size_y, palm_thickness, palm_height]);
                octa_smoother();
            }
         
            union() {
                translate([3 * stud_size_y / 4 - screw_hole_diameter, palm_thickness * 2, palm_height / 4 ])
                rotate([90, 0, 0])
                screw_hole();
                
                translate([3 * stud_size_y / 4, palm_thickness * 2, 3 * palm_height / 4])
                rotate([90, 0, 0])
                screw_hole();
            }
        }
            
        color("Blue")
        translate([arm_length, arm_thickness / 2, 0 ])
        rotate([0, 0, -rot_angle - 90])
        difference()
        {
            minkowski() {
                cube([palm_thickness, stud_size_x, palm_height]);
                rotate([0, 0, 180])
                octa_smoother();
            }
            
            union() {
                translate([-palm_thickness*2, 3 * stud_size_x / 4, palm_height / 4])
                rotate([0, 90, 0])
                screw_hole();
                
                translate([-palm_thickness*2, 3 * stud_size_x / 4 - screw_hole_diameter, 3 * palm_height / 4])
                rotate([0, 90, 0])
                screw_hole();
            }
        }
        
        color("Orange")
        translate([
            arm_length - sin(rot_angle) * palm_thickness, 
            arm_thickness / 2 - cos(rot_angle) * palm_thickness, 
            0
        ])
        rotate([0, 0, 90 - rot_angle])
        minkowski() {
            cube([palm_thickness, palm_thickness, palm_height]);
            smoother();
        }
    }
}

arm();
mirror([1, 0, 0]) arm();

mirror([0, 1, 0]) {
    arm();
    mirror([1, 0, 0]) arm();
}













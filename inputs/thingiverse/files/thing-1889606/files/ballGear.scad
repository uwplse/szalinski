ball_diameter_in_mm = 4; //[1:20]
space_between_in_mm = 2; //[1:20]
ball_count = 10; //[5:100]
ball_resolution_in_percent = 50; //[40:100]
gear_thickness_in_mm = 4; // [1:100]
motor_stick_thickness_in_mm = 6; //[1:100]
motor_stick_planar_thickness_in_mm = 1; //[0:100]
placeholder_thickness_in_mm = 1; //[0:10]
placeholder_overhang_in_mm = 1; //[0:10]


function pi()=3.14159265358979323846;

radius = (((ball_count * ball_diameter_in_mm + ball_count * space_between_in_mm) / 2) / pi());

winkel = 360 / ball_count;

difference() {
    difference() {
        union() {
            linear_extrude(height=gear_thickness_in_mm, center = false, slices = ball_resolution_in_percent) {
                circle(radius+ball_diameter_in_mm/4, $fn=360);
            }
            translate([0,0,-placeholder_thickness_in_mm])
    linear_extrude(height=placeholder_thickness_in_mm,center=false)
        circle(radius + ball_diameter_in_mm/4 + placeholder_overhang_in_mm, $fn=ball_resolution_in_percent);
            translate([0,0,gear_thickness_in_mm])
    linear_extrude(height=placeholder_thickness_in_mm,center=false)
        circle(radius + ball_diameter_in_mm/4 + placeholder_overhang_in_mm, $fn=ball_resolution_in_percent);
        }
        union() {
            for(i = [0:winkel:360]) {
                x = cos(i) * radius;
                y = sin(i) * radius;
                if(gear_thickness_in_mm <= ball_diameter_in_mm) {
                    translate([x,y,(ball_diameter_in_mm/2)])
                    sphere($fn=ball_resolution_in_percent, r=ball_diameter_in_mm/2);
                    
                }else {
                    translate([x,y,(ball_diameter_in_mm/2) + ((gear_thickness_in_mm - ball_diameter_in_mm) / 2)])
                    sphere($fn=ball_resolution_in_percent, r=ball_diameter_in_mm/2);
                }
            }
        }
    }
    diff_thick = motor_stick_thickness_in_mm/2 - motor_stick_planar_thickness_in_mm;
    difference() {
        linear_extrude(height=gear_thickness_in_mm*3.5+placeholder_thickness_in_mm*2, center = true, slices = 100) {
            circle(d=motor_stick_thickness_in_mm, $fn=ball_resolution_in_percent);
        }
        linear_extrude(height=gear_thickness_in_mm*3.5+placeholder_thickness_in_mm*2, center = true, slices = 100) {
            polygon(points= [[diff_thick,motor_stick_thickness_in_mm/2],[diff_thick,-motor_stick_thickness_in_mm/2],[motor_stick_thickness_in_mm,-motor_stick_thickness_in_mm/2],[motor_stick_thickness_in_mm,motor_stick_thickness_in_mm/2]]);
        }
    }
}

back();
seat();
legs();
/* [Hidden] */

/* [Chair Back] */
//Chair Back Height (mm)
chair_back_height = 30;
//Chair Back Top Thickness (mm)
chair_back_top_thickness = 3;
//Chair Back Bottom Thickness (mm)
chair_back_bottom_thickness = 2;
//Chair Back Bottom Width (mm)
chair_back_bottom_width = 35;
//Hand Hold Width (mm)
chair_back_handhold_width = 6;
//Hand Hold Height (mm)
chair_back_handhold_height = 1;
//Chair Angel
chair_back_angle = 10;

/* [Chair Seat] */
//Chair Seat Thickness (mm)
chair_seat_thickness = 3;
//Chair Seat Depth (mm)
chair_seat_depth = 40;
//Chair Seat Front Width (mm)
chair_seat_front_width = 50;


/* [Chair Legs] */
//Leg Height (mm)
leg_height = 40;
//Leg Edge Offset
leg_edge_offset = 3;
//Leg Top Thickness (mm)
leg_top_thickness = 2.5;
//Leg Middle Thickness (mm)
leg_middle_thickness = 2.5;
//Leg Bottom Thickness (mm)
leg_bottom_thickness = 1.5;
module legs() {
    translate([chair_back_bottom_width/2-leg_edge_offset,leg_edge_offset,0]) {
        leg();
    }

    translate([-chair_back_bottom_width/2+leg_edge_offset,leg_edge_offset,0]) {
        leg();
    }

    translate([chair_seat_front_width/2-leg_edge_offset,chair_seat_depth-leg_edge_offset,0]) {
        leg();
    }

    translate([-chair_seat_front_width/2+leg_edge_offset,chair_seat_depth-leg_edge_offset,0]) {
        leg();
    }
}
module back() {

    rotate([chair_back_angle,0,0]) {
    translate([0,0,chair_back_height]) {
    rotate([90,0,0]) {
    difference() {
        hull() {
            scale([1.5,1,1]){
                intersection() {
                    rotate_extrude(convexity=10, $fn=50) {
                        translate([20,0,0]) {
                            circle(chair_back_top_thickness, $fn=50);
                        }
                    }
                    translate([0,40,0]){
                        rotate([0,0,30]){
                            linear_extrude(height=40, center=true) {
                                circle(50, $fn=3);
                            }
                        }
                    }
                }
            }

            translate([0,-chair_back_height,0]){
                rotate([0,90,0]){
                    linear_extrude(height=chair_back_bottom_width, center=true) {
                        circle(chair_back_bottom_thickness, $fn=50);
                    }
                }
            }
        }

        //hand hold
        hull() {
            translate([0,12,-10]){
                hull(){
                    translate([chair_back_handhold_width,0,0]){
                        sphere(chair_back_handhold_height, $fn=50);
                    }
                    translate([-chair_back_handhold_width,0,0]){
                        sphere(chair_back_handhold_height, $fn=50);
                    }
                }
            }

            translate([0,12,10]){
                hull(){
                    translate([3,0,0]){
                        sphere(3, $fn=50);
                    }
                    translate([-3,0,0]){
                        sphere(3, $fn=50);
                    }
                }
            }
        }
    }
    }
    }
    }
}
module leg() {
    hull() {
        cylinder(1, leg_top_thickness, leg_top_thickness, false);
        translate([0,0,-leg_height/2]) {
            sphere(leg_middle_thickness, $fn=50 );
        }
        translate([0,0,-leg_height]) {
            cylinder(1, leg_bottom_thickness, leg_bottom_thickness, false);
        }
    }
}
module seat() {
    hull() {
        translate([chair_back_bottom_width/2 - (chair_seat_thickness/2),0,0]){
            sphere(chair_seat_thickness, false, $fn=50);
        }
        translate([-chair_back_bottom_width/2 + (chair_seat_thickness/2),0,0]){
            sphere(chair_seat_thickness, false, $fn=50);
        }

        translate([chair_seat_front_width/2,chair_seat_depth,0]){
            sphere(chair_seat_thickness, false, $fn=50);
        }
        translate([-chair_seat_front_width/2,chair_seat_depth,0]){
            sphere(chair_seat_thickness, false, $fn=50);
        }
    }
}

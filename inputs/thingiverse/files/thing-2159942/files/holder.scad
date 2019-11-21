//Hole diameter
vertical_hole_diameter = 3.2;
//Distance between the hole center and the ground plate
ground_hole_distance = 35.5;
//Vertical width
vertical_width = 12;
//Width of the holder
object_width = 3;
//Distance between printer-frame-front and the mounting holes
frame_hole_distance = 10;
//Diameter of ground mounting hole
ground_hole_diameter = 3.2;
// Count of holes for ground mounting
ground_mounting_hole_count = 2;
//Distance between mounting
ground_mounting_hole_distance = 30;

module create_vertical_wall() {
    translate([0, -(object_width / 2)])
    difference() {
        translate([0, 0, (ground_hole_distance + vertical_width / 2) / 2]) {
            cube([vertical_width, object_width, ground_hole_distance + vertical_width / 2], center = true);
        }
        translate([0, 0, ground_hole_distance]) {
            rotate([90, 0, 0])
            scale([1/100, 1/100, 1/100])
            cylinder(d = vertical_hole_diameter * 100, h = object_width * 102, center = true);
        }
    }
}

module create_ground_plate() {
    
    if(ground_mounting_hole_count==1) {
        difference() {
            translate([0, -(frame_hole_distance + vertical_width / 2) / 2, object_width / 2]) {
                cube([vertical_width, frame_hole_distance + vertical_width / 2, object_width], center = true);
            }
            translate([0, -frame_hole_distance, object_width / 2]) {
                scale([1/100, 1/100, 1/100])
                cylinder(d = ground_hole_diameter * 100, h = object_width * 102,center = true);
            }
        }   
    } else {
        difference() {
            translate([0, -(frame_hole_distance + vertical_width / 2) / 2, object_width / 2]) {
                    cube([vertical_width + ground_mounting_hole_distance * (ground_mounting_hole_count - 1), frame_hole_distance + vertical_width / 2, object_width], center = true); 
                }
            if(ground_mounting_hole_count % 2 == 0) {

                    for(i = [0:(ground_mounting_hole_count / 2)]) {
                        translate([-((ground_mounting_hole_distance / 2) + ground_mounting_hole_distance * i) , -frame_hole_distance, object_width / 2]) {
                            scale([1/100, 1/100, 1/100])
                            cylinder(d = ground_hole_diameter * 100, h = object_width * 102,center = true);
                        }
                        translate([((ground_mounting_hole_distance / 2) + ground_mounting_hole_distance * i), -frame_hole_distance, object_width / 2]) {
                            scale([1/100, 1/100, 1/100])
                            cylinder(d = ground_hole_diameter * 100, h = object_width * 102,center = true);
                        }
                    }
                //}
            } else {
                    translate([0, -frame_hole_distance, object_width / 2]) {
                        scale([1/100, 1/100, 1/100])
                        cylinder(d = ground_hole_diameter * 100, h = object_width * 102,center = true);
                    }
                    for(i = [1:((ground_mounting_hole_count-1) / 2)]) {
                        translate([-ground_mounting_hole_distance * i, -frame_hole_distance, object_width / 2]) {
                            scale([1/100, 1/100, 1/100])
                            cylinder(d = ground_hole_diameter * 100, h = object_width * 102,center = true);
                        }
                        translate([ground_mounting_hole_distance * i, -frame_hole_distance, object_width / 2]) {
                            scale([1/100, 1/100, 1/100])
                            cylinder(d = ground_hole_diameter * 100, h = object_width * 102,center = true);
                        }
                    }
            
            
            
    //    }*/
           }
       }
    }
}

create_vertical_wall();
create_ground_plate();
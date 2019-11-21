$fn=50;

//syringe
syringe_front_radius= 14.8;
syringe_front_length = 6.3;

syringe_rear_length = 5.4;
syringe_rear_radius = 14.4;

//from middle part
syringe_middle_length = 105;
syringe_middle_radius = 11.5;

shaft_length = 10;
shaft_radius = 2.1;


nut_lenght = 6.2;
nut_side_to_side = 13;

berring_radius = 7.5;
spacing = 2;

rod_distance = berring_radius+spacing+syringe_rear_radius;
extruder_middle_radius = syringe_rear_radius + berring_radius*2 + spacing*6/2;
extruder_middle_length = syringe_rear_length+ spacing*4;

//axis shaft
threaded_rod_radius = 4.4;
syringe_nozzle_length = 20;
syringe_nozzle_radius = 2.5;

//motor ho
motor_holder_length = 5;
//motor
motor_s_radius = 11.5;
motor_s_length = 2;
motor_shaft_radius = 2.6;
motor_screw_radius = 1.5;
from_motor_center_to_screw = 15;

add_a_little_space = 0.3;

//where to press on syringe
syringe_piston_top_radius = 12.7/2+ add_a_little_space;
syringe_piston_top_length = 1.6 +add_a_little_space;

syringe_piston_rod_length = 100; //no need to be exact
syringe_piston_rod_radius = 4.1/2+add_a_little_space;

module circle_extrude(length, radius){
    linear_extrude(length){
        circle(r = radius);
    }
}
module front_part(){
    //Front part
    difference(){
        linear_extrude(extruder_middle_length){
            circle(r = extruder_middle_radius);
        }
        // shaft1
        translate([-rod_distance,0,0]){
            circle_extrude(shaft_length,shaft_radius);
        }

        // shaft2
        translate([rod_distance,0,0]){
            circle_extrude(shaft_length,shaft_radius);
        }
           
        //syringe_front
        translate([0,-(syringe_front_radius+spacing+threaded_rod_radius), (shaft_length-syringe_front_length)/2]){
            circle_extrude(syringe_front_length, syringe_front_radius);
            translate([-syringe_front_radius,-syringe_front_radius*15,0]){
                cube([syringe_front_radius*2,syringe_front_radius*15,syringe_front_length]);
            }
            rotate([180,0,0]){
                //nozzle
                translate([0,0,-0.1]){
                circle_extrude(syringe_nozzle_length+0.2, syringe_nozzle_radius);    
                
                //cuts to insert nozzle
                translate([-syringe_nozzle_radius,0,0]){
                    cube([syringe_nozzle_radius*2,syringe_nozzle_radius*15,syringe_nozzle_length]);
                }
                }
            }
            //syringe body
            circle_extrude(syringe_middle_length, syringe_middle_radius);  
            translate([-syringe_middle_radius,-syringe_middle_radius*15,0]){  
                cube([syringe_middle_radius*2,syringe_middle_radius*15,syringe_middle_length]);
            }
        }
        
        //threaded_rod
        circle_extrude(shaft_length, threaded_rod_radius);
        
        //cut in bottom
         translate([-extruder_middle_radius,berring_radius+spacing,0]){
                cube([extruder_middle_radius*2,extruder_middle_radius*2,extruder_middle_length]);
            }
    }
}

module moror_part()
{
    //motor coupling part
    translate([0,0,200]){
        difference(){
            linear_extrude(motor_holder_length){
                circle(r = extruder_middle_radius);
            }    
            // shaft1
            translate([-rod_distance,0,0]){
                circle_extrude(shaft_length,shaft_radius);
            }

            // shaft2
            translate([rod_distance,0,0]){
                circle_extrude(shaft_length,shaft_radius);
            }
            //motor 
            circle_extrude(motor_s_length, motor_s_radius);
            circle_extrude(shaft_length, motor_shaft_radius);
            
            //motor holder
            translate([from_motor_center_to_screw, from_motor_center_to_screw, 0]){
                circle_extrude(shaft_length, motor_screw_radius);
            }
            translate([-from_motor_center_to_screw,from_motor_center_to_screw,0]){
                circle_extrude(shaft_length, motor_screw_radius);
            }
            translate([-from_motor_center_to_screw,-from_motor_center_to_screw,0]){
                circle_extrude(shaft_length, motor_screw_radius);
            }
             translate([from_motor_center_to_screw,-from_motor_center_to_screw,0]){
                circle_extrude(shaft_length, motor_screw_radius);
            }        
            
            //cut in bottom
            translate([-extruder_middle_radius,from_motor_center_to_screw+motor_screw_radius+spacing,0]){
                cube([extruder_middle_radius*2,extruder_middle_radius*2,extruder_middle_length]);
            }
        }
    }
}


module syringe()
{
    //front
    circle_extrude(syringe_front_length, syringe_front_radius);
    //middle
    circle_extrude(syringe_middle_length, syringe_middle_radius);
    //rear
    translate([0,0,syringe_middle_length-syringe_rear_length]){
        circle_extrude(syringe_rear_length, syringe_rear_radius);
    }        
}
module extruder_middle(){
    
    //part itself
    difference(){
        linear_extrude(extruder_middle_length){
            circle(r = extruder_middle_radius);
        }
        
        // shaft1
        translate([-rod_distance, 0, 0]){
            circle_extrude(extruder_middle_length,shaft_radius + add_a_little_space);
        }

        // shaft2
        translate([rod_distance, 0, 0]){
            circle_extrude(extruder_middle_length, shaft_radius + add_a_little_space);
        }
        
       //hex cut
        rotate([0,0,90]){
            translate([-1,0,(extruder_middle_length-nut_lenght)/2]){
                linear_extrude(nut_lenght){
                    circle(d=15, $fn=6);             
                }
                translate([nut_side_to_side/4,-nut_side_to_side/2, 0]){
                    cube([25,nut_side_to_side,nut_lenght]);
                }
            }
             //threaded_rod
        circle_extrude(extruder_middle_length, threaded_rod_radius);
        }
        
        //cut for piston
        translate([0,-extruder_middle_radius/2,extruder_middle_length/2]){
            syringe_piston();
        }
        
         //cut in bottom
            translate([-extruder_middle_radius,from_motor_center_to_screw+motor_screw_radius+spacing,0]){
                cube([extruder_middle_radius*2,extruder_middle_radius*2,extruder_middle_length]);
            }
    }
    
}
module syringe_piston(){
    linear_extrude(syringe_piston_top_length, syringe_piston_top_radius);    
    linear_extrude(syringe_piston_rod_length, syringe_piston_rod_radius);
    
    //cuts to insert syringe rod
    translate([-syringe_piston_top_radius,-syringe_piston_top_radius*5,0]){
        cube([syringe_piston_top_radius*2,syringe_piston_top_radius*5,syringe_piston_top_length]);
    }
    
    translate([-syringe_piston_rod_radius,-syringe_piston_rod_radius*15,0]){
        cube([syringe_piston_rod_radius*2,syringe_piston_rod_radius*15,syringe_piston_rod_length]);
    }
}

//front_part();
//moror_part();
translate([0,-(syringe_front_radius+spacing+threaded_rod_radius), (shaft_length-syringe_front_length)/2]){
//    syringe();    
}
translate([0,0, syringe_middle_length]){
    extruder_middle();
}




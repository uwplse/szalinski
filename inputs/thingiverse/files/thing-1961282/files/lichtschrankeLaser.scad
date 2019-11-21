/* [Laser Diode] */
laser_light_hole_diameter = 2.5; //[0:5]

laser_diameter = 6; //[1:20]

laser_length = 9; // [5:25]

/* [General] */
module_height = 20; 

resolution = 50; //[10:100]

/* [Receiver Diode] */
receiver_diameter = 5.5; //[1:20]

reciever_depth_in_module = 3; //[1:10]

/* [Mirrors] */
module_thickness = 5; //[5:20]

/* [Mounting] */
activate_mounting = true; //[true,false]

mounting_distance = 20; //[5:30]

mounting_screw_diameter = 5; //[2:35]

mounting_thickness = 2; //[2:20]

laser_module_on_top = true; //[false,true]

mirror_module_on_top = false; //[false,true]

/*[Creation Selection] */
create = 0; //[0:both, 1:laser, 2:mirror]

/* [Hidden]*/
distance_length = mounting_distance + mounting_screw_diameter * 3;

module mounting(x,y,z) {
translate([x,y,z])
    difference() {
                translate([(distance_length)/2 + (laser_diameter+4)/2,0,0])
                    linear_extrude(mounting_thickness)
                        square([distance_length, mounting_screw_diameter + 4], true);
                translate([mounting_distance + mounting_screw_diameter/2,0,-1])
                    linear_extrude(mounting_thickness*2)
                        circle(d=mounting_screw_diameter, true, $fn=resolution);
                translate([mounting_distance + mounting_screw_diameter*2.5,0,-1])
                    linear_extrude(mounting_thickness*2)
                        circle(d=mounting_screw_diameter, true, $fn=resolution);
            }
}

module laser_module() {
    union(){
        difference() {
            linear_extrude(laser_length + 3)
                square([laser_diameter + 4,module_height,],true);
            
            translate([0,module_height/2 -4,0]) {
                translate([0,0,laser_length - 1])
                    linear_extrude(laser_length)
                        circle(d=laser_light_hole_diameter, $fn=resolution);
                translate([0,0,-1])
                    linear_extrude(laser_length + 1)
                        circle(d=laser_diameter, $fn=resolution);
            }
            
            translate([0,-module_height/2 + 4,0]) {
                translate([0,0,reciever_depth_in_module - 1])
                    linear_extrude(laser_length +4)
                        circle(d=laser_light_hole_diameter, $fn=resolution);
                translate([0,0,-1])
                    linear_extrude(reciever_depth_in_module)
                        circle(d=receiver_diameter, $fn=resolution);
            }
        }
        if(activate_mounting) {
            if(laser_module_on_top) {
                mounting(0,0,laser_length+3-mounting_thickness);
            }else {
                mounting(0,0,0);
            }
                
        }
    }
}
module mirror_module() {
    translate([-laser_diameter -8,0,0])
    rotate([0,0,180])
    union(){
            difference() {
                linear_extrude(module_thickness)
                    square([laser_diameter + 4,module_height,],true);
                
                translate([(laser_diameter + 4)*0.75*0.5,0,0])
                    rotate([0,-90,0])
                        linear_extrude((laser_diameter + 4)*0.75)
                            polygon([[-1,-module_height/2 + 1],[0,-module_height/2 + 1],[module_thickness-1,-tan(45)*(module_thickness-1)],[module_thickness-1,tan(45)*(module_thickness-1)],[0,module_height/2 - 1],[-1,module_height/2 - 1],]);
            }
            if(activate_mounting) {
                if(mirror_module_on_top){
                    mounting(0,0,module_thickness - mounting_thickness);
                }else{
                    mounting(0,0,0);
                }
            }
    }
}

if(create == 1) {
    laser_module();
}else if(create == 2) {
    mirror_module();
}else{
    laser_module();
    mirror_module();
}
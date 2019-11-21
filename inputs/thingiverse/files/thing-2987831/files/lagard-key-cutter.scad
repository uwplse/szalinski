
lagard_key_radius = 4.42;
lagard_long_pie_cut_angle = 45;
lagard__inner_radius = 2.87;
lagard__inner_depth =  20;
lagard_cutting_tool_radius = 1.15;
lagard_key_length = 95;
lagard_guide_cut_angle = 250; //this angle may not be correct
lagard_guide_cut_depth = 1.53;
lagard_degree_per_cut_number = 5; //fixme I dont know what this is, not enough keys to measure
lagard_key_cut_offsets = [5.1,8.81,12.6,16.18];
cut_offset_angle = 10;


/* if all the measurements and offsets are correct, this should be where you enter the
actual key cut numbers*/
lagard_key_cuts = [15,6,2,10]; //how my ebay keys were shipped

 module lagard_key_blank(h) {
  $fn=64;
     union(){
         translate([0,0,lagard_key_length-18])
            cylinder(18,lagard_key_radius+2, lagard_key_radius+2);         
         translate([0,0,lagard_key_length])
            rotate([90,0,90])
                cylinder(3,18, 18,center=true);
         rotate(lagard_long_pie_cut_angle/2){
             difference(){
                union(){
                    difference(){
                   
                        union(){    
                            translate([0,0,-1.5])
                                cylinder(1.5,lagard_key_radius-1, lagard_key_radius); 

                            cylinder(h,lagard_key_radius, lagard_key_radius);
                        }
                        translate([0,0,-1.6])
                            linear_extrude(height = h){     
                                intersection() {
                                    circle(r=lagard_key_radius+1);
                                    square(lagard_key_radius+1);
                                    rotate(lagard_long_pie_cut_angle) square(lagard_key_radius+1);
                                }
                            }
                    }
                    translate([0,0,-1.6])
                        cylinder(h+1.6,lagard__inner_radius, lagard__inner_radius); 
            
                }
                
                translate([0,0,-1.6])
                    cylinder(lagard__inner_depth+.2,lagard__inner_radius, lagard__inner_radius); 
            }
        }
    }
}



module lagard_radial_key_cut(offset, depth, angle){
    $fn=32;
    translate([0,0,offset])
        union(){
            for (a =[cut_offset_angle:1:angle+cut_offset_angle]){
               rotate([90,0,a])
                    translate([0,0,-(lagard_key_radius - (depth/2))])
                        cylinder(depth,lagard_cutting_tool_radius, lagard_cutting_tool_radius,center=true);
                    
            }
        }
}


difference(){
    lagard_key_blank(h=lagard_key_length);
    for(route = [19.8+lagard_cutting_tool_radius:lagard_cutting_tool_radius/2:27.27-lagard_cutting_tool_radius])
        lagard_radial_key_cut(route,lagard_guide_cut_depth,lagard_guide_cut_angle);
    for(pin = [0:1:3])
        lagard_radial_key_cut(lagard_key_cut_offsets[pin]+lagard_cutting_tool_radius,3,lagard_key_cuts[pin] * lagard_degree_per_cut_number);
}
height = 8;
width = 40;
bearing_outer_diameter = 22;
bearing_height = 7; 
flange_inner_diameter = 18;
bolt_center_distance_from_edge = 5;
bolt_diameter = 3;
nut_diameter = 5.5;
nut_height = 2.5;
translate([0,0,height/2]){
    union(){
        difference(){
            cube([width, width, height], center = true);
            cylinder(r = bearing_outer_diameter/2, h = height*1.1, center = true, $fn=60);
            translate([width/2-bolt_center_distance_from_edge, width/2-bolt_center_distance_from_edge, 0]){
                cylinder(r = bolt_diameter/2, h = height*1.1, center = true, $fn=60);
                translate([0,0,height-nut_height]){
                      cylinder(r = nut_diameter/2, h = height, center = true, $fn=6);  
                }
            }
            translate([width/2-bolt_center_distance_from_edge, -width/2+bolt_center_distance_from_edge, 0]){
                cylinder(r = bolt_diameter/2, h = height*1.1, center = true, $fn=60);
                translate([0,0,height-nut_height]){
                      cylinder(r = nut_diameter/2, h = height, center = true, $fn=6);  
                }
            }
            translate([-width/2+bolt_center_distance_from_edge, width/2-bolt_center_distance_from_edge, 0]){
                cylinder(r = bolt_diameter/2, h = height*1.1, center = true, $fn=60);
                translate([0,0,height-nut_height]){
                      cylinder(r = nut_diameter/2, h = height, center = true, $fn=6);  
                }
            }
            translate([-width/2+bolt_center_distance_from_edge, -width/2+bolt_center_distance_from_edge, 0]){
                cylinder(r = bolt_diameter/2, h = height*1.1, center = true, $fn=60);
                translate([0,0,height-nut_height]){
                      cylinder(r = nut_diameter/2, h = height, center = true, $fn=6);  
                }
            }
            
        }
        translate([0,0,-(height/2-(height-bearing_height)/2)]){
            difference(){
                cylinder(r = bearing_outer_diameter/2, h = height-bearing_height, center = true, $fn=60);
                cylinder(r = flange_inner_diameter/2, h = (height-bearing_height)*1.1, center = true, $fn=60);
            }
        }
    }
}

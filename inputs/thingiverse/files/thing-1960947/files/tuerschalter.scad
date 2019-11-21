/* [Furniture Information] */
gap_between_doors = 20; //[5:100]

mounting_depth = 10; //[10:50]

gap_between_door_and_furniture = 5; //[1:10]

doorside_Z_axis_height = 10;
/* [Thing Details] */
resolution = 25; //[50:100]

screw_diameter = 3;

extrusion_thickness = 2;

/* [Hidden] */
posY = gap_between_doors/2*0.8;

union() {
    translate([-mounting_depth/2,0,-extrusion_thickness])
        difference() {
            linear_extrude(extrusion_thickness,true)
                square([mounting_depth,gap_between_doors*1.5],true); 
                translate([0,posY,-20])
                    linear_extrude(50, true)
                        circle(d=screw_diameter, $fn=resolution);
                translate([0,-posY,-20])
                    linear_extrude(50, true)
                        circle(d=screw_diameter, $fn=resolution);
                        
        }
    
    translate([0,0,-doorside_Z_axis_height/2])
        rotate([0,90,0])
            union() {
                difference() {
                    linear_extrude(extrusion_thickness,true)
                        square([doorside_Z_axis_height,gap_between_doors*1.5],true);
                    
                    translate([gap_between_doors*0.7/2-doorside_Z_axis_height*0.25,0,-20])
                        linear_extrude(50,true)
                            circle(d=gap_between_doors*0.7, true, $fn=resolution);
                }   
               translate([0,gap_between_doors/2*1.5-extrusion_thickness,0]) 
                    rotate([-90,0,0])    
                        linear_extrude(extrusion_thickness,true)
                            polygon(points=[[-doorside_Z_axis_height/2 + extrusion_thickness,0],[doorside_Z_axis_height/2,0],[-doorside_Z_axis_height/2 + extrusion_thickness,mounting_depth]]);
                
                translate([0,-gap_between_doors/2*1.5,0]) 
                    rotate([-90,0,0])    
                        linear_extrude(extrusion_thickness,true)
                            polygon(points=[[-doorside_Z_axis_height/2 + extrusion_thickness,0],[doorside_Z_axis_height/2,0],[-doorside_Z_axis_height/2 + extrusion_thickness,mounting_depth]]);
                
                translate([0,gap_between_doors/2+extrusion_thickness,extrusion_thickness])
                    rotate([90,0,0])
                        linear_extrude(extrusion_thickness,true)
                            polygon(points=[[-doorside_Z_axis_height/2,0],[doorside_Z_axis_height/2,0],[doorside_Z_axis_height/2*0.6,gap_between_door_and_furniture],[doorside_Z_axis_height/2*0.4,gap_between_door_and_furniture*0.98],[doorside_Z_axis_height/2*0.2,gap_between_door_and_furniture]]);
                
                
                translate([0,-gap_between_doors/2,extrusion_thickness])
                    rotate([90,0,0])
                        linear_extrude(extrusion_thickness,true)
                            polygon(points=[[-doorside_Z_axis_height/2,0],[doorside_Z_axis_height/2,0],[doorside_Z_axis_height/2*0.6,gap_between_door_and_furniture],[doorside_Z_axis_height/2*0.4,gap_between_door_and_furniture*0.98],[doorside_Z_axis_height/2*0.2,gap_between_door_and_furniture]]);
        
            }
 }
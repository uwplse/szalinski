
//   Variables user sets

// 3/4 inch EMT has an outside diameter = 23.65
pipe_diameter = 23.8;


// how thick the walls should be
support_thickness = 2.5;

// how wide the gap should be for tightening down on the pipe
gap_size = 2.0;

tab_height = 7.5; // the height of the tabs. 
screw_hole_size = 3.0; // diameter of the screw holes

x_and_y_direction_length = 35;

z_direction_length = 45;





// do not edit below this, unless you are changing the calculated shape

// calculated properties
outside_diameter = pipe_diameter+support_thickness*2;
tab_width_outside = support_thickness*2.5+gap_size;


//outside_shape_flat_2d();


difference(){
    
    draw3d_shape_all();
    
    hollow_tubes();
    
}


// plug hole in the z direction
cylinder($fn=60, d=pipe_diameter, h=support_thickness);



module hollow_tubes(){
    
    union() {
        
        //x pipe
        translate([0,0,support_thickness+pipe_diameter/2]) 
            rotate([90,0,90]) 
                cylinder($fn=60, d=pipe_diameter, h=300);
        
        // y pipe
        translate([0,0,support_thickness+pipe_diameter/2]) 
            rotate([0,-90,90]) 
                cylinder($fn=60, d=pipe_diameter, h=300);
        
        
        //z pipe
        translate([0,0,support_thickness]) 
            cylinder($fn=60, d=pipe_diameter, h=300);
            
    }
    
}


module draw3d_shape_all(){
    union(){
        // x direction 
        translate([0,0,outside_diameter/2]) 
            rotate([90,0,90])
                draw3d_shape_single_support(h=x_and_y_direction_length);

        // y direction
        translate([0,0,outside_diameter/2]) 
            rotate([90,0,0])
                draw3d_shape_single_support(h=x_and_y_direction_length);

        // z direction 
        rotate([0,0,-135])
        draw3d_shape_single_support_round(h=z_direction_length);
    }

}


module draw3d_shape_single_support(){
    difference(){
        linear_extrude(height = h, center = false, convexity = 0, twist = 0)
        difference() {
            outside_shape_flat_2d();
            inside_shape_2d();
            
        }
        translate([0,outside_diameter/2+tab_height/2,h-screw_hole_size-gap_size])
        rotate([0,90,0]){
            cylinder($fn=60, d=screw_hole_size,h=h, center=true);
        }
    }
}


module draw3d_shape_single_support_round(h=30){
    difference(){
        linear_extrude(height = h, center = false, convexity = 0, twist = 0)
        difference() {
            outside_shape_round_2d();
            inside_shape_2d();
        }
        translate([0,outside_diameter/2+tab_height/2,h-screw_hole_size-gap_size])
        rotate([0,90,0]){
            cylinder($fn=60, d=screw_hole_size,h=h, center=true);
        }
    }
}

module outside_shape_flat_2d(){
    union(){
        // outer circle (pipe diameter + support)
        circle($fn=60, d=outside_diameter);
        // base 
        translate([-outside_diameter/2,-outside_diameter/2,0]) square([outside_diameter,outside_diameter/2]);
        
        // support tab
        //translate([-tab_width_outside/2,outside_diameter/2-0.75, 0]) square([support_thickness*2.5+gap_size,  screw_hole_size*2.5]);
        translate([-tab_width_outside/2,outside_diameter/2-0.75, 0]) square([support_thickness*2.5+gap_size,  tab_height]);
    }
    
}

module outside_shape_round_2d(){
    union(){
        // outer circle (pipe diameter + support)
        circle($fn=60, d=outside_diameter);
        // support tab
//        translate([-tab_width_outside/2,outside_diameter/2-0.75, 0]) square([support_thickness*2.5+gap_size,  screw_hole_size*2.5]);
        translate([-tab_width_outside/2,outside_diameter/2-0.75, 0]) square([support_thickness*2.5+gap_size,  tab_height]);
    }
}


module inside_shape_2d(){
    
    union(){
        // pipe
        circle($fn=60, d=pipe_diameter);
        // tab
        translate([-gap_size/2,pipe_diameter/2-1, 0]) square([gap_size,tab_height*1.4]);

    }
    
}
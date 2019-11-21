
/*MAIN PARAMETERS*/
number_steps = 4;
step_z = 8; //height of each step (+fencing)
step_x = 100; //length of each step (+fencing)
step_y = 20; //depth of each step (+fencing)
    
/*FENCING RELATED PARAMS*/
add_front_fencing = 0; //[0:false,1:true]
add_left_fencing = 0; //[0:false,1:true]
add_right_fencing = 0; //[0:false,1:true] 
rounded_fencing = 1; //[0:false,1:true]
fence_thickness = 2;
fence_height = 2;

fence_radius = fence_thickness/2;

/*GUTTER RELATED PARAMS*/
add_gutter = 0 ; //[0:false,1:true]
gutter_radius = 2;
add_y_gutter = 0; //[0:false,1:true]
number_y_gutter = 5; 
gutter_gap =3;


if(add_gutter){ 
    difference() {
        stairs();
        
        for ( i = [0: number_steps]){ 
            
            translated_y = (i ) * step_y; 
            translate([gutter_gap, translated_y, 0]){ 
                spacerX();
            }
        }  
        if(add_y_gutter){ 
            spacing = step_x / number_y_gutter;
            height = number_steps * step_y;
        
            for ( i = [0: number_y_gutter]){ 
                
            translated_x = (i ) * spacing; 
                translate([translated_x, gutter_gap, 0]){ 
                     
                        spacerY(height);
                     
                }
            }
        }
    }
}else{
    stairs(); 
}
 
 
module stairs(){ 
    for ( i = [1: number_steps]){ 
     stairs_y = (i-1) * step_y;
     height = i * step_z;  
        translate([0, stairs_y, 0]){ 
            cube([step_x, step_y, height]); 
            
            total_height = fence_height+height ;
            
            if(add_front_fencing){
                front_fence(total_height);
            }
            if(add_left_fencing){
                side_fence(total_height);
            }
            if(add_right_fencing){
                translate([step_x-fence_thickness,0,0])
                side_fence(total_height);
            }
        }    
    }
}

/*FENCING RELATED*/
module front_fence(total_height){
    if(rounded_fencing){
         
        length_offset = 
        (add_left_fencing && add_right_fencing) ? fence_thickness 
        : (add_left_fencing || add_right_fencing) ? fence_radius
        : 0; 
        
        height_offset =total_height-fence_radius;
        left_offset = (add_left_fencing)? fence_radius :0;
        
        
        translate([left_offset,0,0]){
        //top round portion
        translate([0,fence_radius, height_offset])
        rotate([0,90,0])
        cylinder(d=fence_thickness,h= step_x-length_offset);
        //bottom fence 
        cube([step_x-length_offset,  fence_thickness, height_offset]); 
        }
        
        
    } else{
        cube([step_x,  fence_thickness, total_height]);
    }
}

module side_fence(total_height){
    if(rounded_fencing){ 
        height_offset =total_height-fence_radius;
        translate([fence_radius ,fence_radius, height_offset]){
            //top round portion
            rotate([-90,0,0])
            cylinder(d=fence_thickness,h= step_y-fence_radius);
            //corner sphere
            sphere(d=fence_thickness);
            
        }
        //bottom fence
        translate([0,fence_radius,0])
        cube([fence_thickness, step_y-fence_radius, height_offset]);
        //corner post
        translate([fence_radius,fence_radius,0])
        cylinder(d=fence_thickness, h=height_offset);
        
    }else {
       cube([fence_thickness, step_y, total_height]);
    }
    
}

/*GUTTER RELATED*/
module spacerX(){  
    rotate([0,90,0]){
        color("purple", 1.0){
        cylinder( step_x-2*gutter_gap, gutter_radius, gutter_radius);
        }
    } 
}

module spacerY(height){  
    rotate([-90,0,0]){
        color("purple", 1.0){
        cylinder( height-2*gutter_gap, gutter_radius, gutter_radius);
        }
    } 
}
 
   

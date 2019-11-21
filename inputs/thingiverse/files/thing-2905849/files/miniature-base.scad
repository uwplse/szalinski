
/*[global]*/
/*[base_diamensions]*/
//note: for square of 2cm, the diagonal is 2.83
top_diagonal_length = 3; 
bottom_diagonal_length = 3.5; 
height = 0.4; 
//sides of base. circle if sides <3 (or set to a BIG number)
sides =4; 

/* [center_slot] */
show_center_slot = 1;//[0:false,1:true]
//long end of the slot 
center_slot_length = 1.6;
//thickness of the slot
center_slot_breadth = 0.2;
//shift slot away from center
center_slot_y_offset = 0.1;
//rotate slot
center_slot_angle = 0;

/* [center_indentation]*/
show_center_indentation=1; //[0:false,1:true]
indentation_depth = 0.1;
indentation_offset_from_sides = 0.1; 

/*[multiple_quantities=*/
quantity_x = 3;
quantity_y = 3;
spacing_between_bases = 0.5;
 
for(i=[0: quantity_x-1]){
    
    for(j=[0: quantity_y-1]){ 
        offset_x = (bottom_diagonal_length+spacing_between_bases)*i;
        offset_y = (bottom_diagonal_length+spacing_between_bases)*j;
         
        translate([offset_x,offset_y,0])
        if(show_center_slot || show_center_indentation){
            difference(){
                base();
                indentation();
                center_slot();
            }
        }else{
            base();
        }
    }
}
 
module center_slot(){
    if(show_center_slot){ 
        rotate([0,0,center_slot_angle])
        translate([0,center_slot_y_offset, height/2])
        cube([center_slot_length, center_slot_breadth, height],center=true);
    }
}


module indentation(){
    
    if( show_center_indentation){
        translate([0,0,height-indentation_depth])
        linear_extrude(indentation_depth)
        offset(-indentation_offset_from_sides)
        if(sides<3){ 
            circle(  d =top_diagonal_length, $fn = 80 ); 
        }else{
            circle( d =top_diagonal_length, $fn=sides);
        } 
    }
}

module base(){ 
     
    if(sides<3){ 
        cylinder(d1=bottom_diagonal_length, d2=top_diagonal_length, h=height, $fn = 80 ); 
    }else{
        cylinder(d1=bottom_diagonal_length, d2=top_diagonal_length, h=height, $fn=sides);
    } 

}
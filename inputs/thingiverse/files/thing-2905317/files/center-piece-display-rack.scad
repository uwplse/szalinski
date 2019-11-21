
/*[global]*/
 
number_of_steps = 4; 
height_per_step =20;
//thickness/depth of each step (including fencing)
shelf_thickness = 24; 
top_diameter = 22;

//number of sides ( for circle set to <3)
number_of_sides = 4; 

/*[slice/partial model]*/
slice_model = 0; //[0: full, 1: half, 2: quarter]
angle_to_slice_model = 45;
//set to true to show the full top shelf
slice_offset = 0 ;  

/* [fencing] */
use_fencing =1; // [0:false, 1:true]
fence_thickness = 2;
fence_height = 2;

/*[star shape]*/
//create star shapes by rotating a secondary model
rotate_for_secondary_model =0;

if(slice_model == 1){
    
    diameter = number_of_steps * shelf_thickness+ top_diameter;  
    difference(){
        secondary_model();
         
        rotate(angle_to_slice_model){
            translate([ 0,slice_offset,0])
            cube([diameter, diameter, 
                height_per_step * number_of_steps+fence_height]);
         
            translate ([-diameter, slice_offset ,0])
            cube([diameter, diameter, 
                height_per_step * number_of_steps+fence_height]);
        } 
    }  
}else if (slice_model ==2){
    diameter = number_of_steps * shelf_thickness+ top_diameter;
     difference()
    {
        secondary_model();

        rotate(angle_to_slice_model){
            translate([ 0,slice_offset,0])
            cube([diameter, diameter, 
            height_per_step * number_of_steps+fence_height]);

            translate ([-diameter, slice_offset ,0])
            cube([diameter, diameter, 
            height_per_step * number_of_steps+fence_height]);
 
            translate ([ slice_offset,-diameter ,0])
            cube([diameter, diameter+slice_offset, 
            height_per_step * number_of_steps+fence_height]);
            }
       }
      
}else {
    secondary_model();
}

module secondary_model(){
    
    if(use_fencing){

        difference(){
            secondary_fencing(); 
            secondary_fencing_mask();
        }//difference
             
    } 
    
    model();
    rotate([0,0,rotate_for_secondary_model]) 
    model();  

}

module secondary_fencing(){
    fencing();
    rotate([0,0,rotate_for_secondary_model]) 
    fencing();
}


module secondary_fencing_mask(){
    fencing_mask();
    rotate([0,0,rotate_for_secondary_model]) 
    fencing_mask();
}

module model(){
    for(i=[1:number_of_steps]){
    current_step = i ;
    diameter_offset = (number_of_steps-current_step ) * 2 * shelf_thickness;
    diameter = diameter_offset + top_diameter;
         if(number_of_sides<3){
            cylinder(d=diameter, h  = current_step *height_per_step);
        }else {
            cylinder(d=diameter, h  = current_step *height_per_step, $fn=number_of_sides);
        } 
    }
}

module fencing_mask(){
    for(i=[1:number_of_steps]){
        current_step = i ;
        diameter_offset = (number_of_steps-current_step ) * 2 * shelf_thickness;
        diameter = diameter_offset + top_diameter;

        linear_extrude(height = current_step * height_per_step +fence_height)

        if(number_of_sides<3){ 
            offset(r=-fence_thickness)
            circle(d=diameter ); 
        }else{ 
            offset(r=-fence_thickness)
            circle(d=diameter, $fn = number_of_sides); 
        } 
    }//for each step
}

module fencing ( ){
     if(use_fencing){ 
            for(i=[1:number_of_steps]){
                current_step = i ;
                diameter_offset = (number_of_steps-current_step ) * 2 * shelf_thickness;
                diameter = diameter_offset + top_diameter;
                
            linear_extrude(height = current_step *height_per_step +fence_height)
            if(number_of_sides<3){
                difference(){
                circle(d=diameter );
                offset(r=-fence_thickness)
                circle(d=diameter );
                }
            }else{
                difference(){
                circle(d=diameter, $fn = number_of_sides);
                offset(r=-fence_thickness)
                circle(d=diameter, $fn = number_of_sides);
                }
            }
        }
    }
}
 

/*
Simple frame for airplant
*/


/*[global settings]*/
//diameter of holes.
hole_diameter = 3;
//thickness of each layer
thickness = 3;
//number of holes
number_holes = 5;

//bottom dimension (outer)
bottom_ring_outer_diameter = 40;
//bottom dimension (inner)
bottom_ring_inner_diameter = 20;

 

//middle dimension (outer)
middle_ring_outer_diameter = 60;
//middle dimension (inner)
middle_ring_inner_diameter = 50;


//top dimension (outer)
top_ring_outer_diameter = 15;
//top dimension (inner)
top_ring_inner_diameter = 5;

rings();
 
bottom_x = center_x(bottom_ring_inner_diameter,             bottom_ring_outer_diameter); 

middle_x = center_x(middle_ring_inner_diameter,             middle_ring_outer_diameter); 

top_x = center_x(top_ring_inner_diameter,             top_ring_outer_diameter); 

 
 
module holes(x_offset){
    
    translate([x_offset,0,0])
    cylinder(d=hole_diameter, h=thickness+1, center = true);
    
    rotate_degrees = 360.0 / number_holes;
    
    for(i = [1:number_holes-1]){
        r = rotate_degrees * i;
        
        rotate(r)
        translate([x_offset,0,0])
        cylinder(d=hole_diameter, h=thickness+1, center = true);
        
    } 
} 
 


function center_x (inner, outer) =   abs(outer+inner)/4;

module rings(){
// bottom 
    difference(){
        ring(bottom_ring_outer_diameter,     
            bottom_ring_inner_diameter);
         holes(bottom_x, 0);
    }

// middle 
    difference(){
        ring(middle_ring_outer_diameter,     
            middle_ring_inner_diameter);
         holes(middle_x, 0); 
    }
        

// top 
    difference(){
        ring(top_ring_outer_diameter,     
            top_ring_inner_diameter);
         holes(top_x, 0);
    }
} 
 

module ring(outer, inner){
    
    difference(){
        cylinder(d=outer,h=thickness, center = true);
        cylinder(d=inner,h=thickness, center = true);
    }
};


    
    
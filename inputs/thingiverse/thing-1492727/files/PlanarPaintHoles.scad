
//  Size of the holes in each container  
hole_size = 25; //  [1:100]

//  The thicknes of each wall around the hole
wall_thickness = 3; // [1,2,3,4,5,6,7,8,9,10]

//  How many containers on the x axis
containers_length = 2; // [1,2,3,4,5,6,7,8,9,10]

//  How many containers on the y axis
containers_width = 2; // [1,2,3,4,5,6,7,8,9,10]

//  Holes in walls
wall_holes_enabled = "yes"; // ["yes","no"]

//  Height multiplier
height_multiplier = 1; // [0.5,1,2]

for(x = [0:containers_length-1]){
    for(y = [0:containers_width-1]){
        
        translate([x*(hole_size+wall_thickness),y*(hole_size+wall_thickness),0]){
        
            difference() {
                //Outer walls
                cube([hole_size+(wall_thickness*2),hole_size+(wall_thickness*2),(hole_size+(wall_thickness*2))*height_multiplier],center=true);
                //Hole
                translate([0,0,wall_thickness]){
                    cube([hole_size, hole_size,(hole_size+wall_thickness)*height_multiplier],center=true);
                    
                }
                
                if(wall_holes_enabled == "yes"){
                    //Wall Holes Y
                    cube([hole_size-wall_thickness*2,.5+hole_size+wall_thickness*2,(hole_size*height_multiplier*.7)-.5],center=true);
                    
                    //Wall Holes X
                    cube([.5+hole_size+wall_thickness*2,hole_size-wall_thickness*2,(hole_size*height_multiplier*.7)-.5],center=true);
                }
            }
        } // end translate x and y
    } // end y loop
} // end x loop

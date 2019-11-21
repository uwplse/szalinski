 $fn=50;
 
// Length of project enclosure
LENGTH=30;  // min/max: [10:100]

//Width of prject enclosure
WIDTH=15;   // min/max: [10:100]

//Radiues of curved corners
RADIUS=1;   // min/max: [1:5]

//Offset to internal walls
OFFSET=1;   // min/max: [1:10]

//Parametric Version

difference() {
    minkowski(){
        cube([WIDTH,LENGTH,10], center = true);
        sphere(RADIUS);
    }

    // Chop off the top
    translate([0,0,5]) 
        cube([WIDTH + RADIUS*2 + OFFSET,
              LENGTH + RADIUS*2 + OFFSET,
              ,10], center = true);

    // Hollow inside
    minkowski(){
        cube([WIDTH - RADIUS - OFFSET,
              LENGTH - RADIUS - OFFSET
              ,8], center = true);
        sphere(RADIUS);
    }
    
    //Router the outside edge ( create the lip )
    
     translate([0,0,-1]){ 
         difference() {     
             linear_extrude(5){
                 minkowski(){
                    circle(1);
                    square([WIDTH + OFFSET,
                            LENGTH+OFFSET], 
                            center = true );
                 }   
            }
            linear_extrude(6)  {  
                minkowski(){
                    circle(1);
                    square([WIDTH - OFFSET,
                            LENGTH-OFFSET], 
                            center = true );
                }  
            } 
        }
    }
}


//non-Parametric Version
// Added for ease in understanding

translate([20,0,0]) {
    nonpara();
}

module nonpara(){
    difference() {
        minkowski(){
            cube([10,20,10], center = true);
            sphere(1);
        }

        // Chop off the top
        translate([0,0,5]) cube([13,23,10], center = true);

        // Hollow inside
        minkowski(){
            cube([8,18,8], center = true);
            sphere(1);
        }
        
         translate([0,0,-1]){ 
             difference() {     
                 linear_extrude(5){
                     minkowski(){
                        circle(1);
                        square([12,22], center = true );
                     }   
                }
                linear_extrude(6)  {  
                    minkowski(){
                        circle(1);
                        square([9,19], center = true );
                    }  
                } 
            }
        }
    }
}




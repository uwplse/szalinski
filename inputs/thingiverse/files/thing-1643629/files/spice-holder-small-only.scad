$fn=50;
tube_radius = 12;
inner_tube_radius = 6.32;
holder_height = 6;
middle_rod = 3.2;
middle_rod_bottom = 5.2;
module top(){
    linear_extrude(height = holder_height){
        difference(){    
            circle(r = inner_tube_radius*3.7);
           
            
            for (i=[1: 5]) {
                rotate([0,0,i*360/5]) {
                    translate([inner_tube_radius*2.3,0,0]){
                        circle(r = inner_tube_radius);
                    }
                }
            }
            //middle_rod
            circle(r=middle_rod);
        }        
    }
}

module bottom(){
    difference(){    
        linear_extrude(height = holder_height){        
            circle(r = inner_tube_radius*3.7);
        }
        linear_extrude(height = holder_height/2){           
            
            for (i=[1: 5]) {
                rotate([0,0,i*360/5]) {
                    translate([inner_tube_radius*2.3,0,0]){
                        circle(r = inner_tube_radius);
                    }
                }
            }           
        }
    //middle_rod    
         linear_extrude(height = holder_height){   
         
            circle(r=middle_rod_bottom);
         }
         translate([-2.1/2,-middle_rod_bottom-2,0]){
             cube([2.1,middle_rod_bottom*2+4,holder_height]){
             }
         }  
         rotate([0,0,90]){
             translate([-2.1/2,-middle_rod_bottom-2,0]){
                 cube([2.1,middle_rod_bottom*2+4,holder_height]){
                 }
             }  
         }
    }
}

translate([0,0,-50]){
    top();
}
//bottom();
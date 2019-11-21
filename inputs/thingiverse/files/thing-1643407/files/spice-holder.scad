$fn=50;
tube_radius = 12;
inner_tube_radius = 6.2;
holder_height = 6;
middle_rod = 4.05;
middle_rod_bottom = 3.1;
module top(){
    linear_extrude(height = holder_height){
        difference(){    
            circle(r = tube_radius*4+1);
            for (i=[1: 8]) {
                rotate([0,0,i*360/8]) {
                    translate([tube_radius*2.9,0,0]){
                        circle(r = tube_radius);
                    }
                }
            }
            
            for (i=[1: 5]) {
                rotate([0,0,i*360/5]) {
                    translate([inner_tube_radius*2.2,0,0]){
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
            circle(r = tube_radius*4+1);
        }
        linear_extrude(height = holder_height/2){
            for (i=[1: 8]) {
                rotate([0,0,i*360/8]) {
                    translate([12*2.9,0,0]){
                        circle(r = tube_radius);
                    }
                }
            }
            
            for (i=[1: 5]) {
                rotate([0,0,i*360/5]) {
                    translate([inner_tube_radius*2.2,0,0]){
                        circle(r = inner_tube_radius);
                    }
                }
            }           
        }
    //middle_rod    
         linear_extrude(height = holder_height){   
         
            circle(r=middle_rod_bottom);
         }
    }
}

translate([0,0,-50]){
//    top();
}
bottom();
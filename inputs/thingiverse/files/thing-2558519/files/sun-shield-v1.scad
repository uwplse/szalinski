//$fn = 350; //rendering- number of detail
// preview[view:north east, tilt:top diagonal]
/* [Data_of_Your_device] */
//Variables for thingiverse customizer
//(tablet, smartphone, GPS navigation device)
lenght_of_your_device = 210; // [1:300]
thickness_of_your_device = 9;// [1:0.1:30]
width_of_your_device = 124; // [1:300]
/* [Data for sun shield] */
thickness_of_shield = 2; // [0.5:0.1:4]
//Values greater than width of device will not affect model 
lenght_of_shield = 75;//[1:300]
//(exactly the walls of grip)
thickness_of_grip = 2; // [0.5:0.1:4]
height_of_front_part_of_the_grip = 5;// [1:40]
height_of_front_left_and_right_side_of_the_grip = 9;//[1:40]
height_of_back_part_of_the_grip = 12;//[1:50]
/* [First top hole] */
// If You don't want this hole - type 0
lenght_of_first_top_hole = 47; //[0:300]
width_of_first_top_hole = 25; // [0:300]  
position_of_first_top_hole = 77; // [0:300]
/* [Second top hole] */
// If You don't want this hole - type 0
lenght_of_second_top_hole = 50; //[0:300]
width_of_second_top_hole = 9; // [0:300]
position_of_second_top_hole = 29; //[0:300]
/* [First right hole] */
// If You don't want this hole - type 0
lenght_of_first_right_hole = 25; // [0:300]
width_of_first_right_hole = 9; // [0:300]
position_of_first_right_hole = 24; // [0:300]
/* [Second right hole] */
// If You don't want this hole - type 0
lenght_of_second_right_hole = 40; //[0:300]
width_of_second_right_hole = 12; //[0:300]
position_of_second_right_hole = 43; //[0:300]
/* [First left hole] */
// If You don't want this hole - type 0
lenght_of_first_left_hole = 25; //[0:300]
width_of_first_left_hole = 9; //[0:300]
position_of_left_right_hole = 32; // [0:300]
/* [Second left hole] */
// If You don't want this hole - type 0
lenght_of_second_left_hole = 40; //[0:300]
width_of_second_left_hole = 12; //[0:300]
position_of_second_left_hole = 43; // [0:300]


// ignore variable values 
l_dev = lenght_of_your_device;
t_dev = thickness_of_your_device;
w_dev = width_of_your_device; 
t_sh = thickness_of_shield; 

l_sh = lenght_of_shield>w_dev ? w_dev : lenght_of_shield; //blockade of length of shield
t_grip = thickness_of_grip; 
hf_grip = height_of_front_part_of_the_grip; 
hfs_grip = height_of_front_left_and_right_side_of_the_grip; 
hb_grip = height_of_back_part_of_the_grip;

d_hole1= hb_grip>hf_grip ? hb_grip : hf_grip;
d_hole2= hfs_grip>hb_grip ? hfs_grip : hb_grip;//deep of the holes   

lh1_top = lenght_of_first_top_hole; 
wh1_top = width_of_first_top_hole; 
lh2_top = lenght_of_second_top_hole; 
wh2_top = width_of_second_top_hole;

//solution for minus position of holes
a = l_dev/2; //helper
pos_h1_top = position_of_first_top_hole - a;

pos_h2_top = position_of_second_top_hole - a; 


 
lh1_right = lenght_of_first_right_hole; 
wh1_right = width_of_first_right_hole; 
//solution for position of holes
pos_h1_right = position_of_first_right_hole + lenght_of_first_right_hole; 
lh2_right = lenght_of_second_right_hole; 
wh2_right = width_of_second_right_hole; 
pos_h2_right = position_of_second_right_hole + lenght_of_second_right_hole; 

lh1_left = lenght_of_first_left_hole; 
wh1_left = width_of_first_left_hole; 
pos_h1_left = position_of_left_right_hole + lenght_of_first_left_hole; 
lh2_left = lenght_of_second_left_hole; 
wh2_left = width_of_second_left_hole; 
pos_h2_left = position_of_second_left_hole + lenght_of_second_left_hole;

module top(){
    //bottom grip plate
    translate([-l_dev/2 - t_sh,0,0]){
        cube([l_dev + 2*t_sh, t_dev + t_grip, t_sh]);   
    } 
    //back grip plate
    translate([-l_dev/2 - t_sh,0,0]){ 
        cube([l_dev + 2*t_sh, t_grip, hb_grip]);   
    } 
    //front grip plate
    translate([-l_dev/2 - t_sh,t_dev + t_grip,0]){
        cube([l_dev +2*t_sh, t_grip, hf_grip+t_sh]);   
    } 
}

module top_plate(){
    translate([-l_dev/2 - t_sh,t_dev + 2 * t_grip,0]){
        cube([l_dev +2*t_sh, l_sh, t_sh]);   
    }      
}

module left_side_grip(){
    //side grip plate
    translate([-l_dev/2 - t_sh,0,0]){
        cube([t_sh, t_dev + t_grip, w_dev + t_sh]);   
    } 
    //back grip plate
    translate([-l_dev/2 - t_sh,0,0]){
        cube([hb_grip + t_sh, t_grip, w_dev + t_sh]);   
    } 
    //front grip plate
    translate([-l_dev/2 - t_sh,t_dev + t_grip,0]){
        cube([hfs_grip+t_sh, t_grip, w_dev + t_sh]);   
    }      
}

module left_side_plate(){
    translate([-l_dev/2 - t_sh,t_dev + 2 * t_grip,0]){
        cube([t_sh, l_sh, w_dev - l_sh + t_sh]);   
    }
    //curved part of the side plate
  // color([0.1,1.0,0.2]){
        intersection(){  
            translate([-l_dev/2- t_sh,t_dev + 2 * t_grip,w_dev - l_sh + t_sh]){
                cube([t_sh, l_sh, l_sh]);   
            }
            translate([-l_dev/2- t_sh,t_dev + 2 * t_grip,w_dev - l_sh + t_sh]){
                rotate([0,90,0]){
                    cylinder(h = t_sh,r = l_sh);
                }   
            }

        } 
                  
  //  }
}
//mirror of the side plate
module right_side_all(){
    mirror([1,0,0]){
        left_side_grip();
        left_side_plate();
    }  

}

module top_hole(){
       
  //  color([0.1,0.8,0.2]){
        translate([pos_h1_top+3, 1, -1]){   
            minkowski() 
            {
              cube([lh1_top-6,wh1_top-4 + t_sh, d_hole1]); //6 because of cylinder r*2
              cylinder(r=3,h=d_hole1);
            }
        }
                  
 //  }
}

module top_hole_2(){
       
  //  color([0.1,0.8,0.2]){
        translate([pos_h2_top+3,1,-1]){   
            minkowski() 
            {
              cube([lh2_top - 6, wh2_top - 4 + t_sh, d_hole1]);
              cylinder(r=3,h=d_hole1);
            }
        }
                  
  // }
}

module right_hole(){
  // color([0.1,0.8,0.2]){
        translate([l_dev/2-d_hole2-0.01,0,pos_h1_right-3]){  //0.01 value is used beause of rendering problem (shadows)
            rotate([0,90,0]){
                minkowski()
                {
                  cube([lh1_right - 6 - t_sh, wh1_right-3 + t_sh,d_hole2]);
                  cylinder(r=3,h=d_hole2);
                }
            }
        }
                  
  // }       

}

module right_hole_2(){
  //  color([0.1,0.8,0.2]){
        translate([l_dev/2-d_hole2-0.01,0,pos_h2_right-3]){//0.01 value is used beause of rendering problem (shadows) 
            rotate([0,90,0]){
                minkowski()
                {
                  cube([lh2_right - 6 - t_sh,wh2_right-3 + t_sh, d_hole2]);
                  cylinder(r=3,h=d_hole2);
                }
            }
       }
                  
 //  }       

}

module left_hole(){
       
 //   color([0.1,0.8,0.2]){
        translate([-l_dev/2 - 0.01- t_sh, 0, pos_h1_left-3]){ //0.01 value is used beause of rendering problem (shadows)  
            rotate([0,90,0]){
                minkowski() 
                {
                  cube([lh1_left - 6 - t_sh,wh1_left-3 + t_sh+0.01, d_hole2]);//0.01 value is used beause of rendering problem (shadows)
                  cylinder(r=3,h=d_hole2);
                }
            }
        }
                  
 //  }
}

module left_hole_2(){
       
 //   color([0.1,0.8,0.2]){
        translate([-l_dev/2 - 0.01- t_sh, 0, pos_h2_left-3]){ //0.01 value is used beause of rendering problem (shadows)  
            rotate([0,90,0]){
                minkowski()
                {
                  cube([lh2_left - 6 - t_sh,wh2_left-3 + t_sh+0.01,d_hole2]); //0.01 value is used beause of rendering problem (shadows)
                  cylinder(r=3,h=d_hole2);
                }
            }
        }
                  
  // }
}

module difference_top(){
    difference(){
        difference(){
            
          top();
          top_hole();
          
        }  
        top_hole_2();
    } 
    difference(){
        difference(){
            
          top_plate();
          top_hole();
          
        } 
        top_hole_2();
    }
    

}

module difference_left(){
    difference(){
      difference(){
          
          left_side_grip();
          left_hole();
          
      }    
      left_hole_2();
    }  
    difference(){
      difference(){ 
          
          left_side_plate();
          left_hole();
          
      }
      left_hole_2();
    }    

}


module difference_right(){
    difference(){
       difference(){
           
      right_side_all();
      right_hole();
           
       }
     right_hole_2(); 
    }    

}

difference_top();
difference_right();
difference_left();
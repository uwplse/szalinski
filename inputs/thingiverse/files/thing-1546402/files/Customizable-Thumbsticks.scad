/*
Customizable Thumbsticks for replacing/improving controllers.

    Harlo ~ 07/05/2016.
*/

//Inside Cut Height
inner_cut_length = 16; //[0:0.5:50]
//Inside Cut Diameter
inner_dia = 3.2; //[0:0.1:10]
//Inside Cut Resolution (4 for square)
inner_resolution = 32; //[4:1:120]

//Collar Height (Lower Cylinder)
lower_length = 4; //[0:0.25:10]
//Collar Diameter (OD)
lower_dia = 5.5; //[1:0.25:20]
//Collar Resolution
collar_resolution = 100; //[4:1:120]

//Overall Height
total_length = 20; //[10:0.25:50]
//Thumbstick Diameter
upper_dia = 12.5; //[5:0.25:25]
//Thumbstick Resolution
thumbstick_resolution = 12; //[8:1:120]

//Thumb Recess Diameter 
dimple_dia = 8; //[0:0.5:20]







upper_length = total_length - lower_length;


difference(){
    thumbstick();
    inner_cutout();
    top_dimple();
}

module inner_cutout(){
    //-inner_cut_length/2
    translate([0,0,-(total_length/2 - inner_cut_length/2)]){
        cylinder(h = inner_cut_length, d1 = inner_dia, d2 = inner_dia - 0.5, center = true, $fn = inner_resolution);
    }
    
}

module top_dimple(){
    translate([0,0,2.5 + upper_length/2]){
        scale([1,1,1]){
            sphere(d = dimple_dia, $fn = thumbstick_resolution, center = true);
        }
    }
}

module thumbstick(){
    upper();
    translate([0,0,-upper_length/2]){
        attachment();
    }
}



module upper(){
    hull(){
        translate([0,0,upper_length/2]){
            scale([1,1,0.4]){
                sphere(d = upper_dia, $fn = thumbstick_resolution);
            }
        }
        
        translate([0,0,-(upper_length/2 - 0.1)]){
        cylinder(h = 0.1, d = lower_dia, $fn = collar_resolution);
        }
    }   
}

module attachment(){

        cylinder(h = lower_length, d = lower_dia, $fn = collar_resolution, center = true);

}
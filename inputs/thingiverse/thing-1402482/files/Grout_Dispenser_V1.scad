/*
    Nozzle Creation Script
        - built for generating nozzles
        - my specific use is for laying grout
*/

//Wider nozzle end, inner diameter
lower_dia_in = 25; //[20:0.5:100]

//Thinner nozzle end, innet diameter
upper_dia_in = 7; //[4:0.1:50]

//length from bottom to top
length = 40; //[8:0.1:150]

//Nozzle X Scale
nozzle_x_scale = 2.0; //[0.25:0.1:2.0]

//Nozzle Y Scale
nozzle_y_scale = 0.5; //[0.25:0.1:2.0]

//Wall thickness at base
wall_thickness_upper = 2; //[1:0.1:15]

//Wall thickness at nozzle
wall_thickness_lower = 3.5; //[1:0.1:20]

//Smoothness - Resolution of the circles
resolution = 120; //[32:1:240]


//RENDER
difference(){
    outer_wall();
    inner_wall();
}

//MODULES
module outer_wall(){
    hull(){
translate([0,0,length/2]){
upper_nozzle(wall_thickness_upper);
}

translate([0,0,-length/2]){
lower_nozzle(wall_thickness_lower);
}
}
}

module inner_wall(){
    hull(){
translate([0,0,length/2]){
upper_nozzle(0);
}

translate([0,0,-length/2]){
lower_nozzle(0);
}
}
}


module lower_nozzle(thickness){
    cylinder(h = 1, d = lower_dia_in + thickness, center = true, $fn = resolution); 
}

module upper_nozzle(thickness){
    scale([nozzle_x_scale, nozzle_y_scale,1]){
            cylinder(h = 1, d = upper_dia_in + thickness, center = true, $fn = resolution); 
    }
}
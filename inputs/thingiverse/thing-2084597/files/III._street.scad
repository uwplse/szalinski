//City_Generator.scad
road_width=100;
curb_width=75;
street_length=500;
max_buildings_per_side=10;


street(road_width, curb_width, street_length);


module street(r_width, curb_width, s_length){ 
   
    num_buildings = floor(rands(5,max_buildings_per_side,1)[0]);
    translate([curb_width/2,0,5]) 
       block(num_buildings, s_length/(num_buildings), curb_width);
    
    difference(){
        cube([r_width+2*curb_width, s_length, 10]);
        translate([curb_width,0,6]) cube([r_width, s_length, 5]);
    }
    
    num_buildings2 = floor(rands(5,10,1)[0]);
    translate([curb_width+r_width+curb_width/2,0,5]) 
       block(num_buildings, s_length/(num_buildings), curb_width);
}

module block(num_buildings, b_length, curb_width){
    for(n=[0:1:num_buildings-1]){
       translate([0,n*b_length,0]) 
            building(floor( rands(10,curb_width-20,1)[0]), floor( rands(30,b_length,1)[0]), floor( rands(60,200,1)[0]), 3, 5);
    }
}

module building(b_width, b_length, b_height, window_columns, window_rows){
    facade(b_width/2, b_length, b_height,window_columns, window_rows );
    mirror([1,0,0]) facade(b_width/2, b_length, b_height, window_columns, window_rows);
}

module facade(b_width, b_length, b_height, window_columns, window_rows){
    
    w_length = b_length/(2*window_columns+1);
    w_height = b_height/(2*window_rows+1);

    difference(){
        cube([b_width, b_length, b_height]); //main structure
        
        for(z=[w_height:2*w_height:b_height-w_height]){//rows
            for(y=[ w_length : 2* w_length : b_length-w_length]){//columns
                translate([b_width-1,y,z]) cube([2,  w_length , w_height]);
            }
        }//windows
    }//facade
}


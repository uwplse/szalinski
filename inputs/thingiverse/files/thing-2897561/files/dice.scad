
size = 500;
radius = 50; 
number_radius = 50;  

hollow_die = 0; //[0:false, 1: true]

weight_proportion =0.3;
weight_size =size*weight_proportion;
weight_offset = 20; 
weight_location_corner_1 = 7 ; //[8:none,1:1-2-3,5:1-2-4,0:1-3-5,4:1-4-5,2:2-3-6,6:2-4-6,3:3-5-6,7:4-5-6] 
weight_location_corner_2 = 8 ; //[8:none,1:1-2-3,5:1-2-4,0:1-3-5,4:1-4-5,2:2-3-6,6:2-4-6,3:3-5-6,7:4-5-6]
weight_location_corner_3 = 8 ; //[8:none,1:1-2-3,5:1-2-4,0:1-3-5,4:1-4-5,2:2-3-6,6:2-4-6,3:3-5-6,7:4-5-6]
weight_location_corner_4 = 8 ; //[8:none,1:1-2-3,5:1-2-4,0:1-3-5,4:1-4-5,2:2-3-6,6:2-4-6,3:3-5-6,7:4-5-6]
weight_location_side_1 =7; //[12:none,5:1-2,3:1-3,11:1-4,4:1-5,2:2-3,10:2-4,6:2-6,0:3-5,1:3-6,8:4-5,9:4-6,7:5-6]
weight_location_side_2 =12; //[12:none,5:1-2,3:1-3,11:1-4,4:1-5,2:2-3,10:2-4,6:2-6,0:3-5,1:3-6,8:4-5,9:4-6,7:5-6]
weight_location_side_3 =12; //[12:none,5:1-2,3:1-3,11:1-4,4:1-5,2:2-3,10:2-4,6:2-6,0:3-5,1:3-6,8:4-5,9:4-6,7:5-6]

o = weight_offset;
i = size -weight_offset-weight_size;
c = (o+i)/2;
offset_location_corner=[ [o,o,o],[i,o,o],[i,i,o],[o,i,o],
             [o,o,i],[i,o,i],[i,i,i],[o,i,i]];  
             
offset_location_side = [[o,c,o],[c,i,o],[i,c,o],[c,o,o],  
                [o,o,c],[i,o,c],[i,i,c],[o,i,c],
                [o,c,i],[c,i,i],[i,c,i],[c,o,i] ];

 
numbered_die();
 
 

module numbered_die(){
    difference(){ 
        color("Purple",.5 ) 
        die(); 
        
        one();
        two();
        three();
        four();
        five();
        six();
        
        if(hollow_die){
            cube(size);
        }else{ 
            //ADD AIR POCKET //for placing ball bearings
            weight_cube();
        }
    } 
    
    if(hollow_die){
        //ADD PRINTED WEIGHT  
        weight_cube();  
    }
}

module weight_cube(){
    // (CORNERS)
    if(weight_location_corner_1 < 8) 
    translate(offset_location_corner[weight_location_corner_1])
    cube(weight_size);   
    if(weight_location_corner_2 < 8) 
    translate(offset_location_corner[weight_location_corner_2])
    cube(weight_size);   
    if(weight_location_corner_3 < 8) 
    translate(offset_location_corner[weight_location_corner_3])
    cube(weight_size);   
    if(weight_location_corner_4 < 8) 
    translate(offset_location_corner[weight_location_corner_4])
    cube(weight_size);   
    // (SIDES)
    if(weight_location_side_1 < 8) 
    translate(offset_location_side[weight_location_side_1])
    cube(weight_size);  
    if(weight_location_side_2 < 8) 
    translate(offset_location_side[weight_location_side_2])
    cube(weight_size);  
    if(weight_location_side_3 < 8) 
    translate(offset_location_side[weight_location_side_3])
    cube(weight_size);   
}
    
location=[[0,0,0], [size, 0,0], [size, size,0], [0,size,0],
[0,0,size], [size, 0,size], [size, size,size], [0,size,size]];


offsets =[[-radius,0,0],[0,-radius,0],[0,0,-radius],
    [radius,0,0],[0,radius,0],[0,0,radius] ];  
     

center = size /2;
third = size/3;
fourth = size /4;


module one(){
    translate([0,-radius,0])
    rotate([90,0,0])
    color("Red")
    center();
} 
module two(){
    translate([size+radius,0,0])
    rotate([0,-90,0])  { 
        bottom_right(); 
        top_left();
    }
}
module three(){
    translate([0,0,-radius]){
        center(); 
        bottom_right(); 
        top_left();
    }
}
module four(){
    translate([0,0,size+radius]){
        bottom_left();
        bottom_right(); 
        top_left();
        top_right();
    }
}
module five(){
    translate([-radius,0,0])
    rotate([0,-90,0]){
        center();
        bottom_left();
        bottom_right(); 
        top_left();
        top_right();
    }
}

module six(){
    translate([0,size+radius,0])
    rotate([90,0,0]){ 
        bottom_left();
        bottom_right();
        center_left();
        center_right();
        top_left();
        top_right();
    }
} 

module center(){
translate([center,center ])
sphere(r=number_radius);
}
module bottom_right(){
    translate([fourth,fourth]) 
    sphere(r=number_radius);  
}
module bottom_left(){ 
    translate([size-fourth,fourth]) 
    sphere(r=number_radius);
}
module center_right(){
    translate([fourth,center]) 
    sphere(r=number_radius);  
}
module center_left(){
    
    translate([size-fourth,center]) 
    sphere(r=number_radius); 
}
module top_right(){
    translate([fourth,size-fourth]) 
    sphere(r=number_radius); 
}
module top_left(){
    translate([size-fourth,size-fourth]) 
    sphere(r=number_radius);
    
}

    
module die(){   
    inner();
    rounded();
    corner();
}
  
module inner() 
    for(i=offsets)
    translate(i)       
    cube(size); 

module corner()
    for( i = location)
    translate(i) 
    sphere(r=radius); 

 
module rounded(){
    
    module side() 
        for (i=[0:3]) 
        translate(location[i])
        cylinder(r=radius, h=size);
      
    side();
    translate([0,size,0])
    rotate([90,0,0])
    side(); 
    translate([0,0,size ])
    rotate([0,90,0])
    side();
}


//TESTING ONLY
/*
color("Purple", 0.5)
cube(size);
one();
two();
three();
four();
five();
six();
weight_cube();
for(j=offset_location){
    translate(j)
    cube(weight_size);
}
*/

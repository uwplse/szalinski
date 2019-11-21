/* [Global] */

/* [Dimension] */
// front part of house
house_length = 100; 
// side of house
house_width = 50; 
// height of house (excluding roof)
house_height = 60; 
// protrusion from walls (windows, doors, roof)
protrusion = 4;

/* [Roof] */
//height of roof
roof_height = 25;

/* [Chimney] */
// show or hide chimney
show_chimney = 1; // [0:false, 1:true]
// width/length of chimney 
chimney_thickness = 15;
//height of chimney from the floor
chimney_height = 90;
// [0:false, 1:true]
show_window_behind_chimney = 1;

/* [Window] */
//thickness of side window
window_thickness = 2;
// wall to window ratio
window_proportion = 0.35;
// offset of window from top of wall
window_height_offset = 0.4;

/* [Door] */
// wall to door ratio (for height)
door_height_proportion = 0.75;
// wall to door ratio (for width)
door_width_proportion = 0.5; 

/* [Params for Hollow house] */
// show inner details inside house
show_inner_details = 0; // [0:false, 1:true]
// thickness of the wall (only if show_inner_details)
wall_thickness = 4;  
// print the roof separately
separate_roof = 0; // [0:false, 1:true]
// show roof above house
show_roof = 1; // [0:false, 1:true]
// show floor 
show_floor = 1; // [0:false, 1:true]
// thickness of the floor
floor_thickness =1;
 
length = house_width;
thickness = house_length/2;
 
 
    
/*******************
* ROOF AND CHIMNEY *
*******************/ 
module small_triangle(){  
    
    offset(r=-wall_thickness)
    triangle();
    
}
module triangle (){ 
    polygon(points=
        [[0,-protrusion ],
        [0,length+protrusion ],
        [ roof_height, length/2]]); 
}
module base_roof(){
    translate([0,wall_thickness])
    square([wall_thickness, length-wall_thickness*2]);
}

/* //DEBUG ROOF 
color("Green")
 small_triangle();
color("Orange",0.2)
triangle();
color("Red",0.2)
base_roof();
*/
  
module roof(){
    color("Red" ,0.8)
    translate([house_height,0,0])
    if(show_inner_details ){
        difference(){
        linear_extrude (height = thickness+protrusion) 
            triangle(); 
        linear_extrude (height = thickness+protrusion-wall_thickness) 
            small_triangle(); 
        linear_extrude (height = thickness -wall_thickness*2) 
            base_roof();
        
       }
    }else{
        linear_extrude (height = thickness+protrusion){
            triangle();
        }
    }
}

module chimney_top(){ 
    offset  = (thickness - chimney_thickness)/2;

    translate([0,offset,0]){
        //chimney top protrusion
        translate([0,0,chimney_height - protrusion*2]) 
        cube([chimney_thickness+2*protrusion, 
        chimney_thickness+2*protrusion, 
        protrusion]); 
        
        //main chimney
        translate([protrusion, protrusion, house_height]) 
        cube([chimney_thickness,
            chimney_thickness,
            chimney_height-house_height]);  
    }    
     
}

module chimney_indoors(){
   difference(){     
         chimney_bottom(); 
         chimney_hole();
    }
   
}

module chimney_bottom(){ 
    offset  = (thickness - chimney_thickness)/2; 
    
    color("Green", 0.8) 
    translate([protrusion, protrusion+offset, 0]) 
    cube([chimney_thickness,chimney_thickness,house_height]);  
    
    translate([0,thickness - (chimney_thickness*2),0]){ 
    cube ([chimney_thickness + protrusion*2, chimney_thickness*2 , house_height/3 ]);  
    } 
}
 
module chimney_hole(){
    rotate([0,90,0])
    hull(){ 
        l = house_height/6;
        translate([-l-protrusion,
            thickness -(chimney_thickness*2) +protrusion,
            chimney_thickness +protrusion])
        {
            translate([0, l/2, 0])
            cylinder(d=l, h=protrusion*2);
            cube ([l,l,protrusion*2]) ;
        }
    }
}

/********
* WALLS *
********/  
module floor(){
    if(show_floor){
        translate([0,-house_length/2,0])
        cube([house_width, house_length, floor_thickness]);
    }
}

module wall(){
    
    if(show_inner_details){
        difference(){
            color( "Purple" ,0.6 ) {
            cube([house_height,length, thickness]);}
            
             
            color( "Green"   ) {
            translate([0, wall_thickness, 0])
            cube([house_height,length-2*wall_thickness, thickness-wall_thickness]);
            }
        }
    }else {
        color( "Purple" ,0.8 ) {
        cube([house_height,length, thickness]);} 
    }
}

/*******
* DOOR *
*******/ 

module door(){  
    mirror([0,1,0]) 
        translate ([length,(thickness -(door_width_proportion*thickness))/2,0])
    cube([ protrusion, 
        door_width_proportion*thickness,
        house_height * door_height_proportion ]);
}

/**************
*WINDOW MODULE*
***************/
 
//side offset 
function window_offset(wall_length, window_length) = 
        (wall_length - window_length)*0.5;

module window_v_bar(wall_length, wall_offset){ 
    length=wall_length *window_proportion + window_thickness ;
    translate([0,0, wall_offset]) {
    cube([ length , 
        window_thickness,
        protrusion]);  
    }
     
}
module window_h_bar(length, wall_offset){ 
    translate([0,0, wall_offset])
    cube([ window_thickness,
        length *window_proportion + window_thickness ,  
        protrusion]); 
}

module window_3_v_bars(length, wall_offset, spacing){
    window_v_bar(length, wall_offset);
    translate ([0,spacing*window_proportion*0.5, 0])
    window_v_bar(length, wall_offset);
    translate ([0,spacing*window_proportion, 0])
    window_v_bar(length, wall_offset);
}

module window_3_h_bars(length, wall_offset){ 
    window_h_bar(length, wall_offset);
    translate ([house_height*window_proportion*0.5, 0, 0])
    window_h_bar(length, wall_offset);
    translate ([house_height*window_proportion, 0, 0])
    window_h_bar(length, wall_offset);
} 
 
module window(offset, length){
    
    height_offset = window_height_offset * house_height; 
    window_length = length * window_proportion + window_thickness;
    length_offset = window_offset(length, window_length);
    
    translate([height_offset, length_offset, 0]){
        window_3_v_bars(house_height, offset, length);
        window_3_h_bars(length, offset); 
    }
}

module front_window(){
    mirror([0,0,1])
    rotate([0,90,0]){  
        window(length, thickness );
    }
}
module back_windows(){
    
    
color("Green")  
    
    translate([-protrusion,0,0])
    mirror([0,0,1])
    rotate([0,90,0])
        window(0, thickness );
    
    
    translate([-protrusion,0,0])
    mirror([0,1,0]) 
    mirror([0,0,1])
    rotate([0,90,0])
        window(0, thickness );
        
    if(!show_chimney || show_window_behind_chimney){
        
    translate([-protrusion,0,0])
    mirror([0,0,1])
    rotate([0,90,0])
        window(0, thickness );
    }
}

/*****************
* HOUSE ASSEMBLY *
*****************/  
module half_house(){    
    if(show_roof  ){
        roof();
    }
    
    if (separate_roof){
        
        translate([-house_height,-(house_width + 2* protrusion ), 0]){
            roof();  
        }
    }
    wall();
    window(thickness, length);
} 

module house_main(){  
    
    if(show_chimney){
        chimney_indoors(); 
        if (separate_roof){
             
            translate([-(house_width+protrusion*2),0,-house_height])
            chimney_top();
         
        }  
        if(show_roof){
             chimney_top();
        }
         
    }
    door();
    front_window();
    back_windows();
    rotate([-90,-90,0]){
        half_house();
        mirror([0,0,1]) half_house();
    } 
    
    floor();
}

house_main();
 
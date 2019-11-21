
/*[global]*/
//number of steps 
number_steps = 4; 
//length of rack
length = 40;

/*[rack]*/
//spacing below last shelf
bottom_spacing = 10;
//offset from front
offset_from_front = 0;
side_thickness = 3;

/*[shelf]*/
//thickness of shelf
shelf_thickness = 4;
//depth of top shelf
top_shelf_depth = 10;
//increment in depth every step
shelf_depth_increment = 10;
//spacing (including shelf_thickness)
spacing_between_shelves = 30; 
  
total_height = number_steps* (shelf_thickness + spacing_between_shelves)
                +bottom_spacing;
   
shelves();  
sides();
translate([0,length-side_thickness,0])
sides(); 
  
module rack_side(depth, height){ 
    translate([shelf_thickness,0,0])
    cube([height, side_thickness , depth]);
}  
module shelf( depth ){
    
    cube([shelf_thickness, length, depth]);
}


module sides(){
    for(increment =[0:number_steps-2]){
        echo("current index: ", increment);
        shelf_depth = top_shelf_depth + increment*shelf_depth_increment; 
        
        translate([increment*spacing_between_shelves, 0,0]){
            rack_side(shelf_depth, spacing_between_shelves); 
        }
    } 
    //base
    increment = number_steps-1;
    shelf_depth = top_shelf_depth 
                + increment *shelf_depth_increment; 
    translate([increment*spacing_between_shelves, 0,0]) 
    rack_side(shelf_depth, bottom_spacing); 
    
}

module shelves(){
    for(increment =[0:number_steps-1]){
        echo("current index: ", increment);
        shelf_depth = top_shelf_depth + increment*shelf_depth_increment; 
        
        translate([increment*spacing_between_shelves, 0,0]){
            
            shelf( shelf_depth);  
        }
    } 
}
// length of the longest bit
bay_height = 107;

// width of bits side by side
bay_width = 14;

// diameter of thickest bit
bay_depth = 8;

// number of bays
number_bays = 5;

// thickness of all the walls including the base
wall_thickness = 2;

// label height (0 for no label space)
label_height = 0;

// do some preliminary calulations
total_width = wall_thickness+number_bays*(bay_width+wall_thickness);
total_height = (label_height==0) ? bay_height+2*wall_thickness : label_height+bay_height+3*wall_thickness;
total_depth = bay_depth+wall_thickness;

label_depth = 1;
difference(){
    // make a base
    cube([total_width,total_height,total_depth]);
    
    // cut out the bays
    y1_move = (label_height==0) ? wall_thickness : 2*wall_thickness+label_height;
    for(i=[0:1:number_bays-1]){ 
        translate([wall_thickness+i*(bay_width+wall_thickness), y1_move, wall_thickness])cube([bay_width,bay_height, bay_depth]);   
    }
    
    // make a finger slot
    y2_move = (label_height == 0) ? total_height/2 : label_height+2*wall_thickness+bay_height/2;
    
    translate([0,y2_move,12.5+wall_thickness])rotate([0,90,0])cylinder(d=25,h=total_width);
    
    //make a label slot
    if(label_height!=0)
    translate([wall_thickness, wall_thickness,total_depth-label_depth])cube([total_width-2*wall_thickness,label_height,label_depth]);
    
}
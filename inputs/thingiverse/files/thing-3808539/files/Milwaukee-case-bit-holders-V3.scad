/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Milwaukee Bit Holders
* Benjamen Johnson <workshop.electronsmith.com>
* 20190809
* Version 1
* openSCAD Version: 2015.03-2
*******************************************************************************/
/*[Easy]*/
// number of slots for bits
num_slots = 8; //[1:8]

// Type of holder
holder_type = 1; //[0:Short,1:Tall]

/*[Advanced]*/
/*******************************************************************************
*    /\ /\ /\ /\ /\ /\ /\ /\ /\ /\  < ---- bits
*   -------------------------------  --
*  |                               |  body_height 
*  |                               |
*   -------------------------------  --
*  |< ------- body_width --------->|
*   -------------------------------  --
*  | X  X  X  X  X  X  X  X  X  X  |  body_depth
*   -------------------------------  --
*
*   -----------
*  | --- | --- | --
*  ||   |||   ||  slot_width
*  | --- | --- | --
*   -----------
*         |<->| slot_length (I know these seem backward in 2D)
*******************************************************************************/
// width of the holder body
body_width = 82.5 ; // 82.5

// depth of holder 
body_depth = 11; // 11

// height of holder
body_height_array = [12.5,25]; //short = 12.5, long = 25
body_height = body_height_array[holder_type];

// length of the bit slot (side to side)
slot_length = 7.3;

// width of the bit slot (front to back)
slot_width = 6.6;


/*******************************************************************************
*     -------------------------------
*   -| X  X  X  X  X  X  X  X  X  X  |-
*     -------------------------------
*  | <------ total_pin_length -------->|
*
*    -------
*   |---O---|  o <- pin_dia (diamter of pivot pin)
*   |   |   | 
*   |   |   |    <- catch_dia (diameter of the semicircular catches)
*    -------
******************************************************************************/
// Length of cylinder passing through the holder that it rotates on 
total_pin_length = 88; // 88

// diameter of the above cylinder
pin_dia = 4.5; // 4.5

// diameter of the semicircular catches
catch_dia = 2.5;

// how much material to leave at the bottom of the bit slots
bottom_thickness = 2;

// how much to chamfer the ends
bottom_chamfer = 5;

// add a slight offset to cuts to make model render properly
render_offset = 0.01; //0.005


/*[Hidden]*/
window_depth = 2.5;
front_window_height_array = [4,10]; //short = 4, long = 10;
rear_window_height_array = [6,10];  //short = 6, long = 10;

front_window_height = front_window_height_array[holder_type];
rear_window_height = rear_window_height_array[holder_type];

spring_width = 5;
spring_thickness = 2;
spring_length = rear_window_height;
spring_z_pos = -(body_height-spring_length)/2+bottom_thickness+0.5;

detent_dia = 4;
detent_pos = -(spring_length-detent_dia)/2;

pin_height = 10; // pin distance from the bottom of holder;

//calculations for positioning the slots
min_edge = 1;
width2= body_width - 2 * min_edge;
step = width2 /(num_slots);
start = -width2/2+step/2;
end = width2/2;     

pin_pos = - body_height/2+pin_height;

rotate([90,0,0])
union(){
    difference(){
        union(){
            // Form the main body
            cube([body_width,body_depth,body_height],center = true);
                    
            // form the pivot pins
            translate([0,0,pin_pos])rotate([0,90,0])cylinder(d=pin_dia,h=total_pin_length,center=true,$fn=50);
            
            //form the horizontal catches
            translate([body_width/2,0,pin_pos])rotate([90,0,0])cylinder(d=catch_dia,h=body_depth,center=true,$fn=50);
            translate([-body_width/2,0,pin_pos])rotate([90,0,0])cylinder(d=catch_dia,h=body_depth,center=true,$fn=50);
            
            //form the vertical catches
            translate([body_width/2,0,0])rotate([0,0,0])cylinder(d=catch_dia,h=body_height,center=true,$fn=50);
            translate([-body_width/2,0,0])rotate([0,0,0])cylinder(d=catch_dia,h=body_height,center=true,$fn=50);
        }
        //cut off corners of bottom
        translate([(body_width+catch_dia)/2,0,-body_height/2])rotate([0,45,0])cube([bottom_chamfer,body_depth+render_offset,bottom_chamfer],center=true);
        translate([-(body_width+catch_dia)/2,0,-body_height/2])rotate([0,45,0])cube([bottom_chamfer,body_depth+render_offset,bottom_chamfer],center=true);
        translate([0,-body_depth/2,-body_height/2])rotate([45,0,0])cube([body_width+render_offset, bottom_chamfer ,bottom_chamfer],center=true);
        translate([0,body_depth/2,-body_height/2])rotate([45,0,0])cube([body_width+render_offset, bottom_chamfer ,bottom_chamfer],center=true);
        
        
        //cut front and back "window"
        translate([0,-body_depth/2,-(body_height-front_window_height)/2-render_offset+bottom_thickness])cube([body_width-5,window_depth*2,front_window_height],center=true);
        translate([0,body_depth/2,-(body_height-rear_window_height)/2-render_offset+bottom_thickness])cube([body_width-5,window_depth*2,rear_window_height],center=true);
    
        // cut the slots for the bits
        for (x=[start:step:end])
            translate([x,0,bottom_thickness])cube([slot_length,slot_width,body_height], center=true);   
    
    }//end difference
    //create the spring that keeps the bit in
    for (x=[start:step:end])
        translate([x,(body_depth-spring_thickness)/2,spring_z_pos])spring();
}// end union


module spring(){
    cube([spring_width,spring_thickness,spring_length], center=true);
        translate([0,0,detent_pos])sphere(d=detent_dia, center=true,$fn=50);
}
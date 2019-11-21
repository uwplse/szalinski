/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Milwaukee Die Holders
* Benjamen Johnson <workshop.electronsmith.com>
* 20191003
* Version 6
* openSCAD Version: 2019.05
*******************************************************************************/


/*******************************************************************************
*
*   ---      -----  -----
*  |   |   /       \    |
*  |   |  /         \   | <- die_width
*  |   |  \         /   |
*  |   |   \       /    |
*   ---     -----  -----
*  |   |
*  |   | <- die_thickness
*
*******************************************************************************/
/*[Hidden]*/
die_width_array = [16.2,25.4];
die_thickness_array = [6.5,9.2];
num_slot_array = [5,3];
die_bottom_pos_array = [0,3]; //3 for 5/8" dies
body_depth_array = [11,12];

/*[Die Parameters]*/
//Dummy variable to fix Customizer
dummy = 1;

// type or size of die
die_type = 1; //[0:Small Die (5/8-in), 1:Standard Die (1-in)]

// Die width adjustment (ex, 1.01 would be 101% of fixed width)
die_width_adj = 1;

// Width of dies across the flats
die_width = die_width_array[die_type] * die_width_adj;

// array of slot widths
num_slots = num_slot_array[die_type];

// Die thickness adjustment (ex, 0.99 would be 99% of fixed thickness )
die_thickness_adj = 1;

// Thickness of the die
die_thickness = die_thickness_array[die_type] * die_thickness_adj;

// Width of dies across the points
die_width_pt_to_pt = die_width/sin(60);

/*[Holder Parameters]*/
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
*  || <- min_edge
*   -----------
*  | --- | --- | --
*  ||   |||   ||  slot_width
*  | --- | --- | --
*   -----------
*         |   | <- slot_length (I know these seem backward in 2D)
*  
*******************************************************************************/
// adjust height of holder
height_adjustment = 0;

// figure out where the bottom of the die sits
die_bottom_pos = die_bottom_pos_array[die_type]+height_adjustment;

// how much to chamfer the ends
bottom_chamfer = 5;

// how much material to leave at the bottom of the bit slots
bottom_thickness = sqrt(pow(bottom_chamfer,2)/2) + die_bottom_pos;

// width of the holder body
body_width = 82.5 ; // 82.5

// adjust the body depth (ex, 1.01 would be 101% of fixed depth)
body_depth_adj = 1;

// depth of holder
body_depth = body_depth_array[die_type] * body_depth_adj;

// height of holder
body_height = die_width + bottom_thickness;

// length of slot (side to side)
slot_length = die_width;

// width of the bit slot (front to back)
slot_width = die_thickness;

//width of the finger slot
finger_width = die_width - 5;

// minimum wall thickness at the edge of the holder
min_edge = 1;

/*[Connector Parameters]*/
/*******************************************************************************
*     -------------------------------
*   -| X  X  X  X  X  X  X  X  X  X  |-
*     -------------------------------
*  | <------ total_pin_length -------->|
*
*             -------
*        --  |---O---|  o <- pin_dia (diamter of pivot pin)
* pin_height |   |   | 
*            |   |   |    <- catch_dia (diameter of the semicircular catches)
*        --   -------
******************************************************************************/
// Length of cylinder passing through the holder that it rotates on 
total_pin_length = 88; // 88

// diameter of the above cylinder
pin_dia = 4.5; // 4.5

// diameter of the semicircular catches
catch_dia = 2.5;

// pin distance from the bottom of holder;
pin_height = 10; 

/*[Expert]*/
// add a slight offset to cuts to make model render properly
render_offset = 0.01; //0.005

difference(){

    // make the basic holder
    MilwaukeeHolder();

    //calculations for positioning the slots
    width2= body_width - 2 * min_edge;
    step = width2 /(num_slots);
    start = -width2/2+step/2;
    end = width2/2;
    
    for (x=[start:step:end]){
        // cut the slots for the discs
        translate([x,0,-(body_height-die_width_pt_to_pt)/2+bottom_thickness])rotate([90,30,0])cylinder(d=die_width_pt_to_pt, die_thickness, center=true, $fn=6);
        translate([x,0,bottom_thickness+die_width_pt_to_pt/2])cube([die_width,die_thickness,body_height],center=true);
        
        // cut the finger holes
        translate([x,-4,(2/3)*die_width+bottom_thickness])cube([finger_width,die_thickness,body_height],center=true);
        translate([x,-4,-body_height/2+(2/3)*die_width+bottom_thickness])rotate([90,0,0])cylinder(h=slot_width, d=finger_width, center=true, $fn=50);
        }//end for

}//end difference

module MilwaukeeHolder(){
    
    // calculate where to put the pin
    pin_pos = - body_height/2+pin_height;

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
        } // end union
        
        //cut off bottom corners
        translate([(body_width+catch_dia)/2,0,-body_height/2])rotate([0,45,0])cube([bottom_chamfer,body_depth+render_offset,bottom_chamfer],center=true);
        translate([-(body_width+catch_dia)/2,0,-body_height/2])rotate([0,45,0])cube([bottom_chamfer,body_depth+render_offset,bottom_chamfer],center=true);
        translate([0,-body_depth/2,-body_height/2])rotate([45,0,0])cube([body_width+render_offset, bottom_chamfer ,bottom_chamfer],center=true);
        translate([0,body_depth/2,-body_height/2])rotate([45,0,0])cube([body_width+render_offset, bottom_chamfer ,bottom_chamfer],center=true);     
    
    }//end difference
} // end module
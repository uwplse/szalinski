/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Milwaukee Dremel disc Holders
* Benjamen Johnson <workshop.electronsmith.com>
* 20190913
* Version 3
* openSCAD Version: 2015.03-2
*******************************************************************************/
/*[Global]*/

// Diameter of the disc (25 small, 33 large)
disc_dia = 21; 

// number of slots
num_slots = 3;

// width of the disc slot (front to back)
disc_slot_width = 10;

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
// width of the holder body
body_width = 82.5 ; // 82.5

// depth of holder 
body_depth = disc_slot_width+2*1.5; // 11

// height of holder
body_height = 28;

// length of slot (side to side)
slot_length = disc_dia;

// width of the bit slot (front to back)
slot_width = disc_slot_width;

// how much material to leave at the bottom of the bit slots
bottom_thickness = 2;

// how much to chamfer the ends
bottom_chamfer = 5;

//width of the finger slot
finger_width = 16;

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
    bottom_pos = bottom_thickness+ (33 - disc_dia);
    
    for (x=[start:step:end]){
        // cut the slots for the discs
        translate([x,0,-(body_height-disc_dia)/2+bottom_pos])rotate([90,0,0])cylinder(h=slot_width, d=disc_dia, center=true, $fn=50);
        translate([x,0,disc_dia/2+bottom_pos])cube([disc_dia,slot_width,body_height],center=true);
        
        // cut the finger holes
        translate([x,-4,-(body_height-disc_dia)/2+bottom_pos])rotate([90,0,0])cylinder(h=slot_width, d=finger_width, center=true, $fn=50);
        translate([x,-4,disc_dia/2+bottom_pos])cube([finger_width,slot_width,body_height],center=true);
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
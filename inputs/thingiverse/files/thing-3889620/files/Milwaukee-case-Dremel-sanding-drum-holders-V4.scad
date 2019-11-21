/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Milwaukee Dremel disc Holders
* Benjamen Johnson <workshop.electronsmith.com>
* 20190917
* Version 4
* openSCAD Version: 2015.03-2
*******************************************************************************/
/*[Global]*/
// number of slots for bits
num_slots = 4 ; //[1:12]

/*[Sanding Drum Parameters]*/
/******************************************************************************
*
*    ***    -------------------------
*  *  -  *---                        |
* * (   ) * small_drum_outer_dia   big_drum_inner_dia
*  *  -  *---                        |
*    ***    -------------------------
* | |  
*  wall_thickness
*
*******************************************************************************/
// inner diameter of the big sandring drums
big_drum_inner_dia = 12.75;

// outer_diameter of the small sanding drums
small_drum_outer_dia = 9;

// drum holder wall thickness
wall_thickness = 1;

/*[Expert: modify at your own risk]*/
//Sanding drum height (WARNING don't mess, it will break many things)
drum_height = 13;

// height of two drums minus a littel bit so you can pull out the little drums
drum_tower_height = drum_height*2 - 4; //22

// how much to cut out of the basic holder
cut_out_height = 8;

/*[Size Parameters]*/
/*******************************************************************************
*      +++++++   +++++++  +++++++  < ---- discs
*   -------------------------------  --
*  |                               |  body_height 
*  |                               |
*   -------------------------------  --
*  |< ------- body_width --------->|
*
*******************************************************************************/
// width of the holder body
body_width = 82.5 ; // 82.5

// depth of holder 
body_depth = 11; // 11

// height of holder
body_height = 12.5;

// how much material to leave at the bottom of the bit slots
bottom_thickness = 2;

// how much to chamfer the ends
bottom_chamfer = 5;

/* [Connector Parameters] */
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

// add a slight offset to cuts to make model render properly
render_offset = 0.05; //0.005


/*[Hidden]*/
pin_height = 10; // pin distance from the bottom of holder;
pin_pos = - body_height/2+pin_height;

//calculations for positioning the slots
min_edge = 5;
width2= body_width - 2 * min_edge;
step = width2 /(num_slots);
start = -width2/2+step/2;
end = width2/2;

union(){
    difference(){
        
        // make the basic holder
        MilwaukeeHolder();
        
        // cut out middle
        translate([0,0,cut_out_height])cube([width2,body_depth+render_offset,body_height],center=true);
    }// end difference
    
    // make the drum holders
    for (x=[start:step:end]){
        difference(){
            union(){
                // make outer body
                translate([x,0,-(body_height-drum_tower_height)/2+cut_out_height])cylinder(d=small_drum_outer_dia+2*wall_thickness,h=drum_tower_height,center=true,$fn=50);
                
                // make ribs 
                translate([x,0,-(body_height-drum_tower_height)/2+cut_out_height])rotate([0,0,45])cube([big_drum_inner_dia,1,drum_tower_height],center=true);
                translate([x,0,-(body_height-drum_tower_height)/2+cut_out_height])rotate([0,0,45])cube([1,big_drum_inner_dia,drum_tower_height],center=true);
            } //end union
        
        // cut out smaller drum holder
        translate([x,0,21.5])cylinder(d=small_drum_outer_dia,h=13,center=true,$fn=50);
        }// end difference
    }//end for

}// end union

module MilwaukeeHolder(){
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
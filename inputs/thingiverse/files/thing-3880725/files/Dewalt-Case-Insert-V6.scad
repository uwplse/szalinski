/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Dewalt ToughCase Bit Holders
* Benjamen Johnson <workshop.electronsmith.com>
* 20190925
* Version 6
* openSCAD Version: 2015.03-2
*******************************************************************************/
/* [Simple] */
// number of bit slots
num_slots= 9;

// Adjust the fit of the bits in the slots
fudge = 1.02;

/* [Expert] */
/*******************************************************************************
*      -----------------------------------   ------
*    \|                                   |/    |
*    /|                                   |\    |
*     |                                   |   width
*    \|                                   |/    | 
*    /|                                   |\    |
*      -----------------------------------   ------
*     |   <--------- length ---------->   |
*
*      -------------  -----    
*     |  :::   :::  |   |
*     |  :::   :::  |   |
*     |  :::   :::  | depth
*     |  :::   :::  |   | 
*     |  :::   :::  |   |
*      -------------  -----
*     | <- width -> | 
*
* Note: The dovetails are represented by colons. I'm ignoring that the
*       dovetails change in width for this diagram to make it simpler
*******************************************************************************/
// Length of insert not counting the dovetails (x direction)
width = 70.5;

// Width of insert (y direction)
height = 25;

// Depth of insert from the bottom of the case up(z direction)
depth = 15;

/*******************************************************************************
*    ---------   ---------  ---
*    \       /   \       /   |
*     \     /     \     /   dovetail_offset (offset from standard, not distance)
*      \   /       \   /     |
*    ---------------------- ---
*        | <--- ---> | -- dovetail_distance
*  --------------------------
*  |  :       :   :       :  |
*  |  :       :   :       :  | |   /
*  |   :     :     :     :   | |  /  <- dovetail_angle: the dovetails are wider
*  |   :     :     :     :   | | /      at the top than the bottom. They are 
*  |    :   :       :   :    | |/       defined by the with of the bottom and 
*  |    :   :       :   :    |          the angle.
*   ------------------------- 
*       |< >| -- dovetail_width_bottom
*
*******************************************************************************/
// distance between the dovetails
dovetail_distance = 11.7;

// width of the bottom part of the dovetail
dovetail_width_bottom = 7;

// the taper angle of the dovetails (bottom narrower than top)
dovetail_angle = 2.5;

// an adjustment for moving the dovetails in or out
dovetail_offset = 0.3;

//Add a small amount to cut peices to make the engine render properly
render_offset = 0.05;

/*[hidden]*/

//inches to mm conversion
in_to_mm = 25.4;

//bit size
bit_dia_points =.288*in_to_mm*fudge;
bit_dia_flats = .25*in_to_mm*fudge;

difference(){
    translate([0,0,-depth/2])difference(){
        union(){
            //Create main body
            cube([width,height,depth*2],center=true);
            
            //Create dovetails
            translate([-width/2-dovetail_offset,dovetail_distance/2,0])rotate([dovetail_angle,0,0])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            translate([-width/2-dovetail_offset,dovetail_distance/2,0])rotate([-dovetail_angle,0,0])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            
            translate([-width/2-dovetail_offset,-dovetail_distance/2,0])rotate([dovetail_angle,0,0])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            translate([-width/2-dovetail_offset,-dovetail_distance/2,0])rotate([-dovetail_angle,0,0])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            
            translate([width/2+dovetail_offset,dovetail_distance/2,0])rotate([dovetail_angle,0,180])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            translate([width/2+0.2,dovetail_distance/2,0])rotate([-3,0,180])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            
            translate([width/2+dovetail_offset,-dovetail_distance/2,0])rotate([dovetail_angle,0,180])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            translate([width/2+dovetail_offset,-dovetail_distance/2,0])rotate([-dovetail_angle,0,180])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
        } // end union
        
        // cut off bottom of holder
        translate([0,0,-(depth+10)/2]) cube([width+10,height+render_offset,depth+10],center=true);
    } //end difference
    
    min_edge = 1;
    width2= width - 2 * min_edge;
    step = width2 /(num_slots);
    start = -width2/2+step/2;
    end = width2/2;
        
    for (x=[start:step:end]){
        translate([x,0,0])BitHolder();
    } //end for
} //end difference

module BitHolder(){
    
    difference(){
        union(){
            // horizontal hole
            translate([0,1,3])rotate([90,30,0])cylinder(d=bit_dia_points, h=height, center=true,$fn=6);
            translate([0,10,6])rotate([90,0,0])cube([bit_dia_flats,bit_dia_flats,height], center=true);
        }// end union
        
        // keepers
        translate([bit_dia_flats/2,6,5.2])rotate([90,0,0])cylinder(d=0.5,h=4, center=true,$fn=20);
        translate([-bit_dia_flats/2,6,5.2])rotate([90,0,0])cylinder(d=0.5,h=4, center=true,$fn=20);
        } // end difference
    
    // vertical hole
    translate([0,-3,0])rotate([0,0,30])cylinder(d=bit_dia_points, h=depth+render_offset, center=true,$fn=6);
    translate([0,-8,-4])cube([bit_dia_flats,bit_dia_flats,depth], center=true);
}

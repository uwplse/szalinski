/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
* Dewalt Case Dividers
* Benjamen Johnson <workshop.electronsmith.com>
* 20190309
* Version 2
* openSCAD Version: 2015.03-2
*******************************************************************************/

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
length = 70.5;

// Width of insert (y direction)
width = 2;

// Depth of insert from the bottom of the case up(z direction)
depth = 16;

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
dovetail_distance = 0;

// width of the bottom part of the dovetail
dovetail_width_bottom = 6.8;

// the taper angle of the dovetails (bottom narrower than top)
dovetail_angle = 2.5;

// an adjustment for moving the dovetails in or out
dovetail_offset = 0.4;

/*******************************************************************************
* Custom parameters for the divder insert
*******************************************************************************/
// Divider height -- how high the divider extends above the insert (z direction)
divider_height = 19;

difference(){
    union(){
        //Create main body
        cube([length,width,depth*2],center=true);
            
        //Create upper divider
        translate([0,0,depth+divider_height/2])cube([length,width,divider_height],center=true);
            
        //Create dovetails
        translate([-length/2-dovetail_offset,dovetail_distance/2,0])rotate([dovetail_angle,0,0])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
        translate([-length/2-dovetail_offset,dovetail_distance/2,0])rotate([-dovetail_angle,0,0])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
            
        translate([length/2+dovetail_offset,dovetail_distance/2,0])rotate([dovetail_angle,0,180])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
        translate([length/2+0.2,dovetail_distance/2,0])rotate([-3,0,180])cylinder(d=dovetail_width_bottom,h=depth*2,center=true,$fn=3);
    } // end union
     
    // erase bottom half
    translate([0,0,-(depth+10)/2]) cube([length+10,width+10,depth+10],center=true);
} // end difference

/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Key for dovetail groove
* Benjamen Johnson <workshop.electronsmith.com>
* 20190703
* Version 1
* openSCAD Version: 2015.03-2 
*******************************************************************************/

/*******************************************************************************
        |<----   base   --->|
         ------------------- ---
angle ->|\                 /  |
        | \               /   height 
        |  \             /    |
             -----------     ---

         ------------------------------
        |                              |
        |                              |
        |                              |
         ------------------------------
        | <--------   length  -------->|
*******************************************************************************/
// base measurement of the dovetail
base = 11.7;

// height of the dovetail
height = 6.3;

// dovetail angle
angle = 14;

// length of the dovetail key
length = 30;

/*******************************************************************************

        ---                              --------  ---
      /     \ < -- bolt_pt_to_pt_dia    |        |  bolt_head_thickness
  --> \     /                            --------  ---
        ---                                |  |
                                       --> |  | <-- bolt_staft_dia
                                           |  |

*******************************************************************************/
// width of bolt head point to point
bolt_pt_to_pt_dia = 11.2;

// how thick is th bolt head
bolt_head_thickness = 3.9;

// bolt shaft diameter
bolt_shaft_dia = 5;

//calculate the coordinate for the narrow part of the dovetail
x=tan(angle)*height;

// Add a tiny amount to make holes render better
render_offset=0.005;

difference(){
    //form the dovetail
    rotate([-90,0,0])linear_extrude(height=length, center=true,convexity = 10) translate([-base/2,-height/2,0])polygon(points=[[0,0],[base,0],[base-x,height],[x,height]]);

    //drill the shaft hole
    cylinder(h=height+render_offset, d=bolt_shaft_dia, center=true, $fn=100);
    
    // inlay the bolt head
    rotate([0,0,30])translate([0,0,(height - bolt_head_thickness)/2])cylinder(h=bolt_head_thickness+render_offset, d=bolt_pt_to_pt_dia, center=true, $fn=6);
}
/**
 * Customizable SMD tray boxes
 * http://www.thingiverse.com/thing:1816077
 *
 * Original by GoolGaul (http://www.thingiverse.com/GoolGaul/about)
 * Original Thing: http://www.thingiverse.com/thing:56731
 *
 * Author: Dennis Schmitt <peppie23@gmail.com>
 */

// Max height if the rear trays in mm
max_height = 15;

// Set the max columns and rows
rows = 2;
cols = 4;

// Set the dimension of one tray in mm
tray_dim_x = 15;
tray_dim_y = 15;

// Set the space between each tray in mm
// A value lower or eq 0 will be set to 1mm
tray_space = 2;

// Set the thickness of the edge in mm
// A value lower or eq 0 will be set to 1mm
edge_thickness = 3;

// Set the bottom thickness in mm
// A value lower or eq 0 will be set to 1mm
box_bottom_thickness = 2;

// Enable or disable the flattening of the tray
// Values are true or false
box_flattening = true;

// Enable or disable stair stepping vor the bottom of the tray.
// Is this option is enabled the bottom of the rear trays will be higher
tray_stair_stepping = true;

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

difference()
{
    // check the minimum parameters for box_bottom_thickness,edge_thickness and tray_space
    box_bottom_thickness = (box_bottom_thickness<=0) ? 1:box_bottom_thickness;
    edge_thickness = (edge_thickness<=0) ? 1:edge_thickness;
    tray_space = (tray_space<=0) ? 1:tray_space;
    
    // some helper variables
    tray_spacer_x = (tray_dim_x+tray_space);
    tray_spacer_y = (tray_dim_y+tray_space);
    times2edge = 2*edge_thickness;
    box_dim_x = (rows*tray_spacer_x)-tray_space+times2edge;
    box_dim_y = (cols*tray_spacer_y)-tray_space+times2edge;
    stair_step_height = ((max_height-box_bottom_thickness)/(rows*1.5));
    
    // make base of tray
    cube([box_dim_x,box_dim_y,max_height]);

    // loop column and row trays
    for(row=[0:rows-1]){
        for (col=[0:cols-1]){
            stair_height = (tray_stair_stepping) ? ((rows-1)-row)*stair_step_height:0;
            translate([ edge_thickness+(row*tray_spacer_x),edge_thickness+(col*tray_spacer_y),box_bottom_thickness+stair_height])
            cube([ tray_dim_x, tray_dim_y, max_height]); 
        }
    }
    
    if(box_flattening){
        // rotate the cutter by asin
        arcsin = asin((max_height-(max_height*0.33))/box_dim_x);
        // place the cutter cube
        translate([-edge_thickness,-edge_thickness,max_height])
        rotate([0,arcsin,0])
        cube([(box_dim_x*2)+times2edge,box_dim_y+times2edge,max_height]);
    }
}
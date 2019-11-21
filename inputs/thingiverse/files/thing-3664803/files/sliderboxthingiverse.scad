// slider box maker - long, thin box with a sliding top and a divot on top for the thumbset
// ©2019 Jonathan Ziegler. All rights reserved.
// For individual use only. No commercial sales of this code nor any items made from this code without written permission from Jonathan Ziegler, 520-360-8293 (leave message), technoobscura@gmail.com,

// slider with stuff and stuff

// Slider Box Length (x axis). 10-500mm.
box_length_x = 100; // [10:1:500]
// Slider Box Width (y axis). 10-500mm.
box_width_y = 35; // [10:1:500]
// Box Height (z axis). 10-500mm.
box_height_z = 25;  // [10:1:500]
// Wall thickness. 2-25mm
wall_thickness = 4.0; // [2:0.1:25]
// Slider Top Thickness.
slider_thickness = 3.2; // [1:0.1:5]
// Margin of error. Takes from inside of slide grooves in the box. Depends on your printer/filament limits. For small/thin boxes, allow more. I rarely go over 0.25mm for any box. Larger boxes are usually pretty good with 0.185 or less.
wiggle_room = 0.185; 

/* [Hidden] */

slider_flange_thickness = ( 0.5 * wall_thickness ); 
slider_flange_width = ( 0.5 * slider_thickness );

// slider top

difference(){
    
rotate( [ 90, 0, 90 ] )
 linear_extrude( height = ( box_length_x - wall_thickness ), twist = 0, center = true ) { // begin linear extrude
 polygon( 
     points = [
        [ wiggle_room, 0 ],
        [ ( box_width_y - wall_thickness - wiggle_room ), 0 ],
        [ ( box_width_y - wall_thickness - slider_flange_width - wiggle_room ), slider_thickness ],
        [ slider_flange_width + wiggle_room, slider_thickness ], 
        [ wiggle_room, 0 ]
    ]
 );
 
 } // End linear extrude - // start thumbset code
 
 translate( [ ( ( box_length_x / 2 ) - 2 * wall_thickness ), ( ( ( box_width_y - 2 * wall_thickness ) / 2 ) + ( slider_flange_width ) ) , slider_thickness  ] )
 scale([ 8, 6, 2 ])
 difference(){
     sphere( d = 2, $fn = 96 ); // fixed 
     translate([1,0,0])
     cube( size = 2, center = true );
     } // end difference (thumbset code)
 
 } // end difference - slider top minus thumbset geometry

// box with slider slots

 translate( [ 0, -box_width_y/2 - wall_thickness, box_height_z/2 ] )
 
 difference(){ // subtract interior from solid box.
     cube( size = [ box_length_x, box_width_y, box_height_z ], center = true );
     union(){
         translate( [ 0, 0, ( box_height_z / 2 + wall_thickness ) ] )
         cube( size = [ ( box_length_x - 2 * wall_thickness ), ( box_width_y - 2 * wall_thickness ), ( 2 * box_height_z ) ], center = true );
         translate( [ ( wall_thickness - 2 * wiggle_room ), (-box_width_y+wall_thickness)/2, (box_height_z/2 - slider_thickness) ] )
         rotate( [ 90, 0, 90 ] )
          linear_extrude( height = ( box_length_x + 2 * wiggle_room ), twist = 0, center = true ) {
 polygon( 
     points = [
        [ 0, 0 ],
        [ ( box_width_y - wall_thickness + wiggle_room ), 0 ],
        [ ( box_width_y - wall_thickness - slider_flange_width + wiggle_room ), slider_thickness ],
        [ ( box_width_y - wall_thickness - slider_flange_width + wiggle_room ), 2*slider_thickness ],
        [ slider_flange_width - wiggle_room, 2*slider_thickness ],
        [ slider_flange_width - wiggle_room, slider_thickness ],
        [ 0, 0 ]
    ]
 );
 
 } // end linear extrude
 } // end union
 } // end difference
 
 

/*
*  Filename:    DC2416-Box.scad
*  Created by: Anhtien Nguyen
*  Date:  Aug 24, 2018
   Description: Design the box and cover for electronic board
 *  120/220 VAC to 24VDC power supply, model DC2416
*/


// Choose, which part you want to see!
part = "all_parts__";  //[all_parts__:All Parts,bottom_part__:Bottom,top_part__:Top]


// Dimensions for DC2416 is 65.5 x 115.5 x 35
width=65.5;//[29:87]
length = 115.5;//[53:160]
height=35; //[13:40]
lid_height = 10;//[5:15]

// Adjust for clearance, thickness, and wire holes
gap = 0.5;
thickness = 3;
hole_radius = 8;

// Program Section //
if(part == "bottom_part__") {
    box();
} else if(part == "top_part__") {
    box(width = width + gap*2 + thickness, length = length + gap*2+ thickness, height = lid_height + gap*2+ thickness,lid=true);
} else if(part == "all_parts__") {
    all_parts();
} else {
    all_parts();
}

module all_parts() {
// call the function for the bottom part
//
translate([0,0,(height+gap+thickness)/2]) box();
//
// call the function for the top part
//
translate([width+gap+(thickness*2)+10,0,(lid_height+gap*2+thickness*2)/2]) box(width = width + gap*2+ thickness, length = length + gap*2+ thickness, height = lid_height + gap*2+ thickness ,lid=true);
}
// special variable
dy = 20; // offset of the side hole
/*
 * Function box()
 * Draw the box without the top
 */
module box(width = width+gap, length = length+gap , height = height +gap, lid=false) {
    ow_width = width + thickness;
    ow_length= length + thickness;
    ow_height= height  + thickness;

//    rotate([0,0,45]) translate([-ow_width/2,-ow_length/2,0]) cube([10,10,ow_height+thickness*2],center=true);
    difference() {
        // define the box without the top
        union() 
        difference() {
                // outside wall
                intersection() {
                    cube([ow_width, ow_length, ow_height],center=true);
                }
                // inside wall
                 translate([0,0,thickness]) intersection() {
                   cube([width, length, height],center=true);
                 }
        } 
        
        // if it's the bottom part, punch two holes for the wires
        if(!lid) {
            rotate([90,0,90]) translate([length/2-dy,0,width/2]) cylinder(r=hole_radius,h=thickness*2,$fn=60,center=true);
            rotate([90,0,0]) translate([0,0, length/2]) cylinder(r=hole_radius,h=thickness*2,$fn=60,center=true);
        }
    }
}
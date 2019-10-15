/*
*  Created by: Anhtien Nguyen
*  Date:  June 9, 2018
   Description: Design the box and cover for electronic board
 *  120/220 VAC to 24VDC power supply, model DC2412
*/


// Choose, which part you want to see!
part = "all_parts__";  //[all_parts__:All Parts,bottom_part__:Bottom,top_part__:Top]


// Dimensions for DC2412 is 58 x 107 x 30
width=58.0;//[29:87]
length = 107;//[53:160]
height=30; //[13:40]
lid_height = 5;//[5:10]

// Adjust for clearance, thickness, and wire holes
gap = 1;
thickness = 2;
hole_radius = 5;

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
translate([width+gap+(thickness*2)+10,0,(lid_height+gap+thickness)/2]) box(width = width + gap*2+ thickness, length = length + gap*2+ thickness, height = lid_height + gap*2+ thickness ,lid=true);
}
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
            rotate([90,0,0]) translate([0,0,-length/2]) cylinder(r=hole_radius,h=thickness*2,$fn=60,center=true);
            rotate([90,0,0]) translate([0,0, length/2]) cylinder(r=hole_radius,h=thickness*2,$fn=60,center=true);
        }
    }
}
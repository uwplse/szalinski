switch_width = 14.1; // .1 for clearance

// outer cube itself
// total height of cube. be sure to factor in some play for the wires!
height = 22.5;
// total depth, or y value, of the cube
depth = 26.5;
// total width, or x value, of the cube
width = 21;
// thickness of longer walls on the cube
long_wall_thickness = 3;
// thickness of shorter walls on the cube
short_wall_thickness = 2;

// micro usb hole
// usb hole width
usb_width = 7.5;
// usb hole depth
usb_depth = depth;
// usb hole height
usb_height = 2;
// height from the bottom that the middle of the usb hole should be at
usb_height_offset = 6;

//top
//thickness of top plate that holds in the switch
top_thickness = 2;

//bottom
//bottom lip width
bottom_padding_width = 3;
// bottom lip depth
bottom_padding_depth = 3;
// bottom lip height. works a bit wonky right now; best to leave it at 1
bottom_padding_height = 1;

//amount of iterations to do for the switch holes. even numbers please! 4 = 2 on each side of the original
switch_hole_iterations = 4;

rotate([180,0,0]){
    difference(){
        cube([width,depth,height], center=true); // outside cube
        cube([width-long_wall_thickness,depth-short_wall_thickness,height], center = true); // inside cube
        
        translate([0,-depth/2,-height/2 + usb_height_offset])
        cube([usb_width,usb_depth,usb_height], center = true); // micro usb hole
    }
    
    // top
    translate([0,0,(height + top_thickness)/2])
    difference(){
        cube([width,depth,top_thickness], center = true);
        for (x = [0:switch_hole_iterations]){
            translate([19 * (x-switch_hole_iterations/2), 0, 0]) 
            cube([switch_width,switch_width,top_thickness], center = true);// switch hole
        }
    }
}

translate([0,depth + 10,-height/2 + (top_thickness + bottom_padding_height)/2 - top_thickness])
difference(){
    cube([width + bottom_padding_width,depth + bottom_padding_depth,top_thickness + bottom_padding_height], center = true);
    translate([0,0,bottom_padding_height]) cube([width+.1,depth+.1,top_thickness], center = true);
}
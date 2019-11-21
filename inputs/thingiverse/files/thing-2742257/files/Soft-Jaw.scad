thickness = 5;

width = 201;
height = 50;
depth = 17;

block_width = 191;
block_height = 43;
    
difference() {
    // Main body
    cube([width + 2*thickness, depth + 2*thickness, height + thickness]);
    
    // Cut out the jaw
    translate([thickness, thickness, thickness]) 
    cube([width, depth, height]);
    
    // Cut out the block
    translate([thickness + (width - block_width)/2, 0, thickness + height - block_height])
    cube([block_width, depth, block_height]);

    // Cut out the vertical guide
    translate([width/2 + thickness, depth + 2*thickness - sqrt(2*thickness*thickness)/2, 0])
    rotate([0,0,45])
    cube([thickness, thickness, height+thickness]);

    // Cut out the horizontal guide
    translate([0,depth + 2*thickness - sqrt(2*thickness*thickness)/2,height/2])
    rotate([-45,0,0])
    cube([width + 2*thickness, thickness, thickness]);
}
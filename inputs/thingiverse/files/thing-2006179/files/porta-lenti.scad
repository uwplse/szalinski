// Part 1: cassetta Lenti 

/// VARIABLES
height=5; //support height
width=50; //support width
depth=30; //support depth
box_height=50; //height of boxes
large_box_width=30; // the little one will be calculated by difference
thickness=1;
screw_head=3;
delta_mount_y=4;

// CALCULATED VARIABLES
invito=screw_head/4;
delta_wall=delta_mount_y+thickness;
small_box_width=width-large_box_width-4*thickness; // the little one will be calculated by difference
depth_boxes=depth-4*thickness;


// Porta Lenti grande
*rotate([180,0,0])
translate([1.5*thickness,thickness+1,-box_height+height+thickness])
difference(){
    union(){ translate([0,0,0])
            cube([large_box_width,depth_boxes,box_height]);
            translate([-2*thickness,-2*thickness,box_height])
            cube([large_box_width+(2*thickness),depth_boxes+(4*thickness),thickness]);}
   translate([thickness,thickness,thickness])
        cube([large_box_width-(2*thickness),depth_boxes-(2*thickness),box_height+8*thickness]);}

// Porta Lenti piccolo
*rotate([180,0,0])
translate([large_box_width+2.5*thickness,thickness+1,-box_height+height+thickness])
difference(){
    union(){ translate([0,0,0])
            cube([small_box_width,depth_boxes,box_height]);
            translate([-0*thickness,-2*thickness,box_height])
            cube([small_box_width+(2*thickness),depth_boxes+(4*thickness),thickness]);}
   translate([thickness,thickness,thickness])
        cube([small_box_width-(2*thickness),depth_boxes-(2*thickness),box_height+8*thickness]);}



// Inizio Struttura

// Porta Lenti
difference(){
    translate([0,-delta_wall,0])
        cube([width,depth+delta_wall,height]);
    translate([thickness,thickness,-1])
        cube([width-(2*thickness),depth-(2*thickness),height+2]);}


// Wall mount
translate([0,thickness-delta_wall,0])
rotate([90,0,1]) 
difference(){
    hull(){
        cube([width,height,thickness*2]);
        translate([width/2,depth,thickness]) sphere(thickness);}
    translate([width/2,depth*0.8,-1]) cylinder(height+2,screw_head,invito);
    translate([width*.8,depth*0.30]) cylinder(height+2,screw_head,invito);
    translate([width*.2,depth*0.30]) cylinder(height+2,screw_head,invito);
    }
    
    
    

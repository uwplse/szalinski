// License:  Creative Commons Attribtion
// https://creativecommons.org/licenses/by/3.0/

// Author: Brownzaero, 20-Dec-2016
// LED Strip Frame for Monitor

// Dimensions in [mm]

// General Dimensions
$fn = 50*1;
// thickness of printed body in mm
thickness = 3.2;          

// thickness of monitor towards desired edge
monitor_thickness = 26;   
// width of monitor border
monitor_lip = 14;          
monitor_width = 560*1;        // just for fun
monitor_height = 400*1;       // just for fun

// length of LED Strip
LED_length = 153;
// width of LED Strip
LED_width = 9.6;
// thickness of LED strip
LED_thickness = 3.2;
// diameter of LED
LED_diameter = 3.2;
// distance between LEDs
LED_spacing = 31.75*0.5;
// distance from start of strip to first LED
LED_start = thickness+25.4*0.25; 

// Chip Dimensions
chip_length = 36*1;        // length of the circuit board
chip_width = 18*1;         // width of the circuit board
chip_thickness = 3.2*1;    // thickness of the circuit board

// Frame Dimensions
frame_width = monitor_thickness + 2*thickness;
frame_length = LED_length + 2*thickness;
frame_height_base = monitor_lip + thickness;
frame_height = LED_width + thickness;

// hole diameter needed for bolts in the back
back_bolt_hole_diameter = 6;   
// width of the nut across flats for the back bolt
nut_width_across_flats = 9;  
// thickness of nut. this will determine nut trap sizing.
nut_thickness = 5;              
trap_square_size = nut_width_across_flats + 2*thickness;
trap_height = nut_thickness + thickness;
// distance from center of trap to edge
trap_edge_distance = 6.35;          

module pre_frame(){
    // frame base
    cube([frame_length,frame_width,frame_height_base,],center=true);
        
    // frame top
    translate([-frame_length/2,-frame_width/2,frame_height_base/2])
        rotate([90,0,90])
            linear_extrude(height=frame_length,center=false)
            polygon([[0,0],[frame_width,0],[thickness,frame_height],[0,frame_height]], [[0,1,2,3]]);
    
    // left nut trap
    translate([trap_square_size/2-frame_length/2+trap_edge_distance,frame_width/2+trap_height/2,trap_square_size/2-frame_height_base/2]) 
        rotate([-90,0,0]) 
            nut_trap_no_bolt();

    // right nut trap
    translate([-trap_square_size/2+frame_length/2-trap_edge_distance,frame_width/2+trap_height/2,trap_square_size/2-frame_height_base/2]) 
        rotate([-90,0,0]) 
            nut_trap_no_bolt();
}

module frame_holes(){
    // frame top hole
    translate([0,thickness,frame_height_base/2+frame_height/2])
        cube([frame_length-2*thickness,frame_width,frame_height],center=true);
    
    // frame monitor hole
    translate([0,0,-thickness])
        cube([frame_length*2,frame_width-2*thickness,frame_height_base],center=true);
    
    // right bolt hole
    translate([-trap_square_size/2+frame_length/2-trap_edge_distance,frame_width/2+trap_height+1,0]) 
        rotate([90,0,0])
            cylinder(h=trap_height*3+thickness,d=back_bolt_hole_diameter,center=true);
    
    // left bolt hole
    translate([trap_square_size/2-frame_length/2+trap_edge_distance,frame_width/2+trap_height+1,0]) 
        rotate([90,0,0])
            cylinder(h=trap_height*3+thickness,d=back_bolt_hole_diameter,center=true);
    
    // iterate to get the LED holes
    translate([0,0,frame_height_base/2+frame_height/2]){
        rotate([90,0,0]){
            for (i=[-frame_length/2+LED_start:LED_spacing:frame_length/2-thickness]) {
                translate([i,0,0])
                    cylinder(h=100,d=LED_diameter,center=true);
            }
        }
    }
}

module frame(){
    difference(){
        pre_frame();
        frame_holes();
    }
}

module monitor(){
    // modeling a monitor just for fun
    difference(){
        color("dimgray")
        cube([monitor_width,monitor_thickness,monitor_height],center=true);
        color("darkslategray")
        translate([0,-monitor_thickness/2-5,0])
        cube([monitor_width-2*monitor_lip,monitor_thickness,monitor_height-2*monitor_lip],center=true);
    }
}
module nut_trap_no_bolt(){
    difference(){
        // main cube for nut trap
        cube([trap_square_size,trap_square_size,trap_height],center=true);
        // cube cutout for the nut to slide in
        translate([0,0,-thickness/2])
            cube([nut_width_across_flats,trap_square_size*2,nut_thickness],center=true);
    }
}
module assembled_frame(){
    frame();
    // LED Strip
    translate([0,LED_thickness/2-frame_width/2+thickness*1.5,frame_height_base/2+LED_width/2+thickness*0.1])
        cube([LED_length,LED_thickness,LED_width],center=true);
    // chip
    translate([0,5,frame_height_base/2+thickness*0.1])
    cube([chip_length,chip_width,chip_thickness],center=true);
}
module complete_assembly(){
    translate([0.1,0.1,-0.1]) monitor();
    translate([0,0,monitor_height/2-frame_height_base/2+thickness]) assembled_frame();
    translate([monitor_width/2-frame_height_base/2+thickness,0,0]) rotate([0,90,0]) assembled_frame();
}
//complete_assembly();
rotate([0,0,0]) frame();


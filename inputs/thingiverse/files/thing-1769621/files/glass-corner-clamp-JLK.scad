//
// Glass Corner Clip for Prusa i2
// 
// Default setup is for 214mm x 214mm
// heated bed with 200mm x 213mm Borosilicate Glass
//
// Enter your own dimensions to customize the clips
//
// Created by Jody Krivohlavek
// 09/12/2016
// V1.0

// Variable declarations

clip_side = 14;          // width and length of the clip
clip_hold = 0.5;         // thickness of holding layer on top of the glass
glass_width = 213;       // width of glass (X Axis)
glass_length = 200;      // length of glass (Y Axis)
glass_thickness = 3.3;   // thickness of glass surface
bed_hole_width = 209;    // width of hole spacing on heated bed
bed_hole_length = 209;   // length of hole spacing on heated bed
bed_hole_diameter = 3.2; // bed hole diameter
bed_width = 214;         // width of heated bed (X Axis)
bed_length = 214;        // length of heated bed (Y Axis)


// Call Modules

// Original Left Front Corner
translate([-(clip_side+2),-(clip_side+2),0]){
    cornerclip();
}

// Right Front Corner
translate([clip_side+2,-(clip_side+2),0]){
    scale([-1,1,1]) cornerclip();
}

// Left Rear Corner
translate([-(clip_side+2),clip_side+2,0]){
    scale([1,-1,1]) cornerclip();
}

// Right Rear Corner
translate([clip_side+2,clip_side+2,0]){
    scale([-1,-1,1]) cornerclip();
}

// Module code

module cornerclip(){
    
    difference(){
        
        // Base cube of part
        
        polyhedron(
        points=[[0,0,0], [clip_side,0,0], [0,clip_side,0],
          [0,0,clip_hold+glass_thickness],
          [clip_side,0,clip_hold+glass_thickness],
          [0,clip_side,clip_hold+glass_thickness]],
        faces=[[0,3,4,1],[1,4,5,2],[0,2,5,3],[0,1,2],[3,5,4]]
        );

        
        // Parts cut out of Base
        union(){
            
            // Cut out for Glass Plate
            translate([(bed_width-glass_width+2)/2,(bed_length-glass_length)/2,clip_hold])
              #cube([clip_side,clip_side,glass_thickness+1]);
            
            // Heated Bed mounting hole
            translate([(bed_width-bed_hole_width+2)/2,(bed_length-bed_hole_length)/2,-1])
              #cylinder(h = glass_thickness+clip_hold+2, r = bed_hole_diameter/2, $fn = 36);
            
        }
    }
}
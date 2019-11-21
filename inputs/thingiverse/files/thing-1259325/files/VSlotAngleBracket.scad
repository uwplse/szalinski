/*
Aluminum Extrusion 90 Degree corner bracket
Parametric
Author: BinaryConstruct
*/

/* [Basic] */

// length
size_x = 1; // [1:4]

// width
size_y = 2; // [1:4]

// height
size_z = 1; // [1:4]

// include extra diagonals
incremental_supports = 1; // [0:1]

// include alignment studs
alignment_studs = 1; // [0:1]

// slot holes
slot_holes = 1; // [0:1]

// screw hole diameter
hole_d = 5.2;


/* [Advanced] */
// thickness of base plates
plate_thickness = 3; // [2:4]

// thickenss of angled support
side_thickenss = 3; // [2:4]

// size of extrusion increment (20mm)
base_size = 20;

// size of alignement stud
alignment_stud_diameter = 5; 
alignment_stud_height = 1;
slot_length = 4;

difference()
{
    union(){
        difference(){
            cube([size_x * base_size,size_y * base_size,size_z * base_size]);
            
            // hollow cut
            translate([plate_thickness,side_thickenss,plate_thickness]) {
                cube([size_x * base_size, (size_y * base_size) - (side_thickenss * 2),base_size * size_z]);
            }
        }
        
        if (incremental_supports == 1) {
            for (y=[base_size : base_size : (size_y-1) * base_size])
                translate([0,y-side_thickenss/2,z])
                cube([size_x * base_size,side_thickenss,size_z * base_size]);
        }
        
        if (alignment_studs == 1) {
            // vertical holes
            for(z=[base_size / 2 : base_size : (size_z * base_size) - (base_size / 2)])
            for(y=[base_size / 2 : base_size : (size_y * base_size) - (base_size / 2)])
            {
                translate([0,y,z-alignment_stud_diameter]) 
                rotate([0,90,0]) 
                translate([0,0,-alignment_stud_height]) 
                { cylinder($fn=16, r=alignment_stud_diameter/2,h=alignment_stud_height); }
                
                translate([0,y,z+alignment_stud_diameter]) 
                rotate([0,90,0]) 
                translate([0,0,-alignment_stud_height]) 
                { cylinder($fn=16, r=alignment_stud_diameter/2,h=alignment_stud_height); }
            }
        }
    }
    
    // diagonal cut   
    translate([plate_thickness/2,size_y * base_size+1,plate_thickness/2])
    rotate([90,0,0])
        linear_extrude(size_y * base_size+2) {
            polygon([
                [size_x * base_size,0], 
                [size_x * base_size,size_z * base_size],
                [0,size_z * base_size]]);
        }
      
    // bottom holes
    for(x=[base_size / 2  : base_size : (size_x * base_size) - (base_size / 2)])
    for(y=[base_size / 2  : base_size : (size_y * base_size) - (base_size / 2)])
    {
        
        translate([x,y,-plate_thickness/2])
        union()
        { 
            cylinder($fn=16, r=hole_d/2,h=plate_thickness*2); 
            if (slot_holes == 1) {
                
                translate([0,-hole_d/2,0])
                cube([slot_length,hole_d,plate_thickness*2]);
                
                translate([slot_length,0,0])
                cylinder($fn=16, r=hole_d/2,h=plate_thickness*2); 
            }
        }
    }

    // vertical holes
    for(z=[base_size / 2 : base_size : (size_z * base_size) - (base_size / 2)])
    for(y=[base_size / 2 : base_size : (size_y * base_size) - (base_size / 2)])
    {
        translate([0,y,z]) 
        rotate([0,90,0]) 
        translate([0,0,-plate_thickness/2]) 
        { cylinder($fn=16, r=hole_d/2,h=plate_thickness*2); }
    }

}


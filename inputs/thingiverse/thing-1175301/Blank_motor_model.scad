///VARIABLES

//Overall width.
cube_x = 42.3; //[10:0.1:100]
//Width to the chamfer - if none, just keep it the same as the x value.
cube_y = 33; //[10:0.1:100]
//Depth OR Length of the motor
cube_z = 39.8; //[10:0.1:100]

//The large slightly protruding inner cylinder that surrounds the shaft
cyl_dia = 22; //[10:0.1:100]
//Amount by which the inner cylinder protrudes above the flat top of the motor
cyl_extra_height = 2;

//Shaft diameter
shaft_dia = 5;
//Shaft length above the top of the main flat of the motor -- NOT the protruding cylinder
shaft_length = 24;

//The diameter of the threaded inserts
retain_dia = 3.5;
//Overall seperation of the centers of the threaded retaining holes 
retain_placement = 31; 
//How deep the holes extend into the body, set to zero to remove
retain_depth = 15;


//Variables - Inner
retain_spacing = retain_placement/2;
cyl_resolution = 64*1;






///RENDERS
difference(){
union(){
hull(){
wide_cube();
tall_cube();
}

large_cylinder();
shaft();
}

retain_all();
}

///MODULES
module retain_all(){
    translate([0,0,(cube_z/2) - (retain_depth/2) + 1]){   
    retain_double();
    mirror([0,1,0]){
           retain_double();
        }
    }
}

module retain_double(){
    retain_single();
    mirror([1,0,0]){
        retain_single();
    }
}

module retain_single(){
    translate([retain_spacing,retain_spacing,0]){
        cylinder(h = retain_depth + 1, d = retain_dia, center = true, $fn = cyl_resolution); 
    }
}


module wide_cube(){
    
    cube([cube_x,cube_y,cube_z], center = true);
    
}

module tall_cube(){
       
    rotate([0,0,90]){
        wide_cube();
    }
    
}

module large_cylinder(){
    translate([0,0,(cube_z/2) - 1]){
        cylinder(h = cyl_extra_height + 1, d = cyl_dia, center = true, $fn = cyl_resolution); 
    }
}

module shaft(){
    translate([0,0,(cube_z/2) + (shaft_length/2)]){
        cylinder(h = shaft_length, d = shaft_dia, center = true, $fn = cyl_resolution); 
    }
    
}
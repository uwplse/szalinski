// Started on 2019/08/27 
// Ended on 2019/08/28
// Made by anv3d
// PLEASE give credit if used!
//v1.4

// c = cube 
// f = frame


/* [Cube] */

// Number of cubes (default 5) Note: If not enough cubes show up, try decreasing 'f_w' variable, or increasing 'c_size' variable.
num_cubes = 5; 

// Size of the biggest cube. (default 50)
c_size = 50; 

// Width of the cube frame. (default 4)
f_w = 4; 

// Round radius of outside. (default 2)
f_rad_o = 2; 

// Round radius of inner cuts. (default 2)
f_rad_i = 2; 

// Resolution. (lower to test for faster rendering, raise for final model and higher quality)
fn = 10; 

/* [Base] */

// Enables or disables a base to display on a corner. (1-true, 0-false)
base = 1;    

// Base size modifier. Not a measurement. (default 10)
b_mod = 10; 

// Thickness of the base. (default 4)
b_thickness = 4;

// Diameter of the base. (default 60)
b_diameter = 60; 

// Number of sides on the base. (default 6)
b_sides = 6; 


/* [Hidden] */
dec = f_w;
//c_size = cube_size+f_w*2;
// Modules 

module rCube(x,y,z,rd,fn){ // From HullCube.scad
    $fn=fn;
    hull(){
        translate([rd,rd,rd]) sphere(rd);
        translate([x-rd,rd,rd]) sphere(rd);
        translate([x-rd,y-rd,rd]) sphere(rd);
        translate([rd,y-rd,rd]) sphere(rd);
        translate([rd,rd,z-rd]) sphere(rd);
        translate([x-rd,rd,z-rd]) sphere(rd);
        translate([x-rd,y-rd,z-rd]) sphere(rd);
        translate([rd,y-rd,z-rd]) sphere(rd);
    }
}
module cubeF(cs,ro,f_width){ // Cube frame
    difference(){
        rCube(cs,cs,cs,ro,fn);
        
        translate([f_width,f_width,-cs/2]) rCube(cs-(f_width*2),cs-(f_width*2),cs*2,f_rad_i,fn);
    
        
        rotate([90,0,0])translate([f_width,f_width,-cs*1.5])  rCube(cs-(f_width*2),cs-(f_width*2),cs*2,f_rad_i,fn);
        
        rotate([0,90,0])translate([-cs+f_width,f_width,-cs/2])  rCube(cs-(f_width*2),cs-(f_width*2),cs*2,f_rad_i,fn);
    }
}

module cubeT(n){
    for(i=[1:n]){
        translate([dec*(i-1),dec*(i-1),dec*(i-1)]) cubeF((c_size+(dec*2))-((dec*i)*2),f_rad_o,f_w*1.5);
    }
}
module stand(){
    difference(){
        union(){
    
           hull(){
               translate([f_rad_o,f_rad_o,f_rad_o]) sphere(r=f_rad_o,$fn=fn);
               translate([f_rad_o,f_rad_o,c_size-f_rad_o]) sphere(r=f_rad_o,$fn=fn);
               translate([f_rad_o-b_mod,f_rad_o-b_mod,f_rad_o]) sphere(r=f_rad_o,$fn=fn);
               rotate([180,90-35.3,45]) translate([0,0,b_thickness]) sphere(r=f_rad_o,$fn=fn);
       
           }
       
           hull(){
               translate([f_rad_o,f_rad_o,f_rad_o]) sphere(r=f_rad_o,$fn=fn);
               translate([f_rad_o,c_size-f_rad_o,f_rad_o]) sphere(r=f_rad_o,$fn=fn);
               translate([f_rad_o-b_mod,f_rad_o,f_rad_o-b_mod]) sphere(r=f_rad_o,$fn=fn);
               rotate([180,90-35.3,45]) translate([0,0,b_thickness]) sphere(r=f_rad_o,$fn=fn);
           
           }
       
           hull(){
               translate([f_rad_o,f_rad_o,f_rad_o]) sphere(r=f_rad_o,$fn=fn);
               translate([c_size-f_rad_o,f_rad_o,f_rad_o]) sphere(r=f_rad_o,$fn=fn);
               translate([f_rad_o,f_rad_o-b_mod,f_rad_o-b_mod]) sphere(r=f_rad_o,$fn=fn);
               rotate([180,90-35.3,45]) translate([0,0,b_thickness]) sphere(r=f_rad_o,$fn=fn);
           
           }
       }
       rotate([180,90-35.3,45]) translate([0,0,-f_w*0.5]) cylinder(d=b_diameter,h=b_mod*2); // flatten base
    }
    rotate([180,90-35.3,45]) translate([0,0,-f_w*0.5]) cylinder(d=b_diameter,h=b_thickness,$fn=b_sides); // base cylinder
}

/* Run */
cubeT(num_cubes); // cubes
if (base==1){
    stand();
}

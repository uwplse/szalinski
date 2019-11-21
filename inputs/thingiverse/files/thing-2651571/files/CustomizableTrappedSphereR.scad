
/* [Trapped Sphere] */

// Scales the whole thing by number
Scale = 1;

// Resolution
$fn = 100;

// Cube 
cubeSize = 20;

// Round radius
rds=1;

// Hole diameter (doesn't work if too small)
hole = 13.5;

// ball size
ball = 20;

// Sphere Hole size
sphereHole = 22;
// Rounded Cube Module //
// Created by @skitcher //


  module rCube(x,y,z,rd,fn){
    $fn=fn;
    
    
    hull(){
        translate([rd,rd,rd]) sphere(r=rd);
        translate([x-rd,rd,rd]) sphere(r=rd);
        translate([rd,y-rd,rd]) sphere(r=rd);
        translate([rd,rd,z-rd]) sphere(r=rd);
        
        translate([x-rd,y-rd,rd]) sphere(r=rd);
        translate([x-rd,rd,z-rd]) sphere(r=rd);
        translate([x-rd,y-rd,z-rd]) sphere(r=rd);
        
        translate([rd,y-rd,z-rd]) sphere(r=rd);
    }    
}


module TrappedCube(){
    //Cube with holes
    difference(){
        //cube
        color("lightgrey") rCube(cubeSize*Scale,cubeSize*Scale,cubeSize*Scale,rds,$fn);
        
        //cylinder 1
        color("lightgreen") translate([cubeSize/2*Scale, cubeSize/2*Scale, -1]) cylinder(r=hole/2*Scale, h=cubeSize*Scale+2);
        
        //cylinder 2
       color("lightgreen")  translate([cubeSize/2*Scale, -1, cubeSize/2*Scale]) rotate([-90, 0, 0]) cylinder(r=hole/2*Scale, h=cubeSize*Scale+2);
        
        //cylinder 3
         color("lightgreen") translate([-1, cubeSize/2*Scale, cubeSize/2*Scale]) rotate([0, 90, 0]) cylinder(r=hole/2*Scale, h=cubeSize*Scale+2);
        
        //sphereHole
        color("lightblue") translate([cubeSize/2*Scale, cubeSize/2*Scale, cubeSize/2*Scale]) sphere(sphereHole/2*Scale);
    }
    
    //The ball
    color("white") translate([cubeSize/2*Scale, cubeSize/2*Scale, cubeSize/2*Scale]) sphere(ball/2*Scale);
}

TrappedCube();
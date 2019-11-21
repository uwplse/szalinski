//Soda Bottle/Pipe Coupler, customizer compatible

//modified from MrWhat's PET soda bottle coupler code, sure was a pleasure to dig through all of the unrelated bits


// cap/mount for PET bottle, usually 16oz, 20oz, 1l, 2l
include <mcad/shapes.scad>

threadOD = 27.4; 
threadID = 24.7;
neckD = 21.4;

// pipe being coupled to
pipeOD=9.525; 

hexag=1;//adds a hexagon shape to the outside, prevents rolling when dropped

gap=5;//gap between threading and pipe, useful for poi project which has components sticking out of bottle
// thread base width 2.2
threadPitch = 2.9;//3.2;
nTurns = 2.3;
toLip = 13;

threadDepth = (threadOD-threadID)/2;

//------------------------------------------------------------


difference(){
    union(){
        translate([0,0,gap])translate([0,0,3])difference(){
            translate([0,0,-3])cylinder(toLip,threadOD/2+2,threadOD/2+2);
            PETtop();
            }
            
       hull(){
            cylinder(5,threadOD/2+2,threadOD/2+2);
            mirror([0,0,1]){
                translate([0,0,19])cylinder(1,pipeOD/2+2,pipeOD/2+2);       
            }
       }
       // cylinder(r=threadID/2-.2,h=4,$fn=100);
    }
  mirror([0,0,1])translate([0,0,-10])cylinder(30,pipeOD/2,pipeOD/2);  
}

if (hexag==1){
    difference(){
        translate([0,0,toLip/2+gap/2])hexagon(threadOD+5,toLip+gap);
        cylinder(toLip+gap, threadOD/2,threadOD/2);
        }
        difference(){
            hull(){
                translate([0,0,.5])hexagon(threadOD+5,1);
                mirror([0,0,1]){
                    translate([0,0,19])cylinder(1,pipeOD/2+2,pipeOD/2+2);       
                }   
            }
        
            mirror([0,0,1])translate([0,0,-10])cylinder(30,pipeOD/2,pipeOD/2); 
        }
}
//------------------------------------------------------------

module PETtop() union() {
  translate([0,0,-2.9]) cylinder(r=threadID/2+3,h=3,$fn=100);

  cylinder(r=threadID/2-.2,h=toLip,$fn=100);

  // can't really do a hull to make threads thicker, so
  // just repeat them.  Its not perfect, but you won't be able
  // to tell by the time it gets through the slicer
  for(offst=[.4,.7,1]) translate([0,0,3.25-offst])
    linear_extrude(height=nTurns*threadPitch,twist=-nTurns*360)
      translate([threadDepth,0,0]) circle(r=threadID/2 + threadDepth/2);
}
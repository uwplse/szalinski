// clip to hold pipe (or shelving) off the wall at fixed distance
// Alexander Hulpke, 12/2014

// Diameter Of Held Pipe (mm)
pipe_diameter=19.5;

// Clip-wall Thickness (mm)
thick=2.5;

// Height Of Clip (mm)
height=15;

// Distance The Pipe Should Be Kept From Wall (mm)
wall_distance=18;

// Radius Of Rounded Corner (mm)
corner_radius=3;

// Radius Of Screw Hole (mm)
hole_radius=1.9;

// Rendering Fineness ($fn)
fineness=100;

//rotate for nicer view
rotate(a=180,v=[0,0,1]) {
difference() {
  union(){
rotate(a=45,v=[0,0,1]) {difference() {
  cylinder(r=pipe_diameter/2+thick,h=height,$fn=fineness);
  cylinder(r=pipe_diameter/2+0.2,h=height,$fn=fineness);
  translate(v=[pipe_diameter/20,pipe_diameter/20,0]) {cube(pipe_diameter);}
}}
  translate(v=[-pipe_diameter/2+corner_radius/2,-pipe_diameter/2-wall_distance,0]) {
    minkowski() {
      cube(size=[pipe_diameter-corner_radius,wall_distance-corner_radius,height/2]);
      cylinder(r=corner_radius,h=height/2);
    }
  }
}
  translate(v=[0,0,height/2]) {
   rotate(a=90,v=[1,0,0]) {
     cylinder(r=hole_radius,h=pipe_diameter+wall_distance);
     cylinder(r1=pipe_diameter/2,r2=hole_radius,h=pipe_diameter/2+1.5*thick,$fn=fineness);
   }}
  translate(v=[-0.75*pipe_diameter,-pipe_diameter/2-3*corner_radius,height/3-3.5])  cube(size=[1.5*pipe_diameter,2,4]);
  translate(v=[-0.75*pipe_diameter,-pipe_diameter/2-3*corner_radius,2*height/3-0.5])  cube(size=[1.5*pipe_diameter,2,4]);
}
}

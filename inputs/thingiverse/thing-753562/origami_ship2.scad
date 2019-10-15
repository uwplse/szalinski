/*
   origami ship

   Kit Wallace

*/
// length of bow from centre
lb=15; 
// height of bow
hb=12;
// width midships
wm=5; 
// height midships
hm=3; 
// waterline length e.g. from centre eg. half length of bow
wl=7.5; 
// width of hull from centre
wh=2; 
// height of sail
h=10; 
//Thickness of paper
thickness=1;
// sphere quality
steps = 20;
// overall scale
scale=5;


module double(axis) { 
      union() {
          children();
          mirror(axis) children();
      }
  }
module plane(s,t=0.5) {
    hull()
    for (i=[0:len(s) -1])
       translate(s[i]) sphere(t/2);     
    } 

module ground(size=50) {
   translate([0,0,-size]) cube(2*size,center=true);
}

p1=[lb,0,hb];
p2=[wl,0,0];
p3=[0,wm,hm];
p5=[0,0,h];
p4=[0,wh,0];

module ship_q(t) {
   plane([p1,p2,p3],t);
   plane([p2,p3,p4],t);
   plane([p4,p2,p5],t);
};

$fn=steps;
scale(scale) 
 difference() {
  double([0,1,0]) 
     double([1,0,0]) 
         ship_q(thickness); 
 * ground();
 }

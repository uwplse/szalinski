Cubesize=30;
Sphereradius=15;
hole=20;
highstand=2;
radiusstand=5;
difference() {
cube(Cubesize,center=true);
color("red"){
sphere(hole,$fn=100);}}
union(){
color("red");
sphere(Sphereradius,$fn=100);
translate([0,0,-Sphereradius]){
cylinder(h=highstand,r=radiusstand);
}}
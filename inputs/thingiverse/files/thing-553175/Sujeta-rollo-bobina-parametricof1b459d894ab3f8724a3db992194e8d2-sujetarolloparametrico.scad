// Porta bobinas de filamento parametrico
// para Prusa i3 RepRap
// Parametric spool holder for Prusa i3 RepRap
// --by www.Bioplastic3d.es November,2014

//Variables Description
Grosor_Marco=5;//[5:18]
grosor=Grosor_Marco+1;
Altura_Marco=40;//[35:80]
altura=Altura_Marco;

difference(){
union(){
linear_extrude(height=16,center=true)
union(){
difference(){
difference(){
square([altura+8,grosor+8],center=true);
square([altura+0.25,grosor+0.25],center=true);
}

color("red")
translate([2,grosor-2,0])
square([altura-6,grosor],center=true);}
color("red")
translate([altura+4,0,0])
square([altura,grosor+8],center=true);
}

color("green")
translate([70,0,0])
cube(16, center=true);



color("blue")

translate([altura+50,106,2.4])
rotate([-30,-90,106])
difference (){ 
  
difference (){

difference (){
rotate([0,0,30])
cylinder(r1=12,r2=12,h=125,$fn=6);
for (i=[0:4]){
translate([0,0,12+i*20])
rotate([-78,0,0])
cylinder(r=6,h=500,center=true);}}

for (i=[0:3]){
translate([0,0,12+i*20])
rotate([0,90,0])
cylinder(r=6,h=50,center=true);}}

}}
translate([altura+4,0,0])
rotate([90,0,0])
cylinder(r=5,h=60,center=true);
translate([altura-9,0,0])
rotate([90,0,0])
cylinder(r=5,h=60,center=true);}
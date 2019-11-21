echo ("Copyright 2017 Nevit Dilmen");
echo ("Creative Commons Attribution Share Alike");


sides = 7; //Number of sides
step= 360/sides ;
knotdiameter = 19.7; // Hexagonal knot hole diameter (Corner to corner)

difference () {
difference () {

//Star
minkowski(){
for (angle=[0:step:360]) {
linear_extrude (1){
hull() {
rotate ([0,0,angle])
translate ([30,0,0]) 
circle (d=25);
circle (d=27);
}}}
sphere(3);
}

// Center hole

linear_extrude (20, center=true){
circle (d=22.3 , $fn=50); // hole diameter
}
}
//Holes
for (i=[0:step:360]) {
linear_extrude (11, center=true){
rotate ([0,0,i])
translate ([30,0,0])
circle (d=knotdiameter, $fn=6); // hexagon diameter
}
}
}






//Hive storage by jeremie rioux
$fn = 6;

//variable en millimetre
//the width and length have to be the same number; if not, it will create a stretched hive.
width_length=0;
height=0;

resize(newsize=[width_length,width_length,height]){
difference(){
cylinder(r=25, h=100);
cylinder(r=23, h=100); 
   
}
difference() {
translate([37.5,21.5,0])
cylinder(r=25,h=100);
translate([37.5,21.5,0])
cylinder(r=23,h=100);
}
translate([0,43,0]){
difference(){
cylinder(r=25, h=100);
cylinder(r=23, h=100); 
   
}
difference() {
translate([37.5,21.5,0])
cylinder(r=25,h=100);
translate([37.5,21.5,0])
cylinder(r=23,h=100);
}
}
translate([-37.5,64.5,0]){
difference() {
translate([37.5,21.5,0])
cylinder(r=25,h=100);
translate([37.5,21.5,0])
cylinder(r=23,h=100);
}
}
translate([37,21.5,0]){
difference() {
translate([37.5,21.5,0])
cylinder(r=25,h=100);
translate([37.5,21.5,0])
cylinder(r=23,h=100);
}
}
}
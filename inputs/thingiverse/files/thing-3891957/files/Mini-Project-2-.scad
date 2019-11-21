// Katherine Wendt
// Customizable Lego Head
//MSE 4777 Oct 2019

//Depending on the bolt size you want, you can take the bolt head height, bolt overall length, and diameter and divide them from 60 to get a scalable bolt size. Or you can just omit the bolt alltogether

hmain=60; //main cylinder height

hradius=hmain/2; //main cylinder bottom radius

hsecond=hmain/2.4; //top cylinder height

hsradius=hmain/4; //top cylinder lower radius

eye=hmain/6; //eye sphere radius


B=25;

// Bolt head height
h=8;

// Bolt overall length
l=69.5;

// diamter
d=11;


difference() {
difference() {
union() {
cylinder(hmain,hradius,hradius, false);
translate([0,0,hmain-10]) {
    cylinder(hsecond,hsradius,hsradius);
}
}
translate([hmain/1.7,hmain/4.6,hmain/1.7]) {
    sphere(eye);
}
translate([hmain/1.7,-hmain/4.6,hmain/1.7]) {
    sphere(eye);
}
translate([hmain/1.7,0,hmain/4]) {
    cylinder(hmain/6, hmain/6,hmain/4);
}
}


$fn=100;
union(){
		translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
		cylinder(h=l, r=d/2); // bolt shaft
		}
					}
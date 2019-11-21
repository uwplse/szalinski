//Rison's snowman project

use <write/Write.scad>
parts_to_render=13;//[1:top_sphere,2:middle_sphere,3:bottom_sphere,4:eye,5:mouth,6:nose,7:left_arm,8:right_arm,9:hat,10:nail,11:preview_assemble,12:preview_exploded,13:production]
Render_Quality = 24;// [24:Draft,60:production]
Project_Size = 111; // [100:250]
$fn=Render_Quality;

//BODY
module middle_sphere(){

color("white")sphere(30);
}
module bottom_sphere(){
 translate([0,0,-50])
 {
 color("white")sphere(40);
 }
}
module top_sphere(){
 translate([0,0,40])
 {
 color("white")sphere(20)
 ;}
}



//EYE
module eye()
 {
 translate([17,-9,45])color("black")cube([4,4,4],center=true);
 translate([17,9,45])color("black")cube([4,4,4],center=true);
}

//MOUTH
module mouth()
{
translate([20,0,35])color("black")cube([2,2,2],center=true);

translate([20,2,35])color("black")cube([2,2,2],center=true);

translate([20,3,35])color("black")cube([2,2,2],center=true);

translate([20,3,35])color("black")cube([2,2,2],center=true);

translate([20,-3,35])color("black")cube([2,2,2],center=true);

translate([20,-2,35])color("black")cube([2,2,2],center=true);
}


//NOSE
module nose(){
translate([28,0,42])
 {
 color("red")rotate(a=90,v=[0,-1,0])cylinder(r1=.01,r2=2,h=10);
 }
}

//ARM
module right_arm(){
 translate ([0,20,0])
 {
 rotate(a=90,v=[0,-1,1])color("brown")cube  ([50,3,3]);
 }
}
module left_arm() {
translate([0,-20,0])
 {
 rotate(a=-90,v=[0,-1,1])color("brown")cube([50,3,3]);
 }
}



//HAT
module hat(){
 translate([0,0,57]){
 rotate(a=30,v=[0,0,0])color("blue")cylinder(r= 15,h=2);
 }
 translate([0,0,57])
 {
 color("blue")cylinder(r=10,h=20); 
 }
}

//NAIL

module nail(){
 translate([0,24,50])
 {
 rotate(a=90,v=[1,0,0])
 color("gray")cylinder(r=2,h=50);
 }
 translate([0,-31,50])
 {
 rotate(a=90,v=[-1,0,0])
 color("gray")cylinder(r1=.01,r2=2,h=5);
 }
 translate([0,23,50])
 {
 rotate(a=90,v=[-1,0,0])color("gray")cylinder(r =4,h=3);
 }
}
scale([Project_Size/scale_factor, Project_Size/scale_factor, Project_Size/scale_factor]) {
	if (parts_to_render == 1) {
		top_sphere();
	}
	if (parts_to_render == 2) {
		middle_sphere();
	}
	if (parts_to_render == 3) {
		bottom_sphere();
	}
	if (parts_to_render == 4) {
		eye();
	}
	if (parts_to_render == 5) {
		mouth ();
	}
	if (parts_to_render == 6) {
		nose();
	}
	if (parts_to_render == 7) {
		right_arm();
	}
	if (parts_to_render == 8) {
		left_arm();
	}
	if (parts_to_render == 9) {
		hat();
	}
	if (parts_to_render == 10) {
		nail();
	}
}


if (parts_to_render==11){
	//everything laying out
	translate ([0,-50,-20]) {top_sphere();}
	translate ([-90,-45,0]) {middle_sphere();}
	translate ([-50,30,50]) {bottom_sphere();}
	translate ([0,0,0]) {eye();}
	translate ([0,0,0]) {mouth();}
   translate ([0,0,0]) {nose();}
	translate ([-50,-50,30]) {right_arm();}
	translate ([-50,0,50]) {left_arm();}
	translate ([40,0,80]) { rotate(a=180,v=[1,0,0])hat();}
	translate ([0,60,0]) { rotate(a=-30,v=[1,0,0])nail();}
}

if (parts_to_render==12){
//explode mode
	translate ([0,0,15]) {top_sphere();}
	translate ([0,0,0]) {middle_sphere();}
	translate ([0,0,-25]) {bottom_sphere();}
	translate ([10,0,0]) {eye();}
	translate ([0,0,0]) {mouth();}
   translate ([40,0,0]) {nose();}
	translate ([0,-20,0]) {left_arm();}
	translate ([0,20,0]) {right_arm();}
	translate ([0,0,40]) { hat();}
	translate ([0,60,0]) { nail();}
}

if (parts_to_render==13){
	top_sphere();
	middle_sphere();
	bottom_sphere();
	eye();
	mouth();
   nose();
	left_arm();
	right_arm();
	hat();
   nail();
}


	


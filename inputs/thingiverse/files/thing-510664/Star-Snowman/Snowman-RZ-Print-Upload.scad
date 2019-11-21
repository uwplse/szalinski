//Robin Zuo

//
// The parameters below may be changed by the customizer
//
// BEGIN CUSTOMIZER

/* [Snowman Parameters] */

//select part(s) to render
part_to_render = 5; //[1:body, 2:branches, 3:hat, 4:nose, 5:preview_assembled, 6:preview_exploded, 7:all]

//Draft for preview, prduction for final
Render_Quality = 60; //[24:Draft,60:production]

//approx. height when assembled, mm
Project_Size = 80; // [65:125]

// END CUSTOMIZER

//
// The parameters below are not meant to be changed by the customizer
//

$fn=Render_Quality;
scale_factor = 64 * 1;


module body() {
union(){
difference(){
	sphere(r = 20, center = true);//bottom sphere
	translate([0,-20,0])cube([40,5,40], center = true);
}

difference(){
	translate([0,25,0])sphere(r = 15, center = true); //middle sphere
	translate([-14,26,0])rotate([0,90,150])cylinder(r1=2,r2=2,h=4.5); //hole for arm
	translate([14,26,0])rotate([0,90,30])cylinder(r1=2, r2=2, h=4.5);//hole for arm
}

difference(){
	translate([0,44,0])sphere(r = 10, center = true); //top sphere

	translate([-2,42,9.8])cube([4,4,4]); //surface to put nose

	translate([-10,53,-10])cube([20,20,20]);//surface to put hat
}

translate([0,0,19.3])
linear_extrude(height = 1)
polygon([
[5 * cos(162), 5 * sin(162)],
[5 * cos(18), 5 * sin(18)], 
[5 * cos(234), 5 * sin(234)],
[0,5],
[5 * cos(306), 5 * sin(306)]],
[[0,1,2,3,4]], center = true); //STAR!!!

translate([0,25,14.3])
linear_extrude(height = 1)
polygon([
[3.5 * cos(162), 3.5 * sin(162)],
[3.5 * cos(18), 3.5 * sin(18)], 
[3.5 * cos(234), 3.5 * sin(234)],
[0,3.5],
[3.5 * cos(306), 3.5 * sin(306)]],
[[0,1,2,3,4]], center = true); //STAR!!!
//

translate([-3,41.125,8.5])rotate([30,0,0])linear_extrude(height = 1)circle(0.5);//mouth

translate([-1.5,40.28125,8.6])rotate([30,0,0])linear_extrude(height = 1)circle(0.5);//mouth

translate([0,40,8.7])rotate([30,0,0])linear_extrude(height = 1)circle(0.5);//mouth

translate([1.5,40.28125,8.6])rotate([30,0,0])linear_extrude(height = 1)circle(0.5);//mouth

translate([3,41.125,8.5])rotate([30,0,0])linear_extrude(height = 1)circle(0.5);//mouth

//function: y = (1 / 8) * x ^ 2
//

translate([-4,48,7.8])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([-6,48,6.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([-2,48,8.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([-4,50,6.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([-4,46,8.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

//

translate([4,48,7.8])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([6,48,6.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([2,48,8.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([4,50,6.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye

translate([4,46,8.3])rotate([-30,0,0])linear_extrude(height = 1)circle(0.5);//eye
}
}

//in the honor of sec derivative.... even it does not look like that.....
//

module nose(){
	translate([25,-17.5,0])rotate([270,0,0])cylinder(r1 = 2, r2 = 0.5, h = 5);//nose
}

module branchesL(){
translate([65,-17.5,0])rotate([270,0,0])cylinder(r1=2, r2=0.5, h=20); //arm: y = -0.58x + 17.9

translate([65,-10.5,0])rotate([50,30,170])cylinder(r1=1,r2=0.5,h=8); //branch

translate([65,-5.5,0])rotate([170,-30,120])cylinder(r1=1,r2=0.5,h=5); //branch
}

module branchesR(){
translate([55,-17.5,0])rotate([270,0,0])cylinder(r1=2, r2=0.5, h=20); //arm: y = 0.58x + 17.9

translate([55,-10.5,0])rotate([50,30,170])cylinder(r1=1,r2=0.5,h=8); //branch

translate([55,-5.5,0])rotate([170,-30,120])cylinder(r1=1,r2=0.5,h=5); //branch

}
//

module hat(){
translate([40,-17.3,0])rotate([270,0,0])cylinder(r1 = 5, r2 = 5, h = 10);//cylinder part of the hat

difference(){
translate([40,-16.5,0])rotate([90,0,0])linear_extrude(height = 1)circle(10);//edge of the hat

translate([40,-16.5,0])rotate([90,0,0])linear_extrude(height = 1)circle(4.5);//edge of the hat
}
}

rotate([90,0,0]){
scale ([Project_Size/scale_factor, Project_Size/scale_factor, Project_Size/scale_factor]){
if(part_to_render == 1) {
	body();
}
if(part_to_render == 2) {
	
	translate([10,0,0])branchesL();
	translate([60,-17.3,0])rotate([90,0,0])cylinder(r1 = 5, r2 = 5, h = 1);
	translate([5,0,0])branchesR();
	translate([75,-17.3,0])rotate([90,0,0])cylinder(r1 = 5, r2 = 5, h = 1);
}
if(part_to_render == 3) {
	hat();
}
if(part_to_render == 4) {
	nose();
}
if(part_to_render == 5) {
	body();
	translate([-25,44,27])rotate([90,0,0])nose();
	translate([-40,70,0])hat();

	translate([-27,35,55])rotate([0,90,55])branchesR();

	translate([27,35,65])rotate([0,90,-55])branchesL();
}

if(part_to_render == 6) {
	body();
	translate([-25,44,32])rotate([90,0,0])nose();
	translate([-40,75,0])hat();
	translate([-30,36,55])rotate([0,90,55])branchesR();
	translate([30,36,65])rotate([0,90,-55])branchesL();
}
	
if(part_to_render == 7) {
	body();
	translate([10,0,0])branchesL();
	translate([5,0,0])branchesR();
	nose();
	hat();
	translate([60,-17.3,0])rotate([90,0,0])cylinder(r1 = 5, r2 = 5, h = 1);
translate([75,-17.3,0])rotate([90,0,0])cylinder(r1 = 5, r2 = 5, h = 1);
}
} //end scale
}
// The parameters below may be changed by the customizer
//
// BEGIN CUSTOMIZER


//select part(s) to render
part_to_render = 3; //[1:body, 2:uplegs, 3:all]

//Draft for preview, prduction for final
Render_Quality = 60; //[24:Draft,60:production]

//approx. height when assembled, mm
Project_Size = 100; // [65:125]

// END CUSTOMIZER

//
// The parameters below are not meant to be changed by the customizer

$fn = Render_Quality;

module body(){
difference(){
union(){
translate([0,8,90])
scale([1.2,1.2,1.2])
union(){
//head
difference(){
union(){
translate([0,0,0])
sphere(20);
scale([1.08,1,0.8])
translate([0,0,-4])
sphere(20);
}
translate([0,-20,-10])//mouth
scale([1.2,1.2,1.2])
difference(){
cylinder(5,4,0);
    translate([5,0,5])
    sphere(5);
    translate([-5,0,5])
    sphere(5);
}
}
rotate([5,0,0])
//eyes
union(){
scale([0.8,1,1])
translate([9,-13,8])
rotate([90,0,20])
difference(){
cylinder(5,5,5);
    translate([0,0,4.7])
    cylinder(0.4,3.5,3.5);
}
scale([0.8,1,1])
translate([-9,-13,8])
rotate([90,0,-20])
difference(){
cylinder(5,5,5);
    translate([0,0,4.7])
    cylinder(0.4,3.5,3.5);
}
}

//ears
rotate([20,-40,0])
translate([0,0,19])
difference(){
difference(){
cylinder(7,4,0);
    translate([-5,-10,-0.1])
    cube([10,10,7]);
}
translate([0,0,-0.5])
cylinder(4,3,0);
}
rotate([20,40,0])
translate([0,0,19])
difference(){
difference(){
cylinder(7,4,0);
    translate([-5,-10,-0.1])
    cube([10,10,7]);
}
translate([0,0,-0.5])
cylinder(4,3,0);
}
}
//body
difference(){
    translate([0,0,7])
union(){
    
//back

difference(){
cylinder(60,30,30);
    translate([-35,-70,-0.1])
    cube([70,70,71]);
}
difference(){
difference(){
scale([0.712,0.78,0.86])
translate([0,-5,45])
sphere(50);
translate([-50,-100,0])
cube([100,100,100]);
}
cylinder(60,50,50);
}
difference(){
    translate([0,0,40])
        sphere(50);
    translate([-50,-50,0])
    cube([100,100,90]);
        
}
//up-legs
translate([20,0,60])
sphere(10);
translate([-20,0,60])
sphere(10);



translate([0,0,-10])
//front
difference(){
scale([0.86,1.05,1.16])
difference(){
translate([0,30,40])
sphere(50);
    translate([-50,0,-10])
    cube([100,100,100]);
}
translate([30,-10,0])
cube([70,70,70]);
translate([-100,-10,0])
cube([70,70,70]);
}

//down-legs
translate([-19,0,5])
sphere(13);
translate([19,0,5])
sphere(13);
translate([-19,0,5])
rotate([90,0,14])
union(){
cylinder(26,13,13);
translate([0,0,26])
sphere(13);
}
translate([19,0,5])
rotate([90,0,-14])
union(){
cylinder(26,13,13);
translate([0,0,26])
sphere(13);
}
//tail
translate([0,24,-3])
sphere(5);
translate([0,33,-3])
rotate([90,0,0])
union(){
cylinder(8,5,5);
sphere(5);
}
}
translate([-100,-100,-200])
cube([200,200,200]);
}
}

translate([20,0,67])
rotate([90,0,0])
cylinder(100,3,3);
translate([-20,0,67])
rotate([90,0,0])
cylinder(100,3,3);


}
//nose
translate([0,-18,90])
sphere(3);
}
module uplegs(){
//up-leg
translate([-20,-15,70])
rotate([-90,90,0])
union(){
difference(){
union(){
translate([0,0,11.5])
rotate([0,40,0])
cylinder(5,3,3);
translate([0,0,11])
sphere(3.2);
cylinder(10,10,10);
sphere(10);
}
translate([-10,-10,-28])
cube([20,20,20]);
scale([0.8,1,1])
translate([2,0,-8.1])
cylinder(1,3,3);
scale([1,0.8,1])
translate([-2,4,-8.1])
cylinder(1,2,2);
scale([1,0.8,1])
translate([-2,-4,-8.1])
cylinder(1,2,2);
scale([1,0.8,1])
translate([-3.5,0,-8.1])
cylinder(1,2,2);
}
}
translate([20,-15,70])
rotate([-90,90,0])
union(){
difference(){
union(){
translate([0,0,11.5])
rotate([0,40,0])
cylinder(5,3,3);
translate([0,0,11])
sphere(3.2);
cylinder(10,10,10);
sphere(10);
}
translate([-10,-10,-28])
cube([20,20,20]);
scale([0.8,1,1])
translate([2,0,-8.1])
cylinder(1,3,3);
scale([1,0.8,1])
translate([-2,4,-8.1])
cylinder(1,2,2);
scale([1,0.8,1])
translate([-2,-4,-8.1])
cylinder(1,2,2);
scale([1,0.8,1])
translate([-3.5,0,-8.1])
cylinder(1,2,2);
}
}
}

module all() {
    union(){
		body();
        uplegs();
        }
	}
    
scale([Project_Size/scale_factor, Project_Size/scale_factor, Project_Size/scale_factor]) {

	if (part_to_render == 1) {
		body();
	}
	if (part_to_render == 2) {
		uplegs();
	}
    if (part_to_render == 3) {
        all();
}
}
//end scale
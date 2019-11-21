//
//Customizable snow man
//
//My contibutions are:
//
//1. Made it all into a single oprnscad program, and make it costomizable.
//2. You can reveiw every individual parts and model view or printable view, every single parts are printable.
//3. You can choose the height, collors, render quality, and every individual parts you want. 
//4. If you want to print that snow man, you need to print the printable view program, because that is printable and you do not need any supports.
//
use <write/Write.scad>

//
// The parameters below many be changed bu the customier
//
// BEGIN CUSTOMIZER

/*[Snow man parameters]*/

//select part(s) to render
parts_to_render = 6;// [1:hat, 2:head, 3:nose, 4:body, 5:modelview, 6:printableview]

//Draft for preview, production for final 
Render_Quality = 24;	// [24:Draft,60:production]

// mm
// approx. height when assembled, mm
Project_Size = 111; // [50:200]

// END CUSTOMIZER


//
// The parameters below are not meant to be changed by the customizer
//
$fn = Render_Quality;
module hat(){
	difference() {
		union(){
rotate([0,0,110]){
color("black"){
	translate([-15,-15,91])
		rotate([-90,90,-90])
			cube([2,30,30],center=ture);
translate([0,0,100])
	cylinder(r=8,h=20,center=true);
			
		}
	}
}
}
}

module head(){
	difference(){
		union(){
rotate([0,0,110]){
			translate([0,0,25]){
difference(){
color("snow"){
translate([0,0,55])
	sphere(r=13, center=true);
			}

}
// snow man's eye, i rotate that, let it be printable
color("black"){
	translate([-10.2,-5.5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
	translate([-10.2,5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
			 }
// snow man's mouth, i rotate them, let them be printable
color("black"){
	translate([-12,-3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,0,51.6])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
}
//nose
color("orangered"){
	translate([-17,0,57])	
		rotate([-90,0,90])
		cylinder(h=9,r1=1.7,r2=0,center=true);
	}

}
}
	}		
}
}
module body(){
difference() {
union(){
// three sphere which are snow man's body and head
rotate([0,0,110]){
color("snow"){
	sphere(r=25,center=true);
translate([0,0,32])
	sphere(r=18.7,center=true);
}
color("deepskyblue"){
	translate([0,0,-20])
		cylinder(r=25,h=10,center=true);
					}

			color("black"){
translate([0, 26, 46])
		rotate([50,0,180])
			cylinder(r=2.15,h=35,center=true);
	translate([0, -26, 46])
		rotate([-50,0,-180])
			cylinder(r=2.15,h=35,center=true);
				
		}
	}
}

}
}
module nose(){
	union(){ 
rotate([0,0,110]){
		color("orangered"){
	translate([-17.3,0,81.7])	
		cylinder(h=9,r1=1.7,r2=0,center=true);
	}
}
}
}


module modelview(){
difference() {
union(){
// three sphere which are snow man's body and head
rotate([0,0,110]){
translate([0,0,25]){
difference(){
color("snow"){
	sphere(r=25,center=true);
translate([0,0,32])
	sphere(r=18.7,center=true);
translate([0,0,55])
	sphere(r=13, center=true);
			}
translate([0,0,66.5])
	cylinder(r=10,h=5,center=true);
}
// snow man's eye, i rotate that, let it be printable
color("black"){
	translate([-10.2,-5.5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
	translate([-10.2,5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
			 }
// snow man's mouth, i rotate them, let them be printable
color("black"){
	translate([-12,-3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,0,51.6])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);

// snow man's arm
	translate([0, 26, 46])
		rotate([50,0,180])
			cylinder(r=2.15,h=35,center=true);
	translate([0, -26, 46])
		rotate([-50,0,-180])
			cylinder(r=2.15,h=35,center=true);
			}

}
// the bottom of snow man, let the sphere be printable
color("deepskyblue"){
	translate([0,0,5])
		cylinder(r=25,h=10,center=true);
					}
// snow man's nose
color("orangered"){
	translate([-17.3,0,81.7])	
		rotate([-90,0,90])
		cylinder(h=9,r1=1.7,r2=0,center=true);
// this is a cylinder which is flat, snow man's nose can be connected on that.
translate([-12.13,0,81.7])
	rotate([0,90,0])
		cylinder(r=1.7,h=1.7,center=true);
}
// snow man's hat.
color("black"){
	translate([-15,-15,91])
		rotate([-90,90,-90])
			cube([2,30,30],center=ture);
translate([0,0,100])
	cylinder(r=8,h=20,center=true);

			}
	}
}
}
}

	

module printableview(){
difference() {
union(){
rotate([0,0,110]){
// three sphere which are snow man's body and head
translate([0,0,25]){
difference(){
color("snow"){
	sphere(r=25,center=true);
translate([0,0,32])
	sphere(r=18.7,center=true);
translate([0,0,55])
	sphere(r=13, center=true);
			}
translate([0,0,66.5])
	cylinder(r=10,h=5,center=true);
}
// snow man's eye, i rotate that, let it be printable
color("black"){
	translate([-10.2,-5.5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
	translate([-10.2,5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
			 }
// snow man's mouth, i rotate them, let them be printable
color("black"){
	translate([-12,-3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,0,51.6])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);

// snow man's arm
	translate([0, 26, 46])
		rotate([50,0,180])
			cylinder(r=2.15,h=35,center=true);
	translate([0, -26, 46])
		rotate([-50,0,-180])
			cylinder(r=2.15,h=35,center=true);
			}

}
// the bottom of snow man, let the sphere be printable
color("deepskyblue"){
	translate([0,0,5])
		cylinder(r=25,h=10,center=true);
					}
// snow man's nose
color("orangered"){
	translate([-18,50,4.5])	
		cylinder(h=9,r1=1.7,r2=0,center=true);
// this is a cylinder which is flat, snow man's nose can be connected on that.
translate([-12.13,0,81.7])
	rotate([0,90,0])
		cylinder(r=1.7,h=1.7,center=true);
}
// snow man's hat.
color("black"){
	translate([3,-65,2])
		rotate([-90,90,-90])
			cube([2,30,30],center=ture);
translate([18,-50,10])
	cylinder(r=8,h=20,center=true);

			}
	}
}
}
}

scale([Project_Size/scale_factor, Project_Size/scale_factor, Project_Size/scale_factor]) {

	if (parts_to_render == 1) {
		hat();
	}
	if (parts_to_render == 2) {
		head();
	}
	if (parts_to_render == 3) {
		nose();
	}
	if (parts_to_render == 4) {
		body();
	}

    if (parts_to_render == 5) {
		modelview();
	}
	if (parts_to_render == 6) {
		printableview();
	}
}// end scale
//
// The parameters below may be changed by the customizer.
//
// BEGIN CUSTOMIZER

/* [Snowman Parameters] */

//select part(s) to render
part_to_render = 3; //[1:front, 2:back, 3:all]

//Draft for preview, production for final
Render_Quality = 24; //[24:Draft,60:production]

//approx. height when assembled, mm
Project_Size = 125; // [70:125]

// END CUSTOMIZER


//
// The parameters below are not meant to be changed by the customizer.
//

//split();

sizing_factor = 70*1;
module split() {

//splits everything except for face

	translate([80,0,0])
	rotate([0,270,0]) difference() {
		body();
		translate([-250,0,0]) cube([500,1000,1000], center=true);
	 }


	translate([-30,0,0])
	rotate([0,270,0]) difference() {
		body();
		translate([-250,0,0]) cube([500,1000,1000], center=true);
	 }
}


module body (){

scale([1.5,1.5,1.5]) {

	color("white"){

	difference() {
		//bottom sphere
			sphere(r = 15, center = true);
			translate([10,0,-27]){
    				cube(30,30,30, center = true);
			}
	}

	//middle sphere
		translate([0,0,18]){ 
			sphere(r = 12);
		}

	//head
		translate([0,0,33]){
 			sphere(r = 9);
		}
	}

//arms
	translate([0,11,20]){
		rotate([-45,0,0])
		color("saddleBrown") cylinder(h = 17, r = 1.5);
		}
	translate([0,-10,20]){
		rotate([45,0,0])
		color("saddleBrown") cylinder(h = 17, r = 1.5);
		}

//hat
	translate([0,0,41]){
		color("black") cylinder(h = 1.5, r = 10);
	}
	translate([0,0,41]){
		color("black") cylinder(9,6,6);
	}

//scarf
	translate([0,0,26]){
		color("fireBrick") cylinder(4,10,10);
	}


//gloves
	translate([0,21,30]){
		rotate([-40,0,0])
		color("navy") cylinder(5,3,2);
	}
	translate([0,-20,30]){
		rotate([40,0,0])
		color("navy") cylinder(5,3,2);
	}

}

}

module face(){
scale([1.5,1.5,1.5]) {
//nose
	translate([17.5,0,7]){
		rotate([0,360,0])
		color("darkOrange") cylinder(8,1.7,0.2);
		}

//eyes
	translate([14.5,2,6]){
		color("black") cube([2,2,2]);
	}
		translate([14.5,-4,6]){
		color("black") cube([2,2,2]);
	}

//mouth
		translate([18,4.5,6]){
		color("black") cube([1.5,1.5,1.5]);
	}
		translate([18,-6,6]){
		color("black") cube([1.5,1.5,1.5]);
	}
		translate([19.5,-3,7.5]){
		color("black") cube([1.5,1.5,1.5]);
	}
		translate([19.5,2,7.5]){
		color("black") cube([1.5,1.5,1.5]);
	}
		translate([20.5,-0.5,8]){
		color("black") cube([1.5,1.5,1.5]);
	}
}
}

scale([Project_Size/sizing_factor, Project_Size/sizing_factor, Project_Size/sizing_factor]){
	if (part_to_render == 1){
		face();
		translate([80,0,0])
		rotate([0,270,0]) difference() {
		body();
		translate([-250,0,0]) cube([500,1000,1000], center=true);
	 	}
	}

	if (part_to_render == 2){
		translate([-30,0,0])
		rotate([0,270,0]) difference() {
		body();
		translate([-250,0,0]) cube([500,1000,1000], center=true);
	 }
	}


	if (part_to_render == 3){
		split();
		face();
	}
}
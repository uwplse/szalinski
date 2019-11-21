//HR Snowman



// BEGIN CUSTOMIZER

/* [Snowman Parameters] */

//Draft for preview, production for final
Render_Quality = 20; 	// [25:Draft, 50:Production]

//height of entire snowman(mm)
object_height = 90; //  [80:100]

//select parts to render
parts_to_render = 4; // [1:hat, 2:middle_snowballs, 3:bottom_snowball, 4:preview_assembled, 5:preview_exploded, 6:preview_printable]

// END CUSTOMIZER



$fn=Render_Quality;
scalingFactor = (object_height/94);
scale([scalingFactor, scalingFactor, scalingFactor]){
	if(parts_to_render == 1){
		 hat();
	}
	if(parts_to_render == 2){
		middleBack();
		middleFront();
	}
	if(parts_to_render == 3){
		 bottom();
	}
	if(parts_to_render == 4){
		model();
	}
	if(parts_to_render ==5){
		translate([0, 0, -2]) bottom();
		translate([0,0,5]) middleBack();
		translate([0,0,5]) middleFront();
		translate([0,0, 10]) hat();
	}
	if(parts_to_render ==6){
		split();
	}
}

//split(); 

//orients the four pieces correctly and to the x-axis
module split() {
	translate([-80, 0,47]) bottom();
	translate([-40,0,-1]) rotate([90,0,90]) middleBack();
	translate([40,0,1]) rotate([-90,0,90]) middleFront();
	translate([80,0,-31.95]) hat();
}

//lower sphere
module bottom(){
	difference(){
		model();
		translate([0,0, 20]) cube([60, 60,61.7], center = true);
	}
}

//back half of the middle and top spheres
module middleBack(){
	difference(){
		model();
		bottom();
		translate([0,0, 59.5]) cube([50,50, 55], center = true);
		translate([0, -10, 0]) cube([60, 22, 70], center = true); 
	}
}

//front half of the middle and top spheres
module middleFront(){
	difference(){
		model();
		bottom();
		translate([0,0, 59.5]) cube([50,50, 55], center = true);
		translate([0, 10, 0]) cube([60, 18, 70], center = true); 
	}
}

//top hat
module hat(){
	difference(){
		model();
		translate([0, 0, -23]) cube([60, 60, 110], center = true);
	}
}

//original model of the snowman
module model() {

//variables for smile
	smilex = -2.3;
	smiley = -0;	
	smilez = .6; 

//snow balls
	union(){
	//buttons
	
	if(parts_to_render != 1 && parts_to_render != 3 && parts_to_render != 5){
		for(y=[-1:1]){
		color("mediumvioletred") 
	polyhedron(points=[ [0,-13.5+abs(y)*.5,2+4*y], [-2,-13.5+abs(y)*.5,-1+4*y], [2,-13.5+abs(y)*.5,-1+4*y], [0,-15.5+abs(y)*.5,2+4*y], [-2,-15.5+abs(y)*.5,-1+4*y], [2,-15.5+abs(y)*.5,-1+4*y]],
faces = [[0,1,2], [3,5,4], [1,4,5], [1,5,2], [1,0,3], [4,1,3], [0,5,3], [0,2,5]]);
		}
	}

		//middle ball
		color("white" )sphere(r = 15, center=true);


		//bottom ball
		difference(){
			color("white") translate([0,0,-29]) sphere(r=21, center = true);
			color("white") translate([0,0, -51]) cube([35,35,8], center = true);
		}

		//top ball
		color("white") translate([0,0,22]) sphere(r=12, center = true);

		
	}

//nose
	translate([0, -14, 23]) rotate([-90,0,0]) color("darkorange") cylinder(h = 10, r1 = .1, r2 = 3, center = true);

//eyes
	color("black") minkowski(){
		translate([4, -10.5, 27]) cube(1,1,1);
		rotate([-90, 0, 0]) cylinder(r=1,1.7);
	}
	color("black") minkowski(){
		translate([-5, -10.5, 27]) cube(1,1,1);
		rotate([-90, 0, 0]) cylinder(r=1,1.7);
	}

//smile
	for(x= [-3:3]){
		color("black") minkowski(){
			translate([smilex*x-.35, smiley*abs(x)-10.75, smilez*x*x+15]) cube(.7,.7,.7);
			rotate([-90, 0, 0]) cylinder(r=.7,.7);
		}
	}

//arms
//right
	color("saddlebrown") union(){
		translate([20, 0,2.8]) rotate([0,70,0]) cylinder(18, r=2.1, r=1, center = true);
		translate([24, 0, 4.5]) rotate([0,40,0]) cylinder(4, r1=1, r2=.8);
		translate([23.7,0, 4]) rotate([0,100,0]) cylinder(4, r1=1, r2 = .8); 
	}
//left
	color("saddlebrown") union(){
		translate([-20, 0,2.8]) rotate([0,-70,0]) cylinder(18, r=2.1, r=1, center = true);
		translate([-24, 0, 4.5]) rotate([0,-40,0]) cylinder(4, r1=1, r2=.8);
		translate([-23.7,0, 4]) rotate([0,-100,0]) cylinder(4, r1=1, r2 = .8); 
	}	


//hat
	color("grey") translate([0,0, 33]) cylinder(13, r= 8);
	color("grey") translate([0,0, 32]) cylinder(2, r=12);
	color("indigo") translate([0,0,33]) cylinder(4, r=8.1);
}


	
	
	
//Android Figure
//To test out openSCAD
//by FrankkieNL (and Google)

// preview[view:south, tilt:top diagonal]

//vars
$fn=50;
//Height of Body (39)
body_height = 39; //[35:50]
//Radius of Body (22.5)
body_r = 22.5; //[21.5:Thin, 22.5:Normal, 23.5:Fat, 24.5:Extra Fat]
//Length of Neck (4)
neck_height = 4; //[1:10]
//Radius of Neck (20)
neck_r = 20; //[18:21]
//Radius of Sholder (2.5)
sholder_r = 2.5; //[1.5:Thin, 2.5:Normal, 3.5:Fat]
//Space between Legs (7)
leg_spacing = 7; //[2:14]
//Radius of Eyes (4)
eye_r = 4; //[3:6]
//Adjust height of eyes (0)
eye_height_addition = 0; //[-4:5]
//Length of Antenna (7)
antenna_lengte = 7; //[2:12]
//Angle of Antenna (25)
antenna_angle = 25; //[10:50]
//Thickness of Anntenna (2)
antenna_thick_r = 2; //[1:4]
//PRINT MODE IMPORTENT!!
print_mode = 0; //[0:Preview Mode, 1:Print Mode]

//constants
sholder_width = 60/1; //width
sholder_length = 15/1;
sholder_height = 30.5/1; //starting from bottom-body
arm_afstand_body = 2/1;
arm_thick_r = 5/1;
arm_lengte = 30/1;
arm_height_vanaf_bottom_body = 11/1; //arm down
arm_height_vanaf_bottom_body_wave = 21/1; //arm up
wave = 10/1;
leg_thick = 9/1;
leg_thick_r = 4.5/1;
leg_height = 9; //totaal
leg_depth = 32/1;

start();

//////////////////////////////////////////////////////////////////

module start(){
	if (print_mode == 0){
		android();
	} else {
		print1();
		print2();
		print3();
	}
}

module print1(){
	translate([-50,0,-body_height]) neck();
	translate([-30,45,-body_height-neck_height]) head();
}

module print2(){
	translate([0,0,body_height])
	rotate(180,[1,0,0]){
		body();
		legs();
 	}
}

module print3(){
	translate([-20,-30,arm_thick_r]){
		rotate(90,[0,1,0]) rotate(90,[1,0,0]) arm_sholder(0,1);
	}
	translate([20,-20,arm_thick_r]){
		rotate(-90,[0,1,0]) rotate(90,[1,0,0]) arm_sholder(1,1);
	}
}

module android(){
	body();
	neck();
	head();
	translate([body_r + arm_afstand_body + arm_thick_r,0,arm_height_vanaf_bottom_body]) {
		arm_sholder(0,0); 
	}
	translate([-(body_r + arm_afstand_body + arm_thick_r),0,arm_height_vanaf_bottom_body]){
		arm_sholder(1,0);
	}
	legs();
}

module body(print){
	difference(){
		color("lime") cylinder(body_height,body_r,body_r);
		sholders_diff();
	}
}

module neck(){
	//neck
  	translate([0,0,body_height])
  	color("white") cylinder(neck_height, neck_r, neck_r);
}

module head(){
  //head (15 high)
  translate([0,0,body_height + neck_height]){
     difference(){
  	scale([1,1,0.8]){
      	color("lime") sphere(body_r);  	
      }
	  //a bit more for safety :P
        translate([0,0,-(body_height + neck_height + 1)]) //reset translation
    	cylinder((body_height + neck_height + 1),body_r + 1,body_r + 1); //+1 to be on the safe   side
    }
  }
  antennas();
  eyes();
}

module arm_sholder(isLeft,isPrint){
	if (isLeft == 1){
		translate([0,0,wave]) {color("lime") cylinder(arm_lengte, arm_thick_r, arm_thick_r);}
		translate([sholder_length,0,-arm_height_vanaf_bottom_body + sholder_height]){
		rotate(-90,[0,1,0])
  		color("white") cylinder(sholder_length,sholder_r,sholder_r);}
	} else {
  		color("lime") cylinder(arm_lengte, arm_thick_r, arm_thick_r);
		translate([-sholder_length,0,-arm_height_vanaf_bottom_body + sholder_height])
	  	rotate(90,[0,1,0])
  		color("white") cylinder(sholder_length,sholder_r,sholder_r);
	}
}

module sholders_diff(){
  	//sholder
	difference(){ 
		translate([-(sholder_width/2),0,sholder_height])
	  	rotate(90,[0,1,0])
  		color("white") cylinder(sholder_width,sholder_r,sholder_r);
		translate([-(sholder_width/6),-5,sholder_height-5]) cube([sholder_width/3,10,10]);
	}
}

module antennas(){
  //antennas
  translate([10,0,15 + neck_height + body_height]) //sort-of a guess
  rotate([0,antenna_angle,0])
  color("lime") cylinder(antenna_lengte, antenna_thick_r, antenna_thick_r);
  translate([-10,0,15+ neck_height + body_height]) //sort-of a guess
  rotate([0,-antenna_angle,0])
  color("lime") cylinder(antenna_lengte, antenna_thick_r, antenna_thick_r);
}

module eyes(){
  //eyes
  translate([9,-15,9 + neck_height + body_height + eye_height_addition])
  color("white") sphere(eye_r);
  translate([-9,-15,9 + neck_height + body_height + eye_height_addition])
  color("white") sphere(eye_r);
}

module legs(){
  //legs
  translate([(leg_spacing/2) + leg_thick_r, (leg_depth/2), -leg_height])
  rotate(90,[1,0,0])
  color("lime") cylinder(32, leg_thick_r, leg_thick_r);
  translate([-((leg_spacing/2) + leg_thick_r), (leg_depth/2), -leg_height])
  rotate(90,[1,0,0])
  color("lime") cylinder(32, leg_thick_r, leg_thick_r);
  ////
  translate([(leg_spacing/2), -(leg_depth/2),-leg_height])
  color("lime") cube([leg_thick,leg_depth,leg_height]);
  translate([-(leg_spacing/2 + leg_thick), -(leg_depth/2),-leg_height])
  color("lime") cube([leg_thick,leg_depth,leg_height]);
}
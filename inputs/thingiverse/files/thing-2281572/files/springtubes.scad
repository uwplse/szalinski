/****************************************************************/
/* File: springTubes.scad					*/
/* Version: v1							*/
/* Create by: Rom1 <rom1@canel.ch>				*/
/*            CANEL - https://www.canel.ch			*/
/* Date: 28 avril 2017						*/
/* License: GNU GENERAL PUBLIC LICENSE v3			*/
/* Programme: openscad						*/
/* Description:	Test's tube support like spring			*/
/****************************************************************/


/*************/
/* Variables */
/*************/

th = 2;			// Thinkness

dt = 15;       		// Diameter tube
ss = 18;        	// Space between the spring
bl = 80;        	// Base's length
sl = dt + 2*th;		// Spring's length
sc = 4;  		// Numbers of spring coils
wi = sl;		// Width


/***********/
/* Modules */
/***********/

module halfCircle(diameter = 20, thinkness = 2, orient = 0) {
	translate([0, (diameter + thinkness)/2, 0])
	difference(){
		circle(d = diameter + thinkness);
		circle(d = diameter - thinkness);
		rotate([0, 0, orient]) translate([0, -(diameter + thinkness)/2]) square([(ss + th)/2, ss + th]);
	}
}

module halfLoop(orient = "left", end = "no"){
	module piece(){
		halfCircle(ss, th);
		translate([0, ss]) square([sl, th]);
		if(end == "yes"){
			translate([sl, ss]) square([ss/2, th]);
		}
	}
	if(orient == "left") {
		piece();
	}
	if(orient == "right"){
		mirror([1, 0, 0]) piece();
	}
}

module loop(orient = "left", end = "no"){
	module piece(orient = "left"){
		halfLoop();
		translate([sl, ss]) mirror([1, 0, 0]) halfLoop();
		if(end == "yes"){
			translate([-ss/2, 2*ss]) square([ss/2, th]);
		}
	}
	if(orient == "left"){
		piece();
	}
	if(orient == "right"){
		mirror([1, 0, 0]) piece();
	}
}

module form3d(){
	linear_extrude(height = wi) {
		square([bl, th]);    // Base


		if(sc % 2 == 0){
			if(sc == 2){
				translate([0, (sc - 2)*ss]) loop("left", end = "yes");
				translate([bl, (sc - 2)*ss]) loop("right", end = "yes");
			}else{
				for(i = [0:sc/2-1]){
					translate([0, i*2*ss]) loop("left");
					translate([bl, i*2*ss]) loop("right");
				}
				translate([0, (sc - 2)*ss]) loop("left", end = "yes");
				translate([bl, (sc - 2)*ss]) loop("right", end = "yes");
			}
		}else{
			if(sc == 1){
				translate([0, (sc - 1)*ss]) halfLoop("left", end = "yes");
				translate([bl, (sc - 1)*ss]) halfLoop("right", end = "yes");

			}else{
				for(i = [0:sc/2-1]){
					translate([0, 2*i*ss]) loop("left");
					translate([bl, 2*i*ss]) loop("right");
				}
					translate([0, (sc - 1)*ss]) halfLoop("left", end = "yes");
					translate([bl, (sc - 1)*ss]) halfLoop("right", end = "yes");
			}
		}
	}
}


/********/
/* Main */
/********/

difference(){
	form3d();
	translate([ss/2, th, wi/2]) rotate([270, 0, 0]) cylinder(d = dt, h = sc*ss+th);
	translate([bl - ss/2, th, wi/2]) rotate([270, 0, 0]) cylinder(d = dt, h = sc*ss+th);
}

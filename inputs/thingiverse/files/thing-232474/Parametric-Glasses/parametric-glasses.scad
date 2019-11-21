/* Parametric glasses by Ticha Sethapakdi */

//----USER DEFINED VARIABLES-----

//the style of the glasses can either be 'squared' or 'oval'
frame = "squared";
//value from 1-6; can technically be larger, but some parts may look awkward...
roundedness = 6;

//1 for regular glasses; 2 for sunglasses
style = 2;

width = 10;
height = 5;
length = 14;

//for "oval" mode only:
//(not really working at the moment, so keep this the same for now)
radius = 7;

//see the SVG color list (http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#color) 
//for all possible color selections
//e.g. Crimson, Coral, Fuchsia, Chocolate, Navy...
frame_color = "Crimson";

//if the style is "sunglasses", the user may customize the color of the lens
//again, consult the SVG color list for a range of selections
lens_color = "Aqua";


//-------------------------------

/* The glasses are created here */
eyegap = 5;

if(frame == "squared") {
	rotate([90,0,0]) {
		translate([sqrt(roundedness), -sqrt(roundedness), 0]){
		scale([1/sqrt(roundedness), 1/sqrt(roundedness), 0.5]){
		translate([width/2+eyegap/2-1.5/roundedness, 0,0]) {
			//draws one side of the frame
			color(frame_color) {
				difference() { 
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}

					translate([0,-0.8,0]){ scale([0.8,0.8,2]){
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}}}
				}

			}
			
			//draws the lens
			if(style == 2) {
				color(lens_color, 0.7) {
					translate([0,-0.8,0]){ scale([0.8,0.8,0.5]){
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}}}
				}
			}
			
			else {
				color("white", 0.4) {
					translate([0,-0.8,0]){ scale([0.8,0.8,0.5]){
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}}}
				}
			}

			//leg
			color(frame_color) {
				hull() {
					translate([width/2 + roundedness, (height/2)*0.6-2,-1.5]){ 
						cube([1, 2.5, 5], center = true);  	
					}
						
					translate([width/2 + roundedness, (height/2)*0.6-2,-23.5]){ 
						cube([1, 1.5, 3], center = true);
					}
					
				}
				hull() {
					translate([width/2 + roundedness, (height/2)*0.6-2,-24.5]){ 
						cube([1, 1.5, 1.5], center = true);
					}
					translate([width/2 + roundedness, (height/2)*0.6-5,-32.5]){ 
								cube([1, 1.5, 1.5], center = true);
					}
				}
			}

		}}}

		//bridge
		color(frame_color) {
		
			hull() {
				translate([0.25, -1.8, 0.25]){ 
						cube([0.5, 1, 1], center = true);
				}
				translate([eyegap/3, -1.8, 0.25]){ 
						cube([0.2, 1.5, 1], center = true);
				}
			}
		}
	}

	mirror([1,0,0]) {rotate([90,0,0]) {
		translate([sqrt(roundedness), -sqrt(roundedness), 0]){
		scale([1/sqrt(roundedness), 1/sqrt(roundedness), 0.5]){
		translate([width/2+eyegap/2-1.5/roundedness, 0,0]) {
			//draws one side of the frame
			color(frame_color) {
				difference() { 
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}
					translate([0,-0.8,0]){ scale([0.8,0.8,2]){
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}}}
				}

			}
			
			//draws the lens
			if(style == 2) {
				color(lens_color, 0.7) {
					translate([0,-0.8,0]){ scale([0.8,0.8,0.5]){
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}}}
				}
			}
			
			else {
				color("white", 0.4) {
					translate([0,-0.8,0]){ scale([0.8,0.8,0.5]){
					minkowski() {
						hull() {
							cube([width, 1, 1], center = true);
							translate([0,-height+1,0]){cube([3*width/4, 3*height/4, 1], center = true);}
						}
						cylinder(r=roundedness, h=1);
					}}}
				}
			}

			//leg
			color(frame_color) {
				hull() {
					translate([width/2 + roundedness, (height/2)*0.6-2,-1.5]){ 
						cube([1, 2.5, 5], center = true);  	
					}
						
					translate([width/2 + roundedness, (height/2)*0.6-2,-23.5]){ 
						cube([1, 1.5, 3], center = true);
					}
					
				}
				hull() {
					translate([width/2 + roundedness, (height/2)*0.6-2,-24.5]){ 
						cube([1, 1.5, 1.5], center = true);
					}
					translate([width/2 + roundedness, (height/2)*0.6-5,-32.5]){ 
								cube([1, 1.5, 1.5], center = true);
					}
				}
			}

		}}}

		//bridge
		color(frame_color) {
		
			hull() {
				translate([0.25, -1.8, 0.25]){ 
						cube([0.5, 1, 1], center = true);
				}
				translate([eyegap/3, -1.8, 0.25]){ 
						cube([0.2, 1.5, 1], center = true);
				}
			}
		}
	}}

}


//ROUNDED FRAME
else if (frame == "oval") {
	rotate([90,0,0]) {
		translate([6.5*radius/8+eyegap/2, 0,0]) {
			//draws one side of the frame
			color(frame_color) {
				difference() { 
					cylinder(1,radius,radius, center = true);

					scale([0.8,0.8,2]){
						cylinder(1,radius,radius, center = true);
					}				
					
				}

			}

			//draws the lens
			if(style == 2) {
				color(lens_color, 0.7) {
					scale([0.8,0.8,0.5]){
						cylinder(1,radius,radius, center = true);
					}	
				}
			}
			
			else {
				color("white", 0.4) {
					scale([0.8,0.8,0.5]){
						cylinder(1,radius,radius, center = true);
					}	
				}

			}

			//leg
			color(frame_color) {
				hull() {
					translate([radius, 0, -2]){ 
						cube([1, 2.5, 5], center = true);  	
					}
						
					translate([radius, 0,-23.5]){ 
						cube([1, 1.5, 3], center = true);
					}
					
				}
				hull() {
					translate([radius, 0 ,-24.5]){ 
						cube([1, 1.5, 1.5], center = true);
					}
					translate([radius, -2,-32.5]){ 
								cube([1, 1.5, 1.5], center = true);
					}
				}
			}

		}

		//bridge
		color(frame_color) {
		
			hull() {
				translate([0.25, 1.5, 0]){ 
						cube([0.5, 1, 1], center = true);
				}
				translate([eyegap/3, 1.5, 0]){ 
						cube([0.2, 1.5, 1], center = true);
				}
			}
		}
	}

	mirror([1,0,0]) {rotate([90,0,0]) {
		translate([6.5*radius/8+eyegap/2, 0,0]) {
			//draws one side of the frame
			color(frame_color) {
				difference() { 
					cylinder(1,radius,radius, center = true);

					scale([0.8,0.8,2]){
						cylinder(1,radius,radius, center = true);
					}				
					
				}

			}

			//draws the lens
			if(style == 2) {
				color(lens_color, 0.7) {
					scale([0.8,0.8,0.5]){
						cylinder(1,radius,radius, center = true);
					}	
				}
			}
			
			else {
				color("white", 0.4) {
					scale([0.8,0.8,0.5]){
						cylinder(1,radius,radius, center = true);
					}	
				}

			}

			//leg
			color(frame_color) {
				hull() {
					translate([radius, 0, -2]){ 
						cube([1, 2.5, 5], center = true);  	
					}
						
					translate([radius, 0,-23.5]){ 
						cube([1, 1.5, 3], center = true);
					}
					
				}
				hull() {
					translate([radius, 0 ,-24.5]){ 
						cube([1, 1.5, 1.5], center = true);
					}
					translate([radius, -2,-32.5]){ 
								cube([1, 1.5, 1.5], center = true);
					}
				}
			}

		}

		//bridge
		color(frame_color) {
		
			hull() {
				translate([0.25, 1.5, 0]){ 
						cube([0.5, 1, 1], center = true);
				}
				translate([eyegap/3, 1.5, 0]){ 
						cube([0.2, 1.5, 1], center = true);
				}
			}
		}
	}}

			
}

else {
	echo("Undefined frame style!");
}
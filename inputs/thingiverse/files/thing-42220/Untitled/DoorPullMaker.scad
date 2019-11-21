// How long should the base be? (in mm)
01_stem_height = 20; // [0:40]
stem_height = 01_stem_height + 0.0;

// How thick should the base be? (in mm)
02_stem_diameter = 18; // [10:50]
stem_radius = 02_stem_diameter/2 + 0.0;

// How different is the top of the base compared to the bottom?
03_taper_amount = 0.8; // [1.5:A Lot Larger, 1.2:A Little Larger, 1:No Difference, 0.8:A Little Smaller, 0.5:A Lot Smaller]
taper_amount = 03_taper_amount + 0.0;

// Angled top and bottom edges on stem?
04_angled_edges = "Yes"; // [No, Yes]
stem_chamfer = str(04_angled_edges, "");

// Is the base Straight or Curved?
05_stem_shape = "Straight"; // [Straight, Curved]
stem_shape = str(05_stem_shape,"");

// How far does the screw stick out of the front of your cabinet? (in mm)
06_screw_depth = 5; // [3:15]
screw_depth = 06_screw_depth + 1.0;

// What is the diameter (width) of threaded part of the screw? (in mm)
07_screw_diameter = 3;
screw_radius = (07_screw_diameter+.75)/2.0;

// What type of ornament on the knob?
08_ornament_style = "UFO"; // [None, Ball, Mushroom, UFO, Blimp, Half Blimp, Square, Triangle, Rectangle, Circle, Hexagon]
ornament_style = str(08_ornament_style,"");

// How big do you want the ornament? (in mm)
09_ornament_size = 30; // [5:50]
ornament_size = (09_ornament_size/2) + 0.0;

// Special indent effect?
10_indent_ornament = "Bump"; // [None, Bump, Reverse]
indent_ornament = str(10_indent_ornament,"");

difference() {
	union() {
		if (stem_height > 0) {
			createStem();
		}
		if (ornament_style != "None") {
			if (ornament_style == "Ball") {
				createBallOrnament();
			}
			if (ornament_style == "Mushroom") {
				createHalfBallOrnament();
			}
			if (ornament_style == "UFO") {
				createUfoOrnament();
			}
			if (ornament_style == "Blimp") {
				createBlimpOrnament();
			}
			if (ornament_style == "Half Blimp") {
				createHalfBlimpOrnament();
			}
			if (ornament_style == "Triangle") {
				createShapeOrnament(3);
			}
			if (ornament_style == "Circle") {
				createShapeOrnament(36);
			}
			if (ornament_style == "Hexagon") {
				createShapeOrnament(6);
			}
			if (ornament_style == "Rectangle") {
				createRectangleOrnament();
			}
			if (ornament_style == "Square") {
				createShapeOrnament(4);
			}
		}
	}
	if ((stem_height > 0) || (ornament_style != "None")) {
		createScrewHole();
	}
}

module createStem() {
	difference() {
		cylinder(r1=max(stem_radius,screw_radius+1),r2=max(stem_radius*taper_amount,screw_radius+1),h=stem_height,$fn=48);
		
		if (stem_shape == "Curved") {
			translate([0,0,stem_height/1.55])
			rotate_extrude(convexity = 10, $fn=24)
			scale([1,(stem_height*0.775)/stem_radius,1]) 
			translate([stem_radius*1.65, 0, stem_height])
			circle(r = stem_radius, $fn=24);
		}
		
		if (stem_chamfer == "Yes") {
			// bottom
			rotate_extrude(convexity = 10, $fn=64)
			translate([stem_radius+1, 0, -10])
			circle(r = 2, $fn=6);
			// top
			rotate_extrude(convexity = 10, $fn=64)
			translate([(stem_radius+1)*taper_amount, stem_height, -10])
			circle(r = 2*taper_amount, $fn=6);
		}

		if (ornament_style == "None" && indent_ornament != "None") {
			if (indent_ornament == "Bump") {
				rotate_extrude(convexity = 10, $fn=64)
				translate([(stem_radius*taper_amount)-3, stem_height, -10])
				circle(r = 0.5, $fn=6);
			}
			if (indent_ornament == "Reverse") {
				translate([0,0,stem_height-0.5])
				cylinder(r1=stem_radius*taper_amount-3,r2=stem_radius*taper_amount-3,h=stem_height,$fn=48);
			
			}
		}
	}
}

module createScrewHole() {
	if (stem_height > 5 ) {
		translate([0,0,-2]) cylinder(r1=screw_radius,r2=screw_radius,h=min(screw_depth+2,stem_height),$fn=24);
	} else {
		translate([0,0,-80]) cylinder(r1=screw_radius,r2=screw_radius,h=85,$fn=24);
	}
}

module createBallOrnament() {
	if ((ornament_size) >= stem_radius*taper_amount)
	{ 
		translate([0,0,(stem_height+(sqrt(pow(ornament_size,2)-pow(stem_radius*taper_amount,2)) ) )])
		difference() {
		 union() {
				if (indent_ornament == "Bump") {
					sphere(r=ornament_size-1, $fn=36);
				}
			difference() {
				sphere(r=ornament_size, $fn=36);
				if (indent_ornament != "None") {
					translate([0,0,max(stem_height*0.5,ornament_size-1)]) sphere(r=ornament_size-1, $fn=36);
				}
			}
		}

		}
	}
 	else {
		translate([0,0,stem_height])
		 union() {
			if (indent_ornament == "Bump") {
				sphere(r=ornament_size-1, $fn=36);
			}
			difference() {
				sphere(r=ornament_size, $fn=36);
				if (indent_ornament != "None") {
					translate([0,0,10]) sphere(r=ornament_size-1, $fn=36);
				}
			}
		}
	}

}

module createHalfBallOrnament() {
	translate([0,0,stem_height]) 
	difference() {
		union() {
			if (indent_ornament == "Bump") {
				sphere(r=ornament_size-1, $fn=36);
			}
			difference() {
				sphere(r=ornament_size, $fn=36);
				if (indent_ornament != "None") {
					translate([0,0,ornament_size-1]) sphere(r=ornament_size-1, $fn=36);
				}
			}
		}
		translate([-35,-35,-70]) cube([70,70,70], center=false);
	}

}


module createUfoOrnament() {
	if ((ornament_size) >= stem_radius*taper_amount)
	{ 
		scale([1,1,0.2])	
		translate([0,0,((stem_height*5)+(sqrt(pow(ornament_size,2)-pow(stem_radius*taper_amount,2)) ) )])
		union() {
			if (indent_ornament == "Bump") {
				sphere(r=ornament_size-1, $fn=36);
			}
			difference() {
				sphere(r=ornament_size, $fn=36);
				if (indent_ornament != "None") {
					translate([0,0,ornament_size-1]) sphere(r=ornament_size-1, $fn=36);
				}
			}
		}
	}
	else {
		scale([1,1,0.2])	
		translate([0,0,stem_height*5]) 
		union() {
			if (indent_ornament == "Bump") {
				sphere(r=ornament_size-1, $fn=36);
			}
			difference() {
				sphere(r=ornament_size, $fn=36);
				if (indent_ornament != "None") {
					translate([0,0,ornament_size-1]) sphere(r=ornament_size-1, $fn=36);
				}
			}
		}
	}
}

module createBlimpOrnament() {
	translate([0,0,(stem_height+(sqrt(pow(ornament_size,2)-pow(stem_radius*taper_amount,2)) )/2 )])
	scale([1,0.5,0.5]) 
	union() {
		if (indent_ornament == "Bump") {
			sphere(r=ornament_size-1, $fn=36);
		}
		difference() {
			sphere(r=ornament_size, $fn=36);
			if (indent_ornament != "None") {
				translate([0,0,ornament_size-1]) sphere(r=ornament_size-1, $fn=36);
			}
		}
	}
}

module createHalfBlimpOrnament() {
		scale([1,0.5,0.5]) translate([0,0,stem_height*2]) 
		difference() {
		union() {
			if (indent_ornament == "Bump") {
				sphere(r=ornament_size-1, $fn=48);
			}
			difference() {
				sphere(r=ornament_size, $fn=48);
				if (indent_ornament != "None") {
					translate([0,0,ornament_size-1]) sphere(r=ornament_size-1, $fn=48);
				}
			}
		}
		translate([-35,-35,-70]) cube([70,70,70], center=false);
	}
}

module createShapeOrnament(sides, scale) {
	translate([0,0,stem_height])
	scale([scale,scale,1])
	difference() {
		cylinder(r=ornament_size, h=ornament_size/3, $fn=sides);
		if (indent_ornament != "None") {
			translate([0,0,ornament_size/3-1])
			difference() {
				cylinder(r=ornament_size-4, h=10, $fn=sides);
				if (indent_ornament == "Bump") {
					cylinder(r=ornament_size-6, h=10, $fn=sides);
				}
			}
		}
	}
}
module createRectangleOrnament() {
	translate([0,0,stem_height])
	difference() {
		translate([-ornament_size,-ornament_size/2,0])
		cube(size=[ornament_size*2,ornament_size,ornament_size/5], center=false);
		if (indent_ornament != "None") {
			translate([-ornament_size+2,-ornament_size/2+2,ornament_size/5-1])
			difference() {
				cube(size=[ornament_size*2-4,ornament_size-4,ornament_size/5], center=false);
				if (indent_ornament == "Bump") {
					translate([2,2,0])
					cube(size=[ornament_size*2-8,ornament_size-8,ornament_size/5], center=false);
				}
			}
		}
	}
}

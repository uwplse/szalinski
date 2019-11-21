use <utils/build_plate.scad>;

// Type of part to make
_1_type = "Top"; //[Base, Flat Window, Round Window, Top]

// Diameter of the lantern at the window
_2_lanternDiameter = 40; //[12:120]

// Height of the top lantern part
_3_topHeight = 4; //[2:12]

// Height of the window part of the lantern
_4_windowHeight = 60; //[10:120]

// Height of the bottom lantern part
_5_baseHeight = 6; //[2:24]

// Thickness of the window (set it to print one layer for maximum transparency)
_6_windowThickness = 0.2;

// Circular gap in the top and base for the window insert
_7_windowGap = 0.5;

// Size of the notch used to hold flat windows (set to 0 for round windows)
_8_notchWidth = 2.4;

// Add optional led holder to the base of the lantern
_9_addLedClip = 0; //[0:No, 1:Yes]


module ledSide(width, offset) {
	thickness = 1.4;
	radius = 4;
	height = 10;
	eps = 0.1;
	wireDepth = 0.5;
	yoffset = width/2 - radius;

	translate([offset,0,0])
	translate([thickness,0,0])
	rotate(a=[0,-2.5,0])
	translate([-thickness,0,0]) {

		difference() {
			union() {
				hull() {
					translate([0,-9,0]) {
						cube(size=[thickness, width, 1]);
					}
				
					for(y=[-yoffset, yoffset]) {
						translate([0,y,height - radius]) {
							rotate(a=[0,90,0]) {
								cylinder(r=radius,h=thickness);
							}
						}
					}
				}

				//support
				translate([thickness,0,0])
				scale(v=[1,1,2])
				difference() {
					translate([0,0,-0.1])
					rotate([0,45,0]) {
						cube(size=[1.0,width,1.0], center=true);
					}
					translate([0,0,-1.1]) {
						cube(size=[2.0,width,2.0], center=true);
					}
				}
			}
	
			// cut wire guides
			for(y=[0:2.0:6]) {
				for(flip=[-1,1]) {
					translate([-eps, -0.3 + y * flip, -eps]) {
						cube(size=[wireDepth+eps, 0.8, height + 2*eps]); 
					}
				}
			}
	
			// lower cutout
			hull() {
				cube(size=[wireDepth*2, width+eps, 8], center=true); 
				cube(size=[0.001, width+eps, 10], center=true); 
			}
			
			// bevel top	
			translate([0,0,height])
			scale(v=[1,1,3])
			rotate([0,45,0]) {
				cube(size=[0.8,width+eps,0.8], center=true);
			}
			
		}
	}	
}

module addLedClip() {
	width = 18;
	gap=3.5;

	ledSide(width, gap/2);
	mirror() {
		ledSide(width, gap/2);
	}
}

module makeTop(diameter, height, windowGap, notchWidth, windowInset) {
	inset = min(windowInset, height-1.0);
	wallThickness = 1.1;
	radius1 = diameter/2 - windowGap/2;
	radius2 = radius1 + windowGap;
	radius3 = radius2 + wallThickness;
	eps = 0.1;
	translate([0,0,height]) {
		difference() {
			translate([0,0,-height]) {
				difference() {
					cylinder(r=radius3, h=height);
					translate([0,0,-eps]) {
						cylinder(r=radius1-wallThickness, h=height + 2*eps);
					}
				}
			}
			translate([0,0,-inset]) {
				difference() {
					cylinder(r=radius2, h=inset+eps);
					translate([0,0,-eps]) {
						cylinder(r=radius1, h=inset + 3*eps);
					}
				}
			}
			if (notchWidth > 0) {
				translate([-notchWidth/2,radius1-wallThickness*2,-inset]) {
					cube(size=[notchWidth,wallThickness*2,inset+eps], center=false);
				}
			}
		}
	}
}

module makeBase(diameter, height, windowGap, notchWidth, windowInset, clip) {
	radius = diameter/2 + windowGap/2 + 1.0;
	baseThickness = 1.0;
	union() {
		makeTop(diameter, height, windowGap, notchWidth, windowInset);
		cylinder(r=radius, h=baseThickness);
		if (clip == 1) {
			translate([0,0,baseThickness]) {
				addLedClip();
			}
		}
	}
}

module makeFlatWindow(diameter, height, thickness) {
	width = diameter * 3.14159265359;
	seamWidth = 1.0;
	seamDepth = 1.5;
	xoffset = -width/2 + seamWidth/2;
	union() {
		cube(size=[width, height, thickness], center=true);
		for (x = [-xoffset,xoffset]) {
			translate([x,0,seamDepth/2]) {	
				cube(size=[seamWidth, height, seamDepth], center=true);

			}
		}
	}
}

module makeRoundWindow(diameter, height, thickness) {
	radius = diameter/2;
	eps = 0.1;
	difference() {
		cylinder(r=radius + thickness/2, h=height);
		translate([0,0,-eps]) {
			cylinder(r=radius - thickness/2, h=height + 2*eps);
		}
	}
}

module run($fn=180) {
	if (_1_type == "Top") {
		makeTop(_2_lanternDiameter, _3_topHeight, _7_windowGap, _8_notchWidth, 4.0);
	} else if (_1_type == "Flat Window") {
		makeFlatWindow(_2_lanternDiameter, _4_windowHeight, _6_windowThickness);
	} else if (_1_type == "Round Window") {
		makeRoundWindow(_2_lanternDiameter, _4_windowHeight, _6_windowThickness);
	} else {
		makeBase(_2_lanternDiameter, _5_baseHeight, _7_windowGap, _8_notchWidth, 4.0, _9_addLedClip);
	}
}

build_plate(3,140,140);
run();
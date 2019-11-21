markers = 4;

height = 50;
thickness = 3; // General padding between markers

eraser_width = 25;
eraser_depth = 25;

marker_rad = 6; // This radius value works for standard expo dry erase markers
marker_ridge_height = 5; // sure, why not?

fastener_width = 15;

nudge = 0.1; 
precision = 100;

// can be none, simple, magnet, screw
fastener_type="magnet";

// Magnet size must include the wanted tolerance.
magnet_diam=10.5;
magnet_height=3.5;

difference(){
	union(){
		//eraser block
		color("blue") {
			difference() {
				cube([eraser_width + thickness * 2, eraser_depth + thickness * 2, height + thickness]);
				//eraser hole
				translate([thickness, thickness, thickness]) {
					cube([eraser_width, eraser_depth, height + thickness]);
				}
				translate([eraser_width/2+thickness,eraser_depth+thickness*3,height/2]) {
					rotate([90,0,0]) {
						linear_extrude(height=eraser_depth+thickness*4) {
							bi_ogive(height/3,marker_rad*2);
						}
					}
				}
			}
		}

		//markers block
		color("green") {
			difference () {
				union () {
					translate([eraser_width + thickness * 2,0,0]) {
						cube([(marker_rad * 2 + thickness) * markers + thickness, marker_rad + thickness, height + thickness]);
					}
					translate([thickness * 2 + eraser_width + marker_rad,thickness + marker_rad,thickness]) {
						markers(false);
					}
				}
				//marker holes
				translate([thickness * 2 + eraser_width + marker_rad,thickness + marker_rad,thickness]) {
					markers(true);
				}
			}
		}

		color("red") {
			fasteners();
		}
	}
		
}

module bi_ogive(height, width) {
	intersection () {
	  translate([-width/2,height/2]) { circle(width); }
	  translate([width/2,height/2]) { circle(width); }
	}
	intersection () {
	  translate([-width/2,-height/2]) { circle(width); }
	  translate([width/2,-height/2]) { circle(width); }
	}
	square([width,height], center=true);
}

module fastener(){
	if (fastener_type == "simple") {
		cube([fastener_width, thickness, height + thickness]);
	}
	if (fastener_type == "magnet") {
		difference () {
			cube([magnet_diam+thickness*2, magnet_height+thickness*2, height + thickness]);
			translate([magnet_diam/2+thickness,thickness*2,height/2-magnet_diam]) {
				rotate([90,0,0]) {
					linear_extrude(height=magnet_height) {
						bi_ogive(height,magnet_diam);
					}
				}
			}			
		}
	}
}

module fasteners(){
	if (fastener_type == "magnet") {
		translate([-magnet_diam-thickness*2,0,0]) {
			fastener();
		}	
	} else {
		translate([-fastener_width,0,0]) {
			fastener();
		}	
	}
	translate([eraser_width + thickness * 3 + (marker_rad * 2 + thickness) * markers, 0, 0]) {
		fastener();
	}
}

module markers(holes){
	for(i = [0:(markers - 1)]){
		translate([(marker_rad * 2 + thickness) * i + thickness, 0, 0]) {
			if (holes) {
				union(){
					cylinder(r=marker_rad, h = height, $fn = precision);
					translate([0,0,height - marker_ridge_height]) {
						cylinder(r1 = marker_rad, r2 = marker_rad + thickness / 2 - nudge, h = marker_ridge_height + thickness, $fn = precision);
					}
					translate([0,marker_rad+thickness*2,height/2]) {
						rotate([90,0,0]) {
							linear_extrude(height=marker_rad*2+thickness*4) {
								bi_ogive(height/3,marker_rad*2);
							}
						}
					}
				}
			} else {
				translate ([0,0,-thickness]) {
					cylinder(r=marker_rad+thickness, h = height+thickness, $fn = precision);
				}
			}
		}
	}
}

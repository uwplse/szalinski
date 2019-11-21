heightOfHolder=2.4;
magnetDiameter=9;
motorHoleDiameter=11.5;

rotate([-60,0,0])
difference() {
	union() {
		// flat bottom
		difference() {
			cube([86.6,62.0,2.0]);
		    // motor hole
			translate([35.0, 53.5, -1]) {
				cylinder(r=motorHoleDiameter/2, h=8, $fn=100);
			}
		}
		translate([12,61,0]) {
			cube([59.3,17.0,2.0]);
		}

		// down side
		cube([86.6,2,5]);

		//left side
		cube([2,62.1,3]);
		cube([2,14.2,5]);

		//right side
		translate([86.6-2,0,0]) {
			cube([2,62.1,5]);
		}

		//left bottom clip
		translate([0,3,0]) {
			cube([6,9,5]);
		}

		//left top clip
		translate([0,3+38.5+9.0,0]) {
			cube([6,9,5]);
		}
		//right bottom clip
		translate([86.6-6,3,0]) {
			cube([6,9,5]);
		}

		//right top clip
		translate([86.6-6,3+38.5+9,0]) {
			cube([6,9,5]);
		}

       // four magnets
		translate([20.3,17.3,1]) {
			rotate([180,0,0]) {
				cylinder(r1=((max(magnetDiameter+1,12)-11)*3+11)/2, r2=11/2, h=3, $fn=100);
			    cylinder(r=1.7, h=4+1, $fn=100);
			}
		}
		translate([66.6,17.3,1]) {
			rotate([180,0,0]) {
				cylinder(r1=((max(magnetDiameter+1,12)-11)*3+11)/2, r2=11/2, h=3, $fn=100);
		    	cylinder(r=1.7, h=4+1, $fn=100);
			}
		}
		translate([20.3,57.2,1]) {
			rotate([180,0,0]) {
				cylinder(r1=((max(magnetDiameter+1,12)-11)*3+11)/2, r2=11/2, h=3, $fn=100);
			    cylinder(r=1.7, h=4+1, $fn=100);
			}
		}
		translate([66.6,57.2,1]) {
			rotate([180,0,0]) {
				cylinder(r1=((max(magnetDiameter+1,12)-11)*3+11)/2, r2=11/2, h=3, $fn=100);
			    cylinder(r=1.7, h=4+1, $fn=100);
			}
		}

		// motor screw
		translate([50.825,38.025,0]) {
			cylinder(r=4, h=7.4, $fn=100);
			cylinder(r=3, h=9.3, $fn=100);
		}
		translate([50.825,69.075,0]) {
			cylinder(r=4, h=7.4, $fn=100);
			cylinder(r=3, h=9.3, $fn=100);
		}
		translate([19.775,69.075,0]) {
			cylinder(r=4, h=7.4, $fn=100);
			cylinder(r=3, h=9.3, $fn=100);
		}

		translate([12,72.5,1.5]) {
			rotate([-30,0,0]) {
				cube([59.3,3,6]);
			}
		}
		translate([8.65,77,16]) {
			cube([66,1,23.3]);
		}
		translate([8.65,75.25,16]) {
			cube([66,2.75,22.3]);
		}
		translate([12,75.25,0]) {
			cube([59.3,2.75,24.1]);
		}
		translate([10.15,75.25,5.196]) {
			cube([63,2.75,24.1]);
		}
		translate([8.65,68,16]) {
			cube([2.3,10,23.3]);
		}
		translate([2.95,68,29]) {
			cube([8,2.3,10.3]);
		}
		translate([72.35,68,16]) {
			cube([2.3,10,23.3]);
		}
		translate([72.35,68,29]) {
			cube([9.45,2.3,10.3]);
		}

		// \_/ holder
		translate([27.9,77,35.65]) {
			difference() {
				cube([27.5,2.25+heightOfHolder,3.65]);
				translate([-1,0.95,-1]) {
					cube([29.5,heightOfHolder,3.15]);
				}
			}
		}
		translate([53.605,77,37.4253]) {
			rotate([0,45,0]) {
				difference() {
					cube([27.5,2.25+heightOfHolder,2.55]);
					translate([-1,0.95,-1]) {
						cube([29.5,heightOfHolder,2.05]);
					}
				}
			}
		}
		translate([10.2293,77,18.05]) {
			rotate([0,-45,0]) {
				difference() {
					cube([27.5,2.25+heightOfHolder,2.55]);
					translate([-1,0.95,-1]) {
						cube([29.5,heightOfHolder,2.05]);
					}
				}
			}
		}


	    // motor hole
		translate([35.0, 53.5, 0]) {
			difference() {
				cylinder(r=motorHoleDiameter/2+1, h=5, $fn=100);
				translate([0,0,-1]) {
					cylinder(r=motorHoleDiameter/2, h=7, $fn=100);
				}
			}
		}
		translate([35.0-6.5/2,53.4+motorHoleDiameter/2,0]) {
			cube([6.5,18-(motorHoleDiameter-11)/2,5]);
		}

		// carriage box screw hole left
		translate([2.95+3.8,67.5,29]) {
			difference() {
				cylinder(r=2.2, h=10.3, $fn=100);
				translate([0,0,-1]) {
					cylinder(r=1.2, h=10.3+2, $fn=100);
				}
			}
		}
		// carriage box screw hole right
		translate([77.7,67.5,29]) {
			difference() {
				cylinder(r=2.2, h=10.3, $fn=100);
				translate([0,0,-1]) {
					cylinder(r=1.2, h=10.3+2, $fn=100);
				}
			}
		}

		// carriage machine screw hole left
		translate([8.65,75,5.196]) {
			difference() {
				cylinder(r=3, h=12.2, $fn=100);
				translate([0,0.3,-1]) {
					cylinder(r=1.5, h=11, $fn=100);
				}
			}
		}
		// carriage machine screw hole right
		translate([74.65,75,5.196]) {
			difference() {
				cylinder(r=3, h=12.2, $fn=100);
				translate([0,0.3,-1]) {
					cylinder(r=1.5, h=11, $fn=100);
				}
			}
		}
	}

    // four magnets
	translate([20.3,17.3,-1]) {
	    cylinder(r=magnetDiameter/2, h=10, $fn=100);
	}
	translate([66.6,17.3,-1]) {
	    cylinder(r=magnetDiameter/2, h=10, $fn=100);
	}
	translate([20.3,57.2,-1]) {
	    cylinder(r=magnetDiameter/2, h=10, $fn=100);
	}
	translate([66.6,57.2,-1]) {
	    cylinder(r=magnetDiameter/2, h=10, $fn=100);
	}

    // bottom square hole
	translate([28.45,3,-1]) {
		cube([25.6,9.3,8]);
	}

    // connect hole
	translate([47.5,43,-1]) {
		cube([6.7,20.8,8]);
	}

    // 4 clip
	translate([1.5,5,-1]) {
		cube([3,5,8]);
	}
	translate([1.5,52.6,-1]) {
		cube([3,5,8]);
	}
	translate([81.8,5,-1]) {
		cube([3,5,8]);
	}
	translate([81.8,52.6,-1]) {
		cube([3,5,8]);
	}

	// motor nuts hole
	translate([35.0, 57, 0]) {
		translate([-1.35,0,-1]) {
			cube([2.7,29,2.65+1]);
		}
		translate([0,0,2.65]) {
			rotate([-90,0,0]) {
				cylinder(r=2.7/2, h=29, $fn=100);
			}
		}
	}

	// motor screw
	translate([50.825,38.025,-1]) {
		cylinder(r=1.7, h=11, $fn=100);
		cylinder(r=3.35, h=4, $fn=100);
	}
	translate([50.825,69.075,-1]) {
		cylinder(r=1.7, h=11, $fn=100);
		cylinder(r=3.35, h=4, $fn=100);
	}
	translate([19.775,69.075,-1]) {
		cylinder(r=1.7, h=11, $fn=100);
		cylinder(r=3.35, h=4, $fn=100);
	}

	translate([0,75,0]) {
		rotate([-30,0,0]) {
			cube([86.6,3,8.4]);
		}
	}

	// carriage box screw hole left
	translate([2.95+3.8,67.5,29]) {
		translate([0,0,-1]) {
			cylinder(r=1.2, h=10.3+2, $fn=100);
		}
	}
	// carriage box screw hole right
	translate([77.7,67.5,29]) {
		translate([0,0,-1]) {
			cylinder(r=1.2, h=10.3+2, $fn=100);
		}
	}

}


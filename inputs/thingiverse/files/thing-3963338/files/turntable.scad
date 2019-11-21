What_to_show=1; // [1:All in one, 2:Floor plate, 3:Turntable gear, 4:Turntable wheels, 5:Control gear]

// Number of teeth of the turntable
Number_of_teeth=64; // [40:200]

Rails_angle_start = 45;
Rails_angle_step = 45;
Rails_angle_end = 270;

use <MCAD/involute_gears.scad>

turntableGearPitchRadius = Number_of_teeth * 333 / 360;
function wheelAngles() = Number_of_teeth < 50?[]:
	Number_of_teeth < 60?[0, 180]:
	Number_of_teeth < 80?[45, 135, 225, 315]:
	Number_of_teeth < 120?[90-asin(35/turntableGearPitchRadius),90+asin(35/turntableGearPitchRadius),270-asin(35/turntableGearPitchRadius),270+asin(35/turntableGearPitchRadius), 0, 180]:
	Number_of_teeth < 160?[90-asin(35/turntableGearPitchRadius),90+asin(35/turntableGearPitchRadius),270-asin(35/turntableGearPitchRadius),270+asin(35/turntableGearPitchRadius), 30, -30, 150, 210]:
	[90-asin(35/turntableGearPitchRadius),90+asin(35/turntableGearPitchRadius),270-asin(35/turntableGearPitchRadius),270+asin(35/turntableGearPitchRadius), 45, 135, 225, 315, 0, 180];

function entryAngle() = Number_of_teeth < 50?50:
	Number_of_teeth < 70?45:
	Number_of_teeth < 90?40:
	Number_of_teeth < 110?36:
	Number_of_teeth < 130?33:
	Number_of_teeth < 150?31:
	29;

floorLayerHeight = 2+0;
pinBaseOffset = 1 + 0;
pinBaseHeigth = floorLayerHeight + pinBaseOffset;

controlGearPitchRadius = 18.7+0;
clearance=0.2 + 0;

module turnTable() {
	bearing();

	difference() {
		// gear
		gear(number_of_teeth=Number_of_teeth, circular_pitch=333, pressure_angle=28, hub_thickness=0, bore_diameter=turntableGearPitchRadius*2 - 24.1, rim_thickness=7, rim_width=10);
		// wheel holes
		for (angle = wheelAngles()) {
			rotate([0, 0, angle]) {
				translate([0, turntableGearPitchRadius-8, 3.5]) {
					cube([10, 4, 7], center=true);
					translate([0, 5.8, 0]) {
						rotate([90, 0, 0]) {
							cylinder(10, r=2);
						}
					}
				}
			}
		}
	}

	// rails on turntable
	intersection() {
		translate([-turntableGearPitchRadius, -20, -2.4]) {
			rotate([90,0,90]) {
				linear_extrude(turntableGearPitchRadius * 2) {
					body();
				}
			}
		}
		difference() {
			cylinder(10, r=turntableGearPitchRadius-2);
			cylinder(12.4, r=11);
		}
	}
}

module controlGear() {
	rotate([0, 0, 360/40]) {
		bearing();
	
		gear(number_of_teeth=20, circular_pitch=333, pressure_angle=28, hub_thickness=0, bore_diameter=22, rim_thickness=7, rim_width=6);
		translate([13.8, 0, 7]) {
			cylinder(10, r=3);
		}
		translate([13.8, 0, 17]) {
			sphere(5);
		}
	}
}


module wheelAxis() {
	translate([0, 0, 1]) {
		cylinder(2, r=3.2, center=true);
	}
	translate([0, 0, 5.75]) {
		cylinder(11.5, r=1.93, center=true);
	}
}


module wheel() {
	translate([0,0,1.75]) {
		difference() {
			cylinder(3.5, r=4.5, center=true);
			cylinder(3.5, r=2.2, center=true);
		}
	}
}

bottomHeigth = 8;
edgeRounding = 2;


turntableGearMargin = 3;
turntableGearEdgeWidth = 15;

controlGearMargin = 3;
controlGearEdgeWidth = 5;

pinRadius = 3.95;
pinHeigth = 10;
pinBaseRadius = 4.75;

$fn=100;

module pin() {
	translate([0, 0, pinHeigth/2]) {
		cylinder(pinHeigth, r=pinRadius, center=true);
	}
	translate([0, 0, pinBaseHeigth/2]) {
		cylinder(pinBaseHeigth, r=pinBaseRadius, center=true);
	}
}

module rails(length, connectorType) {
	if (connectorType == 0) {
		difference() {
			rotate([90, 0, 90]) {
				translate([-20, 0, 0]) {
					linear_extrude(length) body();
				}
			}
			translate([length, 0, 20]) {
				rotate([90, 0, 180]) {
					connector();
				}
			}
		}
	} else {
		rotate([90, 0, 90]) {
			translate([-20, 0, 0]) {
				linear_extrude(length-17) body();
			}
		}
		translate([length, 0, 0]) connector_male(17);
	}
}


module floorPlate() {
	difference() {
		union() {
			hull() {
				union() {
					cylinder(bottomHeigth - edgeRounding, r=turntableGearPitchRadius + turntableGearMargin + turntableGearEdgeWidth + edgeRounding);
					translate([0, 0, bottomHeigth - edgeRounding]) {
						cylinder(edgeRounding, r1=turntableGearPitchRadius + turntableGearMargin + turntableGearEdgeWidth + edgeRounding, r2=turntableGearPitchRadius + turntableGearMargin + turntableGearEdgeWidth);
					}
				}

				translate([turntableGearPitchRadius + clearance + controlGearPitchRadius, 0, 0]) {
					cylinder(bottomHeigth - edgeRounding, r=controlGearPitchRadius + controlGearMargin + controlGearEdgeWidth + edgeRounding);
					translate([0, 0, bottomHeigth - edgeRounding]) {
						cylinder(edgeRounding, r1=controlGearPitchRadius + controlGearMargin + controlGearEdgeWidth + edgeRounding, r2=controlGearPitchRadius + controlGearMargin + controlGearEdgeWidth);
					}
				}
			}
			rotate([0, 0, entryAngle()]) {
				rails(turntableGearPitchRadius+40, 0);
			}
			for (railAngle = [Rails_angle_start:Rails_angle_step*2:Rails_angle_end]) {
				rotate([0, 0, railAngle + entryAngle()]) {
					rails(turntableGearPitchRadius+40, 1);
				}
			}
			for (railAngle = [Rails_angle_start+Rails_angle_step:Rails_angle_step*2:Rails_angle_end]) {
				rotate([0, 0, railAngle + entryAngle()]) {
					rails(turntableGearPitchRadius+40, 0);
				}
			}
		}
		translate([0, 0, 20+floorLayerHeight]) {
			cylinder(40, r=turntableGearPitchRadius + turntableGearMargin, center=true);
		}
		translate([turntableGearPitchRadius + clearance + controlGearPitchRadius, 0, bottomHeigth/2 + floorLayerHeight]) {
			cylinder(bottomHeigth, r=controlGearPitchRadius + controlGearMargin, center=true);
		}
	}

	pin();
	translate([turntableGearPitchRadius + clearance + controlGearPitchRadius, 0, 0]) {
		pin();
	}
}

/*********************************************************\
* Combinations of the modules, for rendering and printing *
\*********************************************************/
if (What_to_show == 1) {
	allInOne();
} else if (What_to_show == 2) {
	floorPlate();
} else if (What_to_show == 3) {
	turnTable();
} else if (What_to_show == 4) {
	wheelsForPrinting();
} else if (What_to_show == 5) {
	controlGear();
} else if (What_to_show == 6) {
	wheel();
} else if (What_to_show == 7) {
	wheelAxis();
}

module allInOne() {
	floorPlate();
	translate([0,0,pinBaseHeigth]){
		color("green") {
			turnTable();
		}
	}
	translate([turntableGearPitchRadius + clearance + controlGearPitchRadius,0,pinBaseHeigth]) {
		color("blue") {
			controlGear();
		}
	}
	color("orange") {
		for (angle = wheelAngles()) {
			rotate([0, 00, angle]) {
				translate([0, turntableGearPitchRadius - 9.8, 4.5 + floorLayerHeight]) {
					rotate([-90, 0, 0]) {
						wheel();
					}
				}
			}
		}
	}
	color("red") {
		for (angle = wheelAngles()) {
			rotate([0, 0, angle]) {
				translate([0, turntableGearPitchRadius - 14.4, 4.5 + floorLayerHeight]) {
					rotate([-90, 0, 0]) {
						wheelAxis();
					}
				}
			}
		}
	}
}

module wheelsForPrinting() {
	if (len(wheelAngles()) > 0) {
		translate([-len(wheelAngles())*7.5-8, -8, 0])
		for (wheel = [1:len(wheelAngles())]) {
			translate([wheel * 15, 0, 0]) {
				wheel();
			}
			translate([wheel * 15, 15, 0]) {
				wheelAxis();
			}
		}
	}
}

/******************************************************************************************************\
|* This is a trimmed-down and slightly modified version of by https://www.thingiverse.com/thing:43278 *|
\******************************************************************************************************/
WIDTH=40.7;
HEIGHT=12.4;
LENGTH=205;
BEVEL=1;
TRACK_WIDTH=6.2;
TRACK_HEIGHT=3;
TRACK_DIST=20;

BRIDGE_HEIGHT=64;
BRIDGE_R1=214;
BRIDGE_R2=220;

CONN_WIDTH=7.3;
CONN_R=6.5;
CONN_BEVEL=1.7;
CONN_DEPTH=17;

CONN_HEIGHT=11.5;

CONN_MALE_R=6;
CONN_MALE_W=6.5;
CONN_MALE_HOLE_Y=6.8;
CONN_MALE_HOLE_Z=6.4;
CONN_MALE_RIM=1;
CONN_MALE_PROTRUDE=0.75;
CONN_MALE_PROTRUDE_R=1.5;

CONN_FEMALE_R=5.6;
CONN_FEMALE_PROTRUDE_R=1.2;
CONN_FEMALE_BRIDGE_L=6.5;
CONN_FEMALE_BRIDGE_W1=3.5;
CONN_FEMALE_BRIDGE_W2=4.5;
CONN_FEMALE_BRIDGE_RIM=CONN_FEMALE_BRIDGE_W2-CONN_FEMALE_BRIDGE_W1;
CONN_FEMALE_THICK=1.7;

module track_single() {
    square([TRACK_WIDTH,TRACK_HEIGHT]);
}

module track() {
    translate([WIDTH/2-TRACK_WIDTH-TRACK_DIST/2,HEIGHT-TRACK_HEIGHT,0])
        track_single();
    translate([WIDTH/2+TRACK_DIST/2,HEIGHT-TRACK_HEIGHT,0])
        track_single();
}

module body() {
    difference() {
        polygon(points=[[BEVEL,0],[WIDTH-BEVEL,0],[WIDTH,BEVEL],[WIDTH,HEIGHT-BEVEL],[WIDTH-BEVEL,HEIGHT],[BEVEL,HEIGHT],[0,HEIGHT-BEVEL],[0,BEVEL]]);
        translate([0,0,0.01])
            track();
    }
}

module conn_bevel() {
    translate([WIDTH/2-BEVEL,0,0])
    linear_extrude(height=10*HEIGHT)
        polygon(points=[[0,-0.01],[BEVEL+0.01,BEVEL],[BEVEL+0.01,-0.01]]);
}
module connector() {
    rotate([90,90,0])
    {
    hull() {
        translate([-(CONN_WIDTH+2*CONN_BEVEL)/2,-0.01,0])
            cube([CONN_WIDTH+2*CONN_BEVEL, 0.01, 10*HEIGHT]);
        translate([-CONN_WIDTH/2,CONN_BEVEL,0])
            cube([CONN_WIDTH, 0.01, 10*HEIGHT]);
    }
    translate([-CONN_WIDTH/2,0,0])
        cube([CONN_WIDTH, CONN_DEPTH, 10*HEIGHT]);

    difference() {
        translate([0,CONN_DEPTH-CONN_R+1.1,0])
            cylinder(10*HEIGHT,r=CONN_R);
    }

    conn_bevel();
    mirror([1,0,0])
        conn_bevel();

    } 
}

module connector_male_protrude() {
    translate([0,CONN_MALE_R-CONN_MALE_PROTRUDE_R+CONN_MALE_PROTRUDE,0])
        cylinder((CONN_HEIGHT-2*CONN_MALE_RIM)/2,r=CONN_MALE_PROTRUDE_R,$fn=20);
}

module connector_male_end(len) {
	intersection() {
		translate([0,50,0])
			cube([100,100,100],center=true);
		union() {
			translate([0,0,CONN_HEIGHT/2-CONN_MALE_RIM])
				hull() {
					cylinder(0.01, r=CONN_MALE_R, $fn=20);
					translate([0,0,CONN_MALE_RIM])
						cylinder(0.01, r=CONN_MALE_R-CONN_MALE_RIM, $fn=20);
				}
			cylinder(CONN_HEIGHT/2-CONN_MALE_RIM, r=CONN_MALE_R, $fn=20);
		}
	}
}

module connector_male_bridge(len) {
    hull() {
        cube([len-CONN_MALE_R,0.01,CONN_HEIGHT/2], center=true);
        translate([0,CONN_MALE_RIM,-CONN_MALE_RIM/2])
            cube([len-CONN_MALE_R,0.01,CONN_HEIGHT/2-CONN_MALE_RIM], center=true);
    }
    translate([0,-(CONN_MALE_W-2*CONN_MALE_RIM)/4,0])
        cube([len-CONN_MALE_R,(CONN_MALE_W-2*CONN_MALE_RIM)/2,CONN_HEIGHT/2], center=true);
}

module connector_male_quart(len) {
    connector_male_end(len);
    translate([(len-CONN_MALE_R)/2,CONN_MALE_W/2-CONN_MALE_RIM,CONN_HEIGHT/4])
        connector_male_bridge(len);
}

module connector_male(len) {
	rotate([0, 0, 180])
    translate([CONN_MALE_R,0,CONN_HEIGHT/2]) {
        connector_male_quart(len);
        mirror([0,0,1])
            connector_male_quart(len);
        mirror([0,1,0]) {
            connector_male_quart(len);
            mirror([0,0,1])
                connector_male_quart(len);
        }
    }
}

/******************************************************************************************************\
|* This bearing was once inspired by https://www.thingiverse.com/thing:2746804                        *|
\******************************************************************************************************/
module bearing() {
	rotate_extrude() {
		difference() {
			translate([4, 0]) square([7, 7]);
			translate([7.625, 0]) extractPolygon();
		}
	}
	for (angle=[0:40:360]) {
		rotate([0, 0, angle]) translate([7.62, 0]) bearingPin();
	}
}

module bearingPin() {
	half_pin();
	translate([0,0,7]) {
		mirror([0,0,1]) {
			half_pin();
		}
	}
}

module half_pin() {
	cylinder(0.25, 2.25, 2.5);
	translate([0,0,0.25]) cylinder(1.15, r=2.5);
	translate([0,0,1.40]) cylinder(1.40, 2.5, 1.5);
	translate([0,0,2.80]) cylinder(0.70, r=1.5);
}

module extractPolygonPart() {
	polygon([[2.925, 0], [2.675, 0.25], [2.675, 1.40], [1.7, 2.80], [1.7, 3.5], [0, 3.5], [0,0]]);
}

module extractPolygon() {
	extractPolygonPart();
	translate([0, 7, 0]) mirror([0, 1, 0]) extractPolygonPart();
	mirror([1, 0, 0]) {
		extractPolygonPart();
		translate([0, 7, 0]) mirror([0, 1, 0]) extractPolygonPart();
	}
}

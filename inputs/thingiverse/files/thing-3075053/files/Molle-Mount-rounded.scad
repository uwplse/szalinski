/* [General Settings] */

// Inner width in mm
innerWidth = 45;

// Strap width in mm
strapWidth = 30;

// Strap thickness of the left Strap in mm
strap1Thickness = 0.5;
// Same as left strap when zero
strap2Thickness = 0;

// Size of the left opening in mm
opening1 = 1;
// Same as left opening when zero
opening2 = 0;

// Share of height (may look odd with very small or very big values)
opening1Position = 0.8; // [0:0.01:1]
opening2Position = 0.8; // [0:0.01:1]

// Clip length in mm
length = 4;

/* [Print settings] */

// Wall thickness of the clip in mm
thickness = 2.5;

// Imprecision margin in mm
margin = 1;

// Start with a small value to preview, increase just before rendering
resolution = 15;

/* [Hidden] */
$fn = resolution;

module makeouter() {
	strap2Thickness =   strap2Thickness == 0 ? strap1Thickness : strap2Thickness;
	opening2 = opening2 == 0 ? opening1 : opening2;

	innerHeight = strapWidth + 2 * margin;

	outerWidth = innerWidth + strap1Thickness + strap2Thickness + 4 * margin;
	outerHeight = 2 * thickness + innerHeight;
	
	strapHoleHeight = strapWidth + 2 * margin + thickness;

	strapHole1Width = strap1Thickness * margin + thickness;
	strapHole2Width = strap2Thickness * margin + thickness;
	
	opening1Height = opening1 * margin;
	opening2Height = opening2 * margin;
	
	placeOpening1 = thickness + (innerHeight - opening1Height) * (1 - opening1Position);
	placeOpening2 = thickness + (innerHeight - opening2Height) * (1 - opening2Position);

	difference() {
		difference() {
			cube([outerWidth, outerHeight, length]);
			union() {
				translate([-thickness/2,0,0]) {
					//vRoundPlus(outerHeight, length, thickness);
				}
				translate([outerWidth + thickness/2,0,0]) {
					//mirror([1,0,0]) {
					//	vRoundPlus(outerHeight, length, thickness);
					//}
				}
				//hRoundPlus(outerWidth, length, thickness);
				translate([0,outerHeight,0]) {
					//mirror([0,1,0]) {
					//	hRoundPlus(outerWidth, length, thickness);
					//}
				}
				translate([thickness/2,thickness/2,0]) {
					cutEdge(length, thickness,180);
				}
				translate([outerWidth - thickness/2,thickness/2,0]) {
					cutEdge(length, thickness,270);
				}
				translate([outerWidth - thickness/2,outerHeight - thickness/2,0]) {
					cutEdge(length, thickness,0);
				}
				translate([thickness/2,outerHeight - thickness/2,0]) {
					cutEdge(length, thickness,90);
				}
			}				
		}
		union() {
			translate([thickness/2,thickness/2,0]) {
				strapHole(strapHole1Width, strapHoleHeight, length, thickness);
			}
			translate([outerWidth - strapHole2Width - thickness/2,thickness/2,0]) {
				strapHole(strapHole2Width, strapHoleHeight, length, thickness);
			}
			makeOpenings(outerHeight, outerWidth, placeOpening1, placeOpening2, opening1, opening2, opening1Height, opening2Height, length, thickness);
		}
	}
}

module strapHole(strapHoleWidth, strapHoleHeight, length, thickness) {
	
	translate([0, 0, -1]) {
		difference() {
			cube([strapHoleWidth, strapHoleHeight, length + 2]);
			union() {
				vRoundMinus(strapHoleHeight, length, thickness);
				translate([strapHoleWidth,0,0]) {
					vRoundMinus(strapHoleHeight, length, thickness);
				}
				hRoundMinus(strapHoleWidth, length, thickness);
				translate([0,strapHoleHeight,0]) {
					hRoundMinus(strapHoleWidth, length, thickness);
				}
			}
		}
	}
}

module opening(opening, openingHeight, length, thickness) {
	
	translate([-1, -thickness/2, -1]) {
		difference() {
			cube([thickness + 2, openingHeight + thickness, length + 2]);
			translate([thickness/2 + 1,0,1]) {
				pillar(length, thickness);
				translate([0,openingHeight + thickness,0]) {
					pillar(length, thickness);
				}
			}
		}
	}
}

module makeOpenings(outerHeight, outerWidth, placeOpening1, placeOpening2, opening1, opening2, opening1Height, opening2Height, length, thickness) {
	difference() {
		union() {
			translate([0,placeOpening1,0]) {
				opening(opening1, opening1Height, length, thickness);
			}
			translate([outerWidth - thickness,placeOpening2,0]) {
				opening(opening2, opening2Height, length, thickness);
			}
		}
		translate([thickness/2,-1,-2]) {
			cube([outerWidth - thickness,thickness + 1,length + 4]);
		}
		translate([thickness/2,outerHeight - thickness,-2]) {
			cube([outerWidth - thickness,thickness + 1,length + 4]);
		}
	}
}

module vRoundPlus(y, z, thickness) {
	translate([-1,-1,-1]) {
		difference() {
			cube([thickness + 1, y + 2, z + 2]);
			translate([thickness + 1,0,thickness/2 + 1]) {
				rotate([-90,0,0]) {
					//cylinder(d=thickness, h=y + 2);
				}
			}
			translate([thickness + 1,0,length + 1 - thickness/2]) {
				rotate([-90,0,0]) {
					//cylinder(d=thickness, h=y + 2);
				}
			}
			translate([thickness/2 + 1,0,thickness/2 + 1]) {
				cube([thickness/2,y + 2,z - thickness]);
			}
		}
	}
}

module hRoundPlus(x, z, thickness) {
	translate([-1,-thickness/2 -1,-1]) {
		difference() {
			cube([x + 2, thickness + 1, z + 2]);
			translate([0,thickness + 1,thickness/2 + 1]) {
				rotate([0,90,0]) {
					//cylinder(d=thickness, h=x + 2);
				}
			}
			translate([0,thickness + 1,length + 1 - thickness/2]) {
				rotate([0,90,0]) {
					//cylinder(d=thickness, h=x + 2);
				}
			}
			translate([0,thickness/2 + 1,thickness/2 + 1]) {
				cube([x + 2, thickness/2,z - thickness]);
			}
		}
	}
}

module vRoundMinus(y, z, thickness) {
	translate([0,-1,thickness/2 + 1]) {
		rotate([-90,0,0]) {
			//cylinder(d=thickness, h=y + 2);
		}
	}
	translate([0,-1,length + 1 - thickness/2]) {
		rotate([-90,0,0]) {
			//cylinder(d=thickness, h=y + 2);
		}
	}
	translate([-thickness/2,-1,thickness/2 + 1]) {
		//cube([thickness,y + 2,z - thickness]);
	}
}

module hRoundMinus(x, z, thickness) {
	translate([-1,0,thickness/2 + 1]) {
		rotate([0,90,0]) {
			//cylinder(d=thickness, h=x + 2);
		}
	}
	translate([-1,0,length + 1 - thickness/2]) {
		rotate([0,90,0]) {
			//cylinder(d=thickness, h=x + 2);
		}
	}
	translate([-1,-thickness/2,thickness/2 + 1]) {
		//cube([x + 2,thickness,z - thickness]);
	}
}

module cutEdge(length, thickness, rotation) {
	rotate([0,0,rotation]) {
		difference() {
			translate([0,0,-1]) {
				cube([thickness,thickness,length+2]);
			}
			pillar(length, thickness);
		}
	}
}

module pillar(length, thickness) {
	union() {
		translate([0,0,0]) {
			cylinder(d=thickness, h=length);
			//sphere(d=thickness);
		}
		//translate([0,0,length-thickness/2]) {
			//sphere(d=thickness);
		//}
	}
}

makeouter();

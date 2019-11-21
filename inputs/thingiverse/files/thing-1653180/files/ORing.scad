part = "both"; // [first:Mold 1 Only,second:Mold 2 Only,both:Mold 1 and Mold 2]

/* [Parameters] */
//The inner diameter (ID) of the O-ring in Millimeters
Inner_Diameter = 10; // [1:100]
//The thickness/diameter of the of the O-ring in Millimeters
Thickness = 5; // [1:10]

/* [Hidden] */
moldWalls = 5;
tolerance = 0.3;
resolution = 100;

radius = Thickness/2;
outerDiameter = Inner_Diameter + (Thickness*2);
moldHeight = 1.5*(outerDiameter + (moldWalls*2));
moldWidth = moldHeight;
moldDepth = 1.5*(radius + moldWalls);
Sprue_Radius = radius/1.5;

print_part();

module print_part() {
	if (part == "first") {
		mold1();
	} else if (part == "second") {
		mold2();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

module both() {
    mold1();
    mold2();
}

module mold1() {
    translate([0,0,moldDepth]) {
    rotate([0,-90,0]) {
    translate([0,(moldWidth/1.5),0]) {
        rotate([0,0,180]) {
            union() {
            difference() {
                union() {
                    difference() {
                        translate([0,-(moldWidth/2),-(moldWidth/2)]) {
                            cube([moldDepth,moldWidth,moldHeight]);
                        }
                        rotate([0,90,0]) {
                            rotate_extrude(convexity = 10, $fn = resolution) {
                                translate([radius + (Inner_Diameter/2),0,0]) {
                                    circle(radius, $fn = resolution);
                                }
                            }
                        }
                    }
                    rotate([0,90,0]) {
                        rotate_extrude(convexity = 10, $fn = resolution) {
                            translate([radius + ((1.5*(Inner_Diameter + radius + 6))/2),0,0]) {
                                circle(radius, $fn = resolution);
                            }
                        }
                    }
                }
                translate([0,0,(Inner_Diameter/2) + radius]) {
                    cylinder((moldHeight/2), r = Sprue_Radius, $fn = resolution);
                }
            }
            translate([0, (moldWidth - (3*(radius)+2))/2, (moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1), $fn = resolution);
            }
            translate([0, -(moldWidth - (3*(radius)+2))/2, -(moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1), $fn = resolution);
            }
            translate([0, (-(moldWidth - (3*(radius)+2))/2), (moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1), $fn = resolution);
            }
            translate([0, (moldWidth - (3*(radius)+2))/2, -(moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1), $fn = resolution);
            }
        }
        }
    }
}
}
}

module mold2() {
    translate([0,0,moldDepth]) {
    rotate([0,-90,0]) {
    translate([0,(-(moldWidth/1.5)),0]) {
        difference() {
        difference() {
            difference() {
                difference() {
                    translate([-(moldDepth),-(moldWidth/2),-(moldWidth/2)]) {
                        cube([moldDepth,moldWidth,moldHeight]);
                    }
                    rotate([0,90,0]) {
                        rotate_extrude(convexity = 10, $fn = resolution) {
                            translate([radius + (Inner_Diameter/2),0,0]) {
                                circle(radius, $fn = resolution);
                            }
                        }
                    }
                }
                rotate([0,90,0]) {
                    rotate_extrude(convexity = 10, $fn = resolution) {
                        translate([(radius + (tolerance/2)) + ((1.5*((Inner_Diameter - tolerance) + radius + 6))/2),0,0]) {
                            circle(radius + tolerance, $fn = resolution);
                        }
                    }
                }
            }
            translate([0,0,(Inner_Diameter/2) + radius]) {
                cylinder((moldHeight/2), r = Sprue_Radius, $fn = resolution);
            }
        }
            translate([0, (moldWidth - (3*(radius)+2))/2, (moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1)+tolerance, $fn = resolution);
            }
            translate([0, -(moldWidth - (3*(radius)+2))/2, -(moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1)+tolerance, $fn = resolution);
            }
            translate([0, -(moldWidth - (3*(radius)+2))/2, (moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1)+tolerance, $fn = resolution);
            }
            translate([0, (moldWidth - (3*(radius)+2))/2, -(moldHeight - (3*(radius)+2))/2]) {
                sphere((radius*1)+tolerance, $fn = resolution);
            }
        }
    }
}
}
}
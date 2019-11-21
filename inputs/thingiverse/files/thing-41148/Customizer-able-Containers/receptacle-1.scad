
// The shape of pot you'd like
potShape = 0; // [0:14]

// The number of sides (0 for Cylindrical)
numberSides = 4; // [0:100]

drawReceptacle(potShape,numberSides);

module hSphere(r=1,t=0.1,ns,rot) {
	difference() {
		sphere(r);
		sphere(r-t);
	}
}

rotationList=[0,0,0,60,0,-36,60,180/7,0,-20,36,180/11,0,-180/13,180/7,12,0,0,0,0,0,0];

module drawReceptacle(number,sides) {
	ns=(sides<3)?100:sides;
	rotby=(ns>20)?0:rotationList[ns];

		if (number==1) { receptacle3(ns,rotby);
	} else if (number==2) { receptacle1(ns,rotby);
	} else if (number==3) { receptacle2(ns,rotby);
	} else if (number==4) { receptacle5(ns,rotby);
	} else if (number==5) { receptacle6(ns,rotby);
	} else if (number==6) { receptacle7(ns,rotby);
	} else if (number==7) { receptacle4(ns,rotby);
	} else if (number==8) { receptacle8(ns,rotby);
	} else if (number==9) { receptacle9(ns,rotby);
	} else if (number==10) { receptacle10(ns,rotby);
	} else if (number==11) { receptacle11(ns,rotby);
	} else if (number==12) { receptacle14(ns,rotby);
	} else if (number==13) { receptacle12(ns,rotby);
	} else if (number==14) { receptacle13(ns,rotby);
	} else { 
		 receptacle0(ns,rotby);
	}	
}

diameter=50;
height=100;
quality=120;
$fn=quality;
numbsides=100; rotation=0;


module hSphere(r=1,t=0.1,ns,rot) {
	difference() {
		sphere(r);
		sphere(r-t);
	}
}
module hTorus(r=1,t=0.1,ns,rot) {
	scale([1,1,2])difference() {
		rotate([0,0,rot]) rotate_extrude(convexity=15,$fn=ns) translate([r*2/3, 0, 0]) circle(r/3,$fn=quality); 
		rotate([0,0,rot]) scale([1,1,1.2])rotate_extrude(convexity=15,$fn=ns) translate([r*2/3, 0, 0]) circle(r/3-t,$fn=quality); 
	}
}
module nTorus(r=1,t=0.1,ns,rot) {
	scale([1,1,2])difference() {
		rotate([0,0,rot]) rotate_extrude(convexity=15,$fn=ns) translate([r*2/3, 0, 0]) circle(r/3,$fn=quality); 
		rotate([0,0,rot]) scale([1,1,1.1])rotate_extrude(convexity=15,$fn=ns) translate([r*2/3, 0, 0]) circle(r/3-t,$fn=quality); 
	}
}

module receptacle0(ns,rot) {
	intersection() { translate([0,0,0.5])cube(1,center=true);
		scale([1/122,1/122,1/112])translate([0,0,-2.64])difference() {
			scale([1,1,2]) translate([0,0,((30+6)*2*0.813)/2]) union() {
				difference() {
					rotate([0,0,rot]) { rotate_extrude(convexity = 10,$fn=ns) translate([31, 0, 0]) circle(30,$fn=quality);  }
					rotate([0,0,rot]) { scale([1,1,1.08]) rotate_extrude(convexity = 10,$fn=ns) translate([31, 0, 0]) circle(24,$fn=quality); }
					cylinder(31*2.5,31*1.35,31*1.35,center=true,$fn=ns);
				}
				translate([0,0,22.95])cylinder(5,31*1.352,31*1.352,$fn=ns);
				translate([0,0,0-27.95])cylinder(4.9,31*1.352,31*1.352,$fn=ns);
			}
			translate([0,0,108])cylinder(9.1,42,36,center=true,$fn=ns);
			translate([0,0,112])cylinder(9,38,41,center=true,$fn=ns);
		}
	}
}
module receptacle1(ns,rot) {
	intersection() { translate([0,0,0.5])cube(1,center=true);
		scale([1/2,1/2,1/2])translate([0,0,0.5]) union() {
			difference() {
				hTorus(1,0.1,ns,rot);
				cylinder(1.8,0.83,0.83,center=true,$fn=ns);
			}
			scale([1.67,1.67,1]) translate([0,0,-0.5275]) cylinder(0.1,0.498,0.498,center=true,$fn=ns);
		
			difference() {
				union() {
					scale([1.67,1.67,1]) translate([0,0,0.96])  {
						intersection() {
							hTorus(1,0.1,ns,rot);
							cylinder(1.5,0.5,0.5,center=true,$fn=ns);
						}
					}
					rotate([0,0,rot]) translate([0,0,1.442])rotate_extrude(convexity = 10,$fn=ns) translate([0.83, 0, 0]) scale([0.4,1,1])circle(0.1,$fn=quality); 
				}
				union() {
					translate([0,0,0.6])cylinder(0.5,0.85,0.61,center=true,$fn=ns);
					translate([0,0,0.05])cylinder(0.6,0.85,0.85,center=true,$fn=ns);
				}
			}
		}
	}
}
module receptacle2(ns,rot) {
	intersection() { translate([0,0,0.5])cube(1,center=true);
		scale([1/2,1/2,1/3])translate([0,0,0.5]) union() {
			difference() {
				hTorus(1,0.1,ns,rot);
				cylinder(1.8,0.83,0.83,center=true,$fn=ns);
			}
			scale([1.67,1.67,1]) translate([0,0,-0.5275]) cylinder(0.1,0.498,0.498,center=true,$fn=ns);
		
			difference() {
				scale([1,1,2]) union() {
					scale([1.67,1.67,1]) translate([0,0,0.96+((2-1)*-0.29)])  {
						intersection() {
							hTorus(1,0.1,ns,rot);
							cylinder(1.5,0.5,0.5,center=true,$fn=ns);
						}
					}
					rotate([0,0,rot]) translate([0,0,1.442+((2-1)*-0.29)])rotate_extrude(convexity = 10,$fn=ns) translate([0.83, 0, 0]) scale([0.4,1,1])circle(0.1,$fn=quality); 
				}
				union() {
					translate([0,0,0.6])cylinder(0.5,0.85,0.61,center=true,$fn=ns);
					translate([0,0,0.05])cylinder(0.6,0.85,0.85,center=true,$fn=ns);
				}
			}
		}
	}
}
module receptacle3(ns,rot) {
	intersection() { translate([0,0,0.5])cube(1,center=true);
		scale([1/2,1/2,1/1.75])translate([0,0,0.5]) union() {
			difference() {
				hTorus(1,0.1,ns,rot);
				cylinder(1.8,0.83,0.83,center=true,$fn=ns);
			}
			scale([1.67,1.67,1]) translate([0,0,-0.5275]) cylinder(0.1,0.498,0.498,center=true,$fn=ns);
		
			difference() {
				scale([1,1,0.7]) union() {
					scale([1.67,1.67,1]) translate([0,0,1.215])  {
						intersection() {
							hTorus(1,0.1,ns,rot);
							cylinder(1.5,0.5,0.5,center=true,$fn=ns);
						}
					}
					rotate([0,0,rot]) translate([0,0,1.697])rotate_extrude(convexity = 10,$fn=ns) translate([0.83, 0, 0]) scale([0.4,1,1])circle(0.1,$fn=quality); 
				}
				union() {
					translate([0,0,0.6])cylinder(0.5,0.85,0.61,center=true,$fn=ns);
					translate([0,0,0.05])cylinder(0.6,0.85,0.85,center=true,$fn=ns);
				}
			}
		}
	}
}
module receptacle4(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.47])translate([0,0,0.57]) union() {
			difference() {
				hTorus(1,0.1,ns,rot);
				translate([0,0,-1.38])cylinder(1.8,0.83,0.83,center=true,$fn=ns);
				cylinder(1.8,0.65,0.65,center=true,$fn=ns);
				translate([0,0,0.5])cylinder(1,1.1,1.1,center=true,$fn=ns);
			}
			scale([1.67,1.67,1]) translate([0,0,-0.5275]) cylinder(0.1,0.498,0.498,center=true,$fn=ns);
			translate([0,0,0.75])difference() {
				cylinder(1.5,1,1,center=true,$fn=ns);
				cylinder(2,0.9,0.9,center=true,$fn=ns);
			}
			rotate([0,0,rot]) translate([0,0,1.5])rotate_extrude(convexity = 10,$fn=ns) translate([0.95, 0, 0]) circle(0.05,$fn=quality); 
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}
module receptacle5(ns,rot) {
	intersection() {
		scale([0.39,0.39,0.445])translate([0,0,0.5752]) union() {
			difference() {
				hTorus(1,0.1,ns,rot);
				translate([0,0,-1.38])cylinder(1.8,0.83,0.83,center=true,$fn=ns);
				cylinder(1.8,0.65,0.65,center=true,$fn=ns);
				translate([0,0,0.5])cylinder(1,1.1,1.1,center=true,$fn=ns);
			}
			scale([1.67,1.67,1]) translate([0,0,-0.5275]) cylinder(0.1,0.498,0.498,center=true,$fn=ns);
			translate([0,0,0.5])difference() {
				cylinder(1,1,1,center=true,$fn=ns);
				cylinder(2,0.9,0.9,center=true,$fn=ns);
			}
			rotate([0,0,rot]) translate([0,0,1.61])rotate_extrude(convexity = 10,$fn=ns) translate([1.24, 0, 0]) scale([1,3,1])circle(0.025,$fn=quality); 
			scale([2.515,2.515,2])translate([0,0,0.25]) intersection() {
					nTorus(1,0.041,ns,rot);
					cylinder(1.5,0.5,0.5,center=true,$fn=ns);
					translate([0,0,0.5])cylinder(0.5,1,1,center=true,$fn=ns);
				}
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}
module receptacle6(ns,rot) {
	intersection() {
		scale([0.39,0.39,0.57])translate([0,0,0.5752]) union() {
			difference() {
				hTorus(1,0.1,ns,rot);
				translate([0,0,-1.38])cylinder(1.8,0.83,0.83,center=true,$fn=ns);
				cylinder(1.8,0.65,0.65,center=true,$fn=ns);
				translate([0,0,0.5])cylinder(1,1.1,1.1,center=true,$fn=ns);
			}
			scale([1.67,1.67,1]) translate([0,0,-0.5275]) cylinder(0.1,0.498,0.498,center=true,$fn=ns);
			translate([0,0,0.25])difference() {
				cylinder(0.5,1,1,center=true,$fn=ns);
				cylinder(2,0.9,0.9,center=true,$fn=ns);
			}
			rotate([0,0,rot]) translate([0,0,1.11])rotate_extrude(convexity = 10,$fn=ns) translate([1.24, 0, 0]) scale([1,3,1])circle(0.025,$fn=quality); 
			scale([2.515,2.515,2])translate([0,0,0]) intersection() {
					nTorus(1,0.041,ns,rot);
					cylinder(1.5,0.5,0.5,center=true,$fn=ns);
					translate([0,0,0.5])cylinder(0.5,1,1,center=true,$fn=ns);
				}
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}
module receptacle7(ns,rot) {
	intersection() {
		scale([0.39,0.39,0.8])translate([0,0,0.5752]) union() {
			difference() {
				hTorus(1,0.1,ns,rot);
				translate([0,0,-1.38])cylinder(1.8,0.83,0.83,center=true,$fn=ns);
				cylinder(1.8,0.65,0.65,center=true,$fn=ns);
				translate([0,0,0.5])cylinder(1,1.1,1.1,center=true,$fn=ns);
			}
			scale([1.67,1.67,1]) translate([0,0,-0.5275]) cylinder(0.1,0.498,0.498,center=true,$fn=ns);
			rotate([0,0,rot]) translate([0,0,0.61])rotate_extrude(convexity = 10,$fn=ns) translate([1.24, 0, 0]) scale([1,3,1])circle(0.025,$fn=quality); 
			scale([2.515,2.515,2])translate([0,0,-0.25]) intersection() {
					nTorus(1,0.041,ns,rot);
					cylinder(1.5,0.5,0.5,center=true,$fn=ns);
					translate([0,0,0.5])cylinder(0.5,1,1,center=true,$fn=ns);
				}
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}
module receptacle8(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.48])translate([0,0,0.5]) union() {
			translate([0,0,0.25])difference() {
				cylinder(1.5,1,1,center=true,$fn=ns);
				cylinder(2,0.9,0.9,center=true,$fn=ns);
			}
			translate([0,0,-0.45]) cylinder(0.1,1,1,center=true,$fn=ns);
			translate([0,0,1])rotate([180,0,0])difference() {
				hTorus(1,0.1,ns,rot);
				translate([0,0,-1.25])cylinder(1.8,0.83,0.83,center=true,$fn=ns);
				cylinder(1.8,0.65,0.65,center=true,$fn=ns);
				translate([0,0,0.5])cylinder(1,1.1,1.1,center=true,$fn=ns);
			}
			rotate([0,0,rot]) translate([0,0,1.493])rotate_extrude(convexity = 10,$fn=ns) translate([0.83, 0, 0]) scale([1,3.5,1])circle(0.025,$fn=quality); 
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}

module receptacle9(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.48])translate([0,0,0.5]) union() {
			translate([0,0,0.25])difference() {
				cylinder(2.5,1,1,center=true,$fn=ns);
				cylinder(2.6,0.9,0.9,center=true,$fn=ns);
			}
			translate([0,0,-0.45]) cylinder(0.1,1,1,center=true,$fn=ns);
			rotate([0,0,rot]) translate([0,0,1.5])rotate_extrude(convexity = 10,$fn=ns) translate([0.95, 0, 0]) circle(0.05,$fn=quality); 
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}

module receptacle10(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.48])translate([0,0,0.5]) union() {
			scale([2,2,2])translate([0,0,0.25]) intersection() {
					nTorus(1,0.041,ns,rot);
					cylinder(1.5,0.5,0.5,center=true,$fn=ns);
					translate([0,0,0.5])cylinder(0.5,1,1,center=true,$fn=ns);
				}
			translate([0,0,0.25])difference() {
				cylinder(1.5,0.795,0.795,center=true,$fn=ns);
				cylinder(2.1,0.717,0.717,center=true,$fn=ns);
			}
			translate([0,0,-0.45]) cylinder(0.1,0.795,0.795,center=true,$fn=ns);
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}
module receptacle11(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.48])translate([0,0,0.5]) union() {
			scale([2,2,2])translate([0,0,0.25]) intersection() {
					nTorus(1,0.041,ns,rot);
					cylinder(1.5,0.5,0.5,center=true,$fn=ns);
					translate([0,0,-0.5])cylinder(0.5,1,1,center=true,$fn=ns);
				}
			translate([0,0,0.75])difference() {
				cylinder(1.5,0.795,0.795,center=true,$fn=ns);
				cylinder(2.1,0.717,0.717,center=true,$fn=ns);
			}
			translate([0,0,-0.45]) cylinder(0.1,0.95,0.9,center=true,$fn=ns);
			rotate([0,0,rot]) translate([0,0,1.5])rotate_extrude(convexity = 10,$fn=ns) translate([0.76, 0, 0]) circle(0.035,$fn=quality); 
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}
module receptacle12(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.48])translate([0,0,0.5]) union() {
			translate([0,0,0.25])difference() {
				cylinder(2.5,0.5,1,center=true,$fn=ns);
				cylinder(2.6,0.4,0.9,center=true,$fn=ns);
			}
			translate([0,0,-0.45]) cylinder(0.1,0.55,0.55,center=true,$fn=ns);
			rotate([0,0,rot]) translate([0,0,1.5])rotate_extrude(convexity = 10,$fn=ns) translate([0.947, 0, 0]) circle(0.052,$fn=quality); 
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}
module receptacle13(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.48])translate([0,0,0.5]) union() {
			translate([0,0,0.25])difference() {
				cylinder(2.5,1,0.6,center=true,$fn=ns);
				cylinder(2.6,0.9,0.5,center=true,$fn=ns);
			}
			translate([0,0,-0.45]) cylinder(0.1,0.9,0.9,center=true,$fn=ns);
			rotate([0,0,rot]) translate([0,0,1.5])rotate_extrude(convexity = 10,$fn=ns) translate([0.554, 0, 0]) circle(0.045,$fn=quality); 
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}

module receptacle14(ns,rot) {
	intersection() {
		scale([0.5,0.5,0.48])translate([0,0,0.5]) union() {
			scale([2,2,2])translate([0,0,0.25]) intersection() {
					nTorus(1,0.041,ns,rot);
					cylinder(1.5,0.5,0.5,center=true,$fn=ns);
					translate([0,0,0.5])cylinder(0.5,1,1,center=true,$fn=ns);
				}
			translate([0,0,0.5])difference() {
				cylinder(1,0.795,0.795,center=true,$fn=ns);
				cylinder(2.1,0.717,0.717,center=true,$fn=ns);
			}
			scale([2,2,2])translate([0,0,0.25]) intersection() {
					nTorus(1,0.041,ns,rot);
					cylinder(1.5,0.5,0.5,center=true,$fn=ns);
					translate([0,0,-0.5])cylinder(0.5,1,1,center=true,$fn=ns);
				}
			translate([0,0,-0.45]) cylinder(0.1,0.95,0.9,center=true,$fn=ns);
		}
		translate([0,0,0.5]) cube(1,center=true);
	}
}

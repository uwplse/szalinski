//
// Mudguard (beta)
//
//  Quick and "really" dirty version.
//
// Minimotors Speedway Mini 4 (Pro)
// Ruima mini 4
//
//
// Works with openscad >2017 (nightly build ok)
//
// Author: Guillaume F.
//

mg_width	= 145;	/* width */
mg_diameter	= 200;	/* diameter... > wheel */
mg_thick	= 2.5;  /* thickness */

//mg_resol	= 400;  /* for print */
mg_resol	= 50;   /* to work */

mg_screwpos	= [[0,0],[16.5,40],[78+16.5,40],[111,0]]; /* clockwise with rear left in 0,0 */
mg_screwblockpos_x = 220;
mg_screwsupport_thick = 5;
screw_diameter	= 4.2;
screw_space	= 8;

/* Options */
topRounded = 1;
makeFancy = 1;

/* Generate: 1=Full, 2=Splitted Bottom, 3=Splitted Top */
make = 1;



module MudGuard_Vanilla(mask) {
	/* apply final reshape to the mudguard */
	scale(v = [1, 1, 1]) {
		difference() {
			translate([39,-100,0]) {
				difference() {
					scale(v = [0.97, 1, 0.85]) {
						/* Angle : length of the mudguard */
						rotate_extrude(angle=65, convexity=10,  $fn = mg_resol)
							translate([mg_diameter, 0]) circle( mg_width/2  );
					}
					if (! mask) {
						/* y:  thickness of the tail */
						scale(v=[0.94,1,0.83])
							/* apply the thickness on the base */
							translate([ - mg_thick , -mg_thick, 0 ]) {
								union() {
									/* y: The cylinder translate for the shrink effect on the end of the mudguard */
									translate([-65,40,0]) {
										cylinder( r = 50 + mg_diameter+mg_thick*5, h=mg_width*10, $fn = mg_resol, center=true );
									}
									rotate([0,0,0]) {
										scale(v = [1, 1, 1]) {
											rotate_extrude(angle=200, convexity=10, $fn = mg_resol)
												translate([mg_diameter, 0, 0])
												scale(v=[1,1,1]) circle( mg_width/2 );
										}
									}
								}
							}
					}
				}
			}
			translate([255,-255,0]) {
				cube(510,center=true);
			}
		}
	}
}

module ScrewHole(y,x,mask) {
	translate([x,0,y]) {
		rotate([90,0,0]) {
			if (mask == 1) {
				cylinder( r = screw_space/2, h = 500, $fn=mg_resol/2, center=true );
			}
			else if (mask == 2) {
				cylinder( r = screw_space/2 + 3, h = 500, $fn=mg_resol/2, center=true );
			}
			else {
				cylinder( r = screw_diameter/2, h = 500, $fn=mg_resol/2, center=true );
			}
		}
	}
}
module ScrewHoles(mask) {
	translate([mg_screwblockpos_x,0,-(mg_screwpos[3][0]/2)]) {
		union() {
			ScrewHole(mg_screwpos[0][0],mg_screwpos[0][1],mask);
			ScrewHole(mg_screwpos[1][0],mg_screwpos[1][1],mask);
			ScrewHole(mg_screwpos[2][0],mg_screwpos[2][1],mask);
			ScrewHole(mg_screwpos[3][0],mg_screwpos[3][1],mask);
		}
	}
}
module ScrewHolesDrill() {
	ScrewHoles(0);
}
module ScrewHolesSupport() {
	difference() {
		translate([0,500/2,0]) {
			difference() {
				difference() {
					ScrewHoles(2);
					ScrewHoles(0);
				}
				translate([0,mg_screwsupport_thick,0]) {
					ScrewHoles(1);
				}
			}
		}
		difference() {
			translate([500/2,500/2,0]) {
				cube(510,center=true);
			}
			MudGuard_Vanilla(1);
		}
	}
}
module ScrewHolesMask() {
	translate([0, 500/2 + mg_screwsupport_thick, 0]) {
		ScrewHoles(1);
	}
}

module triangleMask(x,y,diam) {
	translate([x,y,0]) {
		difference() {
			linear_extrude(height = 500, center = true, convexity = 10, twist = 0) {
				rotate([0,0,130])
					rotate([60,0,0])
					circle(r = diam/2, $fn=3);
			}
		}
	}
}
module triangleMasks() {
	/* tail */
	triangleMask(203,70,20);
	triangleMask(193,85,18);
	triangleMask(182,100,16);
	triangleMask(171,113,14);
	/* head */
	triangleMask(223,70,12);
	triangleMask(212,85,11);
	triangleMask(200,100,10);
	triangleMask(187,113,9);
}

module topRoundMask() {
	l = 150;
	translate([100,180,0]) {
		rotate([0,0,-13])
		difference() {
			cube(l, center=true);
			translate([l*5/6,0,0])
				cylinder( r = l/2, h=500, $fn = mg_resol, center=true );
		}
	}
}

/* Final Solid - rotated properly */
module MudGuardSolid() {
	rotate([90,0,0]) {
		difference() {
			union() {
				difference() {
					difference() {
						difference() {
							difference() {
								MudGuard_Vanilla();
								ScrewHolesDrill();
							}
							ScrewHolesMask();
						}
					}
					if (topRounded) {
						topRoundMask();
					}
				}
				ScrewHolesSupport();
			}
			if (makeFancy) {
				triangleMasks();
			}
		}
	}
}

module MudGuardSplitBlockTop() {
	translate([150,0,0])
		rotate([0,-40,0])
		translate([0,-500,0])
		cube(1000,false);
}
module MudGuardSplitBlockBottom() {
	translate([150,0,0])
		rotate([0,-40,0])
		translate([0,-500,-1000])
		cube(1000,false);
}

module MudGuardBottom() {
	difference() {
		MudGuardSolid();
		MudGuardSplitBlockTop();
	}
}
module MudGuardTop() {
	difference() {
		MudGuardSolid();
		MudGuardSplitBlockBottom();
	}
}

/* Full */
if (make == 1) {
	MudGuardSolid();
}
else if (make == 2) {
	MudGuardBottom();
}
else if (make == 3) {
	MudGuardTop();
}


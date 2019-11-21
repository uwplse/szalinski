// preview[view:north east, tilt:top diagonal]

////////////////////////////////////////////////////////////////////////////
/* [Impeller Blade Settings] */


// BLADE SETTINGS //

// how many blades
numBlades = 7;
// thickness of the blades
bladeGirth = 3;
// height of blades
bladeHeight = 13;
// type of blades used
bladeType = "curved"; // [straight,curved]
// curved blade curvature
bladeCurvature = 0.6;
// blade direction (doesn't affect straight blades)
bladeDirection = "CCW"; // [CW,CCW]
// angle of twist for the curved blade setting
twistAngle = 15;
// resolution of the curved blades
sliceRes = 5;
// thickness of the base of the impeller
baseGirth = 2;

// IMPELLER BODY //

// diameter of the main fan/impeller
fanDiameter = 45;
// shape of the shaft hole profile
shaftShape = "smooth"; // [smooth,hex,D]
// diameter of the shaft hole for attaching a motor
shaftDiameter = 2;
// type of impeller air intake cutout
cutoutType = "cone"; // [cylinder,cone]
// angle of cone cutout
coneAngle = 40; // [1:89]
// offset width of the boss surrounding the shaft hole
shaftBossOffset = 3;
// height of the boss
bossHeight = 6;
// D-shaft profile, sets the position of the flat edge
DcutRatio = 0.6;


// impeller calculations
coneMod = (bladeHeight*tan(coneAngle))/2;
shaftRadius = shaftDiameter/2;
fanRadius = fanDiameter/2;
shaftBossDiameter = shaftBossOffset + shaftDiameter;
shaftBossRadius = shaftBossDiameter/2;

// cutting profile distance for D shaft profile
DcutDist = shaftRadius*(1 - DcutRatio);

// curved blade cutout radius
bladeRadius = fanRadius * bladeCurvature;

// thickness of curved blades
curvedBladeThickness = bladeGirth / 1.42;


////////////////////////////////////////////////////////////////////////////

/* [Housing Settings] */

// HOUSING BODY AND SIZING // 
// impellerOD and housingID spacing
housingOffsetDiameter = 3;
// Z spacing from fans to cap
housingOffsetHeight = 4;
// thickness of the housing walls
housingWallThickness = 2;

// DC MOTOR HOUSING //
// DC motor mount ID
DCmotorID = 25;
// motor mount OD
DCmotorOD = 29;
// height of the motor mount, set to 0 to remove, otherwise it is located underneath the housing
motorMountHeight = 0;
// housing motor shaft diameter
MotorDiameter = 6;

// OUTLET // 
// outlet Length in radius's
outletLengthMultiplier = 1.5;
// ridge tolerance for fitting the cap
ridgeTolerance = 0.25;

// Radius calculations
DCmotorIDr = DCmotorID/2;
DCmotorODr = DCmotorOD/2;


// housing calculations
// calculations for the output

// outlet outer length
outletLength = fanRadius*outletLengthMultiplier;

// housing ID
housingID = fanDiameter + housingOffsetDiameter;
housingOD = housingID + housingWallThickness;
housingHeight = (bladeHeight + baseGirth + housingOffsetHeight);    
outletCut = housingHeight - (2*baseGirth);

////////////////////////////////////////////////////////////////////////////

/* [Mounting Holes Settings] */

// how many mounting holes
numHoles = 2; // [0,2,4]
// diameter of the mounting holes
holeDiameter = 3;
// Mounting holes boss OD
holeBossOffset = 3;

// mounting holes calculations
holeBossDiameter = holeDiameter + holeBossOffset;
holeBossRadius = holeBossDiameter/2;
holeRadius = holeDiameter/2;


////////////////////////////////////////////////////////////////////////////

/* [Cap Inlet Settings] */

// thickness of cap
capThickness = 1.5;
// Inlet OD
capHoleDiameter = 6.6;
// Inlet ID offset
capBossOffset = 2;
// height of inlet
capAdapterHeight = 7.5;

// cap calculations
capBossDiameter = capHoleDiameter + capBossOffset;


////////////////////////////////////////////////////////////////////////////

/* [Outlet Adapter Settings] */

// Turn outlet Adapter ON/OFF
outletAdpaterON = "true"; // [true,false]
// outlet type
outletAdpaterType = "tube"; // [tube,airhose,square]
// undersizing of outlet housing for fitting tolerances
outletFittingTolerance = 0.3;
// depth of adapter to housing outlet fitting
outletAdpaterMaleLength = 3;
// thickness of adapter on the housing lip
outletAdapterLink = 2;
// converted outlet's OD
outletTubeOD = 8;
// converted outlet's ID
outletTubeID = 6;
// converted outlet's length
outletTubeLength = 7;

////////////////////////////////////////////////////////////////////////////
/* [View Settings] */

// view mode, all places parts in single print mode, assembled puts the components together
viewObject = "all"; // [impeller,housing,cap,adapter,all,assembled]

viewAdapter = "true"; // [true,false]
viewImpeller = "true"; // [true,false]
viewHousing = "true"; // [true,false]
viewCap = "true"; // [true,false]


/* [Hidden] */
$fn = 40;

module Dshaft(height) {
	intersection() {
		cylinder(h = height, r = shaftRadius, center = true);
		translate([DcutDist,0,0])
		cube([2*shaftRadius,2*shaftRadius,height],true);
	}
}

module impeller4() {
	difference() {
		union(){
			// impeller base
            cylinder(h = baseGirth,r = fanRadius, center = true);
            // impeller blades
            if (bladeType == "straight") {
	            for (i = [0:numBlades]) {
	                rotate([0,0,i*360/numBlades])
	                translate([fanRadius/2,0,(bladeHeight+baseGirth)/2]) 
	                cube([fanRadius,bladeGirth,bladeHeight],true);
	            }
	        } else if (bladeType == "curved") {
	        	for (i = [0:numBlades]) {
				rotate([0,0,i*360/numBlades])
				translate([0,0,baseGirth/2])
                curvedBlade2();
				}
	        }

            // impeller boss
            translate([0,0,(bladeGirth/2)])
            cylinder(h = bossHeight, r = shaftBossRadius, center = false);
		}

		union() {
			// air intake cutaway
			if (cutoutType == "cylinder") {
	            // translate([0,0,(bossHeight + baseGirth*1.5 + 0.01)]) 
	            translate([0,0,(bladeHeight - (bladeHeight - bossHeight)/2) + baseGirth/2]) 
            	cylinder(h = (bladeHeight - bossHeight)*1.01, r = shaftBossRadius, center = true);
            } else if (cutoutType == "cone") {
	            // translate([0,0,(bossHeight + baseGirth*1.5 + 0.01)]) 
	            translate([0,0,(bladeHeight - (bladeHeight - bossHeight)/2) + baseGirth/2]) 
            	cylinder(h = (bladeHeight - bossHeight)*1.01, r1 = shaftBossRadius, r2 = shaftBossRadius + coneMod, center = true);
            }

			// shaft cutout
            // translate([0,0,0])
            if (shaftShape == "smooth") { 
            	cylinder(h = (bladeHeight + baseGirth)*2.5, r = shaftRadius, center = true, $fn = 30);
            } else if (shaftShape == "hex") {
            	cylinder(h = (bladeHeight + baseGirth)*2.5, r = shaftRadius, center = true, $fn = 6);
            } else if (shaftShape == "D") {
            	Dshaft((bladeHeight + baseGirth)*2.5);
            }
		}
	}
}

module curvedBlade2() {
    linear_extrude(height = bladeHeight, twist = twistAngle, slices = sliceRes)
    // blades
    difference() {
        // blade base
        translate([(bladeRadius - (shaftRadius/2)),0,0])
        circle(r = bladeRadius, center = true);

        // blade cutout and cleanup
        union() {
            // main blade shape
            translate([(bladeRadius - (shaftRadius/2)) + curvedBladeThickness,-curvedBladeThickness,0])
            circle(r = bladeRadius, center = true);

            // bottom of blade cube cutout
            translate([0,-fanRadius,0])
            square(fanRadius*2,true);

            // cylindrical cutout for blades hanging off the main base
            difference() {
                // OD
                circle(r = fanRadius*5, center = true);

                // ID
                circle(r = fanRadius, center = true);
            }
        }
    }
}

module Housing1() {
    
    difference() {
        union() {
            // makes the outer cylinder
            cylinder(h = housingHeight, r = housingOD/2, center = true);

            // makes the outlet block
            translate([(housingOD - housingHeight)/2,outletLength/2,0])
            cube([housingHeight,outletLength,housingHeight],true);

            // makes the mounting holes
            for (i = [0:numHoles]) {
                rotate([0,0,i*360/numHoles])
                translate([-(housingOD/2 + holeBossRadius),0,0])
                mountingHole(housingHeight);
            }
            translate([0,0,-(housingHeight + motorMountHeight)/2])
                difference() {
                    // motor mount
                    cylinder(h = motorMountHeight, r = DCmotorODr, center = true);

                    translate([0,0,-0.01])
                    cylinder(h = motorMountHeight, r = DCmotorIDr, center = true);
                }

            // outlet ridge
            // will likely require a tolerance fit here as well
            
            translate([0,0,housingHeight/2])
                difference() {
                    // the block the ridge will be cut into
                    translate([(housingOD - housingHeight)/2,(outletLength) - fanRadius/2,0])
                        cube([housingHeight,fanRadius,capThickness],true);

                    // the cylinder that'll cut the ridge
                    cylinder(h = capThickness*1.1, r = (housingOD/2) + ridgeTolerance, center = true);
                }
        }

        union() {
            // housing inner ID cutout
            translate([0,0,baseGirth])
            cylinder(h = housingHeight, r = housingID/2, center = true);

            // motor mount cutout
            cylinder(h = housingHeight*2, r = MotorDiameter/2, center = true);

            // outlet ID cutout
            translate([(housingID - outletCut - housingWallThickness)/2,(outletLength/2) + 0.01,0])
            cube([outletCut,outletLength,outletCut],true);
        }
    }
}

module mountingHole(mountingHeight) {
    $fn = 20;
    difference() {
        union() {
            cylinder(h = mountingHeight, r = holeBossRadius, center = true);
            translate([holeBossRadius,0,0])
                cube([holeBossDiameter,holeBossDiameter,mountingHeight],true);
        }
        union() {
            cylinder(h = mountingHeight*1.01, r = holeRadius, center = true);
        }
    }
}

module cap() {
    
    difference() {
        union() {
            // base of the cap
            cylinder(h = capThickness, r = housingOD/2, center = true);

            // tubing adapter on cap
            translate([0,0,abs(capAdapterHeight + capThickness)/2])
            cylinder(h = capAdapterHeight, r = capBossDiameter/2, center = true);

            // mounting holes
            for (i = [0:numHoles]) {
                rotate([0,0,i*360/numHoles])
                translate([-(housingOD/2 + holeBossRadius),0,0])
                mountingHole(capThickness);
            }
        }

        union() {
            cylinder(h = (capThickness + capAdapterHeight)*2, r = capHoleDiameter/2, center = true);
        }
    }
}

module adapterBase() {
    // builds the base for mounting adapter types to the outlet
    union() {
        // builds the inner male portion of the outlet
        cube([outletCut - outletFittingTolerance,outletAdpaterMaleLength,outletCut - outletFittingTolerance],true);

        // builds the lip for the outlet adapter
        // translates to fit over the insideMaleConnection
        translate([0,(outletAdpaterMaleLength + outletAdapterLink)/2,0])
        cube([housingHeight,outletAdapterLink,housingHeight],true);
    }
}

module adapter() {
	// 
    if (outletAdpaterON == "true") {
        difference() {
            union() {
                // applies a base
                adapterBase();
                
                // setting the stage for placing adapaters
                rotate([90,0,0])
    
                // builds the adapter types
                translate([0,0,-(outletAdpaterMaleLength + outletTubeLength)/2 - outletAdapterLink])
                if (outletAdpaterType == "tube") {
                    // makes the tube's OD
                    cylinder(h = outletTubeLength, r = outletTubeOD/2, center = true);
                } else if (outletAdpaterType == "square") {
                    // make new square adapter
                }
            }
            
            union() {
                rotate([90,0,0])
                cylinder(h = (outletAdpaterMaleLength + outletTubeLength + outletAdapterLink)*2, r = outletTubeID/2, center = true);
            }
    
        }
    }
}


if (viewObject == "all") {
    if (viewHousing == "true") {
        translate([(housingOD/2 + fanRadius) + (holeBossDiameter * 1.5),0,baseGirth/2])
        if (bladeDirection == "CCW") {
        	impeller4();
        } else if (bladeDirection =="CW") {
        	mirror([0,1,0])
        	impeller4();
        }
    }

    if (viewCap == "true") {
        translate([0,-((housingOD/2 + fanRadius) + (holeBossDiameter * 3)),capThickness/2])
        cap();
    }

    if (viewHousing == "true") {
        translate([0,0,(housingHeight/2) + motorMountHeight])
        Housing1();
    }

    if (viewAdapter == "true") {
        rotate([90,0,0])
        translate([housingOD,outletAdpaterMaleLength/2,housingOD*.8])
        adapter();
    }

} else if (viewObject == "impeller") {
    // impeller3();
    if (bladeDirection == "CCW") {
    	impeller4();
    } else if (bladeDirection =="CW") {
    	mirror([0,1,0])
    	impeller4();
    }
} else if (viewObject == "housing") {
    Housing1();
} else if (viewObject == "cap") {
    cap();
} else if (viewObject == "adapter") {
    // rotate([90,0,0])
    adapter();
} else if (viewObject == "assembled") {
    if (viewImpeller == "true") {
        translate([0,0,-((housingHeight/2) - 1.5*baseGirth)])
        if (bladeDirection == "CCW") {
        	impeller4();
        } else if (bladeDirection =="CW") {
        	mirror([0,1,0])
        	impeller4();
        }
    }

    if (viewCap == "true") {
        %translate([0,0,(housingHeight + capThickness)/2])
        cap();
    }

    if (viewHousing == "true") {
        %Housing1();
    }

    if (viewAdapter == "true") {
        translate([-(housingHeight - housingOD)/2,(outletLength - outletAdpaterMaleLength/2),0])
        adapter();
    }
}

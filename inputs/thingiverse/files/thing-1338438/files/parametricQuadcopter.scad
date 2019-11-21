/******************************************
*
*		Fully parametric quadcopter
*		Created by Matteo Novelli
*		On date February 15, 2016
*
******************************************/

outputObject = 0;// [0:Preview, 1:MotorMount, 2:MainPlate, 3:BottomPlate, 4:TopPlate, 5:LandingGear, 6:Arms]

armsMaterial = "peru";// ["peru":Wood, "gray":Aluminium, "black":Carbon, 0:Printed]
printMaterialColor = "red";// ["red":Red, "orange":Orange, "yellow":Yellow, "green":Green, "blue":Blue, "pink":Pink, "purple":Pruple, "brown":Brown]

thickness = 3;
armsHeight = 12.3;
screwHolesSize = 2;
quadcopterSize = 400;// [100:1000]

plateThickness = 2;
mainPlateSize = 80;// [10:500]
mainPlateExtraSize = 50;// [0:500]
topPlateSize = 55;// [0:500]
vibrationDampenerHolesSize = 6.5;

motorMountThickness = 4;
motorDiameter = 23;// [5:100]
shaftHoleSize = 6;// [0:50]
motorBoltHolesSize = 2.2;
motorBoltHolesDistance = 14;

landingGearThickness = 3;

$fn = 50;

if (outputObject == 0) {
	preview();
} else if (outputObject == 1) {
	color(printMaterialColor) {
		rotate([180, 0, 0])
		motorMount();
	}
} else if (outputObject == 2) {
	color(printMaterialColor) {
		if (topPlateSize > 0) {
			rotate([180, 0, 0])
			plate(mainPlateExtraSize, true, false);
		} else {
			rotate([180, 0, 0])
			plate(mainPlateExtraSize, false, false);
		}
	}
} else if (outputObject == 3) {
	color(printMaterialColor) {
		rotate([180, 0, 0])
		plate(0, false, true);
	}
} else if (outputObject == 4) {
	color(printMaterialColor) {
		topPlate();
	}
} else if (outputObject == 5) {
	color(printMaterialColor) {
		landingGear();
	}
} else if (outputObject == 6) {
	color(printMaterialColor) {
		cube([armsHeight, quadcopterSize / 2 - motorDiameter / 2 - thickness * 2, armsHeight]);
	}
}

module preview() {

	if (armsMaterial == 0) {

		armsMaterial = printMaterialColor;
	}

	color(armsMaterial) {

		translate([-quadcopterSize / 2 + motorDiameter, -armsHeight / 2, -armsHeight - thickness])
		cube([quadcopterSize - motorDiameter * 2, armsHeight, armsHeight]);

		translate([-armsHeight / 2, -quadcopterSize / 2 + motorDiameter, -armsHeight - thickness])
		cube([armsHeight, quadcopterSize - motorDiameter * 2, armsHeight]);
	}

	color(printMaterialColor) {

		rotate([0, 0, 45])
		translate([0, 0, 5])
		topPlate();

		translate([-armsHeight / 2 - landingGearThickness, -quadcopterSize / 4, -plateThickness])
		rotate([0, 90, 0])
		landingGear();

		translate([armsHeight / 2 + landingGearThickness, quadcopterSize / 4, -plateThickness])
		rotate([0, 90, 180])
		landingGear();

		translate([quadcopterSize / 4, -armsHeight / 2 - landingGearThickness, -plateThickness])
		rotate([0, 90, 90])
		landingGear();

		translate([-quadcopterSize / 4, armsHeight / 2 + landingGearThickness, -plateThickness])
		rotate([0, 90, 270])
		landingGear();

		translate([0, 0, -thickness + plateThickness])
		rotate([0, 0, 45])
		plate(mainPlateExtraSize, true);

		translate([0, 0, -thickness - armsHeight - plateThickness])
		rotate([180, 0, 45])
		plate(0, false);

		translate([0, quadcopterSize / 2, 0])
		motorMount();

		translate([-quadcopterSize / 2, 0, 0])
		rotate([0, 0, 90])
		motorMount();

		translate([0, -quadcopterSize / 2, 0])
		rotate([0, 0, 180])
		motorMount();

		translate([quadcopterSize / 2, 0, 0])
		rotate([0, 0, 270])
		motorMount();   
	}
}

module topPlate() {

	translate([0, 0, plateThickness / 2])
	cube([topPlateSize, topPlateSize, plateThickness], center = true);

	dampenerSupport();

	rotate([0, 0, 90])
	dampenerSupport();

	rotate([0, 0, 180])
	dampenerSupport();

	rotate([0, 0, 270])
	dampenerSupport();

	module dampenerSupport() {

		difference() {

			hull() {

				translate([topPlateSize / 2 + (vibrationDampenerHolesSize + thickness * 2) / 2, 0, plateThickness / 2])
				cylinder(d = vibrationDampenerHolesSize + thickness * 2, h = plateThickness, center = true);

				translate([0, 0, plateThickness / 2])
				cube([vibrationDampenerHolesSize + thickness * 2, vibrationDampenerHolesSize + thickness * 2, plateThickness], center = true);
			}

			translate([topPlateSize / 2 + (vibrationDampenerHolesSize + thickness * 2) / 2, 0, plateThickness / 2])
			cylinder(d = vibrationDampenerHolesSize, h = plateThickness + 2, center = true);
		}   
	}
}

module motorMount() {

	rotate([180, 0, 0])
	difference() {
		union() {
			hull() {
				cylinder(d = motorDiameter, h = motorMountThickness);

				translate([-armsHeight / 2 - thickness, motorDiameter / 2, 0])
				cube([armsHeight + thickness * 2, thickness, motorMountThickness]);
			}

			hull() {
				translate([-armsHeight / 2 - thickness, motorDiameter / 2, 0])
				cube([armsHeight + thickness * 2, thickness, thickness]);

				translate([-armsHeight / 2 - thickness, motorDiameter / 2 + thickness, 0])
				cube([armsHeight + thickness * 2, armsHeight * 2, armsHeight +thickness * 2]);   
			}
		}

		translate([-armsHeight / 2, motorDiameter / 2 + thickness * 2, thickness])
		cube([armsHeight, armsHeight * 2, armsHeight]);

		translate([0, 0, -1])
		cylinder(d = shaftHoleSize, h = motorMountThickness + 2);

		rotate([0, 0, 45])
		translate([motorBoltHolesDistance / 2, 0, -1])
		cylinder(d = motorBoltHolesSize, h = motorMountThickness + 2);

		rotate([0, 0, 135])
		translate([motorBoltHolesDistance / 2, 0, -1])
		cylinder(d = motorBoltHolesSize, h = motorMountThickness + 2);

		rotate([0, 0, 225])
		translate([motorBoltHolesDistance / 2, 0, -1])
		cylinder(d = motorBoltHolesSize, h = motorMountThickness + 2);

		rotate([0, 0, 315])
		translate([motorBoltHolesDistance / 2, 0, -1])
		cylinder(d = motorBoltHolesSize, h = motorMountThickness + 2);

		translate([0, motorDiameter, -1])
		cylinder(d = screwHolesSize, h = armsHeight + thickness * 2 + 2);

		translate([-(armsHeight + thickness * 2 + 2) / 2, motorDiameter + thickness * 2, screwHolesSize / 2 + thickness / 2 + armsHeight / 2])
		rotate([0, 90, 0])
		cylinder(d = screwHolesSize, h = armsHeight + thickness * 2 + 2);
	}
}

module plate(_mainPlateExtraSize, dampenerHoles, rubberBandAttachements) {

	difference() {

		if (rubberBandAttachements) {

			difference() {

				_plate();

				rubberBandHook();

				rotate([0, 0, 90])
				rubberBandHook();

				rotate([0, 0, 180])
				rubberBandHook();

				rotate([0, 0, 270])
				rubberBandHook();
			}
		} else {

			_plate();
		}

		armsScrewHoles();

		if (dampenerHoles) {

			dampenersHoles();
		}
	}

	module _plate() {

		rotate([180, 0, 0])
		translate([0, 0, plateThickness / 2])
		union() {

			if (_mainPlateExtraSize > 0) {

				cube([mainPlateSize + _mainPlateExtraSize, mainPlateSize - mainPlateSize / 2, plateThickness], center = true);
			}

			difference() {

				union() {

					cube([mainPlateSize, mainPlateSize, plateThickness], center = true);

					armSupport(plateThickness, thickness, armsHeight, mainPlateSize);

					rotate([0, 0, 90])
					armSupport(plateThickness, thickness, armsHeight, mainPlateSize);   
				}

				rotate([0, 0, 45])
				translate([mainPlateSize, 0, 0])
				cube([mainPlateSize, mainPlateSize, plateThickness + 2], center = true);

				rotate([0, 0, 135])
				translate([mainPlateSize, 0, 0])
				cube([mainPlateSize, mainPlateSize, plateThickness + 2], center = true);

				rotate([0, 0, 225])
				translate([mainPlateSize, 0, 0])
				cube([mainPlateSize, mainPlateSize, plateThickness + 2], center = true);

				rotate([0, 0, 315])
				translate([mainPlateSize, 0, 0])
				cube([mainPlateSize, mainPlateSize, plateThickness + 2], center = true);
			}
		}
	}

	module dampenersHoles() {

		translate([topPlateSize / 2 + (vibrationDampenerHolesSize + thickness * 2) / 2, 0, 0])
		cylinder(d = vibrationDampenerHolesSize, h = plateThickness + 2, center = true);

		translate([0, topPlateSize / 2 + (vibrationDampenerHolesSize + thickness * 2) / 2, 0])
		cylinder(d = vibrationDampenerHolesSize, h = plateThickness + 2, center = true);

		translate([-topPlateSize / 2 - (vibrationDampenerHolesSize + thickness * 2) / 2, 0, 0])
		cylinder(d = vibrationDampenerHolesSize, h = plateThickness + 2, center = true);

		translate([0, -topPlateSize / 2 - (vibrationDampenerHolesSize + thickness * 2) / 2, 0])
		cylinder(d = vibrationDampenerHolesSize, h = plateThickness + 2, center = true);
	}

	module armsScrewHoles() {

		translate([mainPlateSize * 0.3, mainPlateSize * 0.3, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);

		translate([mainPlateSize * 0.2, mainPlateSize * 0.2, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);

		translate([mainPlateSize * -0.3, mainPlateSize * 0.3, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);

		translate([mainPlateSize * -0.2, mainPlateSize * 0.2, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);

		translate([mainPlateSize * 0.3, mainPlateSize * -0.3, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);

		translate([mainPlateSize * 0.2, mainPlateSize * -0.2, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);

		translate([mainPlateSize * -0.3, mainPlateSize * -0.3, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);

		translate([mainPlateSize * -0.2, mainPlateSize * -0.2, 0])
		cylinder(d = screwHolesSize, h = plateThickness + 2, center = true);
	}

	module rubberBandHook() {

		translate([mainPlateSize / 2 - 4, 4, -plateThickness - 1])
		cylinder(d = 4, h = plateThickness + 2);

		translate([mainPlateSize / 2 - 4, -4, -plateThickness - 1])
		cylinder(d = 4, h = plateThickness + 2);

		translate([mainPlateSize / 2, -4, -1])
		cube([5, 2, plateThickness + 2], center = true);

		translate([mainPlateSize / 2, 4, -1])
		cube([5, 2, plateThickness + 2], center = true);    
	}

	module armSupport() {

		difference() {

			translate([0, 0, (plateThickness + armsHeight / 2) / 2])
			rotate([0, 0, 45])
			cube([thickness * 2 + armsHeight, mainPlateSize,  armsHeight / 2], center = true);

			translate([0, 0, (plateThickness + armsHeight / 2 + 2) / 2])
			rotate([0, 0, 45])
			cube([armsHeight, mainPlateSize + 2, plateThickness + armsHeight / 2 + 2], center = true);
		}
	}
}

module landingGear() {

	union() {

		difference() {

			translate([0, -armsHeight, 0])
			cube([armsHeight, armsHeight * 2, landingGearThickness]);

			translate([armsHeight / 2, armsHeight / 2, -1])
			cylinder(d = screwHolesSize, h = landingGearThickness + 2);

			translate([armsHeight / 2, -armsHeight / 2, -1])
			cylinder(d = screwHolesSize, h = landingGearThickness + 2);
		}

		translate([armsHeight + armsHeight, 0, 0])
		difference() {

			union() {

				translate([-armsHeight, -armsHeight, 0])
				cube([armsHeight, armsHeight * 2, landingGearThickness]);

				hull() {

					cylinder(d = armsHeight * 2, h = landingGearThickness);

					translate([armsHeight * 2 - thickness * 2, 0, 0]) {

						cylinder(d = armsHeight * 2 * 0.8, h = landingGearThickness);

						translate([armsHeight * 2 * 0.8 - thickness * 2, 0, 0]) {

							cylinder(d = armsHeight * 2 * 0.6, h = landingGearThickness);

							translate([armsHeight * 2 * 0.6 - thickness * 2, 0, 0]) {

								cylinder(d = armsHeight * 2 * 0.4, h = landingGearThickness);

								translate([armsHeight * 2 * 0.4 - thickness, 0, 0])
								cylinder(d = armsHeight * 2 * 0.2, h = landingGearThickness);
							}
						}
					}
				}
			}

			translate([0, 0, -1])
			cylinder(d = armsHeight * 2 - thickness * 2, h = landingGearThickness + 2);

			translate([armsHeight * 2 - thickness * 2, 0, -1]) {

				cylinder(d = armsHeight * 2 * 0.8 - thickness * 2, h = landingGearThickness + 2);

				translate([armsHeight * 2 * 0.8 - thickness * 2, 0, 0]) {

					cylinder(d = armsHeight * 2 * 0.6 - thickness * 2, h = landingGearThickness + 2);

					translate([armsHeight * 2 * 0.6 - thickness * 2, 0, 0]) {

						cylinder(d = armsHeight * 2 * 0.4 - thickness * 2, h = landingGearThickness + 2);
					}
				}
			}
		}
	}
}
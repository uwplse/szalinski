$fs = 0.1/1;
$fa = 0.1/1;

screwHoleRadius = 3.5;
screwHoleHeight = 5;

bottomLength = 8.5;
bottomThickness = 2;
bottomAngle = 30;

holderTopRadius = 12/1;
holderBottomRadius = 8/1;
holderElongationScale = 1.5/1;
holderDistanceFromBottom = tan(bottomAngle)*(screwHoleRadius+bottomLength);

bottomToSeam = 9.5;
seamHeight = 2/1;
seamDepth = 1/1;

bottomToTop = 21;
topHookHeight = 2/1;
topHookDepth = 3/1;

rotate([0, bottomAngle, 0]) {
	difference() {
		screwHoleExtraZ = tan(bottomAngle)*screwHoleRadius;
		translate([screwHoleRadius, 0, screwHoleExtraZ]) {
			// screw hole
			translate([0, 0, -screwHoleExtraZ]) {
				cylinder(screwHoleHeight+bottomThickness+screwHoleExtraZ*2, screwHoleRadius, screwHoleRadius);
			}

			// bottom
			bottomExtraY = (holderTopRadius-holderBottomRadius)/(bottomThickness+bottomToTop)*bottomThickness;
			polyhedron([
					[0, -screwHoleRadius, 0],
					[screwHoleRadius+bottomLength, -holderBottomRadius, holderDistanceFromBottom],
					[screwHoleRadius+bottomLength, holderBottomRadius, holderDistanceFromBottom],
					[0, screwHoleRadius, 0],
					[0, -screwHoleRadius, bottomThickness],
					[screwHoleRadius+bottomLength, -holderBottomRadius-bottomExtraY, holderDistanceFromBottom+bottomThickness],
					[screwHoleRadius+bottomLength, holderBottomRadius+bottomExtraY, holderDistanceFromBottom+bottomThickness],
					[0, screwHoleRadius, bottomThickness]],
					[[0, 1, 2, 3], [4, 5, 1, 0], [7, 6, 5, 4], [6, 7, 3, 2], [5, 6, 2, 1], [7, 4, 0, 3]]);

			// holder
			translate([screwHoleRadius+bottomLength, 0, holderDistanceFromBottom]) {
				difference() {
					// main part
					scale([holderElongationScale, 1, 1]) {
						cylinder(bottomThickness+bottomToTop, holderBottomRadius, holderTopRadius);
					}
					translate([-holderTopRadius*holderElongationScale, -holderTopRadius, 0]) {
						difference() {
							cube([holderTopRadius*holderElongationScale, holderTopRadius*2, bottomThickness+bottomToTop]);
							// seam
							translate([holderTopRadius*holderElongationScale-seamDepth, 0, bottomThickness+bottomToSeam]) {
								difference() {
									cube([seamDepth, holderTopRadius*2, seamHeight]);
									rotate([90, 0, 0]) {
										translate([0, seamHeight+0.1, -holderTopRadius*2]) {
											cylinder(holderTopRadius*2, seamDepth, seamDepth);
										}
										translate([0, -0.1, -holderTopRadius*2]) {
											cylinder(holderTopRadius*2, seamDepth, seamDepth);
										}
									}
								}
							}
							// top edge
							translate([holderTopRadius*holderElongationScale-topHookDepth, 0, bottomThickness+bottomToTop-topHookHeight]) {
								difference() {
									cube([topHookDepth, holderTopRadius*2, topHookHeight]);
									translate([0, holderTopRadius*2, -0.25]) {
										rotate([90, 0, 0]) {
											resize([topHookDepth*2, 0, 0]) {
												cylinder(holderTopRadius*2, topHookHeight, topHookHeight);
											}
										}
									}
								}
							}
						}
					}

					// pen
					translate([5, 0, 1]) {
						rotate([0, atan((holderTopRadius-holderBottomRadius)/(bottomThickness+bottomToTop)), 0]) {
							translate([0, 0, 18]) {
								cylinder(20, 6, 6);
							}
							translate([0, 0, 13]) {
								cylinder(5, 5, 6);
							}
							translate([0, 0, 8]) {
								cylinder(5, 4.5, 5);
							}
							translate([0, 0, 3]) {
								cylinder(5, 2, 4.5);
							}
							translate([0, 0, 0]) {
								cylinder(3, 1, 1.25);
							}
							translate([0, 0, -5]) {
								cylinder(5, 1, 1);
							}
						}
					}
				}
			}
		}

		// cut bottom straight
		polyhedron([
				[0, -holderTopRadius, -1],
				[screwHoleRadius+bottomLength+holderTopRadius*holderElongationScale, -holderTopRadius, -1],
				[screwHoleRadius+bottomLength+holderTopRadius*holderElongationScale, holderTopRadius, -1],
				[0, holderTopRadius, -1],
				[0, -holderTopRadius, 0],
				[screwHoleRadius+bottomLength+holderTopRadius*holderElongationScale, -holderTopRadius, tan(bottomAngle)*(screwHoleRadius+bottomLength+holderTopRadius*holderElongationScale)],
				[screwHoleRadius+bottomLength+holderTopRadius*holderElongationScale, holderTopRadius, tan(bottomAngle)*(screwHoleRadius+bottomLength+holderTopRadius*holderElongationScale)],
				[0, holderTopRadius, 0]],
				[[0, 1, 2, 3], [4, 5, 1, 0], [7, 6, 5, 4], [6, 7, 3, 2], [5, 6, 2, 1], [7, 4, 0, 3]]);
	}
}

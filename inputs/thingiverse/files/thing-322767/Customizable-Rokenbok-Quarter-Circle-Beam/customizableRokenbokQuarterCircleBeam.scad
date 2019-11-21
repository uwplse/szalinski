diameter_in_blocks = 5; //[5, 7, 9, 11, 13, 15, 17, 19]

snaps = 2; // [0:No Snaps,1:One Side,2:Both Sides]

/* [Advanced] */

// for single material printing
supports = 0; // [0:No Supports,1:Supports]

// thickness of support material wall. 0.2 suggested for MakerBot Replicator 2 at medium resolution (0.2mm layer height)
support_thickness = 0.2;

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.3 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
male_snap_fit_tolerance = 0;

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.2 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
female_snap_fit_tolerance = 0;

/* [Hidden] */

/*These designs are owned by Rokenbok Education and published under license by kid*spark, a nonprofit corporation, for nonprofit and educational uses. Drawings of these designs are licensed under Creative Commons Attribution-NonCommercial-ShareAlike (BY-NC-SA) 3.0: http://creativecommons.org/licenses/by-nc-sa/3.0/ The drawings may be freely downloaded, modified, and used, providing that attribution is given to Rokenbok Education and the drawings are for non-commercial purposes. Any modified drawings are licensed under the same terms. The drawings are intended for educational and hobby uses only; 3D prints of these designs should not be considered toys or for use by children without adult supervision. The drawings are not guaranteed to print perfectly.*/

index = (diameter_in_blocks-1)/2-2;

diameter = diameter_in_blocks;

BLOCK_LENGTH = 20;
WINDOW = 12+female_snap_fit_tolerance;
WALL = 2;

OR = BLOCK_LENGTH*sqrt( pow(diameter_in_blocks/2,2) + pow(1/2,2) );
IR = BLOCK_LENGTH*sqrt( pow(diameter_in_blocks/2 - 1,2) + pow(1/2,2) );
MR = BLOCK_LENGTH*(diameter_in_blocks-1)/2;
OD = 2*OR;
ID = 2*IR;
MD = 2*MR;

numInsideHoles = [1, 3, 4, 6, 7, 9, 10, 12];
numTopBottomHoles = numInsideHoles; // 9d is 5, 17d is 11
numOutsideHoles = [3, 4, 6, 7, 9, 10, 12, 14];
offsetInside = ( (90 - (numInsideHoles[index])/(IR/BLOCK_LENGTH)*(180/PI)) / 2);
offsetTopBottom = offsetInside;
offsetOutside = ( (90 - (numOutsideHoles[index])/(OR/BLOCK_LENGTH)*(180/PI)) / 2);

$fn = 100;

module snap(supports = 0, snap_fit_tolerance = 0.1, origin = [0,0,0], orientation = [0,0,0]) {
	translate(origin) rotate(orientation) difference() {
		union() {
			translate([-8.5-6.5/2,-(5.98-(1.5)/2),0])
				cube([6.5,1.5-snap_fit_tolerance,11.8], center = true);
			translate([-8.5-6.5+3.15/2,-5.98-0.8/2+snap_fit_tolerance/2,0])
				cube([5-1.95,0.8,11.8], center = true);
			translate([-(BLOCK_LENGTH/2)-1.53-(5-1.53)/2,-(5.98-1.5-0.75/2+snap_fit_tolerance/2),0])
				cube([5-1.53,0.75,11.8], center = true);
			// add fillets at attachment point
			translate([-8.5-0.5/2,-5.975+0.75,0]) {
				difference() {
					cube([0.5,1.5-snap_fit_tolerance+2*0.5,11.8+2*0.5], center = true);
	
						translate([-0.5/2,-1+snap_fit_tolerance/2-0.5/2,0])
							cylinder(h = 13, r = 0.5, $fs = 0.1, center = true);
						translate([-0.5/2,1-snap_fit_tolerance/2+0.5/2,0])
							cylinder(h = 13, r = 0.5, $fs = 0.1, center = true);
						translate([-0.5/2,0,11.8/2+0.5])
							rotate([90,0,0])
								cylinder(h = 3, r = 0.5, $fs = 0.1, center = true);
						translate([-0.5/2,0,-(11.8/2+0.5)])
							rotate([90,0,0])
								cylinder(h = 3, r = 0.5, $fs = 0.1, center = true);
				} // end difference fillet
			} // end translate
		} // end union
		// subtract 45 degree rotated "cubes"
		translate([-15,-6.78+snap_fit_tolerance/2,0])
			rotate([0,0,45])
				cube([2.54,2.54,12], center = true);
		translate([-11.95,-6.78+snap_fit_tolerance/2,0])
			rotate([0,0,45])
				cube([1.131371,1.131371,12], center = true);
		translate([-11.53,-3.73-snap_fit_tolerance/2,0])
			rotate([0,0,45])
				cube([1.06066,1.06066,12], center = true);
		translate([-14.714711,-3.444711-snap_fit_tolerance/2,0])
			rotate([0,0,30])
				cube([1.558846,1.558846,12], center = true);
		// subtract anti-fillet, doesn't work on polyhedra
		mirror([0,0,1]) {
			translate([-15+1.5,0,-5.9+1.5])
				difference() {
					cube([3.1,BLOCK_LENGTH,3.1], center = true);
					translate([1.5,0,1.5])
						rotate([90,0,0])
							cylinder(h = BLOCK_LENGTH+1, r = 3, $fs = 1, center = true);
				} // end difference
		} // end mirror
		translate([-15+1.5,0,-5.9+1.5])
			difference() {
				cube([3.1,BLOCK_LENGTH,3.1], center = true);
				translate([1.5,0,1.5])
					rotate([90,0,0])
						cylinder(h = BLOCK_LENGTH+1, r = 3, $fs=1, center = true);
			} // end difference
	} // end difference
	
	// supports
	if (supports == 1) {
		translate([-8.5-2.5,-(6-0.75),-5.9-4.1/2]) {
			difference() {
				cube([3.2,1.5-snap_fit_tolerance,4.1], center = true);
				translate([-0.2,0,3*0.2/2])
					cube([3,1.3-snap_fit_tolerance,4.1-3*0.2], center = true);
			} // end difference
		} // end translate
	} // end if (supports != 0)

	if (supports != 0)
		translate([-8.5-2.5,0,-5.9-4.1/2-4.1/2+3*0.2/2])
			cube([3.2,12-snap_fit_tolerance,3*0.2], center = true);
} // end module snap()


module filletX(rad = 0.5, length = BLOCK_LENGTH+4, pos = [MR,(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [0,0,0]) {
	translate([pos[0],pos[1]+sign(pos[1])*rad/2,pos[2]-sign(pos[2])*rad/2])
		rotate(rot)
			rotate([0,0,90])
				difference() {
					cube([rad+.1,length+1,rad+.1], center = true);
			
					translate([rad/2,0,-rad/2])
						rotate([90,0,0])
							cylinder(r = rad, h = length+2, $fs = 0.1, center = true);
				} // end difference fillet
} // end module filletX()

module filletZRO(filletRad = 0.5, rad = OR, height = BLOCK_LENGTH/2) {
	translate([0,0,height-filletRad])
		difference() {
			rotate_extrude(convexity=10)
				translate([rad-filletRad,0,0])
					square(filletRad+0.1,filletRad+0.1);
			rotate_extrude(convexity=10)
				translate([rad-filletRad,0,0])
					circle(r=filletRad);
		} // end difference
} // end module filletZR()

module filletZRI(filletRad = 0.5, rad = IR, height = BLOCK_LENGTH/2) {
	translate([0,0,height-filletRad])
		difference() {
			rotate_extrude(convexity=10)
				translate([rad,0,0])
					square(filletRad+0.1,filletRad+0.1);
			rotate_extrude(convexity=10)
				translate([rad+filletRad,0,0])
					circle(r=filletRad);
		} // end difference
} // end module filletZR()

difference() {
	union() {
		difference() {
			union() {
				translate([MR,BLOCK_LENGTH/2+1,0])
					cube([BLOCK_LENGTH-1,2,BLOCK_LENGTH-1], center = true);
				translate([BLOCK_LENGTH/2+1,MR,0])
					cube([2,BLOCK_LENGTH-1,BLOCK_LENGTH-1], center = true);
			} // end union
	
			difference() {
				cylinder(h = BLOCK_LENGTH, d = OD+10, center = true);
				cylinder(h = BLOCK_LENGTH+1, d = OD, center = true);
			} // end difference
		} // end difference
	
		difference() {
			cylinder(h = BLOCK_LENGTH, d = OD, center = true);
			
			cylinder(h = BLOCK_LENGTH+1, d = ID, center = true);
			difference() {
				cylinder(h = BLOCK_LENGTH-2*WALL, d = OD-2*WALL, center = true);
				
				cylinder(h = BLOCK_LENGTH-2*WALL, d = ID+2*WALL, center = true);
			} // end difference
			translate([-OR/2,0,0])
				cube([BLOCK_LENGTH+OR,OD,BLOCK_LENGTH+1], center = true);
			translate([OR/2,-OR/2,0])
				cube([OR,BLOCK_LENGTH+OR,BLOCK_LENGTH+1], center = true);
		
			for (i = [1:numTopBottomHoles[index]]) {
				rotate(a = [0,0,offsetTopBottom+((90-2*offsetTopBottom)/(numTopBottomHoles[index]))*(i-0.5)])
					translate([MR,0,0])
						cube([WINDOW,WINDOW,BLOCK_LENGTH+1], center = true);
			} // end for loop
			
			for (i = [1:numInsideHoles[index]]) {
				rotate(a = [0,0,offsetInside+((90-2*offsetInside)/(numInsideHoles[index]))*(i-0.5)])
					translate([IR,0,0])
						cube([BLOCK_LENGTH,WINDOW,WINDOW], center = true);
			} // end for loop
			
			for (i = [1:numOutsideHoles[index]]) {
				rotate(a = [0,0,offsetOutside+((90-2*offsetOutside)/(numOutsideHoles[index]))*(i-0.5)])
					translate([OR,0,0])
						cube([BLOCK_LENGTH,WINDOW,WINDOW], center = true);
			} // end for loop */

			// 0.5mm cut-outs
			cylinder(h = 1, d = ID+1, center = true);
			difference() {
				cylinder(h = 1, d = OD+1, center = true);
				cylinder(h = 1, d = OD-1, center = true);
			} // end difference
			translate([0,0,BLOCK_LENGTH/2])
				difference() {
					cylinder(h = 1, d = MD+2, center = true);
					cylinder(h = 1, d = MD, center = true);
				} // end difference
			translate([0,0,-BLOCK_LENGTH/2])
				difference() {
					cylinder(h = 1, d = MD+2, center = true);
					cylinder(h = 1, d = MD, center = true);
				} // end difference

			for (i = [1:numInsideHoles[index]]) {
				rotate(a = [0,0,offsetInside+((90-2*offsetInside)/(numInsideHoles[index]))*(i-0.5)])
					translate([IR,0,0])
						cube([1,1,BLOCK_LENGTH+1], center = true);
			} // end for loop
			for (i = [2:numInsideHoles[index]]) {
				rotate(a = [0,0,offsetInside+((90-2*offsetInside)/(numInsideHoles[index]))*(i-1)])
					translate([IR,0,0])
						cube([1,1,BLOCK_LENGTH+1], center = true);
			} // end for loop

			for (i = [1:numTopBottomHoles[index]]) {
				rotate(a = [0,0,offsetTopBottom+((90-2*offsetTopBottom)/(numTopBottomHoles[index]))*(i-0.5)]) {
					translate([MR,0,BLOCK_LENGTH/2])
						cube([BLOCK_LENGTH+1,1,1], center = true);
					translate([MR,0,-BLOCK_LENGTH/2])
						cube([BLOCK_LENGTH+1,1,1], center = true);
				} // end rotate
			} // end for loop
			for (i = [2:numTopBottomHoles[index]]) {
				rotate(a = [0,0,offsetTopBottom+((90-2*offsetTopBottom)/(numTopBottomHoles[index]))*(i-1)]) {
					translate([MR,0,BLOCK_LENGTH/2])
						cube([BLOCK_LENGTH+1,1,1], center = true);
					translate([MR,0,-BLOCK_LENGTH/2])
						cube([BLOCK_LENGTH+1,1,1], center = true);
				} // end rotate
			} // end for loop

			for (i = [1:numOutsideHoles[index]]) {
				rotate(a = [0,0,offsetOutside+((90-2*offsetOutside)/(numOutsideHoles[index]))*(i-0.5)])
					translate([OR,0,0])
						cube([1,1,BLOCK_LENGTH+1], center = true);
			} // end for loop
			for (i = [2:numOutsideHoles[index]]) {
				rotate(a = [0,0,offsetOutside+((90-2*offsetOutside)/(numOutsideHoles[index]))*(i-1)])
					translate([OR,0,0])
						cube([1,1,BLOCK_LENGTH+1], center = true);
			} // end for loop*/

		} // end difference
	} // end union

	if (snaps >= 1) {
		// x-axis end snap
		translate([MR,BLOCK_LENGTH/2,0]) {
			cube([BLOCK_LENGTH-2*WALL,3,BLOCK_LENGTH+1], center = true);
			cube([3,10,12], center = true);
		} // end translate

		if (snaps == 2) {
			// y-axis end snap
			translate([BLOCK_LENGTH/2,MR,0]) {
				cube([3,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH+1], center = true);
				cube([10,3,12], center = true);
			}
		} else {
			translate([BLOCK_LENGTH/2,MR,0]) {
				cube([1,BLOCK_LENGTH+1,1], center = true);
				cube([1,1,BLOCK_LENGTH+1], center = true);
				cube([6,12,12], center = true);
			}
		}
	} else {
		translate([MR,BLOCK_LENGTH/2,0]) {
			cube([BLOCK_LENGTH+1,1,1], center = true);
			cube([1,1,BLOCK_LENGTH+1], center = true);
			cube([12,6,12], center = true);
		}
		translate([BLOCK_LENGTH/2,MR,0]) {
			cube([1,21,1], center = true);
			cube([1,1,21], center = true);
			cube([6,12,12], center = true);
		}
	} // end if (snaps >- 1)

filletX(rad = 0.5, length = BLOCK_LENGTH+4, pos = [MR,(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [0,0,0]);
mirror([0,0,1])
	filletX(rad = 0.5, length = BLOCK_LENGTH+4, pos = [MR,(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [0,0,0]);
mirror([1,-1,0]) {
	filletX(rad = 0.5, length = BLOCK_LENGTH+4, pos = [MR,(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [0,0,0]);
	mirror([0,0,1])
		filletX(rad = 0.5, length = BLOCK_LENGTH+4, pos = [MR,(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [0,0,0]);
} // end mirror

filletZRO(filletRad = 0.5, rad = OR, height = BLOCK_LENGTH/2);
mirror([0,0,1])
	filletZRO(filletRad = 0.5, rad = OR, height = BLOCK_LENGTH/2);
filletZRI(filletRad = 0.5, rad = IR, height = BLOCK_LENGTH/2);
mirror([0,0,1])
	filletZRI(filletRad = 0.5, rad = IR, height = BLOCK_LENGTH/2);

} // end difference

if (snaps >= 1) { // x snap
	translate([MR,BLOCK_LENGTH-7.75,0])
		difference() {
			cube([BLOCK_LENGTH-2*WALL,1.5,BLOCK_LENGTH-2*WALL], center = true);
			cube([WALL,3,12], center = true);
		} // end difference
	translate([MR,BLOCK_LENGTH,0])
		rotate([0,0,90]) {
			snap(supports, male_snap_fit_tolerance);
			mirror([0,1,0]) snap(supports, male_snap_fit_tolerance);
		} // end rotate

	

	if (snaps == 2) { // y snap
		translate([BLOCK_LENGTH-7.75,MR,0])
			difference() {
				cube([1.5,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH-2*WALL], center = true);
				cube([3,WALL,12], center = true);
			} // end difference
		translate([BLOCK_LENGTH,MR,0]) {
			snap(supports, male_snap_fit_tolerance);
			mirror([0,1,0]) snap(supports, male_snap_fit_tolerance);
		} // end translate
		
	} else { // end if snaps == 2
		if (supports == 1) {
			translate([(BLOCK_LENGTH+support_thickness+WALL)/2,MR,0])
				cube([support_thickness,4,WINDOW], center = true);
		} // end if supports == 1
	} // end else
} else { // end if snaps >= 1
	if (supports == 1) {
		translate([MR,(BLOCK_LENGTH+support_thickness+WALL)/2,0])
			cube([4,support_thickness,WINDOW], center = true);

		translate([(BLOCK_LENGTH+support_thickness+WALL)/2,MR,0])
			cube([support_thickness,4,WINDOW], center = true);
	} // end if supports == 1
} // end else

if (supports == 1) {
	for (i = [1:numTopBottomHoles[index]]) {
		rotate(a = [0,0,offsetTopBottom+((90-2*offsetTopBottom)/(numTopBottomHoles[index]))*(i-0.5)]) {
			translate([MR,0,0])
				difference() {
					cube([WINDOW+2*support_thickness,WINDOW+2*support_thickness,BLOCK_LENGTH], center = true);
					cube([WINDOW,WINDOW,BLOCK_LENGTH+1], center = true);
					cube([WINDOW+2*support_thickness+.1,4,BLOCK_LENGTH-2*WALL], center = true);
					cube([4,WINDOW+2*support_thickness+.1,BLOCK_LENGTH-2*WALL], center = true);
				} // end difference
	

		translate([MR+(WINDOW/2-(WINDOW-4)/4),WINDOW/2-(WINDOW-4)/4,0])
			rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,BLOCK_LENGTH-2*WALL], center = true);
		mirror([0,1,0])
			translate([MR+(WINDOW/2-(WINDOW-4)/4),WINDOW/2-(WINDOW-4)/4,0])
				rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,BLOCK_LENGTH-2*WALL], center = true);

		translate([MR-(WINDOW/2-(WINDOW-4)/4),WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
			rotate([0,0,-45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
		mirror([0,1,0])
			translate([MR-(WINDOW/2-(WINDOW-4)/4),WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
				rotate([0,0,-45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
		mirror([0,0,1]) {
			translate([MR-(WINDOW/2-(WINDOW-4)/4),WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
				rotate([0,0,-45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
			mirror([0,1,0])
				translate([MR-(WINDOW/2-(WINDOW-4)/4),WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
					rotate([0,0,-45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
		} // end mirror


		} // end rotate
	} // end for loop

	for (i = [1:numInsideHoles[index]]) {
		rotate(a = [0,0,offsetInside+((90-2*offsetInside)/(numInsideHoles[index]))*(i-0.5)]) {
			difference() {
				rotate_extrude(convexity=10, angle=10)
					translate([IR+support_thickness/2+WALL/2,0,0])
						square([support_thickness,WINDOW], center = true);

				translate([0,-(OR+1)/2-2,0])
					cube([OD+1,OR+1,WINDOW+1], center = true);
				translate([0,(OR+1)/2+2,0])
					cube([OD+1,OR+1,WINDOW+1], center = true);
				translate([-OR,0,0])
					cube([OR+1,OR+1,WINDOW+1], center = true);
			} // end difference

			translate([IR-BLOCK_LENGTH/4+(WINDOW)/2+(MR-IR-WINDOW/2-WALL/2)/2,(4-support_thickness)/2,0])
				cube([MR-IR-WINDOW/2-WALL/2,support_thickness,WINDOW], center = true);
			mirror([0,1,0])
				translate([IR-BLOCK_LENGTH/4+(WINDOW)/2+(MR-IR-WINDOW/2-WALL/2)/2,(4-support_thickness)/2,0])
					cube([MR-IR-WINDOW/2-WALL/2,support_thickness,WINDOW], center = true);

		} // end rotate
	} // end for loop

	for (i = [1:numOutsideHoles[index]]) {
		rotate(a = [0,0,offsetOutside+((90-2*offsetOutside)/(numOutsideHoles[index]))*(i-0.5)]) {
			difference() {
				rotate_extrude(convexity=10, angle=10)
					translate([OR-support_thickness/2-WALL/2,0,0])
						square([support_thickness,WINDOW], center = true);

				translate([0,-(OR+1)/2-2,0])
					cube([OD+1,OR+1,WINDOW+1], center = true);
				translate([0,(OR+1)/2+2,0])
					cube([OD+1,OR+1,WINDOW+1], center = true);
				translate([-OR,0,0])
					cube([OR+1,OR+1,WINDOW+1], center = true);
			} // end difference

		} // end rotate
	} // end for loop

	if ((diameter_in_blocks != 7) && (diameter_in_blocks != 11) && (diameter_in_blocks != 15)) {
		rotate(a = [0,0,offsetTopBottom]) translate([MR,0,0])
			cube([12,support_thickness,BLOCK_LENGTH-2], center = true);
		rotate(a = [0,0,90-offsetTopBottom]) translate([MR,0,0])
			cube([12,support_thickness,BLOCK_LENGTH-2], center = true);
	} // end if

} // end if supports == 1
// length of beam
number_of_blocks = 4; // [1:17]

snaps = 1; // [0:No Snaps,1:One End,2:Both Ends]

/* [Advanced] */

// for single material printing
supports = 0; // [0:No Supports,1:Supports]

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.3 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
male_snap_fit_tolerance = 0;

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.2 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
female_snap_fit_tolerance = 0;

// 0.2 suggested for printing on MakerBot Replicator 2 with 0.2mm layer height
support_thickness = 0.2;

/* [Hidden] */

/*These designs are owned by Rokenbok Education and published under license by kid*spark, a nonprofit corporation, for nonprofit and educational uses. Drawings of these designs are licensed under Creative Commons Attribution-NonCommercial-ShareAlike (BY-NC-SA) 3.0: http://creativecommons.org/licenses/by-nc-sa/3.0/ The drawings may be freely downloaded, modified, and used, providing that attribution is given to Rokenbok Education and the drawings are for non-commercial purposes. Any modified drawings are licensed under the same terms. The drawings are intended for educational and hobby uses only; 3D prints of these designs should not be considered toys or for use by children without adult supervision. The drawings are not guaranteed to print perfectly.*/

WINDOW = 12+female_snap_fit_tolerance;
BLOCK_LENGTH = 20;
WALL = 2;

module block(origin = [0,0,0]) { // generate one block at origin
	translate(origin) {
		difference() {
		cube(size = BLOCK_LENGTH, center = true);
		cube(size = [BLOCK_LENGTH+1,WINDOW,WINDOW], center = true);
		cube(size = [WINDOW,BLOCK_LENGTH+1,WINDOW], center = true);
		cube(size = [WINDOW,WINDOW,BLOCK_LENGTH+1], center = true);
		cube(size = [BLOCK_LENGTH-2*WALL,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH-2*WALL], center = true);
		translate([0,0,(BLOCK_LENGTH/2)])
			cube(size = [BLOCK_LENGTH+1,1,1], center = true);
		translate([0,0,-(BLOCK_LENGTH/2)])
			cube(size = [BLOCK_LENGTH+1,1,1], center = true);
		translate([0,-(BLOCK_LENGTH/2),0])
			cube(size = [BLOCK_LENGTH+1,1,1], center = true);
		translate([0,(BLOCK_LENGTH/2),0])
			cube(size = [BLOCK_LENGTH+1,1,1], center = true);
		translate([0,0,(BLOCK_LENGTH/2)])
			cube(size = [1,BLOCK_LENGTH+1,1], center = true);
		translate([0,0,-(BLOCK_LENGTH/2)])
			cube(size = [1,BLOCK_LENGTH+1,1], center = true);
		translate([0,-(BLOCK_LENGTH/2),0])
			cube(size = [1,1,BLOCK_LENGTH+1], center = true);
		translate([0,(BLOCK_LENGTH/2),0])
			cube(size = [1,1,BLOCK_LENGTH+1], center = true);
		} // end difference
		if (supports == 1) {
			translate([0,-(BLOCK_LENGTH+support_thickness-WALL)/2,0])
				cube([4,support_thickness,WINDOW], center = true);
			//translate([0,-(BLOCK_LENGTH/2-WALL+0.1),0])
			//	cube([4,support_thickness,WINDOW], center = true);
			translate([0,(BLOCK_LENGTH-support_thickness-WALL)/2,0])
				cube([4,support_thickness,WINDOW], center = true);
			//translate([0,(BLOCK_LENGTH/2-WALL+0.1),0])
			//	cube([4,support_thickness,WINDOW], center = true);
			translate([(4-support_thickness)/2,(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,0])
				cube([support_thickness,(BLOCK_LENGTH-WINDOW-WALL)/2,WINDOW], center = true);
			mirror([1,0,0])
				translate([(4-support_thickness)/2,(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,0])
					cube([support_thickness,(BLOCK_LENGTH-WINDOW-WALL)/2,WINDOW], center = true);
			mirror([0,1,0]) {
				translate([(4-support_thickness)/2,(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,0])
					cube([support_thickness,(BLOCK_LENGTH-WINDOW-WALL)/2,WINDOW], center = true);
				mirror([1,0,0])
					translate([(4-support_thickness)/2,(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,0])
						cube([support_thickness,(BLOCK_LENGTH-WINDOW-WALL)/2,WINDOW], center = true);
			} // end mirror
			difference() {
				cube([WINDOW+support_thickness,WINDOW+support_thickness,BLOCK_LENGTH-2*WALL], center = true);

				cube([WINDOW,WINDOW,BLOCK_LENGTH], center = true);
				cube([4,WINDOW+1,BLOCK_LENGTH-2*WALL], center = true);
				cube([WINDOW+1,4,BLOCK_LENGTH-2*WALL], center = true);
			} // end difference
			translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
				rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
			mirror([1,0,0])
				translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
					rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
			mirror([0,1,0]) {
				translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
					rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
				mirror([1,0,0])
					translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
						rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
			} // end mirror
			mirror([0,0,1]) {
				translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
					rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
				mirror([1,0,0])
					translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
						rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
				mirror([0,1,0]) {
					translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
						rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
					mirror([1,0,0])
						translate([WINDOW/2-(WINDOW-4)/4,WINDOW/2-(WINDOW-4)/4,(WINDOW+WALL)/2])
							rotate([0,0,45])	cube([support_thickness,sqrt(2)*(WINDOW-4)/2,(BLOCK_LENGTH-WINDOW)/2-WALL], center = true);
				} // end mirror
			} // end mirror
		} // end if (supports != 0)
	} // end translate
} // end module block()

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
	if (supports != 0) {
		translate([-8.5-2.5,-(6-0.75),-5.9-4.1/2]) {
			difference() {
				cube([3.2,1.5-snap_fit_tolerance,4.1], center = true);
				translate([-support_thickness,0,3*0.2/2])
					cube([3,1.3-snap_fit_tolerance,4.1-3*0.2], center = true);
			} // end difference
		} // end translate
	} // end if (supports != 0)

	if (supports != 0)
		translate([-8.5-2.5,0,-5.9-4.1/2-4.1/2+3*0.2/2])
			cube([3.2,12-snap_fit_tolerance,3*0.2], center = true);
} // end module snap()

module filletX(rad = 0.5, length = 20, pos = [0,-(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [0,0,0]) {
	translate([pos[0],pos[1]-sign(pos[1])*rad/2,pos[2]-sign(pos[2])*rad/2])
		rotate(rot)
			rotate([0,0,90])
				difference() {
					cube([rad+.1,length+1,rad+.1], center = true);
			
					translate([rad/2,0,-rad/2])
						rotate([90,0,0])
							cylinder(r = rad, h = length+2, $fs = 0.1, center = true);
				} // end difference fillet
} // end module filletX()

module filletY(rad = 0.5, length = 20, pos = [-(BLOCK_LENGTH/2),0,(BLOCK_LENGTH/2)], rot = [0,0,0]) {
	translate([pos[0]-sign(pos[0])*rad/2,0,pos[2]-sign(pos[2])*rad/2])
		rotate(rot)
			difference() {
				cube([rad+.1,length+1,rad+.1], center = true);
		
				translate([rad/2,0,-rad/2])
					rotate([90,0,0])
						cylinder(r = rad, h = length+2, $fs = 0.1, center = true);
			} // end difference fillet
} // end module filletY()

module filletZ(rad = 0.5, length = 20, pos = [(BLOCK_LENGTH/2),-(BLOCK_LENGTH/2),0], rot = [0,0,90]) {
	translate([pos[0]-sign(pos[0])*rad/2,pos[1]-sign(pos[1])*rad/2],0)
		rotate(rot)
			rotate([90,0,0])
				difference() {
					cube([rad+.1,length+1,rad+.1], center = true);
			
					translate([rad/2,0,-rad/2])
						rotate([90,0,0])
							cylinder(r = rad, h = length+2, $fs = 0.1, center = true);
				} // end difference fillet
} // end module filletZ()

difference() {
	union() { // generate blocks
		for (i = [1:number_of_blocks]) {
			block([BLOCK_LENGTH*(i-1),0,0]);
		}
	}

	if (number_of_blocks > 1) {
		for (i = [2:number_of_blocks]) {
			translate([(BLOCK_LENGTH/2)+BLOCK_LENGTH*(i-2),0,0])
				difference() {
					cube([1,BLOCK_LENGTH+1,BLOCK_LENGTH+1], center = true);
					cube([1,19,19], center = true);
				}
		}
	} // end if number_of_blocks > 1
	
	if (snaps >= 1) {
		// near end snap
		translate([-(BLOCK_LENGTH/2),0,0])
			cube([3,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH+1], center = true);

		if (snaps == 2) {
			// far end snap
			translate([number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH/2),0,0])
				cube([3,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH+1], center = true);
		} else {
			translate([number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH/2),0,0]) {
				cube([1,BLOCK_LENGTH+1,1], center = true);
				cube([1,1,BLOCK_LENGTH+1], center = true);
			}
		}
	} else {
		translate([-(BLOCK_LENGTH/2),0,0]) {
			cube([1,BLOCK_LENGTH+1,1], center = true);
			cube([1,1,BLOCK_LENGTH+1], center = true);
		}
		translate([number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH/2),0,0]) {
			cube([1,BLOCK_LENGTH+1,1], center = true);
			cube([1,1,BLOCK_LENGTH+1], center = true);
		}
	} // end if (snaps >= 1)

	// edge fillets 0.5mm radius
	filletX(rad = 0.5, length = number_of_blocks*BLOCK_LENGTH, pos = [(number_of_blocks-1)*(BLOCK_LENGTH/2),-(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [0,0,0]);
	filletX(rad = 0.5, length = number_of_blocks*BLOCK_LENGTH, pos = [(number_of_blocks-1)*(BLOCK_LENGTH/2),(BLOCK_LENGTH/2),(BLOCK_LENGTH/2)], rot = [-90,0,0]);
	filletX(rad = 0.5, length = number_of_blocks*BLOCK_LENGTH, pos = [(number_of_blocks-1)*(BLOCK_LENGTH/2),-(BLOCK_LENGTH/2),-(BLOCK_LENGTH/2)], rot = [90,0,0]);
	filletX(rad = 0.5, length = number_of_blocks*BLOCK_LENGTH, pos = [(number_of_blocks-1)*(BLOCK_LENGTH/2),(BLOCK_LENGTH/2),-(BLOCK_LENGTH/2)], rot = [180,0,0]);

	filletY(rad = 0.5, length = BLOCK_LENGTH, pos = [-(BLOCK_LENGTH/2),0,(BLOCK_LENGTH/2)], rot = [0,0,0]);
	filletY(rad = 0.5, length = BLOCK_LENGTH, pos = [-(BLOCK_LENGTH/2),0,-(BLOCK_LENGTH/2)], rot = [0,-90,0]);
	filletY(rad = 0.5, length = BLOCK_LENGTH, pos = [number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH/2),0,(BLOCK_LENGTH/2)], rot = [0,90,0]);
	filletY(rad = 0.5, length = BLOCK_LENGTH, pos = [number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH/2),0,-(BLOCK_LENGTH/2)], rot = [0,180,0]);

	filletZ(rad = 0.5, length = BLOCK_LENGTH, pos = [-(BLOCK_LENGTH/2),-(BLOCK_LENGTH/2),0], rot = [0,0,0]);
	filletZ(rad = 0.5, length = BLOCK_LENGTH, pos = [-(BLOCK_LENGTH/2),(BLOCK_LENGTH/2),0], rot = [0,0,-90]);
	filletZ(rad = 0.5, length = BLOCK_LENGTH, pos = [number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH/2),-(BLOCK_LENGTH/2),0], rot = [0,0,90]);
	filletZ(rad = 0.5, length = BLOCK_LENGTH, pos = [number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH/2),(BLOCK_LENGTH/2),0], rot = [0,0,180]);

	
} // end difference

if (snaps >= 1) {
	// near end snap
	translate([-7.75,0,0])
		difference() {
			cube([1.5,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH-2*WALL], center = true);
			cube([WALL,3,12], center = true);
		} // end difference
	snap(supports, male_snap_fit_tolerance);
	mirror([0,1,0])
		snap(supports, male_snap_fit_tolerance);

	if (snaps == 2) {
		// far end snap
		translate([(number_of_blocks-1)*BLOCK_LENGTH+7.75,0,0])
			difference() {
				cube([1.5,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH-2*WALL], center = true);
				cube([WALL,3,12], center = true);
			} // end difference
		translate([(number_of_blocks-1)*BLOCK_LENGTH,0,0])
			mirror([1,0,0]) {
				snap(supports, male_snap_fit_tolerance);
				mirror([0,1,0])
					snap(supports, male_snap_fit_tolerance);
			} // end mirror
	} else { // end if (snaps == 2)
		if (supports == 1) {
			translate([number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH+support_thickness+WALL)/2,0,0])
				cube([support_thickness,4,WINDOW], center = true);
			//translate([number_of_blocks*BLOCK_LENGTH-12+0.1,0,0])
			//	cube([support_thickness,4,WINDOW], center = true);
			translate([(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,(4-support_thickness)/2,0])
				cube([(BLOCK_LENGTH-WINDOW-WALL)/2,support_thickness,WINDOW], center = true);
			mirror([0,1,0])
				translate([(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,(4-support_thickness)/2,0])
					cube([(BLOCK_LENGTH-WINDOW-WALL)/2,support_thickness,WINDOW], center = true);
		} // end if supports == 1
	} // end else if (snaps == 2)
} else { // end if (snaps >= 1)
	if (supports == 1) {
		translate([number_of_blocks*BLOCK_LENGTH-(BLOCK_LENGTH+support_thickness+WALL)/2,0,0])
			cube([support_thickness,4,WINDOW], center = true);
		//translate([number_of_blocks*BLOCK_LENGTH-12+0.1,0,0])
		//	cube([support_thickness,4,WINDOW], center = true);
		translate([-(BLOCK_LENGTH-support_thickness-WALL)/2,0,0])
			cube([support_thickness,4,WINDOW], center = true);
		//translate([-8-0.1,0,0])
		//	cube([support_thickness,4,WINDOW], center = true);
		translate([(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,(4-support_thickness)/2,0])
				cube([(BLOCK_LENGTH-WINDOW-WALL)/2,support_thickness,WINDOW], center = true);
		mirror([0,1,0])
			translate([(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,(4-support_thickness)/2,0])
				cube([(BLOCK_LENGTH-WINDOW-WALL)/2,support_thickness,WINDOW], center = true);
		mirror([1,0,0]) {
			translate([(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,(4-support_thickness)/2,0])
				cube([(BLOCK_LENGTH-WINDOW-WALL)/2,support_thickness,WINDOW], center = true);
			mirror([0,1,0])
				translate([(WINDOW)/2+(BLOCK_LENGTH-WINDOW-WALL)/4,(4-support_thickness)/2,0])
					cube([(BLOCK_LENGTH-WINDOW-WALL)/2,support_thickness,WINDOW], center = true);
		} // end mirror
	} // end if supports == 1
} // end else if snaps >= 1
// in mm, For iPhone 5/5s try 7.9
slot_width = 7.9;

// in mm
slot_height = 10;

// in mm, must be >= 1
wall_thickness = 4;

//in mm
floor_height = 0.6;

snaps = 1; // [0:No Snaps,1:Snaps on Bottom]

// for single material printing
supports = 0; // [0:No Supports,1:Supports]

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.3 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
male_snap_fit_tolerance = 0;

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.2 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
female_snap_fit_tolerance = 0;

/* [Hidden] */

/*These designs are owned by Rokenbok Education and published under license by kid*spark, a nonprofit corporation, for nonprofit and educational uses. Drawings of these designs are licensed under Creative Commons Attribution-NonCommercial-ShareAlike (BY-NC-SA) 3.0: http://creativecommons.org/licenses/by-nc-sa/3.0/ The drawings may be freely downloaded, modified, and used, providing that attribution is given to Rokenbok Education and the drawings are for non-commercial purposes. Any modified drawings are licensed under the same terms. The drawings are intended for educational and hobby uses only; 3D prints of these designs should not be considered toys or for use by children without adult supervision. The drawings are not guaranteed to print perfectly.*/

WINDOW = 12+female_snap_fit_tolerance;
BLOCK_LENGTH = 20;
WALL = 2;
slot_length = BLOCK_LENGTH;

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
		rotate([0,0,90]) {
			translate([0,-(BLOCK_LENGTH/2),0])
				cube(size = [BLOCK_LENGTH+1,1,1], center = true);
			translate([0,(BLOCK_LENGTH/2),0])
				cube(size = [BLOCK_LENGTH+1,1,1], center = true);
			translate([0,-(BLOCK_LENGTH/2),0])
				cube(size = [1,1,BLOCK_LENGTH+1], center = true);
			translate([0,(BLOCK_LENGTH/2),0])
				cube(size = [1,1,BLOCK_LENGTH+1], center = true);
		} // end rotate
		} // end difference
		if (supports == 1) {
			translate([0,-(BLOCK_LENGTH/2-0.1),0])
				cube([4,0.2,WINDOW], center = true);
			translate([0,-(BLOCK_LENGTH/2-WALL+0.1),0])
				cube([4,0.2,WINDOW], center = true);
			translate([0,(BLOCK_LENGTH/2-0.1),0])
				cube([4,0.2,WINDOW], center = true);
			translate([0,(BLOCK_LENGTH/2-WALL+0.1),0])
				cube([4,0.2,WINDOW], center = true);
			if (snaps == 0) {
				rotate([0,0,90]) {
					translate([0,(BLOCK_LENGTH/2-0.1),0])
						cube([4,0.2,WINDOW], center = true);
					translate([0,(BLOCK_LENGTH/2-WALL+0.1),0])
						cube([4,0.2,WINDOW], center = true);
				} // end rotate
			} // end if snaps == 1
			difference() {
				cube([WINDOW+0.2,WINDOW+0.2,BLOCK_LENGTH-2*WALL], center = true);

				cube([WINDOW,WINDOW,BLOCK_LENGTH], center = true);
				cube([4,WINDOW+1,BLOCK_LENGTH-2*WALL], center = true);
				cube([WINDOW+1,4,BLOCK_LENGTH-2*WALL], center = true);
			} // end difference
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
				translate([-0.2,0,3*0.2/2])
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
	union() {
		block();
		translate([BLOCK_LENGTH/2+floor_height/2,0,0])
			cube([floor_height,slot_width,slot_length], center = true);
		translate([BLOCK_LENGTH/2+slot_height/2,slot_width/2+wall_thickness/2,0])
			cube([slot_height,wall_thickness,slot_length], center = true);
		mirror([0,1,0])
			translate([BLOCK_LENGTH/2+slot_height/2,slot_width/2+wall_thickness/2,0])
				cube([slot_height,wall_thickness,slot_length], center = true);
		translate([BLOCK_LENGTH/2-WALL/2,0,0])
			cube([WALL,WINDOW,WINDOW], center = true);
	} // end union

	filletX();
	mirror([0,1,0]) filletX();
	mirror([0,0,1]) filletX();
	mirror([0,1,0]) mirror([0,0,1]) filletX();

	filletY();
	mirror([1,0,0]) filletY();
	mirror([0,0,1]) filletY();
	mirror([1,0,0]) mirror([0,0,1]) filletY();

	filletZ();
	mirror([0,1,0]) filletZ();
	mirror([1,0,0]) filletZ();
	mirror([0,1,0]) mirror([1,0,0]) filletZ();

	filletZ(rad = 1, length = slot_length, pos = [BLOCK_LENGTH/2+slot_height,slot_width/2+1,0]);
	mirror([0,1,0])
		filletZ(rad = 1, length = slot_length, pos = [BLOCK_LENGTH/2+slot_height,slot_width/2+1,0]);

	if (snaps == 1) {
		translate([-(BLOCK_LENGTH/2),0,0])
			cube([3,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH+1], center = true);
	} // end if snaps == 1

} // end difference

if (snaps == 1) {
	//rotate([0,-90,0]) {
		translate([-7.75,0,0])
			difference() {
				cube([1.5,BLOCK_LENGTH-2*WALL,BLOCK_LENGTH-2*WALL], center = true);
				cube([WALL,3,12], center = true);
			} // end difference
			snap(supports, male_snap_fit_tolerance);
			mirror([0,1,0])
				snap(supports, male_snap_fit_tolerance);
	//} // end rotate
} // end if snaps == 1
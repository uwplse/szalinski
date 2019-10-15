// how Arduino connects to board, choose printed plastic pins or screw holes
mounting_points = 0; // [0:Pins,1:Screw holes]

// in mm
mounting_post_height = 6;

// in mm
mounting_post_diameter = 6.4;

// in mm
screw_hole_diameter = 3.2;

// in mm, 2.9 suggested for MakerBot Replicator 2 at 0.2mm layer height
pin_diameter = 2.9;

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.2 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
female_snap_fit_tolerance = 0;

/* [Hidden] */

/*These designs are owned by Rokenbok Education and published under license by kid*spark, a nonprofit corporation, for nonprofit and educational uses. Drawings of these designs are licensed under Creative Commons Attribution-NonCommercial-ShareAlike (BY-NC-SA) 3.0: http://creativecommons.org/licenses/by-nc-sa/3.0/ The drawings may be freely downloaded, modified, and used, providing that attribution is given to Rokenbok Education and the drawings are for non-commercial purposes. Any modified drawings are licensed under the same terms. The drawings are intended for educational and hobby uses only; 3D prints of these designs should not be considered toys or for use by children without adult supervision. The drawings are not guaranteed to print perfectly.*/

$fn = 50;
WINDOW = 12+female_snap_fit_tolerance;
BLOCK_LENGTH = 20;
WALL = 2;

module mountingPost(origin = [0,0,0]) {
	translate(origin)
		difference() {
			union() {
				cylinder(h = mounting_post_height+0.5, d = mounting_post_diameter);
				if (mounting_points == 0) {
					translate([0,0,mounting_post_height])
						cylinder(h = 3, d = pin_diameter);
				} // end if mounting_points == 1
			} // end union

			if (mounting_points == 1) {
				cylinder(h = mounting_post_height+1, d = screw_hole_diameter);
			} // end if mounting_points == 1
		} // end difference
} // end module mountingPost

module filletX(rad = 0.5, length = 4*BLOCK_LENGTH, pos = [0,-(3*BLOCK_LENGTH/2),(WALL/2)], rot = [0,0,0]) {
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

module filletY(rad = 0.5, length = 3*BLOCK_LENGTH, pos = [-(4*BLOCK_LENGTH/2),0,WALL/2], rot = [0,0,0]) {
	translate([pos[0]-sign(pos[0])*rad/2,0,pos[2]-sign(pos[2])*rad/2])
		rotate(rot)
			difference() {
				cube([rad+.1,length+1,rad+.1], center = true);
		
				translate([rad/2,0,-rad/2])
					rotate([90,0,0])
						cylinder(r = rad, h = length+2, $fs = 0.1, center = true);
			} // end difference fillet
} // end module filletY()

module filletZ(rad = 0.5, length = WALL, pos = [(4*BLOCK_LENGTH/2),-(3*BLOCK_LENGTH/2),0], rot = [0,0,90]) {
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
	cube([4*BLOCK_LENGTH,3*BLOCK_LENGTH,WALL], center = true);

	translate([-2*BLOCK_LENGTH,-1.5*BLOCK_LENGTH,0])
		for (i = [1:3]) {
			for (j = [1:2]) {
				translate([i*BLOCK_LENGTH,j*BLOCK_LENGTH,0])
					cube([WINDOW,WINDOW,WALL+1], center = true);
			} // end for j
		} // end for i

	for (i = [1:7]) {
		translate([i*BLOCK_LENGTH/2-2*BLOCK_LENGTH,0,0]) {
			translate([0,0,WALL/2])
				cube([1,3*BLOCK_LENGTH+1,1], center = true);
			translate([0,0,-WALL/2])
				cube([1,3*BLOCK_LENGTH+1,1], center = true);
		} // end translate
	} // end for i

	for (i = [1:5]) {
		translate([0,i*BLOCK_LENGTH/2-1.5*BLOCK_LENGTH,0]) {
			translate([0,0,WALL/2])
				cube([4*BLOCK_LENGTH+1,1,1], center = true);
			translate([0,0,-WALL/2])
				cube([4*BLOCK_LENGTH+1,1,1], center = true);
		} // end translate
	} // end for i

	filletX();
	mirror([0,0,1]) filletX();
	mirror([0,1,0]) filletX();
	mirror([0,1,0]) mirror([0,0,1]) filletX();

	filletY();
	mirror([0,0,1]) filletY();
	mirror([1,0,0]) filletY();
	mirror([1,0,0]) mirror([0,0,1]) filletY();

	filletZ();
	mirror([0,1,0]) filletZ();
	mirror([1,0,0]) filletZ();
	mirror([1,0,0]) mirror([0,1,0]) filletZ();

} // end difference

mountingPost([-0.75*25.4,0.95*25.4,WALL/2]);
mountingPost([-0.8*25.4,-0.95*25.4,WALL/2-0.5]);
mountingPost([1.25*25.4,-0.75*25.4,WALL/2-0.5]);
mountingPost([1.25*25.4,0.35*25.4,WALL/2-0.5]);
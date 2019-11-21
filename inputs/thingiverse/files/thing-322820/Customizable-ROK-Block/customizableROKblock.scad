length = 1; //[1:10]

width = 2; //[1:10]

height = 2; //[1:10]

/* [Advanced] */

// for single material printing
supports = 0; // [0:No Supports,1:Supports]

// 0.2 suggested for printing on MakerBot Replicator 2 with 0.2mm layer height
support_thickness = 0.2;

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.0 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
male_snap_fit_tolerance = 0;

// increase if snap fits are too tight, decrease if snap fits are too loose. 0.2 suggested for MakerBot Replicator 2, 0.0 suggested for Shapeways
female_snap_fit_tolerance = 0;

/* [Hidden] */

/*These designs are owned by Rokenbok Education and published under license by kid*spark, a nonprofit corporation, for nonprofit and educational uses. Drawings of these designs are licensed under Creative Commons Attribution-NonCommercial-ShareAlike (BY-NC-SA) 3.0: http://creativecommons.org/licenses/by-nc-sa/3.0/ The drawings may be freely downloaded, modified, and used, providing that attribution is given to Rokenbok Education and the drawings are for non-commercial purposes. Any modified drawings are licensed under the same terms. The drawings are intended for educational and hobby uses only; 3D prints of these designs should not be considered toys or for use by children without adult supervision. The drawings are not guaranteed to print perfectly.*/

BLOCK_LENGTH = 20;
WINDOW = 12+female_snap_fit_tolerance;
TOP_WINDOW = 13.6;
WALL = 2;
PYRAMID_LENGTH = 11.6;
PYRAMID_HEIGHT = 8.5;
p1 = sqrt(pow(4.7,2)+pow(5,2));

module filletX(rad = 0.5, length = 20, pos = [0,-10,10], rot = [0,0,0]) {
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

module filletY(rad = 0.5, length = 20, pos = [-10,0,10], rot = [0,0,0]) {
	translate([pos[0]-sign(pos[0])*rad/2,0,pos[2]-sign(pos[2])*rad/2])
		rotate(rot)
			difference() {
				cube([rad+.1,length+1,rad+.1], center = true);
		
				translate([rad/2,0,-rad/2])
					rotate([90,0,0])
						cylinder(r = rad, h = length+2, $fs = 0.1, center = true);
			} // end difference fillet
} // end module filletY()

module filletZ(rad = 0.5, length = 20, pos = [10,-10,0], rot = [0,0,90]) {
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

module pyramid(origin = [0,0,0], orientation = [0,0,0]) { // generate pyramid
	translate([origin[0],origin[1],origin[2]+PYRAMID_HEIGHT/2])
		rotate(orientation) {
				difference() {
					union() {
						cube(size = [PYRAMID_LENGTH,PYRAMID_LENGTH,PYRAMID_HEIGHT], center = true);
						
					} // end union
		
					for (i = [0:90:270]) {
						rotate([0,0,i])
							translate([-5.65,0,8.65-PYRAMID_HEIGHT/2]) rotate([0,-43.23,0])
								cube(size = [p1,PYRAMID_LENGTH+1,p1], center = true);
					} // end for
					translate([0,0,3.15/2-PYRAMID_HEIGHT/2-.1])
						cube([PYRAMID_LENGTH-3,PYRAMID_LENGTH-3,3.15+.2], center = true);
					for (j = [0:90:270]) {
						rotate([0,0,j])
							intersection_for (i = [0:90:90]) {
								rotate([0,0,i])
									translate([-0.328506,0,3.028506-PYRAMID_HEIGHT/2]) rotate([0,-43.23,0])
										cube(size = [5.619227,PYRAMID_LENGTH-3,5.619227], center = true);
							} // end intersection_for
					} // end for
					translate([0,0,PYRAMID_HEIGHT/2-1.5-0.411352/2])
						cube(size = 0.411352, center = true);
					for (i = [0:90:270]) {
						rotate([0,0,i]) {
							filletZ(rad = 1, length = 10, pos = [PYRAMID_LENGTH/2,-PYRAMID_LENGTH/2,0]);
							//#filletX(rad = 1, length = PYRAMID_LENGTH, pos = [0,-PYRAMID_LENGTH/2,0]); // doesn't work with non-90 degree corner
						} // end rotate
					} // end for
				} // end difference
			translate([PYRAMID_LENGTH/2,0,2-PYRAMID_HEIGHT/2])
				cube([0.5-male_snap_fit_tolerance,2,4], center = true);
			translate([-4.064241,0,5.306774-PYRAMID_HEIGHT/2])
				rotate([0,-39.38,0])
					cube([4.727957,2,0.5-male_snap_fit_tolerance], center = true);
			mirror([1,0,0]) {
				translate([-4.064241,0,5.306774-PYRAMID_HEIGHT/2])
					rotate([0,-39.38,0])
						cube([4.727957,2,0.5-male_snap_fit_tolerance], center = true);
				translate([PYRAMID_LENGTH/2,0,2-PYRAMID_HEIGHT/2])
					cube([0.5-male_snap_fit_tolerance,2,4], center = true);
			} // end mirror
			translate([0,PYRAMID_LENGTH/2+(TOP_WINDOW-PYRAMID_LENGTH)/4-1.5/2,-(PYRAMID_HEIGHT+WALL)/2]) 
				cube([PYRAMID_LENGTH-3,(TOP_WINDOW-PYRAMID_LENGTH)/2+1.5,WALL], center = true);
			mirror([0,1,0])
				translate([0,PYRAMID_LENGTH/2+(TOP_WINDOW-PYRAMID_LENGTH)/4-1.5/2,-(PYRAMID_HEIGHT+WALL)/2]) 
					cube([PYRAMID_LENGTH-3,(TOP_WINDOW-PYRAMID_LENGTH)/2+1.5,WALL], center = true);
		
			if (supports == 1) {
				difference() {
					union() {

						translate([0,TOP_WINDOW/2+support_thickness/2,-(height*BLOCK_LENGTH+PYRAMID_HEIGHT)/2])
							cube([TOP_WINDOW,support_thickness,height*BLOCK_LENGTH-WALL], center = true);
						translate([TOP_WINDOW/2+support_thickness/2,0,-(height*BLOCK_LENGTH+PYRAMID_HEIGHT)/2])
							cube([support_thickness,TOP_WINDOW,height*BLOCK_LENGTH-WALL], center = true);
	
						mirror([0,1,0]) {
							translate([0,TOP_WINDOW/2+support_thickness/2,-(height*BLOCK_LENGTH+PYRAMID_HEIGHT)/2])
								cube([TOP_WINDOW,support_thickness,height*BLOCK_LENGTH-WALL], center = true);
						} // end mirror
						mirror([1,0,0]) {
							translate([TOP_WINDOW/2+support_thickness/2,0,-(height*BLOCK_LENGTH+PYRAMID_HEIGHT)/2])
								cube([support_thickness,TOP_WINDOW,height*BLOCK_LENGTH-WALL], center = true);
						} // end mirror
					} // end union

					translate([0,0,-(PYRAMID_HEIGHT+height*BLOCK_LENGTH)/2]) {
						cube([length*BLOCK_LENGTH,4,height*BLOCK_LENGTH], center = true);
						cube([4,width*BLOCK_LENGTH,height*BLOCK_LENGTH], center = true);
					} // end translate
				} // end difference

				// new April 30 2014
				translate([0,(PYRAMID_LENGTH-3+support_thickness)/2,-(height*BLOCK_LENGTH+PYRAMID_HEIGHT+WALL)/2])
					cube([PYRAMID_LENGTH-3,support_thickness,height*BLOCK_LENGTH-WALL], center = true);
				mirror([0,1,0])
					translate([0,(PYRAMID_LENGTH-3+support_thickness)/2,-(height*BLOCK_LENGTH+PYRAMID_HEIGHT+WALL)/2])
						cube([PYRAMID_LENGTH-3,support_thickness,height*BLOCK_LENGTH-WALL], center = true);
				// floor
				translate([0,0,-((2*height)*BLOCK_LENGTH+PYRAMID_HEIGHT)/2+0.6/2])
					cube([PYRAMID_LENGTH-3,PYRAMID_LENGTH-3,0.6], center = true);
			} // end if supports == 1

		} // end rotate
} // end module pyramid

difference() {
	cube([length*BLOCK_LENGTH,width*BLOCK_LENGTH,height*BLOCK_LENGTH], center = true);

	cube([length*BLOCK_LENGTH-2*WALL,width*BLOCK_LENGTH-2*WALL,height*BLOCK_LENGTH-2*WALL], center = true);

	for (i = [1:length]) {
		for (j = [1:height]) {
			translate([(-(length+1)/2)*BLOCK_LENGTH+i*BLOCK_LENGTH,0,(-(height+1)/2)*BLOCK_LENGTH+j*BLOCK_LENGTH])
				cube([WINDOW,width*BLOCK_LENGTH+1,WINDOW], center = true);
		} // end for j = 1:height
	} // end for i = 1:length

	for (i = [1:width]) {
		for (j = [1:height]) {
			translate([0,(-(width+1))/2*BLOCK_LENGTH+i*BLOCK_LENGTH,(-(height+1))/2*BLOCK_LENGTH+j*BLOCK_LENGTH])
				cube([length*BLOCK_LENGTH+1,WINDOW,WINDOW], center = true);
		} // end for j = 1:height
	} // end for i = 1:width

	for (i = [1:length]) {
		for (j = [1:width]) {
			translate([(-(length+1))/2*BLOCK_LENGTH+i*BLOCK_LENGTH,(-(width+1))/2*BLOCK_LENGTH+j*BLOCK_LENGTH,0]) {
				translate([0,0,-(height*BLOCK_LENGTH-WALL)/2])
					cube([WINDOW,WINDOW,WALL+1], center = true);
				translate([0,0,(height*BLOCK_LENGTH-WALL)/2])
					cube([TOP_WINDOW,TOP_WINDOW,WALL+1], center = true);
			} // end translate
		} // end for j = 1:width
	} // end for i = 1:length
	
	// edge fillets 0.5mm radius
	filletX(rad = 0.5, length = length*BLOCK_LENGTH, pos = [0,width*BLOCK_LENGTH/2,height*BLOCK_LENGTH/2], rot = [-90,0,0]);
	filletX(rad = 0.5, length = length*BLOCK_LENGTH, pos = [0,width*BLOCK_LENGTH/2,-height*BLOCK_LENGTH/2], rot = [180,0,0]);
	filletX(rad = 0.5, length = length*BLOCK_LENGTH, pos = [0,-width*BLOCK_LENGTH/2,height*BLOCK_LENGTH/2], rot = [0,0,0]);
	filletX(rad = 0.5, length = length*BLOCK_LENGTH, pos = [0,-width*BLOCK_LENGTH/2,-height*BLOCK_LENGTH/2], rot = [90,0,0]);

	filletY(rad = 0.5, length = width*BLOCK_LENGTH, pos = [length*BLOCK_LENGTH/2,0,height*BLOCK_LENGTH/2], rot = [0,90,0]);
	filletY(rad = 0.5, length = width*BLOCK_LENGTH, pos = [length*BLOCK_LENGTH/2,0,-height*BLOCK_LENGTH/2], rot = [0,180,0]);
	filletY(rad = 0.5, length = width*BLOCK_LENGTH, pos = [-length*BLOCK_LENGTH/2,0,height*BLOCK_LENGTH/2], rot = [0,0,0]);
	filletY(rad = 0.5, length = width*BLOCK_LENGTH, pos = [-length*BLOCK_LENGTH/2,0,-height*BLOCK_LENGTH/2], rot = [0,-90,0]);

	filletZ(rad = 0.5, length = height*BLOCK_LENGTH, pos = [length*BLOCK_LENGTH/2,width*BLOCK_LENGTH/2,0], rot = [0,0,180]);
	filletZ(rad = 0.5, length = height*BLOCK_LENGTH, pos = [length*BLOCK_LENGTH/2,-width*BLOCK_LENGTH/2,0], rot = [0,0,90]);
	filletZ(rad = 0.5, length = height*BLOCK_LENGTH, pos = [-length*BLOCK_LENGTH/2,width*BLOCK_LENGTH/2,0], rot = [0,0,-90]);
	filletZ(rad = 0.5, length = height*BLOCK_LENGTH, pos = [-length*BLOCK_LENGTH/2,-width*BLOCK_LENGTH/2,0], rot = [0,0,0]);//*/

} // end difference

for (i = [1:length]) {
	for (j = [1:width]) {
			pyramid(origin = [(-(length+1)/2)*BLOCK_LENGTH+i*BLOCK_LENGTH,(-(width+1))/2*BLOCK_LENGTH+j*BLOCK_LENGTH,height/2*BLOCK_LENGTH], orientation = [0,0,(i+j)*90]);
	} // end for j = 1:width
} // end for i = 1:length */

if (supports == 1) {
	for (i = [1:length]) {
		for (j = [1:height]) {
			translate([(-(length+1)/2)*BLOCK_LENGTH+i*BLOCK_LENGTH,width*BLOCK_LENGTH/2-support_thickness/2-WALL/2,(-(height+1)/2)*BLOCK_LENGTH+j*BLOCK_LENGTH])
				cube([WINDOW/3,support_thickness,WINDOW], center = true);
			translate([(-(length+1)/2)*BLOCK_LENGTH+i*BLOCK_LENGTH,-(width*BLOCK_LENGTH/2-support_thickness/2-WALL/2),(-(height+1)/2)*BLOCK_LENGTH+j*BLOCK_LENGTH])
				cube([WINDOW/3,support_thickness,WINDOW], center = true);

		} // end for j = 1:height
	} // end for i = 1:length

	for (i = [1:width]) {
		for (j = [1:height]) {
			translate([length*BLOCK_LENGTH/2-support_thickness/2-WALL/2,(-(width+1))/2*BLOCK_LENGTH+i*BLOCK_LENGTH,(-(height+1))/2*BLOCK_LENGTH+j*BLOCK_LENGTH])
				cube([support_thickness,WINDOW/3,WINDOW], center = true);
			translate([-(length*BLOCK_LENGTH/2-support_thickness/2-WALL/2),(-(width+1))/2*BLOCK_LENGTH+i*BLOCK_LENGTH,(-(height+1))/2*BLOCK_LENGTH+j*BLOCK_LENGTH])
				cube([support_thickness,WINDOW/3,WINDOW], center = true);

		} // end for j = 1:height
	} // end for i = 1:width
} // end if supports == 1
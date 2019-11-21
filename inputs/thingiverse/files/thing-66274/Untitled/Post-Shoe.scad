// Simon Bruechner 2013, http://bruechner.de
// Post shoe

// Side length of the post in mm
POST_SIDE_LENGTH 	= 23;  //  // [5:300]

// Screw head size in mm, default: 12 mm
SCREW_HEAD_SIZE  	= 12;  // [3:30]


WALL_THICKNESS   	= POST_SIDE_LENGTH / 2 * 1;  	//  mm
SHOE 				= WALL_THICKNESS * 3 * 1;  		//  mm
PSL 				= POST_SIDE_LENGTH + 0.5 * 1;

$fn 				= 100 * 1;

difference() {
	union() {
		cube([PSL + WALL_THICKNESS, PSL + WALL_THICKNESS, PSL + WALL_THICKNESS], true);
		translate([0, 0, -((PSL + WALL_THICKNESS)  / 2)]) {
			polyhedron(
		  		points=[[SHOE, SHOE, 0], [SHOE, -SHOE, 0], [-SHOE, -SHOE, 0], [-SHOE, SHOE, 0], [0, 0, SHOE* 1.333333]], 
		  		triangles=[ [0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4], [1, 0, 3], [2, 1, 3]]
		   );
      }
	}
	union () {
		//  Post
		#cube([PSL, PSL, PSL * 4], true);
		
		translate([(PSL + WALL_THICKNESS * 2) / 2 / 3, -((PSL + WALL_THICKNESS) + SCREW_HEAD_SIZE) / 2, -10]) {
			cylinder(h = PSL * 2, r=(SCREW_HEAD_SIZE / 2));
			translate([0, 0, -SHOE]) cylinder(h = PSL * 2, r=1.5);
		}
 		translate([-(PSL + WALL_THICKNESS * 2) / 2 / 3, -((PSL + WALL_THICKNESS) + SCREW_HEAD_SIZE) / 2, -10]) {
			cylinder(h = PSL * 2, r=(SCREW_HEAD_SIZE / 2));
			translate([0, 0, -SHOE]) cylinder(h = PSL * 2, r=1.5);
		}

		translate([-((PSL + WALL_THICKNESS) + SCREW_HEAD_SIZE) / 2, -(PSL + WALL_THICKNESS * 2) / 2 / 3, -10]) {
			cylinder(h = PSL * 2, r=(SCREW_HEAD_SIZE / 2));
			translate([0, 0, -SHOE]) cylinder(h = PSL * 2, r=1.5);
		}
 		translate([-((PSL + WALL_THICKNESS) + SCREW_HEAD_SIZE) / 2, (PSL + WALL_THICKNESS * 2) / 2 / 3, -10]) {
			cylinder(h = PSL * 2, r=(SCREW_HEAD_SIZE / 2));
			translate([0, 0, -SHOE]) cylinder(h = PSL * 2, r=1.5);
		}

		translate([(PSL + WALL_THICKNESS) / 2, -SHOE, (-SHOE / 2) - 1]) cube([SHOE* 2, SHOE* 2, SHOE* 2]);
		translate([-SHOE, (PSL + WALL_THICKNESS) / 2, (-SHOE / 2) - 1]) cube([SHOE* 2, SHOE* 2, SHOE* 2]);
	}
}